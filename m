From: "Thomas Leonard" <talex5@gmail.com>
Subject: Re: Fwd: [Bug 163341] Re: git-svn gets wrong parent revision for tags
Date: Wed, 9 Apr 2008 11:39:17 +0100
Message-ID: <cd53a0140804090339h472bc672ucd84b0ff13e2eeee@mail.gmail.com>
References: <20071117143713.8355.50653.malonedeb@potassium.ubuntu.com>
	 <20080407195610.13681.39351.malone@potassium.ubuntu.com>
	 <cd53a0140804080848r54bb1e6dq54b5cce62339d6d1@mail.gmail.com>
	 <20080408171502.GA6163@atjola.homenet>
	 <cd53a0140804081343l4b791dc3x5fa3fb294af71621@mail.gmail.com>
	 <20080409080333.GA13892@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 09 12:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjXil-0003SO-F5
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 12:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbYDIKjU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 06:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbYDIKjT
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 06:39:19 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:12990 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbYDIKjT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2008 06:39:19 -0400
Received: by an-out-0708.google.com with SMTP id d31so556344and.103
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 03:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=d4PRu251VFLQgkMzN3iWgrJUq/AwuJCaBtAFsg/INWQ=;
        b=cQrp085fawC34PMs+4PvqMq95Hs3ISTvQRrDBTuckOmOy0zodFrfKxQ8NAhIqIBWMcoxKg4vBPSkmftedRwdEDRbHU/aIuUzi4HQlF3HY/3FzCVxaRYUMg65qex9CE4JOxYD0DKp/C3ieac+OzVIe1Az4H2rHwpbxeNzgEJxZig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XcuMLIaRze9dYPR71v7Xf+cOhNm6nWBbp9ap+0nikxT8Qu+u/ZiS+Ck5ukPexjVYkZiJ4svqpO8U/fyMRJ3H5Sq24JiKjXpEjO0d/1yiqPJZHDJ+8O2L0lrOrgfxDznlmtMqTdJ4o03nhYU6bY2lHJE8LnK/WpyWEVwFDRloam0=
Received: by 10.100.41.9 with SMTP id o9mr15192118ano.84.1207737557179;
        Wed, 09 Apr 2008 03:39:17 -0700 (PDT)
Received: by 10.100.105.20 with HTTP; Wed, 9 Apr 2008 03:39:17 -0700 (PDT)
In-Reply-To: <20080409080333.GA13892@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79099>

On 09/04/2008, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> [Grmpf, the next time you drop from me Cc:, I'll not bother to
>  answer...]

=46ixed; sorry.

>  On 2008.04.08 21:43:03 +0100, Thomas Leonard wrote:
[...]
>  > The script that made the releases simply did this ("." is the work=
ing copy):
>  >
>  > svn cp -m "Released $VERSION" . http://...
>  >
>  > Since each file in an svn working copy has its own revision (the l=
ast
>  > time it was changed), the branch ends up with multiple source
>  > revisions, even if the working copy is fully up-to-date and has no
>  > local changes.
>  >
>  > Example:
>  >
>  > cd /tmp
>  > svnadmin create test-repo
>  > svn mkdir file:///tmp/test-repo/trunk -m 'Setup'
>  > svn co file:///tmp/test-repo/trunk
>  > cd trunk
>  > touch foo bar
>  > svn add foo bar
>  > svn ci -m 'Start'
>  > echo hi > bar
>  > svn ci -m 'Update'
>  > svn cp . file:///tmp/test-repo/release -m 'Release'
>  > svn log -v file:///tmp/test-repo
>  >
>  > The log shows:
>  >
>  > ------------------------------------------------------------------=
------
>  > r4 | talex | 2008-04-08 21:35:44 +0100 (Tue, 08 Apr 2008) | 1 line
>  > Changed paths:
>  >    A /release (from /trunk:1)
>  >    A /release/bar (from /trunk/bar:3)
>  >    A /release/foo (from /trunk/foo:2)
>  >
>  > Release
>
> Change the "." to "file:///tmp/test-repo/trunk" in the svn cp command
>  and you get:
>  Changed paths:
>    A /release (from /trunk:3)
>
>  Seems more useful. No idea why SVN decides to record crap when you u=
se
>  ".", even when your working copy is clean.

That's good advice, but I'm wondering how to convert my existing svn
repositories to GIT.

>  > So, I don't think the metadata is broken in this case. Maybe other
>  > people don't create branches like this, but it seemed like the obv=
ious
>  > way to do it at the time. Given this behaviour of svn, perhaps it
>  > would be better to take the highest version number as the branch
>  > point?
>
> Uhm, and what happens then, when you actually _did_ just copy over a
>  few files, but not all of them? Right, you get a branch to start at =
a
>  later revision and see a bunch of reverts. Equally broken.

Sure, if you create a situation that GIT can't represent then there's
nothing much git-svn can do.

However, when there are different source revisions:

- Taking the highest revision will give correct results in the common
case, and "equally broken" results in the uncommon case.

- Taking any other revision (the current behaviour) is guaranteed to
give the wrong result. There's no way a branch that was created with a
file from revision 6 can possibly be a branch of revision 5, for
example.

Also, the current behaviour can be wildly out (e.g. revision 1894 when
it should have been 2070, in the previous real example). The highest
revision is unlikely to be far off.


--=20
Dr Thomas Leonard		http://rox.sourceforge.net
GPG: 9242 9807 C985 3C07 44A6  8B9A AE07 8280 59A5 3CC1

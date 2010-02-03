From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 3 Feb 2010 13:48:06 -0500
Message-ID: <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com>
References: <ron1-32BD5F.10255403022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:48:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NckHB-0007oC-O3
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068Ab0BCSsa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 13:48:30 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:60059 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035Ab0BCSs1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 13:48:27 -0500
Received: by ywh36 with SMTP id 36so1565874ywh.15
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 10:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EzAXM5oRQQLgpHDIfy4pMDvz86yn7zHI878NQ6fdJX0=;
        b=sRi1U5hkcoclTDS44gvPIwjY6WUF+RAtQlw0xJJP+Ee3+EdRXkt+Hy1gLx8pXIK+8D
         Q7P1f3ORuaBx5hiKjDU00A6vWGcCJ/pbrGJQk3lYDi8nRJexj7/LpNPwvI1gtLFPhBNo
         uEBX+qBfRHYmPh6wdbNtZyTaFAOsUTi+ugQI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SyoSmnW8Us5BGWnVRD2CtCcMpwCrnFrCcq3l5Fvsqorlipdm0zZoJ1t3JEL5289A3G
         8duaeUUNs2MG7H/JjLJUt7QTerEaT58iT9ALVgkFJjd20AoNOganQeFTXG3Ylj9QmEv/
         YTwohdvT4QvGObcOMumBZLBr2hclGzdivCtTE=
Received: by 10.150.116.5 with SMTP id o5mr331690ybc.336.1265222906284; Wed, 
	03 Feb 2010 10:48:26 -0800 (PST)
In-Reply-To: <ron1-32BD5F.10255403022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138860>

On Wed, Feb 3, 2010 at 1:25 PM, Ron Garret <ron1@flownet.com> wrote:
> So something in my understanding of how git works must be wrong. =A0G=
it
> must be keeping a separate record of file renames somewhere. =A0But w=
here?

It doesn't.  Your experiment is wrong.

> [ron@mickey:~/devel/gittest]$ cat>file2
> 6
> 7
> 8
> 9
> 10
> [ron@mickey:~/devel/gittest]$ git mv file2 file3
> [ron@mickey:~/devel/gittest]$ git commit -m 'letters->numbers'
> [master ae3f6d4] letters->numbers
> =A01 files changed, 0 insertions(+), 0 deletions(-)
> =A0rename file2 =3D> file3 (100%)

Whoops.  You didn't 'git add file2' (before the mv) or 'git add file3'
(after the mv), or use commit -a, so what you've committed is the
*old* content of file2 under the name file3.  The *new* content of
file2 is still uncommitted in your work tree under the name file3.
This is why git can detect the move.  (The 100% is a good clue: it
means the old and new files are 100% identical.)

Artificial tests like this are useless anyway.  If you renamed file2
to file3 *and* changed all the contents, did you *really* rename it?
If so, who cares?  What good does it do you to know this?  If someone
else tries to patch the old file2 and you merge it into a (totally
different) file3 vs a (now missing) file2, how is that any better?

On the other hand, if one guy moves file2 to file3 and changes a few
lines, you want the other guy's patch to go into file3, whether the
first guy used 'git mv' or add+rm or anything else.

As long as only a few lines changed, git does the right thing.  If
most/all of the lines have changed, then there is no right thing,
because you'll get a nasty merge conflict either way.

Have fun,

Avery

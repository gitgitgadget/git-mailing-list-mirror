From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: Running 'git pull' from an unnamed branch
Date: Sun, 5 Apr 2009 23:29:57 +0100
Message-ID: <3f4fd2640904051529t2421ccccrb7ca71fee5119d7@mail.gmail.com>
References: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
	 <20090405220855.GA20356@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 00:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqasJ-0002k5-Rz
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 00:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZDEWaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 18:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbZDEWaB
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 18:30:01 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:40279 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbZDEWaA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 18:30:00 -0400
Received: by bwz17 with SMTP id 17so1644457bwz.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XFonwJatiiSuMBNG3XVOfmwRBD+J4doah9N8tzah+84=;
        b=grZFLTEBYrit7mujn3yqTHjzo0Ndf0+vaTx3U/R/tr5oW4pZDsBlPjb+k5Jl6QHzUa
         dCVUmSXCs/9Fcr54z5M91K0spzVS/k66Tj3PcouP8xKv70BY8yHsBxpWkDTR/tjL/5aB
         NahIrrSeJmv9sogTEDH6WG8V7q0pXM0KJjcq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TBFOkLk213NHUGuUOPPtVi2b0iTDRc7byJ0JCkjZgxZXJ44zzHUb1mp0SEuW04eOhx
         HdFtLigSWOSSG1I7jti8cmYnxbPGYjlw24/u5SuYiNdY+ag1PttxCvTxfaeY804APvjo
         YToRlgZMZO70OmPlxIxFZQKHSOmmnwiYqy2IU=
Received: by 10.239.131.134 with SMTP id 6mr82557hbn.113.1238970597731; Sun, 
	05 Apr 2009 15:29:57 -0700 (PDT)
In-Reply-To: <20090405220855.GA20356@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115729>

2009/4/5 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.04.05 22:33:57 +0100, Reece Dunn wrote:
>> Running `git checkout master && git pull` fixed the above issue. The
>> patch below improves the error message for users that are in this
>> state.
>
> It doesn't "fix" anything, you're simply doing something different.
>
> "git pull" while on a detached HEAD can't work, there are no defaults
> that could be used. But e.g. "git pull origin master" would do, fetch=
ing
> "master" from "origin" and merging it to the commit you have checked
> out.

Sure.

> Your "git checkout master && git pull" does something else. It uses t=
he
> configured pull defaults for "master" to fetch something and merge it=
 to
> "master".

The two cases depend on if you want to stay with the detached HEAD or n=
ot.

>> Also, is "branch..remote" valid? Should this be "branch.remote"?
>
> That's a bug, but it should not be branch.remote. The config setting =
is
> branch.<name>.remote. As you were on a detached HEAD, there is no
> "<name>", and the code that generates the error message doesn't handl=
e
> that correctly. I'd even say that in this case, the whole "If you oft=
en
> merge ..." part makes no sense at all, you simply can't setup pull
> defaults for a detached HEAD.

Yup. In my revised patch, I have it displaying a different message
(the one I added) instead of the default one you get at the moment.

>> + =A0 =A0 echo "You may not be on a branch. In this case, you need t=
o move"
>> + =A0 =A0 echo "onto the branch you want to pull to (usually master)=
:"
>
> Hm? Neither do you really need to move to a branch, nor is "master"
> really _that_ special that it is warranted to recommend checking it
> out... IMHO.

I said "usually master" to give a hint to the casual/newbie user. The
exact wording that is outputted in this case can be figured out. It
can also mention the case you highlighted.

- Reece

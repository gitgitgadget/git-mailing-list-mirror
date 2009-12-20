From: Andrew Myrick <amyrick@gmail.com>
Subject: Re: Efficiency and correctness patches for git-svn mergeinfo support
Date: Sun, 20 Dec 2009 14:03:52 -0800
Message-ID: <6b2f9b1d0912201403t4a801284j39591b2bcf6e9f93@mail.gmail.com>
References: <1261240435-8948-1-git-send-email-sam@vilain.net> 
	<6b2f9b1d0912191415n560a5a58xbe6390b1fcade854@mail.gmail.com> 
	<1261343240.20752.20.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Dec 20 23:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMTvY-0000Rd-7y
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 23:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbZLTWEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 17:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbZLTWEN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 17:04:13 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:62472 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbZLTWEM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2009 17:04:12 -0500
Received: by iwn1 with SMTP id 1so3295767iwn.33
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 14:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GkBO38ZhDg/XEQetyaeeSoV8HHTFEFadsmJx+AkYTvA=;
        b=JZnW+D98ZEKgzsFTU2HLutJxE6cEPudmjg1MaacMAEx17FWYxrRcgjZLy81Y4ALUe3
         W9xyQOVb62slKwGIq0h6q8PRA/uUJ6iE8RjPdFBtoA1R+yo2L58ASEYmf0CEzstO89Eq
         fv/XyY60l7Fh/bmlIhJGTCzftZbuQWPZToiw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=abqVuH7FAa6jl8KzPFN0MAUQN2zDOGwlYI5QQtm8x7ggwDQax9qL/iAN9dwR890b8e
         qfN5zj2geJWbDJ/KiVFMIZDy9pUFeVwlGSadtc/jacemWla5InAJZbXFvDwcygmQNmiI
         7gBxAuaGHw5EYDfqPoNZgIwgb7SqnEtVbd1gU=
Received: by 10.231.159.198 with SMTP id k6mr2806572ibx.54.1261346652088; Sun, 
	20 Dec 2009 14:04:12 -0800 (PST)
In-Reply-To: <1261343240.20752.20.camel@denix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135537>

On Sun, Dec 20, 2009 at 1:07 PM, Sam Vilain <sam@vilain.net> wrote:
> On Sat, 2009-12-19 at 14:15 -0800, Andrew Myrick wrote:
>> I tried cloning from a fairly recent revision that I knew was after
>> our switchover to svn 1.5, and I received a number of these errors:
>>
>> =C2=A0 =C2=A0Couldn't find revmap for [branch]
>> =C2=A0 =C2=A0Exiting subroutine via next at /Users/adm/libexec/git-c=
ore/git-svn line 2983.
>> =C2=A0 =C2=A0Exiting subroutine via next at /Users/adm/libexec/git-c=
ore/git-svn line 2983.
>> =C2=A0 =C2=A0Exiting subroutine via next at /Users/adm/libexec/git-c=
ore/git-svn line 2983.
>>
>> I'm not sure if this is expected, since I didn't clone from the whol=
e
>> repo, but it did cause a lot of spew. =C2=A0I'm starting a fresh clo=
ne now,
>> but it takes a few days to get through the whole repository. =C2=A0I=
'm
>> fairly new to git, so I would welcome any tips on how I can test thi=
s
>> more quickly.
>
> Whoops, no, not expected, I'll post a minor correction. =C2=A0That me=
ans that
> the branch which was merged in does not have git-svn metadata; ie, it=
's
> not being tracked explicitly. =C2=A0If people are doing merging of th=
ings
> which aren't roots of branches you would expect this. =C2=A0SVN, like
> Perforce, supports a confusing amount of flexibility in its merge
> tracking. =C2=A0If [branch] is a real branch, then you'll want to see=
 why it
> doesn't have metadata yet. =C2=A0Is it really a sub-tree of a real br=
anch?
> You could fetch it independently using a separate git-svn remote, or =
you
> could ignore the warning; it should be relatively self-evident what
> happened from the merge message and the contents of the changeset.

I think the problem is that I started fetching from a later revision
than when the branch was created and reintegrated.  There would be no
metadata for the branch, so a lookup for it would fail.  Fetching the
branch explicitly, or fetching from r1 as my current test is doing,
should not experience this problem.

> Note if your repository was significantly re-organized at any point, =
it
> will pay to treat each section of history as a separate import projec=
t,
> and stitch the results together afterwards using grafts and
> filter-branch.

I don't believe it was, but I will keep that in mind if I run into
trouble.  The import from r1 went fine with git v1.6.5.*, and it's
proceeding well now.

> This version should be *significantly* faster than the old one. =C2=A0=
ie, it
> should not take a minute per commit while importing the heavily
> merged-into integration branch. =C2=A0Possibly a few seconds at most.

So far, most commits are fetched in under 3s with your new version.

Thanks for your help, Sam.

-Andrew

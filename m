From: Andrei Neculau <andrei.neculau@gmail.com>
Subject: git cherry-pick gives error: addinfo_cache failed for path
Date: Wed, 18 Nov 2015 16:04:15 +0100
Message-ID: <CAOGnN1e=mj-24uN_Dq2me6U869t62TyPTxePj3Px-Y1_ErGfjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 16:04:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz4Ht-000342-QN
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 16:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbbKRPEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 10:04:42 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34411 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759AbbKRPEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 10:04:41 -0500
Received: by ykfs79 with SMTP id s79so68205674ykf.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=SLStdq8NRHoE5XGd2d4dDUnqxn7uwocUy8AbFGVWlp8=;
        b=ppojg+Qa+cgHq5wqdYyK4FUvvlCrsKmTCOKFfEl3Z6TvBzKev3KMM4ozkAhQzySfjb
         Q85GFv63ijQauz9FzL6m8EWGne8hysrI0z4q9K4QJuu9VIU56tRs3UeM4NG//qzuiftg
         +rYrJcmKFRmFJGLD5Q7C3g4B7lYrVgDXW6WWSl3KP4/SbRnd2GPo1rgtSuNMl54F8J14
         YZFXjelIMsvbQqdfjEaeMXJ9San61PsZqLDbd2TRozkpY+ikV4uZ7wW5SlEO7JPB6mj5
         VvRSXC5g94fP6HLtoRYz60ZyOKjxod4gs81GSCtcHUm9htsaFIdUmrWyMbGvu14dKsD0
         r/7g==
X-Received: by 10.13.251.66 with SMTP id l63mr2212531ywf.279.1447859074389;
 Wed, 18 Nov 2015 07:04:34 -0800 (PST)
Received: by 10.129.101.66 with HTTP; Wed, 18 Nov 2015 07:04:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281449>

UPDATE:

The initial message (see below) got rejected because it wasn't
text/plain, so meanwhile a few things happened.

I was reading the manual pages of gitattributes and saw the note

> When text=auto normalization is enabled in an existing repository, any text files containing CRLFs should be normalized......

indeed, running

> rm ...index && git reset && git add -u && git commit -m "normalize crlf"

fixed the initial problem, leaving me with a new QUESTION:

why "git rm -rf --cached . && git reset --hard HEAD" is NOT showing
dirty files that need normalization, but "rm ....index && git reset"
does?










INITIAL MESSAGE:

Hello

I am running "git cherry-pick <HASH>" from one maintenance branch B2
to another B1, where B2 is newer than B1, in a repository with
.gitattributes containing

> * text=auto



You can see an excerpt of the output below.
Files 2-3-4 were deleted/renamed in B2 (newer branch). It seems that
git cherry-pick is trying to normalize the files, but it fails because
the files don't exist in the newer branch.



> warning: CRLF will be replaced by LF in file1.html.
> The file will have its original line endings in your working directory.
> error: addinfo_cache failed for path 'file2.txt'
> error: addinfo_cache failed for path 'file3.xml'
> error: addinfo_cache failed for path 'file4.js'
> U file4.js
> error: commit is not possible because you have unmerged files.
> hint: Fix them up in the work tree, and then use 'git add/rm <file>'
> hint: as appropriate to mark resolution and make a commit.
> fatal: Exiting because of an unresolved conflict.




I have tried

> git cherry-pick --strategy=recursive -X=no-renormalize <HASH>


to no avail.
At the moment, the only fix I can have is to remove "* text=auto" from
.gitattributes

I mention that before the cherry-pick, the git status is clean.

I am not subscribed to the mailing list, so please keep me in CC

Thank you in advance,
Andrei

-- 
andreineculau.com

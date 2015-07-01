From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] worktree: new place for "git prune --worktrees"
Date: Wed, 1 Jul 2015 17:38:49 +0700
Message-ID: <CACsJy8ASdbmHuJn_og_jHxHn_h0gZ-30ieD=vwMJ6O-j=1hGGQ@mail.gmail.com>
References: <1435582278-31158-1-git-send-email-pclouds@gmail.com> <xmqqh9pqcx1q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 12:39:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAFQL-0008Eq-9Q
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 12:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbbGAKjU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2015 06:39:20 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33705 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbbGAKjT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jul 2015 06:39:19 -0400
Received: by ieqy10 with SMTP id y10so31721005ieq.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+cfZbGKpKxwfeL2+mytZ6J1+15ERcdQLVd2KKvXcXMk=;
        b=svYIWfiYYywiFNAQUaqKmT5f55OKnaWlcRxw+TFXgFtYSv/AbOIVNJ/DUVED7Zm5Nq
         IJ9TZvpsHkoySSM6Kri1zQJc0sKWNO+tKnUeBJzQi0/BIei/awliSJsLZ0RJ4SaTysSw
         EDPsl4aLnxvkX39IBlN49/kEz0xf47mYdfg0W/c0Fc1iHWLJgZrfWAHf3l1ya+zG8WA0
         FHX1vhnY3MZf6VrRsmeke2+xHC8m3UE1U1O66KbOfkwt9oqiiT9HORhre7pvKEGlOMY6
         lP+hTT4qq4rX27GAhAufjx8mCEALepPPIShHC4n1OnAO4w0nkNjz8xWHwVFklFUbaeYd
         W9cw==
X-Received: by 10.50.18.42 with SMTP id t10mr8206156igd.0.1435747158809; Wed,
 01 Jul 2015 03:39:18 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 1 Jul 2015 03:38:49 -0700 (PDT)
In-Reply-To: <xmqqh9pqcx1q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273149>

On Mon, Jun 29, 2015 at 11:13 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Commit 23af91d (prune: strategies for linked checkouts - 2014-11-30)
>> adds "--worktrees" to "git prune" without realizing that "git prune"=
 is
>> for object database only. This patch moves the same functionality to=
 a
>> new command "git worktree".
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  In future I probably move the big block of text in git-checkout.txt=
 to
>>  git-worktree.txt and add "git worktree list". But let's start with
>>  something small and simple before "git prune --worktrees" is shippe=
d
>>  out.
>
> Thanks.  I notice that after applying this, builtin/prune.c does not
> revert to the original before 23af91d.  It stops including "dir.h"
> and it adds an extra blank line.  We've been including a header that
> is not necessary even in v2.4.0, it seems.  We used to walk
> $GIT_DIR/objects ourselves to find loose object files and "dir.h"
> was needed for is_dot_or_dotdot(); for_each_loose_file_in_objdir()
> is what we use these days to hide the implementation details these
> days; 27e1e22 forgot to remove the inclusion when it did this.
>
> The C code part is mostly just \C-x \C-v and I found nothing
> questionable.

I was about to prepare v2, but the only change in the end was removing
this blank line, not worth another round.

>> diff --git a/command-list.txt b/command-list.txt
>> index b17c011..2a94137 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -148,4 +148,5 @@ git-verify-pack                         plumbing=
interrogators
>>  git-verify-tag                          ancillaryinterrogators
>>  gitweb                                  ancillaryinterrogators
>>  git-whatchanged                         ancillaryinterrogators
>> +git-worktree                            mainporcelain
>
> I doubt that a helper that is primarily spawned from "gc" as its
> implementation detail is more mainporcelain than "git config" is:
>
>    git-config                              ancillarymanipulators
>
> I also wonder if "git worktree" command should have a mode that
> works in a way similar to how new-workdir (in contrib/workdir) does,
> instead of an option "checkout --to" that looks just out of place as
> "worktree prune" was out of place in "prune".  The feature is doing
> a lot more than what "checkout" normally does (somewhere in between
> "checkout" and "clone", I would say), and it may be cleaner to use
> an independent command "git worktree" to manage a separate worktree.
>
> And when that happens, the command should definitely be classified
> as a mainporcelain.

And because "git worktree add" is coming, I guess it's ok to stick to
mainporcelain here..

>> diff --git a/git.c b/git.c
>> index 44374b1..fa77bc9 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -483,6 +483,7 @@ static struct cmd_struct commands[] =3D {
>>       { "verify-tag", cmd_verify_tag, RUN_SETUP },
>>       { "version", cmd_version },
>>       { "whatchanged", cmd_whatchanged, RUN_SETUP },
>> +     { "worktree", cmd_worktree, RUN_SETUP },
>
> We do not NEED_WORK_TREE because we can create a new worktree
> off of a bare repository?

Yes.
--=20
Duy

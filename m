Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB8AC47247
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B495A20721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf6xAgs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEDTvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDTvZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:51:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9041C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:51:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w14so10895359lfk.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dtKej02h+1TV9axASqMyo+46GQ2AWmeQJY/blc8k4iI=;
        b=pf6xAgs2GOGpQizx9usDkLcUyj8TaxV+3e2yGvfUkaESxOrJmpztHw2NpeCbhFOTXB
         F6mMlCnJnCLrWiYGusWZoTOa8XZf/2fZrgnXolVwrIUXSeu3zH1D1JCWWpoHDn65cnoW
         pIDWyj4FaPCxwxb2avNAwZI3oi0gs77VpXK+Y7mo5a7w5Gg11tebL/Ndupxek4QJrGWP
         GKuj03Sl3nux2bfDkWasbdiY/jk/zpMfS9+PNm3a9i4hmawPjzBDx2QU6setYlm5+bi/
         K7M3ltvpoya6e/NCjOEmDIqE/cNj0w/16J/JBMghbgWQ6ax6v88LkV/pt8KsOa1gv9xG
         G6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=dtKej02h+1TV9axASqMyo+46GQ2AWmeQJY/blc8k4iI=;
        b=VG66oyIyQ7236D/q9spDo4qMOkUkwX2fOFPfskcG1kvA1sI3SG3ioDhaajpoq7SmiV
         XdAMtbnFM4mbbbVtuXc5Yv4XVQVDTjLJS/c3Wq3jSHdXVmgWbN4WA29TQEy0oSee7W+W
         yTSnRABV1oXU/a7+feiPwnyy61YMmddCfwB8o5Sog74WBzhYEu8it2WRPXgOddEoUgt6
         cA2NW9XpTDGylzhs5b9HyYec57ia5CFXiJfq8pv4bpPtSw3uFBfyHVR8ayN9musmk0k2
         Ij+g8KrSIekUWGkW41QZtOhPAKv5EInIzgPi0M8fqvfNpUG88du6mYmJSyfvtTAhidOR
         cf3A==
X-Gm-Message-State: AGi0PuZNOnj+kl6hecXTNiffJekI8yI7jJuEUEyYlTl0Qigxlxgug16r
        4lAKRkHzripJO0BDiPP9SZYwlZWt
X-Google-Smtp-Source: APiQypI91YzF3ibAVXiQVMkI9vhQda9+IoQXPfYlTuOo1kyOmNRnH7Stje7Tcb3LIoNfgQTHWoFBJA==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr12798032lfa.182.1588621882967;
        Mon, 04 May 2020 12:51:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o18sm10552657lfb.13.2020.05.04.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:51:22 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Ewa =?utf-8?B?xZpsaXdpxYRza2E=?= <kreska07@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org
Subject: Re: file is showing as modified even that it was never commited
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
        <20200504055530.GA13290@konoha>
        <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
        <20200504120024.GA3372@konoha>
        <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
        <874ksvei1r.fsf@osv.gnss.ru>
        <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
Date:   Mon, 04 May 2020 22:51:20 +0300
In-Reply-To: <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
        ("Ewa =?utf-8?B?xZpsaXdpxYRza2EiJ3M=?= message of "Mon, 4 May 2020 20:39:10
 +0200")
Message-ID: <87o8r3cwcn.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ewa Śliwińska <kreska07@gmail.com> writes:

> Hi Sergey,
>
> Thanks for engaging here.
>
> Actually, I gave some details in the first email, I'm not sure if they
> were even noticed.
>
> About asking second time: I emphasized this because I felt this part
> was ignored and I didn't like it.
>
> I wanted to describe problem more generally and gave you the commands.
> But now I will paste the console full output as you demanded:
>
> mac:lp3rater noelo$ git status
>
> On branch master
>
> Your branch is based on 'origin/master', but the upstream is gone.
>
>   (use "git branch --unset-upstream" to fixup)

This is something I've never seen before. Dunno how this happened to
you, but to me it rings a bell that something weird goes on in this
repo. Maybe it's in fact nothing, but then you may get all kinds of
nasty behaviors if repo is indeed broken.

>
>
> Changes to be committed:
>
>   (use "git reset HEAD <file>..." to unstage)
>
>
> new file:   .idea/.gitignore
[... a lot more new files ...]

Interesting. Is it the .gitignore that tells git to ignore all files in
.idea/? If so, it's not a good idea for .gitignore to ignore itself.
It's very confusing at minimum.

Many new files also tells that you somehow, apparently by mistake, added
all these files to staging (that will be committed at the next commit).

Also, apparently you already did this same thing before, so there are
some more files from .idea/ that are already there.

[...]

> Changes not staged for commit:
>
>   (use "git add <file>..." to update what will be committed)
>
>   (use "git checkout -- <file>..." to discard changes in working directory)
>
>
> modified:   .idea/sonarlint/issuestore/c/0/c02b58f69e810278d2d423bdee557628145ed943
> modified:   .idea/sonarlint/issuestore/f/b/fb31951790c271e26d568f9ac5b7681e7f0804ec
> modified:   .idea/sonarlint/issuestore/index.pb

These were likely already committed at the previous commit(s) and now
have some changes. Try, say:

$ git log -- .idea/sonarlint/issuestore/index.pb

to see what commit added the file.

In addition, try:

$ git check-ignore .idea/sonarlint/issuestore/index.pb

to check if the file you think is ignored is in fact ignored, as it'd be
the simplest explanation of your troubles if it isn't.

HTH,
-- Sergey

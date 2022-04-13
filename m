Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F759C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 13:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiDMOBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiDMOA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 10:00:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B19245B1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 06:58:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t25so2462531edt.9
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 06:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7vZ4a9u6TfX0/3gmy+hWafM/moCz6OI3NSNaipbyPFQ=;
        b=HZjuk2aXKiR+tzeGeaq7qlb0Byry1ad8DB31ZDc6HKT65jdUpKIcUD45FUHq+ytehh
         /rmU0zCHxVmtS4LyDC+m37BJ9hRvKSzeJ80Ntyx0rfXB+SfGQsmf95DTphFb/Ov+XaU0
         4NoYScxtZZ1Ur6oGTgZlJIa4agW3T7X0x5RRe+9pVpmcRXusvk+/n4JxmLx+vsVezr+r
         0R+CS0WKxXFGRVn8DdI5V1ORXOA/Ibf5SSf89ChcM9zASKY1XB5TWrVET7CwKj4CMkPf
         jUnIxBf7rUvtt/UbxxiqGEjGiiyGB/7h83g78LrYGEEcDQXDgAoPqHjF8D7WymJNfJyy
         zskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7vZ4a9u6TfX0/3gmy+hWafM/moCz6OI3NSNaipbyPFQ=;
        b=4lyKexRNRTiKWgEWpoaypcn3BKuiqloJCH9MVaassG5CFFB2FdgqHqjM6K3eCkTTS/
         kN2miB5pyPUgVOVClKQQGRmKFa523Ebi4NYT1YvhAwiCaFX4y5kXad8qjzN0BnKpP5ee
         3AyDdh2/CDBOCotGNOau44QwhH1YKAjqcoFF06mUSdliJcQLWedm6SNWWdXDtqZPpYTY
         RwnWi5JSKLmnH+3+VfuHXA3hvrSsGq0c9NQCdMVAG8WN9qGLc+7KyZf44QkiKIwXoCGs
         GHiBVVIfrDYMuJHkShnLUQpvFCZTzu2bgaJOiHrvP5AzFaBtvpBMbbj8pJa3AdLujOYK
         zssw==
X-Gm-Message-State: AOAM531naRZgTGyWJoKHnfxewTgtbAYWF9+loZarP/Qs4Wo5/s61vInR
        bo0MpX34k9vX4pn72E9iUy4=
X-Google-Smtp-Source: ABdhPJzrTwgwusvguTIASHal+/SozC2P/I+DXWyHwSQIjwMEOIR/21cZ7yS9ZmnPNiIl4i4aQs+9FA==
X-Received: by 2002:a05:6402:d6:b0:413:b81:6695 with SMTP id i22-20020a05640200d600b004130b816695mr43990703edu.176.1649858315501;
        Wed, 13 Apr 2022 06:58:35 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm14039ejb.220.2022.04.13.06.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:58:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nedVy-0053uV-8l;
        Wed, 13 Apr 2022 15:58:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Gregory David <gregory.david@p1sec.com>
Cc:     git@vger.kernel.org
Subject: Re: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'
Date:   Wed, 13 Apr 2022 15:57:57 +0200
References: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
Message-ID: <220413.864k2xgk51.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, Gregory David wrote:

> [[PGP Signed Part:Undecided]]
> Hi, this bugreport is about a SEGFAULT on git binary when running in
> this repository (for example, as it also segfault on other private
> repositories): https://framagit.org/groolot-association/osc_looper.git
>
>
> What did you do before the bug happened? (Steps to reproduce your
> issue) I just wanted to list branches, and so playing with 'git
> show-branch --current --reflog=3' in the repository
> https://framagit.org/groolot-association/osc_looper.git
>
> What did you expect to happen? (Expected behavior)
> Not to segfault
>
> What happened instead? (Actual behavior)
> This command fails with a SEGFAULT on version 2.35.1, 2.20.1 and 2.17.1
> It also SEGFAULT on branch 'next' of github git repository.
>
> What's different between what you expected and what actually happened?
> Segfault
>
> Anything else you want to add:
> Segfaut happened when '--current' AND '--reflog=3' are provided together
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.35.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.16.0-4-amd64 #1 SMP PREEMPT Debian 5.16.12-1 (2022-03-08)
> x86_64
> compiler info: gnuc: 11.2
> libc info: glibc: 2.33
> $SHELL (typically, interactive shell): /usr/bin/zsh

This appears to fix it, but I didn't have time to further validate it,
come up with a test etc:

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 330b0553b9d..be3890b2dd6 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -881,10 +881,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				       get_color_reset_code(), ref_name[i]);
 			}
 
-			if (!reflog) {
+			if (!reflog || !reflog_msg[i])
 				/* header lines never need name */
 				show_one_commit(rev[i], 1);
-			}
 			else
 				puts(reflog_msg[i]);
 


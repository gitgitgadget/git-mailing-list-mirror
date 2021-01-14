Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B024FC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888A623A5E
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbhANXH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbhANXH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:07:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9BC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:06:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u4so4084143pjn.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hZYk0FfhU6pHGa7mp5f1MBCKnZQLeks/kL9M2BNP2XE=;
        b=enZ/1L7ZifMKjNiI53nvbjnv/+CdMxPFJZnEMVgGt0x9aTcwaLp1NpJHG9BlUUTxIo
         Q9oDdBOo+RW4peAygkkfpsCoV9WRUJMNZ/MuKlmgBQ4cCBZFImytjveSpVkis5ZP9NxL
         gVrH2fQvyDSYz40S6mFix5R9Uo2Oo6mtr1IerzqhPgKDN77Qqca3g/M0Cj/KbzplEoXT
         TTAp6W0IzQ0uwdZebzj5wj+L7D0dRmh7Y6Q6IOhO0YshoT9GnmoKS0uhB8i18xNDYjOM
         tVZ5tAX/TEQH/zlDFMQECx+g/Emo/wXvHWtfgVJymWY2j9Spp8Q35GoBsZCRFYW5Ux70
         tG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hZYk0FfhU6pHGa7mp5f1MBCKnZQLeks/kL9M2BNP2XE=;
        b=acCepu377t6jn7deQl6gBmxiSPAlFBsDeedpe6icRT4fjJCLvjBxkslF/SBN/Mn4an
         UZKkiSGFjv4hxnhhO4LRb/m2NLtj+9BPc69p+tK2dlzxhq+ivTf0rOP+AiqX7A9rR9pb
         XW9D2B/GdjVBUmFy6tVWNydlS6tEiOYckAKNkcszH/XlsvKxZdVobuIV7fhMWfmt8YJv
         CKPOtAshD6uz8StOOPBFO+BF5ojKpgZgXSi22MUPYagElwtMEKcsLKEkvvk3Avp9bXU5
         IVXInoYYCVqwd3NnPrGcUf3jzdk37aO+MKWteKgub435F6b8mfyWZ7XJIorglEnLOooq
         NwPw==
X-Gm-Message-State: AOAM531SrTuRZHj+GXnntQV4F158yF9Tu+bEVmFauITRGsPWMr4NcWqk
        +n0JP6No+x55Hs5dV8yZ13l2QA==
X-Google-Smtp-Source: ABdhPJzwWnk0HzC9XA3kUOVDLB+oqr36PZfP1XiA6SAu49sEPq+SLOCEDIWK/IGGzyCqyLPyyP2/Ng==
X-Received: by 2002:a17:90a:d3cc:: with SMTP id d12mr7145156pjw.202.1610665605572;
        Thu, 14 Jan 2021 15:06:45 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id c5sm6336799pjo.4.2021.01.14.15.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:06:44 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:06:39 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <YADOf41CcaRuToD7@google.com>
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 11:22:23AM -0800, Junio C Hamano wrote:
> * ds/maintenance-part-4 (2021-01-05) 4 commits
>   (merged to 'next' on 2021-01-08 at 1f98c859ea)
>  + maintenance: use Windows scheduled tasks
>  + maintenance: use launchctl on macOS
>  + maintenance: include 'cron' details in docs
>  + maintenance: extract platform-specific scheduling
> 
>  Follow-up on the "maintenance part-3" which introduced scheduled
>  maintenance tasks to support platforms whose native scheduling
>  methods are not 'cron'.
> 
>  Will merge to 'master'.

This series again has troubles running inside a directory with regex
metachars in the path. Courtesy of Jonathan Nieder, I think this fix
matches the intent a little better; but if we don't like this, the same
lines could be diffed just to add --fixed-value instead.

Before this patch, the test said "Is there something configured in
maintenance.repo that looks like $PWD?" and after this patch, the test
says, "Does the config in maintenance.repo look like $PWD?" - so it is
not quite semantically identical but I think may be clearer.

 - Emily

-- >8 --
Subject: [PATCH] maintenace: explicitly test value of maintenance.repo

Make t7900-maintenance.sh easier to debug by printing and checking the
value of maintenance.repo rather than using a search string. Since only
one maintenance.repo is configured, this is fine; in the event that
multiple maintenance.repo are configured during the test, instead the
directory under test should be provided along with '--fixed-value'.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t7900-maintenance.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2e0c8a4c31..0edad63227 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -487,7 +487,9 @@ test_expect_success 'start and stop macOS maintenance' '
 	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
 
 	# start registers the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	pwd >expect &&
+	git config --get --global maintenance.repo >actual &&
+	test_cmp expect actual &&
 
 	ls "$HOME/Library/LaunchAgents" >actual &&
 	cat >expect <<-\EOF &&
@@ -512,7 +514,9 @@ test_expect_success 'start and stop macOS maintenance' '
 	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance stop &&
 
 	# stop does not unregister the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	pwd >expect &&
+	git config --get --global maintenance.repo >actual &&
+	test_cmp expect actual &&
 
 	printf "bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
 		hourly daily weekly >expect &&
@@ -538,7 +542,9 @@ test_expect_success 'start and stop Windows maintenance' '
 	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&
 
 	# start registers the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	pwd >expect &&
+	git config --get --global maintenance.repo >actual &&
+	test_cmp expect actual &&
 
 	for frequency in hourly daily weekly
 	do
@@ -551,7 +557,9 @@ test_expect_success 'start and stop Windows maintenance' '
 	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance stop &&
 
 	# stop does not unregister the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	pwd >expect &&
+	git config --get --global maintenance.repo >actual &&
+	test_cmp expect actual &&
 
 	printf "/delete /tn Git Maintenance (%s) /f\n" \
 		hourly daily weekly >expect &&
-- 
2.29.2.490.gc7ae633391

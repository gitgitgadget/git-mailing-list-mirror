Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D5DC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47712206DF
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hirgMoZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfLDVY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:24:56 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34508 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfLDVYz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:24:55 -0500
Received: by mail-pj1-f68.google.com with SMTP id t21so338269pjq.1
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 13:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EnvOE1VxzbSc13QEcl13K17m6JEvpfDSX4RaH1406rE=;
        b=hirgMoZfdR/8qF56VEUJMQvJbaTNXry0m8+0iOfvWTj10yCA6KT9Dl7D8OCh2a+I1X
         QY1/OZtBBMYnMhfQ6pSa/V4LaBZt/D4mv9ZEYaweJSPctPPa5iPm2vzgheVPGzeK9scu
         tQB6aLxRBRRFeIC4rUhfgXoHgewFKXrJRnfWhLqR+6zMAQ7RD4bHwOr2gXNo0yik9/cR
         oWS4Bb6Y6yHzzlTNJcBLovCmY5z9vlyQWgixFmCQcDkyh+958Jyx0DEdz4ip9JsaCIFb
         HENK5VQdfvalfG75xH4LsZhBf+6N39bmwpLg65kCVHQtbV8B7Rn/L5+9lk53akk2r/DK
         PlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EnvOE1VxzbSc13QEcl13K17m6JEvpfDSX4RaH1406rE=;
        b=F34Jw5AmQSsD086S0nBiVbmsRHWYMrUgFrUKLEsNRrELJ53SE4bKxtM23tgn544E4W
         C9soVq/4Vi3MDlBs35qPV/3IKg+RVgok0Hn1cJZizkvRPDgPMqnflmzWm0RH22mvoj2r
         SgDQ2BCJFwNfcxkudB64NbU6CpdVULrU1G2a3FbFnDtPGJnwY6KkmPKmw/DbhP2NRTC+
         f6j9JUrBRP2Crurc6KKWQiMyhc+41eYSzY3eUrs/cKsQgL9FnNlWPcRVb3NZyY5/jBIX
         JNaynhAtc0gixD8i02/p9xi0BjtFVj3ESyOCMKWf4OKWbv7x+aceZNe5LoIpwEdvF2dh
         b9Cw==
X-Gm-Message-State: APjAAAUtRV2H9MXq3IcvdO5T2xghvCzGIeg/041vomsLXu2CZJLGC0cs
        DFt306AKpfuYD3VML0iJoy+7laAx
X-Google-Smtp-Source: APXvYqyPQcqBrcd3a7UWd8cRe2W2GkgQHnE3VR9pywUptTYUx0QMqcI4BLfn2wEKnWaIeskRg+Sb7Q==
X-Received: by 2002:a17:90a:f0d6:: with SMTP id fa22mr5454082pjb.136.1575494695126;
        Wed, 04 Dec 2019 13:24:55 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id p28sm7028755pgb.93.2019.12.04.13.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:24:54 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:24:50 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 1/5] t3400: demonstrate failure with format.useAutoBase
Message-ID: <386148a550bdbd06e3c35cd506f69c229a4df664.1575494618.git.liu.denton@gmail.com>
References: <cover.1575445582.git.liu.denton@gmail.com>
 <cover.1575494617.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575494617.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since bb52995f3e (format-patch: introduce format.useAutoBase
configuration, 2016-04-26), `git rebase` has been broken when
`format.useAutoBase = true`. It fails when rebasing a branch:

	fatal: failed to get upstream, if you want to record base commit automatically,
	please use git branch --set-upstream-to to track a remote branch.
	Or you could specify base commit by --base=<base-commit-id> manually
	error:
	git encountered an error while preparing the patches to replay
	these revisions:

	    ede2467cdedc63784887b587a61c36b7850ebfac..d8f581194799ae29bf5fa72a98cbae98a1198b12

	As a result, git cannot rebase them.

Demonstrate that failure here.

Reported-by: Christian Biesinger <cbiesinger@google.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3400-rebase.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ab18ac5f28..ca99e8c6c4 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -159,6 +159,12 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 	test_must_fail git rebase
 '
 
+test_expect_failure 'rebase works with format.useAutoBase' '
+	test_config format.useAutoBase true &&
+	git checkout topic &&
+	git rebase master
+'
+
 test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
 	git checkout -b default-base master &&
 	git checkout -b default topic &&
-- 
2.24.0.578.g4820254054


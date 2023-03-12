Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6BFC6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCLUJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjCLUJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:09:27 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBBB766
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:07 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17786581fe1so4472065fac.10
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678651740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y3mmcLrjJlhO1Q8g5wJPOGcGtUh0BkXk09fcnrGsmw=;
        b=oboRg1l+rD57mAZBRYZlZqSxKY6gBZOKbOa3s4qHkHG3jSS2hS3W6PwW2RclVGRirJ
         WXF70IREFBy8oSGE6e1G1+z7URL6d9I+8MmtmP6X8JCQlbceR6hN3TqzKuGEKw/fC7cz
         0l2pXzH9nhoYDZRn2ZO63oRhIzTrOeMVFwf+DpFtXvr3lWlq4x0r4iIZE34xuhYvPuWP
         hbUgERCKPYHEAAFo/GAaMVzG8aAeM8gTA/jrR5USOVWEV8mFX/U142PsyaBFMploivMO
         CArGhleWn/4xuj2p2Uey+LaM9sMdIK1pWaTRFObwGAWslZy/pIHWMKzY8tu/rFrLms2G
         78Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Y3mmcLrjJlhO1Q8g5wJPOGcGtUh0BkXk09fcnrGsmw=;
        b=2JdwUpFyuljc2TjuawTVDFqCgB+dl3hXF0LgKVcqB8nIwtMZzzBnIVPu5HIuXyW2A7
         pnuzs6B6JG6/pVTPSeh1Lot4EhWuu02dALySLIUmQTO/akX+oPdjELAMTjlgUPwLhVBC
         Ns4DBlMC5v50U8Csmzt/y2QAVGE6vSXWSi5ssqneGe/zirYgXAXQ87+46P7rZ4hgxnRj
         BF7Cp+qHeKIHLfprJJ2Lx70GExLNS45QS+1bH3MbQgUnQx3iwkVPVa9ug0/5RLHxBUkG
         b064dRkpV9ohPG1lwGZ3um5kvkKip9TKaV5bI6P0W6zpRrYlZTGGc5iQOaefPEvJNkDM
         K40Q==
X-Gm-Message-State: AO0yUKXbAZUo3k8Zi9CHxNRexBV9JKkCToj8qoALaT8dWogrmDPI0qKj
        ttde3sLZ383HnfleqKL78I4XYLuvI5I=
X-Google-Smtp-Source: AK7set/fuuZJA8Kc1vKO4NH7HnHU1RNrFWIsYIV0raRjPFeUVMHAhSF/kgk2LoDy8zmoGnu4Y/WQfA==
X-Received: by 2002:a05:6870:45a0:b0:177:a308:8bc6 with SMTP id y32-20020a05687045a000b00177a3088bc6mr1776406oao.18.1678651740198;
        Sun, 12 Mar 2023 13:09:00 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ef49-20020a0568701ab100b001724742cfcesm2320428oab.38.2023.03.12.13.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:08:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: [PATCH 2/5] perf: grep: fix prereqs
Date:   Sun, 12 Mar 2023 14:08:53 -0600
Message-Id: <20230312200856.323688-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230312200856.323688-1-felipe.contreras@gmail.com>
References: <20230312200856.323688-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 5dccd9155f (t/perf: add iteration setup mechanism to perf-lib,
2022-04-04) they are in a --prereq option.

Cc: Neeraj Singh <neerajsi@microsoft.com>
Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/perf/p7821-grep-engines-fixed.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
index 61e41b82cf..0d75240dae 100755
--- a/t/perf/p7821-grep-engines-fixed.sh
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -33,13 +33,13 @@ do
 		fi
 		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
 		then
-			test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
+			test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" --prereq "$prereq" "
 				git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
 			"
 		else
 			for threads in $GIT_PERF_GREP_THREADS
 			do
-				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" "
+				test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" --prereq "$prereq" "
 					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine.$threads' || :
 				"
 			done
-- 
2.39.2.13.g1fb56cf030


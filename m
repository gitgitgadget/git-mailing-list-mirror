Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96587C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJQMJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJQMJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:09:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E2E12636
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a10so18081449wrm.12
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwGxtHIHhVPIg+fv1qAnIT9T292NfBRVXlNSZB1a+AM=;
        b=XpRp3EfY2YL1oTDs014grm1WVGoV2f7wVO55lCKvnX0w2jAinPRnNE0gWDQnkUlwtb
         rB2BCfKXlUYrclXqD0ey4dl4wcs6uD2BpQ+DOMQ+X6cbVOKnxbJ0jmpjdWqApam3aou8
         6T48UPVXTRfN7X0Znq/CX0mG5fCYFw8fS/LEMRaNmkjS8sjjscVgwjBFfSsllTapaCze
         Lh3V5w8tWDJMR3rIaMQv77FNL7bWtU3SV0ytNoltrQEx9nsOXlguGCRCy1hAKsJzHzoD
         ToE6o1ZIGfnAz0d9Xjf9wgHvROlFAJgPSstU/qIMojhpOShue5RKIx+D4NmNxSJsz7gj
         z26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwGxtHIHhVPIg+fv1qAnIT9T292NfBRVXlNSZB1a+AM=;
        b=qh3rLKVq8f8QcX582T6aj1V/RqdJGRXWl25Y9eTqcg2VxvC+04+K/sISTIueH1XbQi
         DBKoixNMCAx4RHMd2MBk7tdNjEO/3lDK5bJaAng3wGLVikQ7UB3/OpMCHUpeKPHtMwYg
         peNIafYQS0rreDxzDd9PAdT3nc0CqCGYUulEl4JEjYW4nQObrtJOiCoFnZ9I9kDe4yDJ
         u/st/QbzXH2wrZ4zvek5y7bC8C5Jtbe+knz4V7kerMU0v3uxVLauN3OMxoaiuN8ozhpE
         T+4ZN/k/OSZyeonZ3fRfKH3ODv1wYvZAnnG1RLGGj9HBhdxU6JhQnlcd1A3j+/9hGW1s
         gfnQ==
X-Gm-Message-State: ACrzQf3vG/vHO/VrhlGixU4WrFHZSm5S2Kw1ly1etIXSB754DKeW6ryw
        3vrAOkESk0uGQHNEdtqUo6p9JatYsYv4vQ==
X-Google-Smtp-Source: AMsMyM495G1hvciXkUWbpx5sqBmNRtBNU8vNkzo1e+GnSztQqXGmizrXY55tqV2GsL2944+EvVXS4g==
X-Received: by 2002:a05:6000:50a:b0:225:210c:a7e4 with SMTP id a10-20020a056000050a00b00225210ca7e4mr5896284wrf.704.1666008574430;
        Mon, 17 Oct 2022 05:09:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] git-submodule.sh: dispatch "foreach" to helper
Date:   Mon, 17 Oct 2022 14:09:19 +0200
Message-Id: <patch-04.10-db6a09ee42a-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dispatch the "git submodule foreach" command directly to "git
submodule--helper foreach". This case requires the addition of the
PARSE_OPT_STOP_AT_NON_OPTION flag, since the shellscript was
unconditionally adding "--" to the "git submodule--helper"
command-line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c |  3 ++-
 git-submodule.sh            | 37 +++----------------------------------
 2 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b4acb442b2..d11e1003019 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -403,7 +403,8 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
-			     git_submodule_helper_usage, 0);
+			     git_submodule_helper_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
 		goto cleanup;
diff --git a/git-submodule.sh b/git-submodule.sh
index 2bdff5119c1..7874e33beea 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -50,37 +50,6 @@ jobs=
 recommend_shallow=
 filter=
 
-
-# Execute an arbitrary command sequence in each checked out
-# submodule
-#
-# $@ = command to execute
-#
-cmd_foreach()
-{
-	# parse $args after "submodule ... foreach".
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			quiet=1
-			;;
-		--recursive)
-			recursive=1
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
-}
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -263,10 +232,10 @@ case "$command" in
 absorbgitdirs)
 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
 	;;
-foreach | update)
-	"cmd_$command" "$@"
+update)
+	cmd_update "$@"
 	;;
-add | init | deinit | set-branch | set-url | status | summary | sync)
+add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
 		${quiet:+--quiet} ${cached:+--cached} "$@"
 	;;
-- 
2.38.0.1091.gf9d18265e59


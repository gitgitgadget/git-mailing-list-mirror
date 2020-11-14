Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35584C55ABD
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE61A206B5
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCV/MbeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKNMVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 07:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgKNMVr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 07:21:47 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1CC0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:21:45 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so13271083wrl.7
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWHers9FmrpI5p/F8dzjuIYWnlN5sQpfKO4SVoRYTrU=;
        b=dCV/MbeAB1wd0S8ZTQ1cd9TACqiyPewKPVh9BmD6rbR8fzf6idu5fRDZUZBXkpT4Pb
         pLsa+WJdktaaw7RzeCv1pnT4Kj6mptTqNcn4F/9GwJxKe2o635OAjrzchACHcGozQBao
         mxWYrkr839veRhTgBoRjqxx43+SwJX5O2i2pS1aaWokict4QYk80asLBGooRjXuh8vh0
         y+nRZyP5aHBBg5vhkpuxIrq8295agdIAcFPW1q4v+0ebx70jLbtmNtyjX0go9uhQptpw
         ns9VYYapZBvGTYcJduMpJSDPWWPc71SwE5sRPK99/mFEJ1ZIldCtEG4mj0GEL9JZl1O4
         IWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWHers9FmrpI5p/F8dzjuIYWnlN5sQpfKO4SVoRYTrU=;
        b=qrOxuk1C5opbwuhRZz+2E+XeJ9Ddn7hJW5wM10bph+z16xTWkQG5yZ3GxZEoRgusWZ
         9FVTIYnbcxGrgkvQVJzz4APksDB7sEw6a/qdbTbd2FnJYj+BJZBuK5xi+IW9cweC6wIY
         44zKVvYm8ZJrwB5p2EWHunhjLBdeJgOh2Qe9BGm6IHVESMTcwvhPF5rnjf2Xb0h5o9Le
         PC01ZCsmiTTIWeNBPdFTHK937McvENC//fi3V4P6/njMPFOUOjmIX71TV2vDlE6EqpiS
         LcqyHsYSubuRi9cyvu5RxZjXNSrEFI4a3mS2ZMxbplgi2hFSBmY9jqaqCjpXxt6gOM8N
         b9vg==
X-Gm-Message-State: AOAM531nBCXNOlbs6JPIqZ9ZMOVoFE63K2+mY2WfPm/Vs07FfFgqnOgR
        B3KEnceOWoRcY+en0PuaII3ej73JxS+lmQ==
X-Google-Smtp-Source: ABdhPJykNDeCNaTMGMiCPRkJM7NgWGRLaSel/Nw8UNpXTpLhTPlf28QqD9I9BxttZ1p4cTuqV3RoIA==
X-Received: by 2002:a5d:67c5:: with SMTP id n5mr9855307wrw.179.1605356504249;
        Sat, 14 Nov 2020 04:21:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12845225wml.21.2020.11.14.04.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 04:21:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] submodule: use "fetch" logic instead of custom remote discovery
Date:   Sat, 14 Nov 2020 13:21:30 +0100
Message-Id: <20201114122132.4344-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201112203155.3342586-1-gitster@pobox.com>
References: <20201112203155.3342586-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace a use of the get_default_remote() function with an invocation
of "git fetch"

The "fetch" command already has logic to discover the remote for the
current branch. However, before it learned to accept a custom
refspec *and* use its idea of the default remote, it wasn't possible
to get rid of some equivalent of the "get_default_remote" invocation
here.

As it turns out the recently added "--stdin" option to fetch[1] gives
us a way to do that. Let's use it instead.

While I'm at it simplify the "fetch_in_submodule" function. It wasn't
necessary to pass "$@" to "fetch" since we'd only ever provide one
SHA-1 as an argument in the previous "*" codepath (in addition to
"--depth=N"). Rewrite the function to more narrowly reflect its
use-case.

1. https://lore.kernel.org/git/87eekwf87n.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7ce52872b7..d39fd226d8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -416,13 +416,15 @@ is_tip_reachable () (
 fetch_in_submodule () (
 	sanitize_submodule_env &&
 	cd "$1" &&
-	case "$2" in
-	'')
-		git fetch ;;
-	*)
-		shift
-		git fetch $(get_default_remote) "$@" ;;
-	esac
+	if test $# -eq 3
+	then
+		echo "$3" | git fetch --stdin "$2"
+	elif test "$2" -ne ""
+	then
+		git fetch "$2"
+	else
+		git fetch
+	fi
 )
 
 #
-- 
2.29.2.222.g5d2a92d10f8


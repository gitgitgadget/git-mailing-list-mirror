Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81112C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BC1206A1
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEWh85fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgKKPSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKKPSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 10:18:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B90C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:15 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b6so2895632wrt.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/AgsSwIkv6DR9jL7gu8P35IXy0WUxl40RfDiA9NwTJk=;
        b=EEWh85fulmNzCGI1/z4o6hIczTsFNQ9oxm6wBdVIvWptDlA8w8knhe/GUZivCuaAUe
         QNeYWcwVtNHBVXev4Z6Gm9A1ZECZkzeBTOQ4ZJ+IcXeHDXV9xTIHSsRS8IG++BjDeVPk
         Nzd71KuXDjZLyhhJNo08p597gq8MsxJJFX8tvHIxATw0iXhPMUf8m4OItwnjf2f3Gb5u
         RcccUS0byj5NqI7gcUzjwm3BrYyOa0/w8AodGIqKhB7pI5QiUZDIxDxXpVPdlZGMcRQ8
         S9y4WGZc4D15DchIep840ZsLM54K/cTAivZFBXWqjRdTCN1Bz0QoSfC+HKlXQjGIDg5f
         FlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/AgsSwIkv6DR9jL7gu8P35IXy0WUxl40RfDiA9NwTJk=;
        b=hniVWKomdWzKYDKNReV77phQUHOQYN999Y0XK5H6t4xpUbEdtR31pS8d07DNtFkofQ
         UTRRLBOGr7zi65YNa1up2FOJmJuXLXr2Y6wookEP3S2CNGoKVzPU+q1G603/RrM1HQq4
         NyXE0uCmC3nHh98KAo/xu78plmRaa21a0sxmd9K6DY2UA31hcl+vye5i+MDRJjpCnMpN
         COZJpcUDS97lBInDMSxiDVO711owsVK4IMgJR7tG/8ACMQzFTBQgOVYzfd7k3eK1v8fm
         Hy2yMVnCcC9E/kAq/DuGv0PvhhmJyzDBNue6Vn/dV9BiMT0mUeTH4LSABly64YwKGg7G
         6VYA==
X-Gm-Message-State: AOAM533+VGNOav81MM/pFip1JDKsO7HsPac65pPcnsu2yqcjZKuBsbjh
        w+xmwMvKW1wGsOkRB4r333CsF6WbwUTL5A==
X-Google-Smtp-Source: ABdhPJyDjYULkdz4n6x3149FYMDZLp+N4p2k3AQ+/DrAiIvsVGsLIBmhEB4CJAuPmydIGIhuCIGN4g==
X-Received: by 2002:adf:df88:: with SMTP id z8mr30212179wrl.113.1605107894201;
        Wed, 11 Nov 2020 07:18:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q2sm2940010wru.76.2020.11.11.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 07:18:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] parse-remote: remove long-dead rebase code
Date:   Wed, 11 Nov 2020 16:17:51 +0100
Message-Id: <20201111151754.31527-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code that was last used in the now-removed rebase.useBuiltin
setting. See d03ebd411c ("rebase: remove the rebase.useBuiltin
setting", 2019-03-18) for the removal of its last user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-parse-remote.sh | 47 ---------------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 6b743cda17..e3f6195281 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -48,50 +48,3 @@ get_remote_merge_branch () {
 	    esac
 	esac
 }
-
-error_on_missing_default_upstream () {
-	cmd="$1"
-	op_type="$2"
-	op_prep="$3" # FIXME: op_prep is no longer used
-	example="$4"
-	branch_name=$(git symbolic-ref -q HEAD)
-	display_branch_name="${branch_name#refs/heads/}"
-	# If there's only one remote, use that in the suggestion
-	remote="$(gettext "<remote>")"
-	branch="$(gettext "<branch>")"
-	if test $(git remote | wc -l) = 1
-	then
-		remote=$(git remote)
-	fi
-
-	if test -z "$branch_name"
-	then
-		gettextln "You are not currently on a branch."
-	else
-		gettextln "There is no tracking information for the current branch."
-	fi
-	case "$op_type" in
-	rebase)
-		gettextln "Please specify which branch you want to rebase against."
-		;;
-	merge)
-		gettextln "Please specify which branch you want to merge with."
-		;;
-	*)
-		echo >&2 "BUG: unknown operation type: $op_type"
-		exit 1
-		;;
-	esac
-	eval_gettextln "See git-\${cmd}(1) for details."
-	echo
-	echo "    $example"
-	echo
-	if test -n "$branch_name"
-	then
-		gettextln "If you wish to set tracking information for this branch you can do so with:"
-		echo
-		echo "    git branch --set-upstream-to=$remote/$branch $display_branch_name"
-		echo
-	fi
-	exit 1
-}
-- 
2.29.2.222.g5d2a92d10f8


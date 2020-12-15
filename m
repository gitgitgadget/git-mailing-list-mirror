Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294E5C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8AD22CB8
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgLPABl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgLOXvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 18:51:24 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EF9C061793
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:50:44 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 91so21474412wrj.7
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UrubKNLTvJdpQPZNlbdPsrhDZYVD72fyFVVDDkURBg=;
        b=NjHBvt/UbEzaDJkYntINEi58Nxv+op9LINjus/Jzq9qtrsDRcwNZz8lnytemgEFKv5
         yw3Jl9SRH8ErQ6+/6AK83TtUwy43140LaOOixr+Obddjj8zL0zEPvKDMBA20qKC7Kn8Q
         /0OPtsws4urLvCQWJCcqxVt/J7+N1ov8Wh895HJzAmxTjnRak2o/3JqWeSnkeXpK+y99
         8G0jmvrfsD8Z2EynebpE5xK0Kyt8EbumJMPH6zDha3u3lg/W7NAp2r0oMnKXe1WRCQIV
         mGTmdKSirO/YiT5Qie7SsMxCN6ZX5o1C/VqUZ9nsys0SYUyFSAf+wsUInctpQ3ygp2pD
         2kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UrubKNLTvJdpQPZNlbdPsrhDZYVD72fyFVVDDkURBg=;
        b=Zzc0c9R6gPSTP9VVo/5uXq16vnq9xzgqreWs2VYDAblq8gjnGFmT78cM5j/Fkc6IYA
         WYLeTctDgQbbu+OW9/Zgh3POZ8BNZsyeEg0ThA4H1WiRFA+lm+O+6WC0gkZJTlxVPLAa
         qypj2i4kRD/v+FacgF5KX3C4kxVjSwOO+W+RyHG1sIoOgadpWKUtFeTcO1UWQYi+fiOx
         qrHn0K7IRE5gEwsl4eqIjywcUkkU1bPa1kZ0FDMSf9Sr31zi1ay839wg3vrKp/l2oEDz
         Q+UOA+A4xum2gNg/UCZdGrIZ52jqfA1pPVt5wh+OIfBPqCJLdVcBteUIa/SiFMiPDlbv
         5+1A==
X-Gm-Message-State: AOAM532aZYZ8Cyg12SNeB94UJ8cOGYtFH+9yq0877fexCIxVGwCdrSDO
        QxzRvCthYz06IM2pabSlKD1wdKiWqckjyg==
X-Google-Smtp-Source: ABdhPJy/c2RG9dI7J7R+GaqzFKx1VUqmupUdK8uydeVBBQwAWgaFX7mQQjvWe17TRF2hJszKp04j1Q==
X-Received: by 2002:a5d:570e:: with SMTP id a14mr35620327wrv.126.1608076243050;
        Tue, 15 Dec 2020 15:50:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f9sm417703wrh.9.2020.12.15.15.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:50:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] style: do not "break" in switch() after "return"
Date:   Wed, 16 Dec 2020 00:50:27 +0100
Message-Id: <20201215235027.10401-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <xmqq7dpkdup6.fsf@gitster.c.googlers.com>
References: <xmqq7dpkdup6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove this unreachable code. It was found by SunCC, it's found by a
non-fatal warning emitted by SunCC. It's one of the things it's more
vehement about than GCC & Clang.

It complains about a lot of other similarly unreachable code, e.g. a
BUG(...) without a "return", and a "return 0" after a long if/else,
both of whom have "return" statements. Those are also genuine
redundancies to a compiler, but arguably make the code a bit easier to
read & less fragile to maintain.

These return/break cases are just unnecessary however, and as seen
here the surrounding code just did a plain "return" without a "break"
already.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c               | 2 --
 builtin/fast-export.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/apply.c b/apply.c
index 4a4e9a0158c..668b16e9893 100644
--- a/apply.c
+++ b/apply.c
@@ -3948,10 +3948,8 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 			break; /* happy */
 		case EXISTS_IN_INDEX:
 			return error(_("%s: already exists in index"), new_name);
-			break;
 		case EXISTS_IN_INDEX_AS_ITA:
 			return error(_("%s: does not match index"), new_name);
-			break;
 		case EXISTS_IN_WORKTREE:
 			return error(_("%s: already exists in working directory"),
 				     new_name);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d2e33f50052..0a60356b06e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -923,7 +923,6 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 		if (!tag)
 			die("Tag %s points nowhere?", e->name);
 		return (struct commit *)tag;
-		break;
 	}
 	default:
 		return NULL;
-- 
2.29.2.222.g5d2a92d10f8


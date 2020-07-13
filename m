Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11356C433E1
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 10:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E046B20758
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 10:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK3wHBrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgGMKK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgGMKK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 06:10:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC288C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 03:10:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so12587970wmi.4
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=3PTj4VRENxzwWcqR4TZlHeHBhBiWUf/is80xJx6e5CY=;
        b=PK3wHBrfvl8619ALBk7hUTzPZd0Ko4uoitBtdmADWWGJWU5X0N3jbcltbHX3myOIuO
         5KYMR3MRFUynRmIfdLczgUw7mK38OPG9pImH5ZqsRaP8T9GTIymqdzJUHAb2FpPDqXuw
         t8JqMiT5s+EcxLCxcQtK/kKs3WccU0So2cMqiWfdEZDojbhNbL3R1KuqIahEdUx3QJNv
         56TSEqPAezK1U4/E8Wvme42RF/QhwTCaDRN5Oj/WI9QZOESo4ntPsNYK1x4pO77TjpGl
         4SqiRcGfk+yYky639yVX19FwpDoJBJxzctOlalneyyyYubxHp2VvgAD/mL9REdsoyLCI
         X5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=3PTj4VRENxzwWcqR4TZlHeHBhBiWUf/is80xJx6e5CY=;
        b=HsbsnnV0HcN8NqBvmhMg7dakrjSOUv3Wj69DmKA504wopTtqM8NQiIsW3YS9WxmJmE
         vEzYlZhzROHg5+AJ5PunuupX6waGO6VHxC+o4siLR/RTpTckmWkXJN2bsDRkDQGpGKr0
         bF9FA6wAd3FPOAkUEsfAGq3xxBi4TcMnGiZo7zf3E3l09gKEwmo5ahz0bPnCckFb61kL
         49Z7ptjc0njPs4WE5/qFojL/YrJcfZqq6WDfbdNMZ+ARzC8GxaE3MA3DU65H/c1YOv4L
         hlRynmmVbbBW22BNK8RpDpbX82Me/LnNx+h6znoQJCLNT0RVLYc3dguvJEu2u2hiAiv3
         bUnA==
X-Gm-Message-State: AOAM533Lnjb9Ck1db4ZRHQG+g15ZACtvfXFsudAac4myE27tSH8oVcDg
        SPqrMkDj8nbYUPYt4/WKALI=
X-Google-Smtp-Source: ABdhPJwf7EZeojXD/zyihje4E5X51x9scJe0GfkqjPhgb5cPoHJaVk2T+curznzbQCj2x/A/sJSniQ==
X-Received: by 2002:a1c:6805:: with SMTP id d5mr17539795wmc.19.1594635055524;
        Mon, 13 Jul 2020 03:10:55 -0700 (PDT)
Received: from localhost.localdomain (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id v7sm23811549wrp.45.2020.07.13.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 03:10:55 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v6 3/5] sequencer: rename amend_author to author_to_free
Date:   Mon, 13 Jul 2020 11:10:43 +0100
Message-Id: <20200713101045.27335-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713101045.27335-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200713101045.27335-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

The purpose of amend_author was to free() the malloc()'d string
obtained from get_author() when amending a commit. But we can
also use the variable to free() the author at our convenience.
Rename it to convey this meaning.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 368d397970..29f6d1bc39 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1335,7 +1335,7 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1357,7 +1357,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1474,7 +1474,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.27.0


Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37187C433E3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F2C207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 10:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDSd9EE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgEUKP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgEUKPU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 06:15:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBCC05BD43
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:15:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n5so5813384wmd.0
        for <git@vger.kernel.org>; Thu, 21 May 2020 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=qd715dbSdeLFKR+JaxIImHifxTxyuvLTQs+JKbIOhEo=;
        b=WDSd9EE3c3lxiOMmHv1XZ3STksKfAQdcFbo+la+NJcDjxcgpZgurAABSkVFHrLe+8h
         qy7NRD/DZuYXf7Vsp5FK5DgIPCYBbmgiQkueZy1cJTxM5JL65IIUXRa6YVW2S6GP3lQq
         WXpnLDEAYzIO2vWFjQiH12tTdf9Mu+RfscSWEE66OeOzS5+32qvLOoBFgAuyft9WzJjM
         DKXkr3+uQ1SwAT6ko07/xyBuVNHGRXpVrvZ6zEmG6rx0wLlpJTgPaJuEJLRla/yXwT+X
         X3Zu8wQ8p9J64i1FihMUa0UkdpmA7ficCAhgvnc7rwLuesS512jQmdaBC0ftqtzG/bgX
         povQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=qd715dbSdeLFKR+JaxIImHifxTxyuvLTQs+JKbIOhEo=;
        b=KaCNMsOMllsAWF9XMnv9oFl2oKxQzUyHlMVtp5y2EYAmqFHo7OmNBXVI/jrDVrQj6X
         dSEKQPLsPAvMDuqPsefNSVVmMykdv/Fejq9q6x3NP+aNMyhoL5JQMAiqmBUwQoP10G76
         I7UczKS1Sv9f10SOff5t69vI+VBDahT3MyXHMIgsFF383JEw+RtFdCHs9p0cGaGaZ7hw
         yjoTb0EDpu0YRl14dciXUBWJUecuI5n7XhjMPzqrhoA//9q/PDLFpWfFRotUlvEZN9rJ
         C2rSfUpRVQy8N9ATV6GHTEVyiKZf3saUdZeigptYr+CJ80x1tjvlikvbtvkFhXzbmCKa
         DQ4w==
X-Gm-Message-State: AOAM530mZa/2ay2gTEf++BQy/uypO3L5DdsSkfRdmm7OI69hDWO7s5u3
        2eJBweImx7sSHyPwZeXwWIA=
X-Google-Smtp-Source: ABdhPJwhhmuiS4cU5G/RpBew7qXeJqqKpaMpvQd8cWueXa+k7PAmUtMkUVxzhXlZWzLvkJoY6sk4PA==
X-Received: by 2002:a7b:c146:: with SMTP id z6mr8931741wmi.156.1590056118383;
        Thu, 21 May 2020 03:15:18 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id y5sm656219wrs.63.2020.05.21.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 03:15:17 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v3 3/5] sequencer: rename amend_author to author_to_free
Date:   Thu, 21 May 2020 11:14:53 +0100
Message-Id: <20200521101455.63484-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521101455.63484-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
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
index 8826c6325b..44e0b45e53 100644
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
@@ -1473,7 +1473,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.26.2


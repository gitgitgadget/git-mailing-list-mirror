Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6EEC10F25
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 05:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E42208C4
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 05:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXRCCZ6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgCKFNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:13:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38940 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCKFNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 01:13:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id f7so647005wml.4
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aMQZWM8WsHWjtHzNZ0Q9Z3k9XgcwOKvn20JFZ/gw2Dk=;
        b=YXRCCZ6HdgDYcC8vD8+BUfBC2Ptgzzmlp/7qcpPvrteO82fuxKi3D3mNOTopXrHcEp
         vA0yn5Vc5es759L8RRXBXwV3zLF7FE/SEKBUPn0PsAaoszrvMzRSFfotHneLCbrv+i18
         JqkFmN3HBsbQzm4YqXKZoWMrsICfjeu0eqf2GoiBkAMJwUHZ2mMvM450p1g05w3Br7un
         mim2BXLr8mxAEydz/th7Z8dKuugmHRSMsf5m6Vd7KnSWEm3xzJIAKcl2FQzLM/AIvdvK
         l6o1HFWfn2p3sScrzBd8gRVD5PLA8slMBIu5T8G82nPe/T2VyHBG9PO2pmnOI5molMaG
         83VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aMQZWM8WsHWjtHzNZ0Q9Z3k9XgcwOKvn20JFZ/gw2Dk=;
        b=Ryzg2jtuoyq5ls7pzyfcO4ZEKY+xjE9tsPLhxJcJTwfTcL8MQFYi/0SuGZTSuP7fAy
         Wvs3wFIXU2EjhVJqyI3HmQo7Wg3utGTtkTG109FxpznponPtVsYrYzMmJIUZiff1Q0Ib
         n2UxfE7ak6cU7s9IoXhjmxEieUbeB7PZndPRr0qVxAJ5a7G0F+2CF/dabfV3caFa/iBX
         M4FcR4HkSR+DsliyYJ/YWwjdI/za2udwTR2WsXA2wlH7o48jOwTEv+XjCjXBUL1dERHE
         wXl33HOEI3z8eNM+0LbSZ6vNW9ns8c32sTmUsFqAo8BI+jrkC5IN98Ez3QZKQSpOJ/FS
         G4hA==
X-Gm-Message-State: ANhLgQ37Q6oF87CCB6exXmnJ5EwdqGOt2Fl6xqcwSQ2O+NcFub+jxzgF
        GmTe00lrX5+xDIwFLgiXLKPqiwpQ
X-Google-Smtp-Source: ADFU+vuQboZGhnXCykPKaW1Po2hE7uUrKg6YveG51GzBrMcvBeJokcn2biT4M2OJdIJzj0MtEHaH1w==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr1485417wmh.174.1583903623703;
        Tue, 10 Mar 2020 22:13:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm6541421wmj.47.2020.03.10.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 22:13:43 -0700 (PDT)
Message-Id: <132f769adb0a34e74b6c237ff84bf8b624ea0d9f.1583903621.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Mar 2020 05:13:40 +0000
Subject: [PATCH 1/2] sequencer: clear CHERRY_PICK_HEAD upon dropping a
 become-empty commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit e98c4269c8 ("rebase (interactive-backend): fix handling of
commits that become empty", 2020-02-15), the merge backend was changed
to drop commits that did not start empty but became so after being
applied (because their changes were a subset of what was already
upstream).  This new code path did not need to go through the process of
creating a commit, since we were dropping the commit instead.
Unfortunately, this also means we bypassed the clearing of the
CHERRY_PICK_HEAD file, which if there were no further commits to
cherry-pick would mean that the rebase would end but assume there was
still an operation in progress.  Ensure that we clear CHERRY_PICK_HEAD
when we decide to drop the commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index 7477b15422a..8b4e0200c5f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1957,6 +1957,7 @@ static int do_pick_commit(struct repository *r,
 		flags |= ALLOW_EMPTY;
 	} else if (allow == 2) {
 		drop_commit = 1;
+		unlink(git_path_cherry_pick_head(r));
 		fprintf(stderr,
 			_("dropping %s %s -- patch contents already upstream\n"),
 			oid_to_hex(&commit->object.oid), msg.subject);
-- 
gitgitgadget


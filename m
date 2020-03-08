Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1828C10F27
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF982084E
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 14:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id5Uy83A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCHO6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 10:58:00 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37934 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgCHO6A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 10:58:00 -0400
Received: by mail-pj1-f68.google.com with SMTP id a16so3281059pju.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l35m2qb40GmKtKpeCopWT7AdpsUusqu4HYZvpWqapzM=;
        b=Id5Uy83AUTmXJmCr9qZ5N73aR3pfj9CncT0Ad1y1NjKWqj5Iq66B3EpJ73h4W+uo5N
         fkfTbUysexFxLOeTvDEp2zIX/5vXRmQHedO5639LgA3h1cJ8FSK0qyWF3M646Pnh/dqG
         bp33UWfFgMr02CwVSDRZOm49zPfdKOIeCpj7NG2ZBfTJFnUBrkUFxCGuUewNCqLKw1aC
         0n9nK3x0gwMVz97sngjJ6/BnmCgB2hLktzCjgE5fKgxW2RgkrOVEmKQQvAjdvi3FkkFd
         ITeRxfOUSRUkSqs0ED8FqouxKEt2TC2dEA+Bi1cYRvKrelcaC90znj+u5r4dmuEelKpb
         wt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l35m2qb40GmKtKpeCopWT7AdpsUusqu4HYZvpWqapzM=;
        b=QIWOIgABnYR/m6t5+LXfA+llYeitQLUbEatoPNUlvoEez9R36f6e79x42pMr3mpHF2
         5KW6bDz9Gzu/q9R6AtgtN93Pcsq/pNPu4xt0wqnXHLSJ1TCmugwTFMXdjohOa9/nGY9j
         O29naeaLB0sB/RCHhIgrxLPmjG7Au23582jyCBtRBmHV6OI4BselwLsdEqmQzEl+DJ0v
         uvyJRIHOlnQhx3oLBtxTvgCwohoCa1q2ZhOVznJAiQvbngI6Oy/md9Gec6ZehtQKswU5
         wsbRd4VHH7IXUC79QUamfLY8qY7TRQOwMri5NjnEiXenHxQU5tkBj1CfL1eIOCJ0zJia
         QjKA==
X-Gm-Message-State: ANhLgQ3kLcFpiblfFHZx2mbFD0mnP0A2e6sWvqQs2iEMtKa2WdOgtyiT
        0cPr+GnexWyKvonX9KnXv7Q=
X-Google-Smtp-Source: ADFU+vt7vHaZHoGXlWbc8bausIRsLsgfVFoGpQvPdtIYjzRovb8gAFt9R9lRV6RX65zoiHgCuuaMHw==
X-Received: by 2002:a17:90b:34f:: with SMTP id fh15mr14064418pjb.49.1583679479535;
        Sun, 08 Mar 2020 07:57:59 -0700 (PDT)
Received: from localhost.localdomain ([117.136.0.219])
        by smtp.gmail.com with ESMTPSA id q7sm27339309pfs.17.2020.03.08.07.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2020 07:57:59 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 2/5] refs.c: refactor to reuse ref_is_hidden()
Date:   Sun,  8 Mar 2020 22:56:28 +0800
Message-Id: <20200308145631.64040-3-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc0.5.gb02b988a14.dirty
In-Reply-To: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
References: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will use
this function for `receive-pack` to check commands with specific
prefixes.

Test case t5512 covered this change.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 11 ++++++++---
 refs.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..229159ea1a 100644
--- a/refs.c
+++ b/refs.c
@@ -1389,13 +1389,18 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 }
 
 int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_is_matched(hide_refs, refname, refname_full);
+}
+
+int ref_is_matched(struct string_list *match_refs, const char *refname, const char *refname_full)
 {
 	int i;
 
-	if (!hide_refs)
+	if (!match_refs)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+	for (i = match_refs->nr - 1; i >= 0; i--) {
+		const char *match = match_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
diff --git a/refs.h b/refs.h
index 545029c6d8..a2ea043f7f 100644
--- a/refs.h
+++ b/refs.h
@@ -739,6 +739,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_is_matched(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.26.0.rc0.5.gb02b988a14.dirty


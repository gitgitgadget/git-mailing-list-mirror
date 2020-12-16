Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E88C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872002342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbgLPSwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbgLPSwD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:03 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B33C0619D6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h205so7474740lfd.5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7vewzoKngdPqq0mSlLm8ilg2Zb81AKNjUERNEbmY98=;
        b=iCstS8nxMsIdREiFpsnfDI4f9lAjMMIpjua5ii5VKc1Vn3MZOBdzWRoYXKlV+3jRk1
         HvV0P/yMqofQMNxdKMTRLPiQBrQWKwpCbHWIcJOOCcqFFLNQRvl7SMqnPCPIXKJl2gTy
         7hmdjHwGA3ZnJcVZu18PLzg3lug6kxEcujma0o+96TGt3hWfXMzXZsYs3OAtyorvUUqD
         kilM7p9wCITG1UNXczjcZ3OGqvgqJnsFiJXA7ldr/Z05HV4whFYolEzRiM8sXAcFwp5w
         r4GnrF8fnJhC2UCnENYu3iNx9CtnhRxuZ4m1JQZ7El9Wlc2l5S6nHEQf3vX9c7W7gnx8
         qYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7vewzoKngdPqq0mSlLm8ilg2Zb81AKNjUERNEbmY98=;
        b=b1d2wXxtn+5XrOfXTTqj+4sDhcvJac0BqeQ8Oeci6jxjnY7MDUcnczInw6UCIDFVwH
         GiivW5FFfjZPnUUA0bWIaIiWfhGZLOs2OgB30xQpx+mt2SVYGTPCL8232BJEgDte+uA6
         eTV3ZSFdw6lzpoyNLJG76Uopc705NmRDMJr0iQX6LrJzvLlBBHVuZLwapLO4CjUWaVhx
         H5NJqKbO6Dgxs2M6eAq3qvEBcvxHXpGwu921XYPIy6gJo/zqw30+PVwgCjey6jMyYuuN
         P2PPm8L9LhTLI69DMMSO3G9SSTrkBUlD2t19Hwn6bpjIdpRur4pDwzE11CEXG5s9jpnX
         mXbw==
X-Gm-Message-State: AOAM531XmjFX9gE2keJNtI2eAJlw6oTAuVNekP0CwP9WNdNN6K7OjRjs
        tHNoWCETGipn5Z/8GE2d8dk=
X-Google-Smtp-Source: ABdhPJxUhFkzJKfDzi0PKTX2Ze2OSLcXzJ/wKoxl5nDOzHK1urIj1X0CrRrKFBMud9QjdhZI3O4/qA==
X-Received: by 2002:a2e:9605:: with SMTP id v5mr9502703ljh.81.1608144650803;
        Wed, 16 Dec 2020 10:50:50 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:50 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 23/33] diff-merges: fix style of functions definitions
Date:   Wed, 16 Dec 2020 21:49:19 +0300
Message-Id: <20201216184929.3924-24-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Put open curly brace on its own line

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index cba391604ac7..0165fa22fcd1 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,7 +2,8 @@
 
 #include "revision.h"
 
-static void suppress(struct rev_info *revs) {
+static void suppress(struct rev_info *revs)
+{
 	revs->separate_merges = 0;
 	revs->first_parent_merges = 0;
 	revs->combine_merges = 0;
@@ -10,17 +11,20 @@ static void suppress(struct rev_info *revs) {
 	revs->combined_all_paths = 0;
 }
 
-static void set_separate(struct rev_info *revs) {
+static void set_separate(struct rev_info *revs)
+{
 	suppress(revs);
 	revs->separate_merges = 1;
 }
 
-static void set_first_parent(struct rev_info *revs) {
+static void set_first_parent(struct rev_info *revs)
+{
 	set_separate(revs);
 	revs->first_parent_merges = 1;
 }
 
-static void set_m(struct rev_info *revs) {
+static void set_m(struct rev_info *revs)
+{
 	/*
 	 * To "diff-index", "-m" means "match missing", and to the "log"
 	 * family of commands, it means "show full diff for merges". Set
@@ -30,19 +34,22 @@ static void set_m(struct rev_info *revs) {
 	revs->match_missing = 1;
 }
 
-static void set_combined(struct rev_info *revs) {
+static void set_combined(struct rev_info *revs)
+{
 	suppress(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 0;
 }
 
-static void set_dense_combined(struct rev_info *revs) {
+static void set_dense_combined(struct rev_info *revs)
+{
 	suppress(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 1;
 }
 
-static void set_diff_merges(struct rev_info *revs, const char *optarg) {
+static void set_diff_merges(struct rev_info *revs, const char *optarg)
+{
 	if (0) ;
 	else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
 		suppress(revs);
@@ -62,7 +69,8 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg) {
  * Public functions. They are in the order they are called.
  */
 
-int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
+int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
+{
 	int argcount = 1;
 	const char *optarg;
 	const char *arg = argv[0];
@@ -86,23 +94,27 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	return argcount;
 }
 
-void diff_merges_suppress(struct rev_info *revs) {
+void diff_merges_suppress(struct rev_info *revs)
+{
 	suppress(revs);
 }
 
-void diff_merges_default_to_first_parent(struct rev_info *revs) {
+void diff_merges_default_to_first_parent(struct rev_info *revs)
+{
 	if (!revs->explicit_diff_merges)
 		revs->separate_merges = 1;
 	if (revs->separate_merges)
 		revs->first_parent_merges = 1;
 }
 
-void diff_merges_default_to_dense_combined(struct rev_info *revs) {
+void diff_merges_default_to_dense_combined(struct rev_info *revs)
+{
 	if (!revs->explicit_diff_merges)
 		set_dense_combined(revs);
 }
 
-void diff_merges_set_dense_combined_if_unset(struct rev_info *revs) {
+void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
+{
 	if (!revs->combine_merges)
 		set_dense_combined(revs);
 }
-- 
2.25.1


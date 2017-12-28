Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187EF1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbdL1EPT (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:19 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36578 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753301AbdL1EOT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:19 -0500
Received: by mail-io0-f195.google.com with SMTP id i143so17043753ioa.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mTVA2oKxsT6k9hsE08qTH9JFNk5PFgdNXE5jHxTLba4=;
        b=YgERFSZ56eYPgY8kO94isMp4BI7ezVPU8yqDycpHiL4KfJXUMTW840Dj0Xni4pv2l3
         7MnMMKhVSpAFnKp1ZyUiJQP8ZfffVtpECRjur3YwuIqATMHEN5GkSb+mTqAuBNth0Jqu
         RWDq+IQXQzNbibeFwiinu9NVHoII5sChFuFfK/B8u9kbUjovKs0DBRIZLgkTlNb0hN8L
         XgWTaLPe913gtOhYXAlwzxuNhf3q+nLPUkij9STPw/UrM/jN//yGnkSHBj7HdlGou0wp
         72L4pCfyp9tj9CsvoA60PZB/7xh5LYxtGMMrB4AUNv5/k+xEngKlpbHxwVBERsMj2Xm5
         lpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mTVA2oKxsT6k9hsE08qTH9JFNk5PFgdNXE5jHxTLba4=;
        b=RfRuthzLv1YcWVQHBJ38GLXFwHNqy8JOpXE2jEOMdgvJjh6I/f0wBbwfREh3MUtUYD
         8wwhx9SV2hyqF64KCqo6teldjBfA75pyTijWdeVnFW2arAkJ+8cmRHuo0KbpmUiqKAoj
         8Yv/CDBEkzXt0rxsK5uxy6LK0H9nfqEI6OUfzr/Z+7Q9Ix8cjhWtvLDroazoQA0bET92
         KvFSuim308MQqScjJ1/btlJfkWXhfCGtALiyL+elZyM0gupye22/DMHQr2wrUzy/021O
         PhKtj2h+DwGIOs7e+KaZEcTabitoeAj/qa16BTCPjgIubZPTTyFJyKnfybxOxSSh+4ZI
         ltyw==
X-Gm-Message-State: AKGB3mIRAmAwhrB4yDHFksrt+qndVSOb9JTwxsaEiJRHn6ISunvQ0ma1
        SBD3FcVSZ4jCE+vpsgTupnpbzA==
X-Google-Smtp-Source: ACJfBot8zdE9nuUF30ISMQXHbSFXxHeSqU2PwycTbEwnQ33G3b7iKcbhZmjAAudSKQlHUEqzh0B8yg==
X-Received: by 10.107.175.103 with SMTP id y100mr41817408ioe.48.1514434458954;
        Wed, 27 Dec 2017 20:14:18 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:18 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 18/34] merge-recursive: make !o->detect_rename codepath more obvious
Date:   Wed, 27 Dec 2017 20:13:36 -0800
Message-Id: <20171228041352.27880-19-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, if !o->detect_rename then get_renames() would return an
empty string_list, and then process_renames() would have nothing to
iterate over.  It seems more straightforward to simply avoid calling
either function in that case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cdd0afa04..da7c67eb8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1329,8 +1329,6 @@ static struct string_list *get_renames(struct merge_options *o,
 	struct diff_options opts;
 
 	renames = xcalloc(1, sizeof(struct string_list));
-	if (!o->detect_rename)
-		return renames;
 
 	diff_setup(&opts);
 	opts.flags.recursive = 1;
@@ -1648,6 +1646,12 @@ static int handle_renames(struct merge_options *o,
 			  struct string_list *entries,
 			  struct rename_info *ri)
 {
+	ri->head_renames = NULL;
+	ri->merge_renames = NULL;
+
+	if (!o->detect_rename)
+		return 1;
+
 	ri->head_renames  = get_renames(o, head, common, head, merge, entries);
 	ri->merge_renames = get_renames(o, merge, common, head, merge, entries);
 	return process_renames(o, ri->head_renames, ri->merge_renames);
@@ -1658,6 +1662,9 @@ static void cleanup_rename(struct string_list *rename)
 	const struct rename *re;
 	int i;
 
+	if (rename == NULL)
+		return;
+
 	for (i = 0; i < rename->nr; i++) {
 		re = rename->items[i].util;
 		diff_free_filepair(re->pair);
-- 
2.15.0.408.g8e199d483


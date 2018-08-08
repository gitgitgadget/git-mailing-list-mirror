Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A20208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeHHR3G (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:29:06 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:43730 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHR3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:29:05 -0400
Received: by mail-ed1-f43.google.com with SMTP id j21-v6so1415843edp.10
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ERtrR3FOcdzqr+kW6+6mCYL0y7/y++TrppA7COP93h4=;
        b=YpU155wkHHj5hX8ksMByyzk6AMqFIx8N6DOTBouhk69xPYeF/MlE6zx05ERcvrcE6o
         cnlERpQ4ZrnmhgbPmRD4WD45TBLsCfVctEdaRhU8mD929PUQ3m3C/7Ep6eOzWPjty7Qc
         mE3Ke9TzMY5DyO3KBxP3G8dR1+H/dHxK1uGaFJJRGMngEfqnsOzebnvmhPa9eHAVt7IC
         VA29xYV+bUlVa78qe97Dv+BkBi2CUxrQ21ioDT8DAmqWpm30uptXnWZf6IW8AbhQcEWd
         GzUf5BjOKP0bi3y0fO2PqibuFUi0p2pP5XnyoN28kSWoy9BmK6XwFPtAgLDCJbrGafqK
         d9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ERtrR3FOcdzqr+kW6+6mCYL0y7/y++TrppA7COP93h4=;
        b=Ox9hrcl5EqJXEnDsXgXPH/wq+U1/QLqLXGC9QAmglzeq640sSZa557iXTG5L0+j7ik
         1Va0QWxJmgiNyU9SQA7NTJecARqwVcG+QQhZ216+Q42KL0pTXErtfwnc3J+F2s70yS7K
         1VpXWFpqtRLh9plDTxSSj3om3v2N/SIosfGkv6EYvN5+dguL4zrH3D8BSHrXkfV8TBCj
         /jkt1GUkGh5/Oq1amFRvZexsbsRfUZ2/DGBK76BH8cqe33Hnzdc9/RunZR53c87PB+T/
         AIC5TEbGiCkMTLtoPBiWW+NvF9Ek7fHumaI+60k1oWgR5pqmJm3sY9fw+9vp/OeYJoVt
         aZgg==
X-Gm-Message-State: AOUpUlFicV6ZkVdMnGEBpu3XwAaAwwxRm6hXEP9RC039zZPLet726hI6
        2nhvWba7jIKzIYme2yhqnB4HS/8i
X-Google-Smtp-Source: AA+uWPwyw9aUA3qCol8W2pP96B35IauNHbre8RSLIE8//DQnx6o8I8fqkeeMNkWOLqql62GnplxGPQ==
X-Received: by 2002:aa7:d40a:: with SMTP id z10-v6mr3737313edq.203.1533740939663;
        Wed, 08 Aug 2018 08:08:59 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id w1-v6sm6771259eda.63.2018.08.08.08.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:08:58 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 7/7] builtin rebase: stop if `git am` is in progress
Date:   Wed,  8 Aug 2018 20:51:22 +0545
Message-Id: <20180808150622.9614-8-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808150622.9614-1-predatoramigo@gmail.com>
References: <20180808150622.9614-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit checks for the file `applying` used by `git am` in
`rebase-apply/` and if the file is present it means `git am` is in
progress so it errors out.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1344e071f3..75c4ac66e0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -539,6 +539,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	git_config(rebase_config, &options);
 
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%s/applying", apply_dir());
+	if(file_exists(buf.buf))
+		die(_("It looks like 'git am' is in progress. Cannot rebase."));
+
 	if (is_directory(apply_dir())) {
 		options.type = REBASE_AM;
 		options.state_dir = apply_dir();
-- 
2.18.0


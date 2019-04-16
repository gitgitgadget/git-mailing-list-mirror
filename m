Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7416B20248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfDPJeo (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:34:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40266 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDPJeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:34:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so10050921plr.7
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LpQW3yOzpUmYqNvUIPEwu5KJKOV3WPI63AuYu/9lLnY=;
        b=UG7r9/o5wPupQunnOVOPkIYtvD8V4eJr9N5Ec5PnhOTgVs6NdO7O1lobtdR8MLLtfs
         jXHJ5ko+ETQge42kky/5u6orTDrX/Z1N35ZBYERGKsNHLZp58VCGt7Ck11mp91QHyjZH
         v8KMg++oZoDZZ45+dHdlv3yv11Vph4eRKihU5724WooC9r3DvLMMJ8Q86FipeRAuNeGb
         xZ2aQZX//aCFLZmuxhN351Vdt6VOTCPSwrrVmTxjCzQOZ0tMQFz22sUiwyOssxqvXj9Q
         st8Lz18uCRlmuGzn338DDoBJjfthVi53iUdUtFoENjyL+ACOY9Rlsz/GFBnFztzF4vfg
         JvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpQW3yOzpUmYqNvUIPEwu5KJKOV3WPI63AuYu/9lLnY=;
        b=SwCosj3fhL2bZDiaQu7Jsrz2moNffDNzhrtr3GdQxQsF8nMYnpP+b/cre5Wx+OeJ9j
         f2q7EtF7S0+TaQ42+RMrUJnap459NO6F4z+5RZgqgYgvmn8eMU+w1Dqj1BBK1rOKUmlt
         3IchoPMg2R/hdW0EXLS83d1zSX92n3B2jIQEFHT5/nHg14P1MFLeHNr0f2dfefSY2NFJ
         MjmhlHCEbtN+varvn+lnfHP0eVcV8xsfCdPB1kANck/GVkYlLk7AyKW+dI6E/RwtodyW
         OG9FXnjxvDRiFel4RHFCr0E8MMLQjeQOMMW2FQ/F5XefuzNqLLE8fOPfqpvbrpQppcxc
         F0kw==
X-Gm-Message-State: APjAAAXqZnS1Dy5GM0gVovBRqikvSdHZoBj9e8s8yhymfsHdsZLiphjR
        tE0QPzhtSZKcO/1tdrIE6II=
X-Google-Smtp-Source: APXvYqzHrKnUlZYcN07hjE6KRPd6jpdab2FOPxUfa8Mq4Wt+FHbWbLz2kGVZeWP1s8nbybM9isTNWw==
X-Received: by 2002:a17:902:f084:: with SMTP id go4mr78364692plb.235.1555407283309;
        Tue, 16 Apr 2019 02:34:43 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id h127sm49183153pgc.31.2019.04.16.02.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:34:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:34:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 02/34] builtin rebase: use oideq()
Date:   Tue, 16 Apr 2019 16:33:09 +0700
Message-Id: <20190416093341.17079-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

Use oideq() instead of !oidcmp(), as it is more idiomatic, and might
give the compiler more opportunities to optimize.

Patch generated with 'contrib/coccinelle/free.cocci' and Coccinelle
v1.0.7 (previous Coccinelle versions don't notice this).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 868bcd1446..c064909329 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1792,7 +1792,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * we just fast-forwarded.
 	 */
 	strbuf_reset(&msg);
-	if (!oidcmp(&merge_base, &options.orig_head)) {
+	if (oideq(&merge_base, &options.orig_head)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
-- 
2.21.0.682.g30d2204636


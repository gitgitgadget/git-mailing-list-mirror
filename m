Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9571FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 23:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbdBPXdF (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 18:33:05 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36466 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933695AbdBPXdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 18:33:03 -0500
Received: by mail-lf0-f67.google.com with SMTP id h65so2578113lfi.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 15:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IfX1izv18XMkWb3ndS21c2/B5Qy+5HpndxcdFGVEsZw=;
        b=Q8anaLH7nCNNp7PRkLP9QZKuUf2Dwvg+wgWC6tru07jVgBIEHp79bIaMxcH5IUMvMU
         T3VH8FZUI5Y1ngVmO/xDZGtbDqOyarwSKYf0q6FSzv9HmBFLQLWfpLsUMjnwi8NGPhfl
         YYsaqzNbZjBNTGstWYEhwZt1WpNTOXaNMR5CyAKfvNxUb/M5shPIRWqGW0KeKWhef8mz
         95Hr9vVBYW5xcB8yNxya083Uf5V8lNU1AsjDXxtNDya+uHMrgFH1WtZ2/xj07JMk38o6
         TcvVf21V1AJFwNc3Ktq87s+Oac+MG8KE+6JKwdb/DaflVyxq3g0NqSKPbckF3ULXreKx
         GOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IfX1izv18XMkWb3ndS21c2/B5Qy+5HpndxcdFGVEsZw=;
        b=ZtRWSBztjKsb+7/E36shJX9tf9y+JVv4smQAxdB9vAT9uD5WNwJN0t2CY/UCiAHFZt
         pTHXz90XF0Tbj97SWZHEK8N4Qo3OEATD8vf3EwsqMYFOhxscwWJrvvBxcSSICSXd/rWT
         uNK7mC1liMAGJso8SeEEjz9yP/HcXMhHSEV63OUnx6Z1+rH4HM4cJn6yXXxDqoPqYOMm
         KY2BgNAoZQ10EGiHp0/A59z+iXkZ0CrE0xQr+W2AUDvN5u1JYj9jnPcFhO0qa75nGbxS
         /h23KNoSLXMcD1xPDBo6hnHiJj9X8rdBYnNQORKXacoLS6W0HKiGGVKmoynk8A8Nhxtw
         /R5A==
X-Gm-Message-State: AMke39kknLe2laVfpVGl+h2mMeuQT6hrBLoI/d3KwNWsg+ZcunJLbB95eXTHsLjwNmmdOA==
X-Received: by 10.25.16.193 with SMTP id 62mr1380887lfq.75.1487287981574;
        Thu, 16 Feb 2017 15:33:01 -0800 (PST)
Received: from localhost.localdomain ([2001:470:1f0b:8fc:eda1:2dcd:3a83:adeb])
        by smtp.gmail.com with ESMTPSA id k127sm2071074lfg.10.2017.02.16.15.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 15:33:00 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH v3 1/2] bisect_next_all(): fix bisect crash when used the gettext translation
Date:   Fri, 17 Feb 2017 02:32:48 +0300
Message-Id: <20170216233249.24757-2-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170216233249.24757-1-franchesko.salias.hudro.pedros@gmail.com>
References: <20170216233249.24757-1-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buffer steps_msg[32] is too small.
Translated "(roughly %d step)" string can not be located in the buffer.

Solution: using xstrfmt which dynamically allocates memory.

Dummy solution: just increase steps_msg size but is not safe.
That feels pretty hacky, though. In practice the set of translations is
contained, but it doesn't have to be (and certainly nobody would notice
if a new translation was added with a longer name until a user
complained).

Reproduce bug: "LANG=ru_RU.UTF8 git bisect start v4.9 v4.8" on linux sources.

Signed-off-by: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
---
 bisect.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 21bc6daa4..787543cad 100644
--- a/bisect.c
+++ b/bisect.c
@@ -940,7 +940,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
 	const unsigned char *bisect_rev;
-	char steps_msg[32];
+	char *steps_msg;
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
@@ -990,14 +990,15 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	nr = all - reaches - 1;
 	steps = estimate_bisect_steps(all);
-	xsnprintf(steps_msg, sizeof(steps_msg),
-		  Q_("(roughly %d step)", "(roughly %d steps)", steps),
-		  steps);
+
+	steps_msg = xstrfmt(Q_("(roughly %d step)", "(roughly %d steps)",
+		  steps), steps);
 	/* TRANSLATORS: the last %s will be replaced with
 	   "(roughly %d steps)" translation */
 	printf(Q_("Bisecting: %d revision left to test after this %s\n",
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
+	free(steps_msg);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
-- 
2.11.1


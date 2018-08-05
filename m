Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190B81F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeHET0E (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50766 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHET0E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so11469410wmc.0
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOwErx21bqbT1jFLPp5tDeStFx2+GJMhV5d34CtgPLE=;
        b=s0rDEokWOAyL03OGaqGyn5q759e7pFhyTMB056xBzO/WhIAlRLOduSppfavhSGHDqp
         D5Oug1rmuOfPq9W5e/5CuuqGy+Lyb82ECaiNP0j0ukAW7gtvmpqLnEMckOMipCFwavkZ
         RktXco7gCnxAYvVQvJzAkFKvq5KuNDOg8m2EG5TuBMQM7QikxBn7wvVBLCInGL0kcrRm
         kA7BuaSnFzWjDixDHv9UYhTsGibHjH38q9QZcOm1Z9OsCzea6YWs6EcMpqCqM/iXLrrz
         cOs525WASKREh4JB6pUnaJZunaMqJKyTXX2Nqrq/p9cuQ0DNO3GC7cva0AMmIfef0lhD
         6o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOwErx21bqbT1jFLPp5tDeStFx2+GJMhV5d34CtgPLE=;
        b=NZwnvyXG2IeYm7Gac5ACHwBjHRLR15BdANptNQEFw8G54WNsNff5btrDuOaSTdcYi3
         FzuEtk0G8AySoa/6ECRelQA4Jt1YNQ9YINoSF6Ldc6cQ90omxVkYaMuunf2khzUjvKYU
         gf4o5h4IRWwjr++Y3Gjl+17Wr4WVCbU6s5+Of1MDTtUGgHLMFwQVQdKQpt2x0C7tOPkg
         5CJs4jQcRgHRyCKxnWKZF/QoqMO7FdJxF8F0SHjxE5OdwBS2wBTU9PM95gNWMkUQCSMP
         yPkT+QB9chPOBvQEp2Lx0Mel+uC2n83ELrJB8OypPCRC0lo0LyLepHJTDTHX9oIGJSnD
         Pqsg==
X-Gm-Message-State: AOUpUlHwvESE600Z0ZN7bQgVfIB05dl3133tlpslH+bW+cNZq73SZ8jx
        FNRfZViXaU7oGXTKVeugLnyjAysa
X-Google-Smtp-Source: AAOMgpfcvOkifCUIoWb7JDuIyO6wauDoNO++zRxmqTF6M1GtwBbPVf4c5D7KQRyvFay+FoZJYBYPEA==
X-Received: by 2002:a1c:f20f:: with SMTP id s15-v6mr742889wmc.0.1533489646570;
        Sun, 05 Aug 2018 10:20:46 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id a84-v6sm4520023wmh.27.2018.08.05.10.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:45 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 01/11] rerere: unify error messages when read_cache fails
Date:   Sun,  5 Aug 2018 18:20:27 +0100
Message-Id: <20180805172037.12530-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.720.gf7a957e2e7
In-Reply-To: <20180805172037.12530-1-t.gummerer@gmail.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have multiple different variants of the error message we show to
the user if 'read_cache' fails.  The "Could not read index" variant we
are using in 'rerere.c' is currently not used anywhere in translated
form.

As a subsequent commit will mark all output that comes from 'rerere.c'
for translation, make the life of the translators a little bit easier
by using a string that is used elsewhere, and marked for translation
there, and thus most likely already translated.

"index file corrupt" seems to be the most common error message we show
when 'read_cache' fails, so use that here as well.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rerere.c b/rerere.c
index e0862e2778..473d32a5cd 100644
--- a/rerere.c
+++ b/rerere.c
@@ -568,7 +568,7 @@ static int find_conflict(struct string_list *conflict)
 {
 	int i;
 	if (read_cache() < 0)
-		return error("Could not read index");
+		return error("index file corrupt");
 
 	for (i = 0; i < active_nr;) {
 		int conflict_type;
@@ -601,7 +601,7 @@ int rerere_remaining(struct string_list *merge_rr)
 	if (setup_rerere(merge_rr, RERERE_READONLY))
 		return 0;
 	if (read_cache() < 0)
-		return error("Could not read index");
+		return error("index file corrupt");
 
 	for (i = 0; i < active_nr;) {
 		int conflict_type;
@@ -1103,7 +1103,7 @@ int rerere_forget(struct pathspec *pathspec)
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 	if (read_cache() < 0)
-		return error("Could not read index");
+		return error("index file corrupt");
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
 	if (fd < 0)
-- 
2.18.0.720.gf7a957e2e7


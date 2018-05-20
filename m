Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2025E1F51C
	for <e@80x24.org>; Sun, 20 May 2018 21:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeETVMM (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 17:12:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39109 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeETVMK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 17:12:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id f8-v6so23364293wmc.4
        for <git@vger.kernel.org>; Sun, 20 May 2018 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Jz7l7N/nkJQDp+220G7sTaz7dpGteP5LMx1JpbQqOE=;
        b=FvcTEMYrgSCak78cQpdQL32Q/1uV0dOvkY3OC+QtzfhjamIWO+iyGPMPG2IhZkAS9W
         7qc+Y09nFE5r26pAueKLkCEqD2/BnOsgYL2676fNdwQMIkqYwUEVThLgvA5QSfoqjBEo
         4qNDAZ+PVNIVQSpq37S5/2YhUJf9lgapCDxBnhTLph+xPLFKDVWZe+t6r411K48C3dqA
         IE3CPvJRCjNVRFDyb0e+n4N6kXRYl1PdrhCu4Fdr9HNNFLBcBEWPteAPNhlka/gnUz3E
         ltvgAx7EIhVQrOqyopSx1rbdLOB6HS46mA/3Vz416g/v0pGwYtevyeOetFhXPkJZCL0g
         3SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Jz7l7N/nkJQDp+220G7sTaz7dpGteP5LMx1JpbQqOE=;
        b=gGel5lh12m+rjaiMvSf2xLO54vq9Oq4TijHxbi00Km2Cha+4nOuNfskY8X5Sgdb6ZU
         cFlR0MV03ci2aJT/tpn6KX61UDK6LU6rCWaTC/vxMC3gX2/ehqJmtYWZyMhLFlr+xvJx
         rEeRIFzjKRBgIiHETfYWVD28X098dcIkUW9T0U2aClWCkjgOwsJXdOJHcTznPpkhh9KI
         /IlDdIMCAxgn51RuuEsNZW3HkkWDJRM1rNQaWuaTFiu7oQOV+oqzNRDIOAMnOhs06VtH
         28QtVuyXvbUENn2yHOLIKaNSrBuyA+y/QU4Wbv6mIfINy9/wnWvCtNs2/6WWvIRPs73l
         hKbQ==
X-Gm-Message-State: ALKqPwelW7nxmNyEuuFgjvIOpfulX8buCGAG7LNPDdLLsbVYGFiCznOD
        DyMyjgnkdikKJEGJannycZreaf2X
X-Google-Smtp-Source: AB8JxZrSv3zM1RlMEHzt6jdMMj56HH7S0U/lqpgxyctg99yYI0ZAL5kdwHGpNW0jswwcRY66MQAqMg==
X-Received: by 2002:a1c:8611:: with SMTP id i17-v6mr8840152wmd.107.1526850729343;
        Sun, 20 May 2018 14:12:09 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r10-v6sm1930655wrn.6.2018.05.20.14.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 14:12:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC/PATCH 1/7] rerere: unify error message when read_cache fails
Date:   Sun, 20 May 2018 22:12:04 +0100
Message-Id: <20180520211210.1248-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.588.g4d217cdf8e.dirty
In-Reply-To: <20180520211210.1248-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
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

"index file corrupt" is also what Stefan chose for his series unifying
these error messages (and 'die'ing, which I'm not sure is the right
thing to do here as also mentioned in my reply to [1]).  I'm happy to
drop this if we decide to go with that series.

[1]: <20180516222118.233868-8-sbeller@google.com>

 rerere.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rerere.c b/rerere.c
index 18cae2d11c..4b4869662d 100644
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
@@ -1104,7 +1104,7 @@ int rerere_forget(struct pathspec *pathspec)
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 	if (read_cache() < 0)
-		return error("Could not read index");
+		return error("index file corrupt");
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
 	if (fd < 0)
-- 
2.17.0.588.g4d217cdf8e.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29AE720401
	for <e@80x24.org>; Mon, 19 Jun 2017 02:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbdFSClr (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 22:41:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33009 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbdFSClr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 22:41:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so8133800pgb.0
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 19:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NlLZ55mCAUhhBMEFCCO3UuPsrcQAMhSoZ1YWpaaRYVM=;
        b=eEq/YFuhvlYM1Hh1qOUsNSBFkhKbpyqCx4md7xkKM936CgMp2Ovb/vMp6bDE0qaQDy
         IyJ2CD1eenLtqrM/kRMoOHTtvM8dkbed8Yr+rX/swohxZ5Cz5GC2f+fmrpD7lURpTiBD
         9MIofu3xPpTNGn+u1h0UHCURtQMYTdssL9jy96rv0EqRVcJKpIB1qAfz6xPl/l+74B4s
         oz8HzCteSiwL8dW9tHE8dEDt8z8eLQeMQdVEJ21gqXnDTQcrM9WFTHzhyh5c0TD+veoJ
         8Sc/IfjQVNwPoFNPyeFxAxPxU734UJQ9o+cSt6PLi9qWxkTWgfUPVzzKbkXMLpyD0G+o
         xKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NlLZ55mCAUhhBMEFCCO3UuPsrcQAMhSoZ1YWpaaRYVM=;
        b=aRABvhwNKUJlfl1S67NOyoMcph1rFaxWLOROwcsiusESsl5QBPppUMIQPh04xY8fmr
         /fp02koBloRbeZ+O1nDKyI2ZzPJlMbPN+3RgrRpnVVWTODwNUpjHpE8+SVb/i4+nfhtI
         sawCvnrLMQELGg6qObfGXkHgkuVuu5je7S/vwHwiv782U3I+Np+92Un4MPJlWuaq/IR4
         mkPYL0WGxnqi+65tpfQSk515TyNlgHc/stYnSEBI44QxVeZV7M5uuthX0Gs6SQ3VBRgi
         z46M2wydwCErk8W33DWVjP/pucMK/aYSKwVssLCDqRF0uWFshu8ov+LaW9FwlHbr3Vit
         vR7g==
X-Gm-Message-State: AKS2vOyD0ai3qRQr0AEwisejzE5qww20xvXAuGPFPYYg5psraFnkQvJT
        NHPm0xI8zGPQmQ==
X-Received: by 10.99.140.9 with SMTP id m9mr24050150pgd.49.1497840106331;
        Sun, 18 Jun 2017 19:41:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:8284:9daf:c00c:2460:a1a2:73fc])
        by smtp.gmail.com with ESMTPSA id a12sm17360351pgn.62.2017.06.18.19.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2017 19:41:45 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, peff@peff.net, git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH 1/2] Contextually notify user about an initial commit
Date:   Mon, 19 Jun 2017 08:11:23 +0530
Message-Id: <20170619024123.5438-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <87shix8zik.fsf@gmail.com>
References: <87shix8zik.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git status" indicated "Initial commit" when HEAD points at
an unborn branch.  This message is shared with the commit
log template "git commit" prepares for the user when
creating a commit (i.e. "You are about to create the initial
commit"), and is OK as long as the reader is aware of the
nature of the message (i.e. it guides the user working
toward the next commit), but was confusing to new users,
especially the ones who do "git commit -m message" without
having a chance to pay attention to the commit log template.

The "Initial commit" indication wasn't an issue in the commit
template. Taking that into consideration, a good solution would
be to contextually use different messages to indicate the user
that there were no commits in this branch.

A few alternatives considered were,

* Waiting for initial commit
* Your current branch does not have any commits
* Current branch waiting for initial commit

Patch-derived-from: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
  Hope this would be final :)

 builtin/commit.c | 1 +
 wt-status.c      | 5 ++++-
 wt-status.h      | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1d805f5da..0f36d2ac3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1648,6 +1648,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
 	status_init_config(&s, git_commit_config);
+	s.commit_template = 1;
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
diff --git a/wt-status.c b/wt-status.c
index 037548496..e6a9ee34f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1576,7 +1576,10 @@ static void wt_longstatus_print(struct wt_status *s)
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s),
+				 s->commit_template
+				 ? _("Initial commit")
+				 : _("No commits yet"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 6018c627b..782b2997f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -76,6 +76,7 @@ struct wt_status {
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
 	int null_termination;
+	int commit_template;
 	int show_branch;
 	int hints;
 
-- 
2.11.0


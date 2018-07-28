Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05EF31F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeG1E3w (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 00:29:52 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:40098 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeG1E3w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 00:29:52 -0400
Received: by mail-oi0-f74.google.com with SMTP id x18-v6so5671298oie.7
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mjjT3Ccl5Lf1kkotlucXEIKztN3jqFxNZwu23pAdCic=;
        b=cBFmnb0ZpKo8UczWhvAmj3AnCqyrCajReLE4bSNnw6+tgZEUkBf4HV2tTbVF/BB7GM
         6Ln1qSXXW8BOwPD+9HZw7SqYIjBJRslPJzZZw/UU2PjZw3ekK3amQoQ0Gxfc+Hso7p8S
         OicPZNsDxaSQYfpiE5CoLjW+4JKwMKQvL1kngNwFM7RyFFhFG6dmNOlaroCBUdiFowSs
         wxo/ogvq0f0oD+vHk3mnIiSf6r+o+KxpvBwmwQ/UQoojCHgVRygCmLjlYSJmmPS/Q281
         RtgEHv0q3Et0XL4S5Dv7tWW3HPu3+ZlmScbiF8CxyTo1+0o2UjzNgHESoiAJghfQKgCM
         /CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mjjT3Ccl5Lf1kkotlucXEIKztN3jqFxNZwu23pAdCic=;
        b=bWyXrcsrGd5eJNFSyEkNKnWEy06MwHK9DMsM44s763R82yvIvbOk2t68WG6XrzQ8iJ
         f7Z9ZUPOxMxaBVzfOHOzxQnng5KAkgmjgwx8/E1DWw+1SY/2O18IIH9F65Flj9KZ83ya
         lKzUTBTiJWU5ZiyzlvmexFa4tX36HHKngdKzYF9ubev8rvdeCKWCwifzGinumUJ3+SyT
         HhaAMLiKK9aCExvk7Qb3S39ckHoEKfm3i2noSaBuH42eCw5Z/mcJj0pRgKQTsfvq03T0
         PbhaeDYgytLKDn3bvqIfmsfZCqDRkWrjlNqIkz/aje7meSkBExLiQPdi7t1zg8ZnipJu
         B8LA==
X-Gm-Message-State: AOUpUlEFihpztHOsEWqfXGqFsyoz3R3vXQ4Z/XHwedxjA/ThTYZETgaM
        o5x6i9QUEjb5oPytLAFHE/0Y1XfKhYiFNbxLIOmgScVwKd6KkGxHj4NcibZOmmkl3bFQ5qMGF+c
        zQuO+24zLlS6zmZi95XJD6BDSfvq/LgCDnX08CB7PiTJ0M3J5GRVYt3s697jZ
X-Google-Smtp-Source: AAOMgpeAm1C9/UFG+eKnlRSwhgpJXERhOrL0QAW1LLjK47m6MlIjysqBphSc9Rv7A0h+kvWae84SEjKDbvJE
X-Received: by 2002:aca:e683:: with SMTP id d125-v6mr5078233oih.41.1532747106707;
 Fri, 27 Jul 2018 20:05:06 -0700 (PDT)
Date:   Fri, 27 Jul 2018 20:04:46 -0700
In-Reply-To: <20180728030448.192177-1-sbeller@google.com>
Message-Id: <20180728030448.192177-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 6/8] diff: use emit_line_0 once per line
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All lines that use emit_line_0 multiple times per line, are combined
into a single call to emit_line_0, making use of the 'set' argument.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index a36ed92c54c..fdad7ffdd77 100644
--- a/diff.c
+++ b/diff.c
@@ -583,10 +583,7 @@ static void emit_line_0(struct diff_options *o,
 	int nofirst;
 	FILE *file = o->file;
 
-	if (first)
-		fputs(diff_line_prefix(o), file);
-	else if (!len)
-		return;
+	fputs(diff_line_prefix(o), file);
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
@@ -606,13 +603,17 @@ static void emit_line_0(struct diff_options *o,
 	if (len || !nofirst) {
 		if (reverse && want_color(o->use_color))
 			fputs(GIT_COLOR_REVERSE, file);
-		if (set_sign && set_sign[0])
-			fputs(set_sign, file);
+		if (set_sign || set)
+			fputs(set_sign ? set_sign : set, file);
 		if (first && !nofirst)
 			fputc(first, file);
-		if (set)
-			fputs(set, file);
-		fwrite(line, len, 1, file);
+		if (len) {
+			if (set_sign && set && set != set_sign)
+				fputs(reset, file);
+			if (set)
+				fputs(set, file);
+			fwrite(line, len, 1, file);
+		}
 		fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
@@ -999,16 +1000,13 @@ static void emit_line_ws_markup(struct diff_options *o,
 	if (!ws && !set_sign)
 		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
 	else if (!ws) {
-		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign, NULL, !!set_sign, reset, sign, "", 0);
-		emit_line_0(o, set, NULL, 0, reset, 0, line, len);
+		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
 		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
-			    sign, "", 0);
+		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
-- 
2.18.0.345.g5c9ce644c3-goog


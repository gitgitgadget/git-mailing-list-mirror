Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450571F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfGERHB (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:07:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36397 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfGERHA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:07:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so10640083wrs.3
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0O/eXuhEnD5jx/0ReEjojd9SJEmu2xsvsKP7ud/r9I=;
        b=Gb1OTH2n4DtXkKXSvqpgQAiT12URWBclVhaX4wm5I0Bkk5jeOJPFzNbT3ZuX+CyUZP
         cQxwTUBglioeR/SVR3a1kcmvwcvuxbfjYtZvXkv68RI3GeKrRhsdpkxIyBd8BPNqk5Aw
         R9vhRHZFCLxNzbsjCaiA/HGV5tF33S26DbhK/281b7MGwFbM+xGWl3mNNY64FOBR96m4
         XgJbadoUmrn+Qauz81YDHBIWUhVZX5AAlmBY2QhbWKMywsJS6sQzltC2J0+AsYTsG8BX
         sTyrst0uBPGXNl/4Y4B4DmaIjvOD2mjEYHWjMR1etixTtQyufShACq0qdGSGPpGxmuTM
         aanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0O/eXuhEnD5jx/0ReEjojd9SJEmu2xsvsKP7ud/r9I=;
        b=HYr00oH+54FkgzPQl5Aap8Mn91N1u/D/FJOmM8qdOg8QU5O7lszm4I+9RK0LJ2q0Gk
         rcQ0VL7/7Zw/H3MBNQ0G4Gglv8zBnilsqpK6N4WgOR/g54YvqbbZr7R73r34v17FUjv2
         5Y79qqs8DGn0eyXGHG/mY9IdFIFMqSmqZp4bRtFpTjrW6jWLlaSZ0fiqUChxGAoMCBmg
         u0HukzG4ZMrBzIEzevQWkmLM4Qvh0wlqC/Ats65d/qIv8TrZJlSy2k9WNQnYrfWtZxWk
         a2jAjQgImm80hgAI9vBtomVNWGipS59VLD1EsSaLeWSFEanYeHxQtZavhTFW/WeBp8nO
         U6iw==
X-Gm-Message-State: APjAAAVZh0He+BInUTVnoMwSNtjHX7HkggOnSLW8/LXBLq4+b1FXkfH1
        ExdEKDkbfLLG2vdeyl53vyujx62/
X-Google-Smtp-Source: APXvYqwMnvE8N5hYaSwyjPhHAl+lf6PBZ9OgbY2yive55nRcAuuO0ptfRzG34dGxyMaxWS87Y22w9A==
X-Received: by 2002:adf:d081:: with SMTP id y1mr5141676wrh.34.1562346417937;
        Fri, 05 Jul 2019 10:06:57 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id h1sm8648376wrt.20.2019.07.05.10.06.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:06:57 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 04/14] apply: only pass required data to check_header_line
Date:   Fri,  5 Jul 2019 18:06:20 +0100
Message-Id: <20190705170630.27500-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the 'check_header_line()' function takes 'struct
apply_state' as parameter, even though it only needs the linenr from
that struct.

This function is in the callchain of 'parse_git_header()', which we
want to make more generally useful in a subsequent commit.  To make
that happen we only want to pass in the required data to
'parse_git_header()', and not the whole 'struct apply_state', and thus
we want functions in the callchain of 'parse_git_header()' to only
take arguments they really need.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index ac668e754d..1602fd5db0 100644
--- a/apply.c
+++ b/apply.c
@@ -1302,15 +1302,15 @@ static char *git_header_name(int p_value,
 	}
 }
 
-static int check_header_line(struct apply_state *state, struct patch *patch)
+static int check_header_line(int linenr, struct patch *patch)
 {
 	int extensions = (patch->is_delete == 1) + (patch->is_new == 1) +
 			 (patch->is_rename == 1) + (patch->is_copy == 1);
 	if (extensions > 1)
 		return error(_("inconsistent header lines %d and %d"),
-			     patch->extension_linenr, state->linenr);
+			     patch->extension_linenr, linenr);
 	if (extensions && !patch->extension_linenr)
-		patch->extension_linenr = state->linenr;
+		patch->extension_linenr = linenr;
 	return 0;
 }
 
@@ -1380,7 +1380,7 @@ static int parse_git_header(struct apply_state *state,
 			res = p->fn(state, line + oplen, patch);
 			if (res < 0)
 				return -1;
-			if (check_header_line(state, patch))
+			if (check_header_line(state->linenr, patch))
 				return -1;
 			if (res > 0)
 				return offset;
-- 
2.22.0.510.g264f2c817a


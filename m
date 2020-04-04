Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0155C2BA17
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B4C2074B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeaUB6uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgDDBME (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42686 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDDBMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id b10so2483930qtt.9
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0aG82s5CcnkkAJmRuKrOrhMfbEmERigVtMxWONZzI8=;
        b=OeaUB6uhaslrbMXMC0bLfWP2jdulth1cEwm7OrwD3ZqXOWT2noiN01+qMdJDtz8Gxe
         TNlP2hZZGwtzRMbDOmwGQa3nrl7NJYeWOMjXrPQKyxNO5ib3/TpdNorPTpjXyYPSdYBv
         vX0oRBLyI6xTKHFZK9E3BVx3ZUZ6OxFKFAM+XM9qNhNL1tjZCrICjy6dIK65ifn/uzAb
         Yijw1hYxYqor2dHJUJcxa/h61cQxN1S2MhKA+6eLWXfocL22iMJ5QFPHsp2EPyULVyKm
         6hLJMUAdFPVRoY6DCS3iTJCzatQMV7yya2b1lcrveef09mhWEm4uK8XfNu3ojJoyp8ya
         G9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0aG82s5CcnkkAJmRuKrOrhMfbEmERigVtMxWONZzI8=;
        b=mG6L3gc3BikfeZii81jJ7sp2pjVInLCKRN0ehTFlZjEnfm1lYnEcBHEOSk9X9M6Y11
         i0hUU+atvUrvvUOnQMGmE5/dKpMAmMX1NzSMu2gsAIqXvwENdYzJELCCL1006ECqBP49
         bNe7h/94nbJYWw1Eo2VJIM29wF3ybRGIhCBlbREqYBt6nKQwY9Wog4M8v0q8/rRfS2A1
         Uf4EEEaH3vsfmz4F4Fdi+PGnNlaOlQaV0AbxV2cSQD+hSobbCofRkkRV5h2a/Lp2Gelj
         tsiVIkmw4zauWJDeYb2zJOPQIPHYJ2dAnRlvTX9ekimz1WgFV5dLW6Qe6fJGzHBc9e9M
         TPUg==
X-Gm-Message-State: AGi0PuaQJdvBknOQ85Qkg12RNaavRqZRx6vzTG41+NHpeU0Km5y8X2gr
        gv+zyNQAmWF+AsR79fPjYhURx8RI
X-Google-Smtp-Source: APiQypLyt/b03Wgk8ML56syxvjdtIWL4xiYfCWpRpW2gWb1SRR9X+Aqd7m09VD+ow4OBcz1FJbVAYw==
X-Received: by 2002:ac8:548d:: with SMTP id h13mr11079518qtq.144.1585962722157;
        Fri, 03 Apr 2020 18:12:02 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:01 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 03/23] sequencer: stop leaking buf
Date:   Fri,  3 Apr 2020 21:11:16 -0400
Message-Id: <76585e5b1367a3adf18d761b2af9356ee64b46fd.1585962672.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In read_populate_opts(), we call read_oneliner() _after_ calling
strbuf_release(). This means that `buf` is leaked at the end of the
function.

Always clean up the strbuf by going to `done_rebase_i` whether or not
we return an error.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e528225e78..faab0b13e8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2485,6 +2485,7 @@ static int read_populate_opts(struct replay_opts *opts)
 {
 	if (is_rebase_i(opts)) {
 		struct strbuf buf = STRBUF_INIT;
+		int ret = 0;
 
 		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
 			if (!starts_with(buf.buf, "-S"))
@@ -2525,7 +2526,7 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->keep_redundant_commits = 1;
 
 		read_strategy_opts(opts, &buf);
-		strbuf_release(&buf);
+		strbuf_reset(&buf);
 
 		if (read_oneliner(&opts->current_fixups,
 				  rebase_path_current_fixups(), 1)) {
@@ -2538,12 +2539,16 @@ static int read_populate_opts(struct replay_opts *opts)
 		}
 
 		if (read_oneliner(&buf, rebase_path_squash_onto(), 0)) {
-			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0)
-				return error(_("unusable squash-onto"));
+			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0) {
+				ret = error(_("unusable squash-onto"));
+				goto done_rebase_i;
+			}
 			opts->have_squash_onto = 1;
 		}
 
-		return 0;
+done_rebase_i:
+		strbuf_release(&buf);
+		return ret;
 	}
 
 	if (!file_exists(git_path_opts_file()))
-- 
2.26.0.159.g23e2136ad0


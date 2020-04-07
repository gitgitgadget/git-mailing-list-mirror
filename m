Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F85C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACF82078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkE8W4DJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgDGO2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36381 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgDGO2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id m33so2787638qtb.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0aG82s5CcnkkAJmRuKrOrhMfbEmERigVtMxWONZzI8=;
        b=FkE8W4DJ7L0oZ7K6alXBZW8houe/WokQ89n42jaiDP3Wjy4RWc1+enhZ5GJ+y5iiYG
         gdhtLMVASIlfrgVim9mhAx979k5s9/5m2GL8VlD088sYcL6g+YNsfm03R+eZ/Q18tewc
         RPJ4Q87CiRN+FkDgVVoaJsQaDLEt5R3q8lQElheD8gJUKqkCZfnyJ/lbOLU1XEyVGOCn
         0Fq0UAwj8vfWqd0uCwQVEtQeY0S6uZLTnqZRYrN9dbbPNIYqN/lhshL4UHc3tpqlQU/s
         /jkzkUmE9YWF/UDrK84EkV/filmKCvyZeabEKBZuPfj6Fns1eAdrFt45shcK0HQw58DV
         vzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0aG82s5CcnkkAJmRuKrOrhMfbEmERigVtMxWONZzI8=;
        b=FvhnqzCacWHsPL1eKolzt7LJNeyfKtXh5RCp9hXNrXObf4CIoVdaW1uzQrZbwA8le/
         K0lZCwZfN+oKhka0b1zGsraCOuF6P3CYsLEgZoVni6wRJAlh8b556XJkMXwtketYxYdf
         nYLByIk2EOyl3oGEeEJgVwdrNv9AtcruuhVspOw/D8Atg/WRJcL1uULXEGSQx6zN5iBO
         0hNiNCmm6aWwe/PgCQs60YjeCzQSya9W/sqakxOOsxHTy69hN/kfpwyScOXqxMG41dY0
         xirvDVx5x16AX6iwTj5QOAeCVYck0zeoWtvZnpUzWPTk5XLjYC5UQtRNit3kpWcV6HOr
         UfLg==
X-Gm-Message-State: AGi0PubqFcQ5Nzk/Ai4/Fwnf7E3rL/3+NXMR0mg1X8BKdzAtzXUp9+fI
        KDcduAHDkgNTlyG2Zb/5WvqvvcVm
X-Google-Smtp-Source: APiQypI/5xAXttBaYEjAmOWTVFt+kgDG8GETjn4OfxOseWA2Gjgf87rxpCBG9YXPIeTLAfFtFJbCbg==
X-Received: by 2002:ac8:6890:: with SMTP id m16mr2475359qtq.5.1586269701882;
        Tue, 07 Apr 2020 07:28:21 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:21 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 03/22] sequencer: stop leaking buf
Date:   Tue,  7 Apr 2020 10:27:50 -0400
Message-Id: <76585e5b1367a3adf18d761b2af9356ee64b46fd.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
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


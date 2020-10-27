Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9875C55179
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B361022258
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 14:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/K5yZFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbgJ0OC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 10:02:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33130 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbgJ0OC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 10:02:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id b8so2086280wrn.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rVLSZ08PoAMbu5DUrshvpmANiqYNkyELjnoBHDServo=;
        b=C/K5yZFIDxMZzBNnKWFvZxaabtVLlADtrDfgPG6pfAvv6xXR/NALqPeJr4G8aVZ6Ty
         Ot/VCEMwnAIQRCw5KGIC8jH8A+cFrOuBmWP/RhPxwF5lYdybF4H0GqvCdcKpm/D7xSMZ
         W7jKFrNSRQ4lm8zuDZpUr7NzChlFejrNPSTV0sCzgqm+XJWGr4kNWCjvtbMoIh1odbSr
         nuqRDBJE1SKdH0fNnFhKyKcNXe5DHox/jcIVIqS5txTJ45CwowMXof7Cr8SVOLhAoToD
         mZuQqLZ8cUizfCg0wyRZzxasOHoBDU7jQ0zTh+wCCsGFGot8wtmjDXA3vUPMBoQRYEEb
         48xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rVLSZ08PoAMbu5DUrshvpmANiqYNkyELjnoBHDServo=;
        b=be5fcCj6SRKbUrXYgAg4pudjRo2tEF3rpm9Hbyp3NRm4ZkVVhfTXNj+xMOhwGZ106D
         ny2Yn80nAxyZegYfEmgA2Fbxr3tEplQf8wRt3oJJn1Ubu5f2eDBe+JXKzBRvqyJ5ajTW
         44sAKBXt9yo5dX80BH25iZPOcm0k84kTyM8J9oAD3Ooy7lj3PaZHSiOXIKkDdacXKXlJ
         ur41BVrAW9DX2eWtwxZRN6/gC8F8Tsb/P8ivUi+lp2SagF91p39/m9ibeIXjsdA8Dloe
         RP0yzRoZl4l3KKhpUBxnZSwRceeF0iDfaQ3/UfLwy19ADzjEOljw3XMN6IkkPK2jAbql
         nvyg==
X-Gm-Message-State: AOAM533Z8lSt3sPIOjWUptNmlpAzXnShsuK8AX7XAFClrxPSrIOSXZv4
        KO1My2sNTh1lT+Go53F2M8r8FhgiJw4=
X-Google-Smtp-Source: ABdhPJwh4CWN0rWiDCy/QYdMlUCU8mGDccbH5e0gOkdx1vsrskmFEcRx+t2ZGlvctqFFlGb1Ch+9nw==
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr3175829wrr.185.1603807343031;
        Tue, 27 Oct 2020 07:02:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i14sm2056868wml.24.2020.10.27.07.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 07:02:22 -0700 (PDT)
Message-Id: <ed78f8628a67b346ffebaab50ac52cf2a83a6131.1603807338.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.773.git.1603807337.gitgitgadget@gmail.com>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 14:02:17 +0000
Subject: [PATCH 4/4] rebase -i: simplify get_revision_ranges()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Caspar Duregger <herr.kaste@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that all the external users of head_hash have been converted to
use a opts->orig_head instead we can stop returning head_hash from
get_revision_ranges().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f94f9fe307..17450e9d9e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -270,15 +270,14 @@ static int edit_todo_file(unsigned flags)
 }
 
 static int get_revision_ranges(struct commit *upstream, struct commit *onto,
-			       struct object_id *orig_head, char *head_hash,
-			       char **revisions, char **shortrevisions)
+			       struct object_id *orig_head, char **revisions,
+			       char **shortrevisions)
 {
 	struct commit *base_rev = upstream ? upstream : onto;
 	const char *shorthead;
 
-	oid_to_hex_r(head_hash, orig_head);
 	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
-						   head_hash);
+			     oid_to_hex(orig_head));
 
 	shorthead = find_unique_abbrev(orig_head, DEFAULT_ABBREV);
 
@@ -328,7 +327,6 @@ static void split_exec_commands(const char *cmd, struct string_list *commands)
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret;
-	char head_hash[GIT_MAX_HEXSZ];
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct strvec make_script_args = STRVEC_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -336,12 +334,12 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	struct string_list commands = STRING_LIST_INIT_DUP;
 
 	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
-				head_hash, &revisions, &shortrevisions))
+				&revisions, &shortrevisions))
 		return -1;
 
 	if (init_basic_state(&replay,
 			     opts->head_name ? opts->head_name : "detached HEAD",
-			     opts->onto, head_hash)) {
+			     opts->onto, &opts->orig_head)) {
 		free(revisions);
 		free(shortrevisions);
 
-- 
gitgitgadget

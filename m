Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E101F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeFEUr7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:47:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35107 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeFEUr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:47:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so7750244wme.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y2IM6DzfFDx9Aaymi1QveC+KmSrtW+10rl842P9AHYs=;
        b=JKz7F31hLvxgygPUtEbYiCTqPf6A0z975RVbwclQIT0Md20AkuIBQeakKzU/nLA+n1
         0ye1Go/8N2WC9wh6Y6HIErrjaWOUHSVU4a8Flve8Ixcp5USJgWuXlkGRUqxhc0NvaA5g
         CERsX42ENT/5xY5ixYql4o2njdTb5V9YsSz6NbpzzaFhZb/SES+LBh7ayWPL2N7q0brk
         LM2V8Q99ojbiZ6ozZrIdBLj14tIRqoN54sNKKr1pcOKyISCFo07PxK9LMg5slA6gzkSg
         OW4LlrVIBCtTgNh5ScTfgE12caNlBt73KcUMNyCXMPi2WEIGpagswD3hkpr0+8TC1aqX
         81OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y2IM6DzfFDx9Aaymi1QveC+KmSrtW+10rl842P9AHYs=;
        b=ul444/OzHp0yOc4W0ShgO3mxsC2UquP2aelGX1SpS1voGijAPs7/g0xXfchj/F9/pm
         41MGIM0qGCgwf0zWsVMItByRIEYbzmk8w0UmtWliWwcgbyyqNCXWcn9XOmXaiX0m+RIE
         VaSIv408CNsF941W1Fm3dS/z5XZWJ9i694thaYuCecI4cbZjY+uXeUYXHd7ZdrfX6u30
         fZ+Ft944WvKum9qXZpqSDgocltQSzfDIZHKbDXJh3rxe2atX6MqMJD+7yZe4jjuQacMv
         X84egqO/vx+AqUPxdQ2/AdEGHGUywgl/OGWOguCnhWruWVzpyo5THs2wg1MXIv4Rxpj+
         bJnA==
X-Gm-Message-State: APt69E1Rlok4SHG8AVGD1KGGcjFstRzYzOTK6ug6MPJ2axc7Ddq1IfN9
        wY9pWxmki9aO03ESn8FFlWDOxsOc
X-Google-Smtp-Source: ADUXVKLfWJ+h04iwLvQLFCmLjkW/udg4rtjj7Fiyi/eTlJt+ZpiwVld5USocQyhqt2JUYQNkb5xe8g==
X-Received: by 2002:a1c:6545:: with SMTP id z66-v6mr401865wmb.86.1528231676152;
        Tue, 05 Jun 2018 13:47:56 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id i4-v6sm1613459wrq.28.2018.06.05.13.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:47:55 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 01/10] rerere: unify error messages when read_cache fails
Date:   Tue,  5 Jun 2018 22:52:10 +0100
Message-Id: <20180605215219.28783-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
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
2.17.0.410.g65aef3a6c4


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE405E7B615
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 13:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbjJDNS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 09:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjJDNSX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 09:18:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E569E
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 06:18:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c61acd1285so15262345ad.2
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696425499; x=1697030299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFTKN8E2VbQJgmeQ1ifbFtW24IbNvHZHQMBXGEY0E/I=;
        b=KwWqK/ejqxcYgDj7HM+atYw1KXqGVH1oZJZXSMq+VNF7bWkf+1ye8PNMVSYWBj5M/l
         BHfvLdVlMStmRCCOA9R0ouDh3MJZDYQkcnGIemVx250/XXnnTNZKYuDwEsC36juvWhHD
         kD73XiTHU/qTFz+BIee4UJJCjIcGOPfPYfaK9TRGVJ+bg+yIJYZd3G5CdosEakrrCLSG
         9bA6ezfHHcHxJy0vPCKMP8XP4GZCI7qJd4oaixFm3NayoUpgjj8uteg0z4vgYndtniT1
         eJFOIJIPGf6Wwv51y8+SQCMiYi0lCi34s174nEy2GvfTMWngCe/mc8If5fLFJa425/X+
         4ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425499; x=1697030299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFTKN8E2VbQJgmeQ1ifbFtW24IbNvHZHQMBXGEY0E/I=;
        b=HWVCtH9jSXDZUjmN51NNzIknbriSAUJFpULqR40+xPA/QS4z9dqcLJqnqRA7Pw2ohy
         +93QnXFQ+CF9u2jQj4HdF1cgE42BGLjpyB1EysFKoa/kBu3BCOx8EL+wK2+MEkcMZXiI
         2qgsZYdHneurcYEGbHwWg8ITMCI2RPXiftiPS0pN3PYu99xZIaMfJYpzueJjabKBTvSl
         adZUNe1lkDoAcWFjb/n/ZMgP98UZ/UiQeXX8tw8ltjmIdxKqGsNLGfsbdjOGt3R/BDT2
         0NDXwVgRBHAQGIJMgIRtj5XFFUAonLDhmDHBqEuK/4Oes49ab6D3M7D+Dzla82RG2SGe
         nOTg==
X-Gm-Message-State: AOJu0YynGIAInrRStovMICg0tcB6tiNc5MP7flOB06V/xF2w5QzHNeZw
        WxyErFWfOgTZQf8c5aBexaBsZhb/nto=
X-Google-Smtp-Source: AGHT+IGNELiN6kDL6ysXKlrg193nPDHb1NumHwijKJSaui6mrYxdzUU4ZKjdQIE3yGSwcC6P7Z76/A==
X-Received: by 2002:a17:90a:3de6:b0:26d:17da:5e9f with SMTP id i93-20020a17090a3de600b0026d17da5e9fmr2073189pjc.1.1696425499460;
        Wed, 04 Oct 2023 06:18:19 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a134e00b00260a5ecd273sm1465496pjf.1.2023.10.04.06.18.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:18:18 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 2/3] pkt-line: memorize sideband fragment in reader
Date:   Wed,  4 Oct 2023 21:18:13 +0800
Message-Id: <e991ba2099aaa12ed01382bfaca54a3a213919c3.1696425168.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>
References: <ZRKax7Me5uIHKHoC@ugly> <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When we turn on the "use_sideband" field of the packet_reader,
"packet_reader_read()" will call the function "demultiplex_sideband()"
to parse and consume sideband messages. Sideband fragment which does not
end with "\r" or "\n" will be saved in the sixth parameter "scratch"
and it can be reused and be concatenated when parsing another sideband
message.

In "packet_reader_read()" function, the local variable "scratch" can
only be reused by subsequent sideband messages. But if there is a
payload message between two sideband fragments, the first fragment
which is saved in the local variable "scratch" will be lost.

To solve this problem, we can add a new field "scratch" in
packet_reader to memorize the sideband fragment across different calls
of "packet_reader_read()".

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 pkt-line.c             | 5 ++---
 pkt-line.h             | 3 +++
 t/t0070-fundamental.sh | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index af83a19f4d..5943777a17 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -592,12 +592,11 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 	reader->options = options;
 	reader->me = "git";
 	reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	strbuf_init(&reader->scratch, 0);
 }
 
 enum packet_read_status packet_reader_read(struct packet_reader *reader)
 {
-	struct strbuf scratch = STRBUF_INIT;
-
 	if (reader->line_peeked) {
 		reader->line_peeked = 0;
 		return reader->status;
@@ -620,7 +619,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 			break;
 		if (demultiplex_sideband(reader->me, reader->status,
 					 reader->buffer, reader->pktlen, 1,
-					 &scratch, &sideband_type))
+					 &reader->scratch, &sideband_type))
 			break;
 	}
 
diff --git a/pkt-line.h b/pkt-line.h
index 954eec8719..be1010d34e 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -194,6 +194,9 @@ struct packet_reader {
 
 	/* hash algorithm in use */
 	const struct git_hash_algo *hash_algo;
+
+	/* hold temporary sideband message */
+	struct strbuf scratch;
 };
 
 /*
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 1053913d2d..a927c665d6 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -81,7 +81,7 @@ test_expect_success 'unpack-sideband: --chomp-newline (default)' '
 	test_cmp expect-err err
 '
 
-test_expect_failure 'unpack-sideband with demultiplex_sideband(), no chomp newline' '
+test_expect_success 'unpack-sideband with demultiplex_sideband(), no chomp newline' '
 	test_when_finished "rm -f expect-out expect-err" &&
 	test-tool pkt-line send-split-sideband >split-sideband &&
 	test-tool pkt-line unpack-sideband \
-- 
2.40.1.50.gf560bcc116.dirty


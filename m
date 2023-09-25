Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FB2CE7A96
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjIYPnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjIYPmq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:42:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2281BC0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:41:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27758c8f62aso1516263a91.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695656511; x=1696261311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFTKN8E2VbQJgmeQ1ifbFtW24IbNvHZHQMBXGEY0E/I=;
        b=mTA7nB0iU8rKGFZujonRu6Ywt+HPZQx8TI5Y3SkUR+RRk0lHNqyAFPo96lNDDHRde9
         w7PDjHdux9YVX3VOUiYfbEzc2kGEP1vqImePlaZSPxGB3V4Sg52zii1zdUCiAxZoyK76
         GYTadP9diXW6uEQDww715ow5kBDeEFHb8AIqGjW8I8/awUjAtVFn/MFnKXYO40mrxFA2
         KqPBcvkKEbfeltHDVp2fCmPLSUsuCUGRwZUGUZWfs3dT163fGy0OehmbUhdiV0EDyEma
         jbKXlXRUQCKe01TUbKzzneORrweKGxmIhaRjASvMAeWtfRevsQdK8InZs12rhkF6RzpZ
         VBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656511; x=1696261311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFTKN8E2VbQJgmeQ1ifbFtW24IbNvHZHQMBXGEY0E/I=;
        b=oozqZSHpw/B3/+YCcUTW519B7sYHFmShhVpaOtFyIRiG+OFIPcxFowBeMfphOruaKx
         802beeEVREmI3hE5G9DsCh8DpQTMUR2E/JcWUri3VioltlpB7YCxg7tT584ck2kkE+gl
         5FdoUJY4Qjo4UxfWZZJ3MgLklCcxcCWPrNOqVVxtjLcvBqXXzzEHTCfPYmdEOiDV5vXm
         Q4m5pB3hpphCIEAD/Hm1FqOyK93+CYUxU1HlEk/p+1asDmtu8XAuDAtebkyiisOpZxGD
         G7aFHwuQ4Y/fr3b/cGRLBtZPosTqfLZ1ZA1h+q4p3vk8/OUS2l8AkiWHheX6CglqoDe0
         LO8g==
X-Gm-Message-State: AOJu0Yx8qHRwo+ihW+jbEIZQbU06FCHqdKQRTeGPapdY6zUMbnYMeO55
        5QQ29F2iigV5TYHa61emfnLudEN5RHU=
X-Google-Smtp-Source: AGHT+IE0MdygXoWA8PWVg6XGJXfzh0bdQ95Ekc15w32g8dFH12Va64VyGO7Q3ND51xGpTEBizwoa+g==
X-Received: by 2002:a17:90b:68f:b0:268:d456:123 with SMTP id m15-20020a17090b068f00b00268d4560123mr4486146pjz.41.1695656511623;
        Mon, 25 Sep 2023 08:41:51 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b00274e610dbdasm10960638pjl.8.2023.09.25.08.41.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:41:51 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 2/3] pkt-line: memorize sideband fragment in reader
Date:   Mon, 25 Sep 2023 23:41:43 +0800
Message-Id: <20230925154144.15213-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
References: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
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


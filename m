Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFECC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85D7222EA
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQB6aclu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgJSTfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSTfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:35:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA16C0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:35:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so1074085wrn.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SUtRTmE+hcSHT1KcogErnq0GmtK35/oPawthAnItLy4=;
        b=oQB6acluSIWEGuvy6R+F1TVct/aC3D9Eo6qNL/AE9PXN208Cb+d+Yfgl0u5Re9ptV0
         r4rXyyshrdSnzi//M9RvwiE9RCnyFETEdnzuLiJyIOlYJe9doVy4Dk9LRtNDi0yfsoQv
         MS/feMYRH/ttiqI7q7Iu4hr2eNIF9wfZckaxuaHUw10BqxE1Ta9J22tq5tlVcVneHPpd
         KxF6XVISo4QPimcK5wVQNQNnrCYpk8BkISR/P8/d/7kzv9ImWCXFlXKl3kNCzv+MWyf4
         QjBGu3vBLQ+7BPgxb4A/wCXGoEjT8qeTdP3mqv5FV0YF6ISROwkQnpsnHlc6ewmfSQSy
         4PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SUtRTmE+hcSHT1KcogErnq0GmtK35/oPawthAnItLy4=;
        b=f97pcIXxcN4tEoBtk93zOKgE/UAYvZ4iNg9vHNBDuTTHX+IrM0RDlIvvoYAa1bHK73
         o7d5vxj2sQmnzQ+kz7tgwlf/uzZjvvLAj5sn8ZMETeZOAC3OPcn29R0S1EyfPbNL/WRu
         TDbNLbnWQAwfR0XJwVOiXhT2gcW7jUmPV9TzUJGnYGa193v4x8e3wLJoGxIpTWhryyRt
         V2n+RnmZzDKgmnD5a+ckJVFMAV+EAgKS+bdI4PRnEsng97wTwOl458J44SgKBFVte0+I
         uCw0sS83uJtUCc5EI1yzQGiO+0FUphBGBoBiWE1EiQkFY9RQbzNXASR7ZpQPwd6H1pk9
         skXg==
X-Gm-Message-State: AOAM531gV/VbtrnKy7ZBglgP5cJy+4YC8vq8sgvGtMpwjvmZqBiRjN91
        Llfcy9czWPNjFogixDGm1O7w1UwuIto=
X-Google-Smtp-Source: ABdhPJwM3E4R8F6MZpO6N/yFpnvHsvjvxQgIWui0filDtUesI0Gz3q9SW3AcIliuTxqT2IH+Sbi8HA==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr869823wrp.312.1603136144648;
        Mon, 19 Oct 2020 12:35:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm805850wro.89.2020.10.19.12.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:35:44 -0700 (PDT)
Message-Id: <e4ba96358b7c5d2b4148c5529a3c253dc0d1f358.1603136143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
        <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:35:40 +0000
Subject: [PATCH v2 1/3] sideband: avoid reporting incomplete sideband messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 2b695ecd74d (t5500: count objects through stderr, not trace,
2020-05-06) we tried to ensure that the "Total 3" message could be
grepped in Git's output, even if it sometimes got chopped up into
multiple lines in the trace machinery.

However, the first instance where this mattered now goes through the
sideband machinery, where it is _still_ possible for messages to get
chopped up: it *is* possible for the standard error stream to be sent
byte-for-byte and hence it can be easily interrupted. Meaning: it is
possible for the single line that we're looking for to be chopped up
into multiple sideband packets, with a primary packet being delivered
between them.

This seems to happen occasionally in the `vs-test` part of our CI
builds, i.e. with binaries built using Visual C, but not when building
with GCC or clang; The symptom is that t5500.43 fails to find a line
matching `remote: Total 3` in the `log` file, which ends in something
along these lines:

	remote: Tota
	remote: l 3 (delta 0), reused 0 (delta 0), pack-reused 0

This should not happen, though: we have code in `demultiplex_sideband()`
_specifically_ to stitch back together lines that were delivered in
separate sideband packets.

However, this stitching was broken in a subtle way in fbd76cd450
(sideband: reverse its dependency on pkt-line, 2019-01-16): before that
change, incomplete sideband lines would not be flushed upon receiving a
primary packet, but after that patch, they would be.

The subtleness of this bug comes from the fact that it is easy to get
confused by the ambiguous meaning of the `break` keyword: after writing
the primary packet contents, the `break;` in the original version of
`recv_sideband()` does _not_ break out of the `while` loop, but instead
only ends the `switch` case:

	while (!retval) {
		[...]
		switch (band) {
			[...]
		case 1:
/* Write the contents of the primary packet */
			write_or_die(out, buf + 1, len);
/* Here, we do *not* break out of the loop, `retval` is unchanged */
			break;
		[...]
	}

	if (outbuf.len) {
/* Write any remaining sideband messages lacking a trailing LF */
		strbuf_addch(&outbuf, '\n');
		xwrite(2, outbuf.buf, outbuf.len);
	}

In contrast, after fbd76cd450 (sideband: reverse its dependency on
pkt-line, 2019-01-16), the body of the `while` loop was extracted into
`demultiplex_sideband()`, crucially _including_ the logic to write
incomplete sideband messages:

	switch (band) {
	[...]
	case 1:
		*sideband_type = SIDEBAND_PRIMARY;
/* This does not break out of the loop: the loop is in the caller */
		break;
	[...]
	}

cleanup:
	[...]
/* This logic is now no longer _outside_ the loop but _inside_ */
	if (scratch->len) {
		strbuf_addch(scratch, '\n');
		xwrite(2, scratch->buf, scratch->len);
	}

The correct way to fix this is to return from `demultiplex_sideband()`
early. The caller will then write out the contents of the primary packet
and continue looping. The `scratch` buffer for incomplete sideband
messages is owned by that caller, and will continue to accumulate the
remainder(s) of those messages. The loop will only end once
`demultiplex_sideband()` returned non-zero _and_ did not indicate a
primary packet, which is the case only when we hit the `cleanup:` path,
in which we take care of flushing any unfinished sideband messages and
release the `scratch` buffer.

To ensure that this does not get broken again, we introduce a pair of
subcommands of the `pkt-line` test helper that specifically chop up the
sideband message and squeeze a primary packet into the middle.

Final note: The other test case touched by 2b695ecd74d (t5500: count
objects through stderr, not trace, 2020-05-06) is not affected by this
issue because the sideband machinery is not involved there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sideband.c               |  2 +-
 t/helper/test-pkt-line.c | 23 +++++++++++++++++++++++
 t/t0070-fundamental.sh   |  6 ++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/sideband.c b/sideband.c
index 0a60662fa6..a5405b9aaa 100644
--- a/sideband.c
+++ b/sideband.c
@@ -190,7 +190,7 @@ int demultiplex_sideband(const char *me, char *buf, int len,
 		return 0;
 	case 1:
 		*sideband_type = SIDEBAND_PRIMARY;
-		break;
+		return 1;
 	default:
 		strbuf_addf(scratch, "%s%s: protocol error: bad band #%d",
 			    scratch->len ? "\n" : "", me, band);
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 69152958e5..0bf20642be 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -84,6 +84,25 @@ static void unpack_sideband(void)
 	}
 }
 
+static int send_split_sideband(void)
+{
+	const char *part1 = "Hello,";
+	const char *primary = "\001primary: regular output\n";
+	const char *part2 = " world!\n";
+
+	send_sideband(1, 2, part1, strlen(part1), LARGE_PACKET_MAX);
+	packet_write(1, primary, strlen(primary));
+	send_sideband(1, 2, part2, strlen(part2), LARGE_PACKET_MAX);
+	packet_response_end(1);
+
+	return 0;
+}
+
+static int receive_sideband(void)
+{
+	return recv_sideband("sideband: ", 0, 1);
+}
+
 int cmd__pkt_line(int argc, const char **argv)
 {
 	if (argc < 2)
@@ -95,6 +114,10 @@ int cmd__pkt_line(int argc, const char **argv)
 		unpack();
 	else if (!strcmp(argv[1], "unpack-sideband"))
 		unpack_sideband();
+	else if (!strcmp(argv[1], "send-split-sideband"))
+		send_split_sideband();
+	else if (!strcmp(argv[1], "receive-sideband"))
+		receive_sideband();
 	else
 		die("invalid argument '%s'", argv[1]);
 
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 7b111a56fd..357201640a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -34,4 +34,10 @@ test_expect_success 'check for a bug in the regex routines' '
 	test-tool regex --bug
 '
 
+test_expect_success 'incomplete sideband messages are reassembled' '
+	test-tool pkt-line send-split-sideband >split-sideband &&
+	test-tool pkt-line receive-sideband <split-sideband 2>err &&
+	grep "Hello, world" err
+'
+
 test_done
-- 
gitgitgadget


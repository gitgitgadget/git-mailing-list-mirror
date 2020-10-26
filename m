Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781EBC2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B046241A4
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjDRjUzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785029AbgJZQJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:09:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39432 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1785022AbgJZQJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:09:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id y12so13252661wrp.6
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SUtRTmE+hcSHT1KcogErnq0GmtK35/oPawthAnItLy4=;
        b=LjDRjUzOZZU/9exKzp7jTXpU91CRabXz9FbVLT4za37dzjF4crxrnUTWyUDrk/wTmB
         HFe1VswU2UhZd2JHfyy3oaDPkX0JwT2ccj3EOmWTns50LtW87W/WF4kvHUjPZ/WP2GPK
         SByY2ZzOLFuOsSq7Hj25mbo5tTUpjHPYPe0+cek3alerKEi7VdbTGvxpDIfpbo7q/GPh
         Z8WDq6ANJYTcETkidgL6iTEwnS1bZ38Xf8Rr9fajKv3fcTNCp4MHIO6AZEITJCS1htSe
         1FJPVowGF1Hz9M7szV4RKnu0KQiLN2SBeM3M1flvoEZZm+vuuXPx4p7COgWoqNwvaqqB
         uDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SUtRTmE+hcSHT1KcogErnq0GmtK35/oPawthAnItLy4=;
        b=KnJKyIK17jN7sXbOvBzBufu/+u/MGac6/Ng/aMZo0j0qeTvYfEzKGU1bmHcnB7no5w
         +JKMF4X010aXD+Zy3wi11n1iANq7BEw+N/y+l14fFCoqJXyyQOI+Fqt++w3S0dBWJlUl
         v442jmzJXn6M0/F5MOPNMiX8cxE715TbPVgQMIW1P3DcsfeR2iaicyo4YzsUcP4LDHwv
         T/pCgUDaWvmYxrS31du7AvIdr0F2H5f+ARngEQUi5hHscWsDRjSK7e42GstHmO11Uio/
         Z6uEWtXvwxULZn/t17Dqe4pdhImJkC9fTvf6DMbwV3SmYFw5GyJu2bdv5jI7cq/vt2TL
         3JCA==
X-Gm-Message-State: AOAM532jV/sZwzyGScmQlgv3IqaZu4cVp2u/4k2ldcUql95Xe4+wGHMN
        kvIAeJ4x/EOKNaZTM6Jxw0pz+sRqbq4=
X-Google-Smtp-Source: ABdhPJxTsvcr3+7Fj0SZ268GjABrxCfUbGDgT8W7csiBqfK8mvcTd2cZoyJwBp66giHcYdMYVSaocA==
X-Received: by 2002:a5d:67c4:: with SMTP id n4mr18381128wrw.125.1603728557733;
        Mon, 26 Oct 2020 09:09:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a185sm21068964wmf.24.2020.10.26.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:09:17 -0700 (PDT)
Message-Id: <e4ba96358b7c5d2b4148c5529a3c253dc0d1f358.1603728555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 16:09:14 +0000
Subject: [PATCH v3 1/2] sideband: avoid reporting incomplete sideband messages
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


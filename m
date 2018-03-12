Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF741F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeCLC2z (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34430 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932618AbeCLC2p (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 18703610E1;
        Mon, 12 Mar 2018 02:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821724;
        bh=sBa+2Vl+rUaMLfuWiuH1OyhXSQ9e+wPvaaSh3yyB7cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mKemfEgPqyqo7aM6qP8ZkSFbbrdwQlmn2bitz8y9Dl1MuUtzRg1dxN3NmTeigH5fN
         pzqxyklNPBPmtHShdLMu8fw1fY+AxefZD0kLRcqX5AruMLJIO54YH5SxbSdDq5d+Bl
         IQ+tSGbcR1rvwxPRGIVWIoNeU1Np6ysLKoOrwGRFG98ojrDEZ7Ye2mFk0GG0iNuGQM
         1g0GwPulNP5dBB6+XOjZNXhk9JoONtTzMo4F8sdqFUATxN96CooUTa2vJ80ij5Sgvg
         /ClEJf9ccJMX2cXtlXJvKIRGzyGXmyhMsQ/U0bn1qW15v0BX8h8t6OTngapP7cYdLW
         Kx8I/7sYW6eot3181ojauO9+KJZMiklk8b7NB9fWcSCLM6r93bbZHsBOQFIALB/v5M
         xBV5U8hyXRN6IS9qraFCEFpXj046QvKuHJ3s+gmwyf+2wdkhPxXffXUfxiWq6cGBtR
         ML88HoDj9ANhoQyaHMmxNHECqWsxzjl22/SiW1yL0aEGcoH5ZsF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 28/36] builtin/notes: convert static functions to object_id
Date:   Mon, 12 Mar 2018 02:27:48 +0000
Message-Id: <20180312022756.483934-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining static functions to take pointers to struct
object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/notes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 39304ba743..08ab9d7130 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -118,11 +118,11 @@ static int list_each_note(const struct object_id *object_oid,
 	return 0;
 }
 
-static void copy_obj_to_fd(int fd, const unsigned char *sha1)
+static void copy_obj_to_fd(int fd, const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = read_sha1_file(sha1, &type, &size);
+	char *buf = read_sha1_file(oid->hash, &type, &size);
 	if (buf) {
 		if (size)
 			write_or_die(fd, buf, size);
@@ -162,7 +162,7 @@ static void write_commented_object(int fd, const struct object_id *object)
 }
 
 static void prepare_note_data(const struct object_id *object, struct note_data *d,
-		const unsigned char *old_note)
+		const struct object_id *old_note)
 {
 	if (d->use_editor || !d->given) {
 		int fd;
@@ -457,7 +457,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			oid_to_hex(&object));
 	}
 
-	prepare_note_data(&object, &d, note ? note->hash : NULL);
+	prepare_note_data(&object, &d, note);
 	if (d.buf.len || allow_empty) {
 		write_note_data(&d, &new_note);
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
@@ -602,7 +602,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	t = init_notes_check(argv[0], NOTES_INIT_WRITABLE);
 	note = get_note(t, &object);
 
-	prepare_note_data(&object, &d, edit && note ? note->hash : NULL);
+	prepare_note_data(&object, &d, edit && note ? note : NULL);
 
 	if (note && !edit) {
 		/* Append buf to previous note contents */

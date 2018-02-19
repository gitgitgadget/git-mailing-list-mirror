Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F131F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932346AbeBSXAm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:00:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33468 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932285AbeBSXAE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 18:00:04 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 77EBF6137A;
        Mon, 19 Feb 2018 23:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081202;
        bh=sBa+2Vl+rUaMLfuWiuH1OyhXSQ9e+wPvaaSh3yyB7cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=udm5SdCmqJ4cQ/CXD38ZA1UeF2QoN4lpHEC9l8MowJPBDGr03l/9r2FDwmT8yQlR1
         vUOZuiuiwJhOW3MvbzDCZ93Mc3QdCIW+qaVtUeC5MoF6FQbdn+oTpJIsfG5k3NgHp8
         o1rsdzJzfDPjXWPkDVKtx2uaefPK+U+/EuHnncDM+9YJk8+JN4Dnnx5BYKizMPR0rm
         NBZAFK3tgB3PI+8THK14cgdCqwLPuWl6zTQyYk+iISJR1MRbIg9i2934NWVyuwnjh4
         ReitKedpWuoPY4fnyrVAKGpxNHB02vFUICKb0IqQ3mzpnsUz2tiiMu40p93/QiJI7e
         s4p3eOZwf4NmfXqJT9J8SQxguFuCxNeESITSIZAG+PjZBLmc9oI2qjio/1zkBAi0/s
         4tdOaNrqPAh1eJZe0q6prqWL7BSz1XGhc/rXlRtX4TjjL1bYI4Xb0y4YzJxTgC56gq
         kRBcDTtAbMQSeiAIsma1ojoa6PnvIKdauXiaeRhwFfvfQipDUDC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 28/36] builtin/notes: convert static functions to object_id
Date:   Mon, 19 Feb 2018 22:59:19 +0000
Message-Id: <20180219225927.386065-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
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

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E62AC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5854F60EFD
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhKLJoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhKLJox (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 04:44:53 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76451C06127A
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n85so8024061pfd.10
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2W5X25/KoAJXu3U5msZKVRYOHfoP6Zpb5dytoB/oTY=;
        b=bXmDRfCxnECG6M4EFqmBYqrn4hAOHZ7bZt4ION6l4/4aLPebxQIMGd2lGeC/rR2yyy
         0K7EgFngS7/YparSWfMMWC/K+8L7qUhtXi3JvLCk+fggzRq+hheJuo2L61ntWQL0ZgWy
         M/DDKcPcwglljTvbt6FeJ78mfQibFDAuUWBVE+aBP+dgKadJCoNieYtphHSiAOMUxxKu
         cWBNyRpm9ubkHrXhaCN/W1jrNRyGsgvgboAZewtE2nGnIGc1Gps+JJjNHs3ko/PTsi8j
         1gUU6V9mttYjmSbnd1R4l2yURzD5qTc2vUjzq2sn/+6XkMiWAaFS/3oXOwqJOP0025U3
         x0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2W5X25/KoAJXu3U5msZKVRYOHfoP6Zpb5dytoB/oTY=;
        b=Yv2iMvB6DoJ0Za8sCZQSY7aJxZFoCFjpoX0Pk3hd5QcD7IDdOHhmmfstUt3ffThS0m
         AouPAcG9+rpfQh+PsLGgSS8N4quRoFrZMEegPxBVFXf+PLl+8XZs9/3aQ5v5ahsHkSaR
         IZZjfCOQIt6jxHdkUCzGg8ZaCvNslaCOsGljuVQ+JegF7n6C6tSI6ZhTm9WdVpH0jieU
         xVbTr2kI8ub2orbYrNvPweDPFRsytNGqr2D49ZboKvvhKEz+B+fN4+ZCczHfKYE6t3ZV
         alC/qlun1HopMt8IK5uTiwQt+dd/XXcR1osVkv6/7N5kJBGnxVJ+wrCtOtZljcrzKTXp
         kISw==
X-Gm-Message-State: AOAM530c5C7dxlyv6zGtkVSQl6c+djAxt+dVikoGYIyNujXWYelYKmim
        QuX4QQBKdguMDz3hufp5E04=
X-Google-Smtp-Source: ABdhPJzP14MUdExdL4eoz6jCcFhB9XTU1plc7NW++uOF6UksAFlRwe1iA8PwOIOykhROHG536eK7Eg==
X-Received: by 2002:a05:6a00:15c7:b0:49f:f48b:f96e with SMTP id o7-20020a056a0015c700b0049ff48bf96emr12803480pfu.65.1636710123050;
        Fri, 12 Nov 2021 01:42:03 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id q18sm6310103pfj.46.2021.11.12.01.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Nov 2021 01:42:02 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v2 3/6] object-file.c: handle nil oid in write_loose_object()
Date:   Fri, 12 Nov 2021 17:40:07 +0800
Message-Id: <20211112094010.73468-3-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.33.1.44.g9344627884.agit.6.5.4
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When read input stream, oid can't get before reading all, and it will be
filled after reading.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index b0838c847e..8393659f0d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1893,7 +1893,13 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	const char *buf;
 	unsigned long len;
 
-	loose_object_path(the_repository, &filename, oid);
+	if (is_null_oid(oid)) {
+		/* When oid is not determined, save tmp file to odb path. */
+		strbuf_reset(&filename);
+		strbuf_addstr(&filename, the_repository->objects->odb->path);
+		strbuf_addch(&filename, '/');
+	} else
+		loose_object_path(the_repository, &filename, oid);
 
 	if (!dry_run) {
 		fd = create_tmpfile(&tmp_file, filename.buf);
@@ -1942,7 +1948,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_oid_fn(&parano_oid, &c);
-	if (!oideq(oid, &parano_oid))
+	if (!is_null_oid(oid) && !oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
@@ -1951,6 +1957,30 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	close_loose_object(fd);
 
+	if (is_null_oid(oid)) {
+		int dirlen;
+
+		/* copy oid */
+		oidcpy((struct object_id *)oid, &parano_oid);
+		/* We get the oid now */
+		loose_object_path(the_repository, &filename, oid);
+
+		dirlen = directory_size(filename.buf);
+		if (dirlen) {
+			struct strbuf dir = STRBUF_INIT;
+			/*
+			 * Make sure the directory exists; note that the
+			 * contents of the buffer are undefined after mkstemp
+			 * returns an error, so we have to rewrite the whole
+			 * buffer from scratch.
+			 */
+			strbuf_reset(&dir);
+			strbuf_add(&dir, filename.buf, dirlen - 1);
+			if (mkdir(dir.buf, 0777) && errno != EEXIST)
+				return -1;
+		}
+	}
+
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
-- 
2.33.1.44.g9344627884.agit.6.5.4


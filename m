Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D5EE14D8
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 06:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjIZGXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 02:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjIZGXI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 02:23:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEEAF0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:23:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c12ae20a5cso129259421fa.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 23:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695709379; x=1696314179; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8hixXzd8jXu6lQmBPmqdQo/d01jD8VxJ5wDmz+8Ee0=;
        b=Ff8aXIeVKoNKuwFCuWvOJKzTclF7H7re58ZgnNOgMPA19mrCb76VkJIt2TlwZHNBru
         Ce+qyXvoLrbAMx1g/0vhdoRDVdJdlMoWyUT1xRiZJT+DrOn0vTUjpF6hwVeFDngaBLtg
         woL5p2tW/0gtxIT3lAZpenfo+ZQTACpC1nPeIuhMVkS2M7SmIZeC/LpW6O9FniKeRZWj
         VzXK9MOcBrQGdaYwnIygt/8EmUNlkHiGOPLniBOqI7p2zCc2oYRpeif0qhvX6dTSewPD
         e1vd2w2v1FusFklKQ4qmfV88Uyr8aAtYYxfSfcpLswyyGrElfwMgbqxbjMyEDR+3stz2
         Jx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695709379; x=1696314179;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8hixXzd8jXu6lQmBPmqdQo/d01jD8VxJ5wDmz+8Ee0=;
        b=PSlOzxbB9QP1O4m4yyolY3oyHUhcpfX8BOLVsTxpxwslj/gEOmLM5sN8r3Ut8N+GgN
         91EZ6fG1aty48r4hzHPKlGZq1UzLAzyB70yBNGpUywQiyQD2fRK5GsAzoph6SPKbv8S2
         bmQ/9Jr5fbxF2h9nJhrF+tjUrqsFeMQiJ7vuKTlOccl/KielkuN4DXBhwZqr+kAgBPLG
         GKWFZq6KMK4mDZN0FhRkQCdQBKJWdYj4s5PWgK6bTAywKlWct3147mFNIyP9iMwdgWMR
         lZVmQVMt98uqDkGZ2ePZKr4+CbiEPIKzRClK+rSZill0LOctyaFaGnDNeOjpLAfqKDGu
         vRWQ==
X-Gm-Message-State: AOJu0Yx+yhMmTnfPDSW2k1lpVzMgnH5ZXGcnRA02wM6pJdW9gX6FjRrA
        kxn+udDB2JpQuSKxsqkbNwYXoixovPM=
X-Google-Smtp-Source: AGHT+IFPzJOzZBsZp1smkKH63dpAL99LaAJsiyqT1KlaqLcvrGS2OLMpzKHCicmxXYpavpk+VAmaeA==
X-Received: by 2002:a2e:6e13:0:b0:2bc:b694:6d6e with SMTP id j19-20020a2e6e13000000b002bcb6946d6emr7700417ljc.27.1695709378971;
        Mon, 25 Sep 2023 23:22:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a2e95c4000000b002ba586d27a2sm2515306ljh.26.2023.09.25.23.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:22:58 -0700 (PDT)
Message-ID: <64e1bd4e4be6d5f59b17986601aa2b7285362937.1695709372.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
References: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
        <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Sep 2023 06:22:52 +0000
Subject: [PATCH v4 4/4] trailer: only use trailer_block_* variables if
 trailers were found
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Previously, these variables were overloaded to act as the end of the log
message even if no trailers were found.

Remove the overloaded meaning by adding a new end_of_log_message field
to the trailer_info struct. The trailer_info struct consumers now only
refer to the trailer_block_start and trailer_block_end fields if
trailers were found (trailer_nr > 0), and otherwise refer to the
end_of_log_message.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 31 +++++++++++++++++++++++--------
 trailer.h | 12 +++++++-----
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3dc2faa969c..c11839ae365 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1083,9 +1083,14 @@ void process_trailers(const char *file,
 
 	parse_trailers(&info, sb.buf, &head, opts);
 
-	/* Print the lines before the trailers */
-	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+	/* Print the lines before the trailers (if any) as is. */
+	if (!opts->only_trailers) {
+		if (info.trailer_nr) {
+			fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+		} else {
+			fwrite(sb.buf, 1, info.end_of_log_message, outfile);
+		}
+	}
 
 	if (!opts->only_trailers && !info.blank_line_before_trailer)
 		fprintf(outfile, "\n");
@@ -1105,9 +1110,14 @@ void process_trailers(const char *file,
 	free_all(&head);
 	trailer_info_release(&info);
 
-	/* Print the lines after the trailers as is */
-	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+	/* Print the lines after the trailers (if any) as is. */
+	if (!opts->only_trailers) {
+		if (info.trailer_nr) {
+			fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+		} else {
+			fwrite(sb.buf + info.end_of_log_message, 1, sb.len - info.end_of_log_message, outfile);
+		}
+	}
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
@@ -1153,8 +1163,13 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
 	info->blank_line_before_trailer = ends_with_blank_line(str,
 							       trailer_block_start);
-	info->trailer_block_start = trailer_block_start;
-	info->trailer_block_end = end_of_log_message;
+	info->trailer_block_start = 0;
+	info->trailer_block_end = 0;
+	if (nr) {
+		info->trailer_block_start = trailer_block_start;
+		info->trailer_block_end = end_of_log_message;
+	}
+	info->end_of_log_message = end_of_log_message;
 	info->trailers = trailer_strings;
 	info->trailer_nr = nr;
 }
diff --git a/trailer.h b/trailer.h
index 70d7b8bf1d8..d1e8751952b 100644
--- a/trailer.h
+++ b/trailer.h
@@ -38,14 +38,16 @@ struct trailer_info {
 
 	/*
 	 * Offsets to the trailer block start and end positions in the input
-	 * string. If no trailer block is found, these are both set to the
-	 * "true" end of the input, per find_true_end_of_input().
-	 *
-	 * NOTE: This will be changed so that these point to 0 in the next
-	 * patch if no trailers are found.
+	 * string. If no trailer block is found, these are set to 0.
 	 */
 	size_t trailer_block_start, trailer_block_end;
 
+	/*
+	 * Offset to the end of the log message in the input (may not be the
+	 * same as the end of the input).
+	 */
+	size_t end_of_log_message;
+
 	/*
 	 * Array of trailers found.
 	 */
-- 
gitgitgadget

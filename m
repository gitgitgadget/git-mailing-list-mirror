Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967F2C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A52060E9B
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbhIUDAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349468AbhIUC0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCF3C1E3A4E
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x6so32565496wrv.13
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2DN0Xuw/aKGv6qAM1UCbcaHEea2KjpY3awCCXYW5wY=;
        b=R3T63oRLowUTHcExZRV3Coa//EANBn7m6A2jWz5nP6CBT0zPzCmKo4PyStPofkCErU
         YgKwxEl9lFD/Hfp1AZqxmMxpDEXD79mVJ/d0VK0vZlTh2IvCZQP/Z6mb7X0zt1owZIGY
         uCCIzjKz+P7VYa5JognupbbjYyEmQ14I3Vz0uzwOBGKJsxqQ6EqFySbquY8wR5AZXGXM
         rcU73E/Zp/GpGF0qcBTyJSSJd7xXuFAbvjKCMFyGL4fIAYNsPpLOoqx7T5/NAPOo6OvX
         VFivnaNUKI74Rd1hgFD3Aqv9pfidyVioJBRexKt1V5UHfln5GUWhLLmCQPeCPwlSUlMV
         B5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2DN0Xuw/aKGv6qAM1UCbcaHEea2KjpY3awCCXYW5wY=;
        b=sqh4J7jbEnksC6tyki7/TzKKMEGSHTOz6Kob9n6Pwck0etm9781u2Gc8iqtzIZU/95
         N+qiy8CMwUf+8+q7+w30Q+SGmVCLshUveXX/s1lLSazo9MApiTtia523QYm+wlMLKnaL
         rzWeDU5ELFp/8PMXX2hy26ALyuYmDXSsuXXtbKfjNQzB1nFKwuSQ3XIeuCap+4W4PmHR
         XBntTS2YZqeXGVVE5Mdin1cKMny1KFdMPSCxEO0jel8FEY7cGoRSYmvMU8e0DrD2JoLF
         NULnSYT8UqyasBDUwqPxD7nO98VxsQWzcUgANSnBGjPd1XaTqNrDpI0M/t3jsGtH6hTd
         jUnQ==
X-Gm-Message-State: AOAM532vW3LUNVToVxNIVdRijzAUDAdvaE1eH30v3nZbWx3D6MqiUWsc
        hp5agkubSv9vizELKCpX9plofiidO9M+Pg==
X-Google-Smtp-Source: ABdhPJwuKCJRT9c5019nJ/6LkcllQrV2+UqShOGVgOh60XCvF8GonsuAXNq+wPbyeAQ+9dkUpfftjA==
X-Received: by 2002:a05:6000:1090:: with SMTP id y16mr17667749wrw.208.1632164678454;
        Mon, 20 Sep 2021 12:04:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 14/17] object-file.c: return ULHR_TOO_LONG on "header too long"
Date:   Mon, 20 Sep 2021 21:04:18 +0200
Message-Id: <patch-v7-14.17-522d71eb19d-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the return code for "header too long" from the generic
negative return value unpack_loose_header() returns, and report via
error() if we exceed MAX_HEADER_LEN.

As a test added earlier in this series in t1006-cat-file.sh shows
we'll correctly emit zlib errors from zlib.c already in this case, so
we have no need to carry those return codes further down the
stack. Let's instead just return ULHR_TOO_LONG saying we ran into the
MAX_HEADER_LEN limit, or other negative values for "unable to unpack
<OID> header".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h             | 5 ++++-
 object-file.c       | 8 ++++++--
 streaming.c         | 1 +
 t/t1006-cat-file.sh | 4 ++--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 90dde86828e..49b18f2755c 100644
--- a/cache.h
+++ b/cache.h
@@ -1322,16 +1322,19 @@ int git_open_cloexec(const char *name, int flags);
  *
  * - ULHR_OK on success
  * - ULHR_BAD on error
+ * - ULHR_TOO_LONG if the header was too long
  *
  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
  * "hdrbuf" argument is non-NULL. This is intended for use with
  * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
  * reporting. The full header will be extracted to "hdrbuf" for use
- * with parse_loose_header().
+ * with parse_loose_header(), ULHR_TOO_LONG will still be returned
+ * from this function to indicate that the header was too long.
  */
 enum unpack_loose_header_result {
 	ULHR_OK,
 	ULHR_BAD,
+	ULHR_TOO_LONG,
 };
 enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 						    unsigned char *map,
diff --git a/object-file.c b/object-file.c
index b214a152ca8..ca4abe172ce 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1268,7 +1268,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 	 * --allow-unknown-type".
 	 */
 	if (!header)
-		return ULHR_BAD;
+		return ULHR_TOO_LONG;
 
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
@@ -1289,7 +1289,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 		stream->next_out = buffer;
 		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
-	return ULHR_BAD;
+	return ULHR_TOO_LONG;
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
@@ -1462,6 +1462,10 @@ static int loose_object_info(struct repository *r,
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
 		break;
+	case ULHR_TOO_LONG:
+		status = error(_("header for %s too long, exceeds %d bytes"),
+			       oid_to_hex(oid), MAX_HEADER_LEN);
+		break;
 	}
 
 	if (status < 0) {
diff --git a/streaming.c b/streaming.c
index 6df0247a4cb..bd89c50e7b3 100644
--- a/streaming.c
+++ b/streaming.c
@@ -235,6 +235,7 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 	case ULHR_OK:
 		break;
 	case ULHR_BAD:
+	case ULHR_TOO_LONG:
 		goto error;
 	}
 	if (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 269ab7e4729..711dcc6d795 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -356,12 +356,12 @@ do
 			if test "$arg2" = "-p"
 			then
 				cat >expect <<-EOF
-				error: unable to unpack $bogus_long_sha1 header
+				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
 				fatal: Not a valid object name $bogus_long_sha1
 				EOF
 			else
 				cat >expect <<-EOF
-				error: unable to unpack $bogus_long_sha1 header
+				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
 				fatal: git cat-file: could not get object info
 				EOF
 			fi &&
-- 
2.33.0.1098.g29a6526ae47


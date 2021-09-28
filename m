Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0FBC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870FF61247
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhI1CVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbhI1CUz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A02C061778
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q127-20020a1ca785000000b0030cb71ea4d1so1501141wme.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTfkA9cJmOFeDByXesQFa7t1cpnzmZyfmbqkEDL/CnU=;
        b=nT8xlLevBqmdGN9gytccI7hCqq799fJsnlstXJvVvxIcRbqMlsxQUq6l7oS7959NbF
         PFq08N/65fqraGZRu6C6l+timJBncubRFSzxnYzYPlLdMuDeILKcjmq5YM5Dhha625MA
         ltaKz+HwbXBMICXhl4zqXRJyevOwQZIU+doIj7EOdeEwrwQpMExMXwh+XwhfCZMDOKZG
         PAqufLRqYUGwEBDUvcUTVh8464a/IsyhAoeUm3eyW3xtvkxtv7SxiwIcpT/nofh+GZiP
         HfDutyuteNfmoUfvPPo+/ud/YEP8BFJBG6ZDx6YQkrunc0IF3N/+4Gu8IU3nfWwGpLUD
         Ideg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTfkA9cJmOFeDByXesQFa7t1cpnzmZyfmbqkEDL/CnU=;
        b=K/mw3mtRDRJHXxoHHaTRDidt2e9vr1F8SX34EuFKEnlj9jafMsyO1NHGpxyQ1cyXRG
         kbl4sLKnfGA0xYHhyPVJzsgI0AnIhkofLuynpTKRk4UzGPd89yg4sxaBjbwXvAUm21qn
         MuxlrZnMtEFPDcCdmH+kTRPtEgkClNLvFL7Xn+ZWyKjrxiGiz9OE/EI1PeviDB2vFZva
         A98eH30F0OR1AX7/RHJ72VQStJ3E7NYaRaGkoxG4KnLyEP5i6odBLg1w652LQIRE4GZL
         2UcFCjd4dmt4d5Jh4N1ym+EXRlW+vgm5efxHjbfZ9sRLpl+LNM/0ftEBhCE00xWnlcr9
         DQig==
X-Gm-Message-State: AOAM533cFoUKZRJ9H8k9fgf4dL8CJeEQPHNzR1QyGD9/jIDliUP24ueA
        Glsxm23g+yO5on0cYdvPcP5MF8dcKACSsg==
X-Google-Smtp-Source: ABdhPJwMxjY/zNW2HBL9WJM2xwcEwgqdrJC9WZY+eNFEHJOyiVMxYYkQSvGs44Li7LJU8/KnFjOPkQ==
X-Received: by 2002:a05:600c:4f54:: with SMTP id m20mr2292150wmq.96.1632795551071;
        Mon, 27 Sep 2021 19:19:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 14/17] object-file.c: return ULHR_TOO_LONG on "header too long"
Date:   Tue, 28 Sep 2021 04:18:55 +0200
Message-Id: <patch-v8-14.17-42b8d135c8c-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
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
index 7239e20a625..8e05392fda8 100644
--- a/cache.h
+++ b/cache.h
@@ -1328,16 +1328,19 @@ int git_open_cloexec(const char *name, int flags);
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
index e0f508415dd..3589c5a2e33 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1290,7 +1290,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 	 * --allow-unknown-type".
 	 */
 	if (!header)
-		return ULHR_BAD;
+		return ULHR_TOO_LONG;
 
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
@@ -1311,7 +1311,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 		stream->next_out = buffer;
 		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
-	return ULHR_BAD;
+	return ULHR_TOO_LONG;
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
@@ -1484,6 +1484,10 @@ static int loose_object_info(struct repository *r,
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
index 5b16c69c286..a5e7401af8b 100755
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
2.33.0.1327.g9926af6cb02


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40DFC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjEAPye (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjEAPyX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:54:23 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACA01BE3
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:54:05 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54fae5e9ec7so37356127b3.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682956445; x=1685548445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wmtv5RU1wZ45UPVBfLEuHugAxBCPpEdNpIApXNNuQWU=;
        b=d2rZ7/JldvrRi1E7HvkiFm4O9o9GBKexyhUuytPmvQZ/qlL/SeAZjuM/vY+syyTDry
         1M6i1eHsu855W64/e1BfGgGLZJJOYqvnlOPPakMyl9Afr+maArX/HREvXO7za2UF0Vuf
         lFkmVviHigSTCyL8dE8vpPmjoyI67BEgaxN+/wXxM9JEbsKab/fBrB0TyHpRvQ7lYbNc
         eDz0G4bSAcS5Lu/H0CUhl6TlIJsc4k0zOdiimiAz/b3o5yVQI/6YjmpElTkY+Vf1NPUL
         Z+uhDCYegB+wJSpp3sVHfHZLp/yt+u5omndb2sNHkLm7deNb0yuC5bioQYWfTlCMHZxF
         P05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956445; x=1685548445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wmtv5RU1wZ45UPVBfLEuHugAxBCPpEdNpIApXNNuQWU=;
        b=S3TuBOURvuxla498zR2LZq3Dxni1kNHkZ9hzk1U8N08tsS+lYMhTHw5lOUSmkF56cA
         wvx/MMPo0fHLUXQRoiSFzBD5iRNk//hMSGThudOfv/KwK8myYUcvzu333amh/Nz4XZ6h
         hq50jlt4A1eRtGASHrQmfgNiXUwrShGL1jZ79pXMCTXK2ZEbCUvRgR8dVjcdcySiSfAX
         1g/6ZeOi1QM9J2dvMTHSJ20w/CmNz7DNnIdxx2XesPd1xG3EnSYbtMRzBuZ9jxhZ9QGo
         p+6c46+Vkxfs/266+CJuYZUtDJam8RmQtGVFhv4xZA1zTrZkh+EZQOnGqPNYUIk7nfXt
         Sh9Q==
X-Gm-Message-State: AC+VfDwQXTrW0C/4iaKrox2sITRop26MGzmMQ8+dPG4Yby0nYLZio3gy
        wRzspADumYxL8VFOCQiWv4oAExKOlItktpB770g+2A==
X-Google-Smtp-Source: ACHHUZ4I2YDm/pe/hNVx2AErTBN6RCxWgu0r1V5nKpJCFB8ewrn0RRSay5NU6efwL36bCjCflZhreg==
X-Received: by 2002:a0d:cc0e:0:b0:54f:bec1:c118 with SMTP id o14-20020a0dcc0e000000b0054fbec1c118mr13412289ywd.38.1682956444901;
        Mon, 01 May 2023 08:54:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c199-20020a814ed0000000b0055a777e3c50sm293216ywb.62.2023.05.01.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:54:04 -0700 (PDT)
Date:   Mon, 1 May 2023 11:54:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 6/7] contrib/credential: avoid fixed-size buffer in libsecret
Message-ID: <9b9e2c0dd170eee96aa2c39eae061f8c92732bc4.1682956419.git.me@ttaylorr.com>
References: <cover.1682956419.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682956419.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The libsecret credential helper reads the newline-delimited
protocol stream one line at a time by repeatedly calling fgets() into a
fixed-size buffer, and is thus affected by the vulnerability described
in the previous commit.

To mitigate this attack, avoid using a fixed-size buffer, and instead
rely on getline() to allocate a buffer as large as necessary to fit the
entire content of the line, preventing any protocol injection.

In most parts of Git we don't assume that every platform has getline().
But libsecret is primarily used on Linux, where we do already assume it
(using a knob in config.mak.uname). POSIX also added getline() in 2008,
so we'd expect other recent Unix-like operating systems to have it
(e.g., FreeBSD also does).

Note that the buffer was already allocated on the heap in this case, but
we'll swap `g_free()` for `free()`, since it will now be allocated by
the system `getline()`, rather than glib's `g_malloc()`.

Tested-by: Jeff King <peff@peff.net>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .../libsecret/git-credential-libsecret.c          | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 2c5d76d789..ef681f29d5 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -244,17 +244,16 @@ static void credential_clear(struct credential *c)
 
 static int credential_read(struct credential *c)
 {
-	char *buf;
-	size_t line_len;
+	char *buf = NULL;
+	size_t alloc;
+	ssize_t line_len;
 	char *key;
 	char *value;
 
-	key = buf = g_malloc(1024);
+	while ((line_len = getline(&buf, &alloc, stdin)) > 0) {
+		key = buf;
 
-	while (fgets(buf, 1024, stdin)) {
-		line_len = strlen(buf);
-
-		if (line_len && buf[line_len-1] == '\n')
+		if (buf[line_len-1] == '\n')
 			buf[--line_len] = '\0';
 
 		if (!line_len)
@@ -298,7 +297,7 @@ static int credential_read(struct credential *c)
 		 */
 	}
 
-	g_free(buf);
+	free(buf);
 
 	return 0;
 }
-- 
2.40.1.452.gb3cd41c833


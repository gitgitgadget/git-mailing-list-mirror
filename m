Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EECCC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C91620757
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zUPKp1OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD2Rge (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2Rge (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 13:36:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C8C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n24so1077608plp.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d2eX3af3CZCo1adjL+hWq+uGifBkGN7Lpw1GojnJ2ak=;
        b=zUPKp1OLp94jtQe1pK77tFzwWAh9l+XYowJFwRDd6oG8okDAuC6EFe58EvtDzfLEu6
         F+H9FZfXsGRCz8nUUoLWZN7hjBEa7Tj4or6oB44Sxth8bffxABi5cdIHU34ptaHQ3krg
         X4vkdOm0iKEkkBnf33AebultHl0s0sccs86JB0/D+X0IHcATxjgU2XB6VRsCDEBXiwpJ
         zFh/X7/9du3KDL6Xr2Fvg0/QNYcFqpZw+9XCU4Uzvh/Vp0oEqprn29Ro74yqU0KC61or
         RLrzy6p05uIpvZnliZwReKM1ooF+HpGE55d+4z768l4KLiX1ZKD9qL6s3e0oXq2JtQA3
         xzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2eX3af3CZCo1adjL+hWq+uGifBkGN7Lpw1GojnJ2ak=;
        b=MsHa8f2oJ4B8UhBqL/0Q91vVPdGzuoN3TeSiv0CEnly+vhw/WcOuqHzQZtJwP39v/m
         zlOcsdE1r9neBIY7EIIOJhoY/7QQR5lR0ibOriFJzv/TxVX+/iyNSb3PA0RoLVS4r5lm
         jH4pNR5LC8teSQdcmb5mB9mhNZn2hhjM9u6zvkJIHl16EinTDWZ5jdD27RYLdF80Ut57
         mBr+Nu6zp3ASQsheI29wRhhU67uXYBJPzykJnDakvgADoxGicEtu3Y+N0myKSNpXdxz6
         9ulu6w0jJgkDEb9uwSwqK6PMJ6UAjFmXhlBQb6GBKHSzlvSJsvO3VwYJVlGE5f2AHtZR
         /6Ew==
X-Gm-Message-State: AGi0PubfmRhmmWu6s0TsVROFFyGTHi64M1Dff1ElGxo2aQkA98UPOkQy
        +VHpFoKXp3O6ggUUO2uCbOxIpcsvFh8bIA==
X-Google-Smtp-Source: APiQypJGllwHbbWNPty2Bl5XJSbgEoukFil8npuqh2msIsovJOAZud6UxpbhnO5VX3UlDeCs4zMjzw==
X-Received: by 2002:a17:90a:a402:: with SMTP id y2mr4703542pjp.24.1588181793346;
        Wed, 29 Apr 2020 10:36:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id j2sm1570763pfb.73.2020.04.29.10.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:36:32 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:36:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v3 1/5] tempfile.c: introduce 'create_tempfile_mode'
Message-ID: <03c975b0bd0cd3dd5d693187f12f45fd7565016c.1588181626.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588181626.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588181626.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, 'hold_lock_file_for_update' will gain an additional
'mode' parameter to specify permissions for the associated temporary
file.

Since the lockfile.c machinery uses 'create_tempfile' which always
creates a temporary file with global read-write permissions, introduce a
variant here that allows specifying the mode.

Note that the mode given to 'create_tempfile_mode' is not guaranteed to
be written to disk, since it is subject to both the umask and
'core.sharedRepository'.

Arguably, all temporary files should have permission 0444, since they
are likely to be renamed into place and then not written to again. This
is a much larger change than we may want to take on in this otherwise
small patch, so for the time being, make 'create_tempfile' behave as it
has always done by inlining it to 'create_tempfile_mode' with mode set
to '0666'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 tempfile.c |  6 +++---
 tempfile.h | 10 +++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index d43ad8c191..94aa18f3f7 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -130,17 +130,17 @@ static void deactivate_tempfile(struct tempfile *tempfile)
 }
 
 /* Make sure errno contains a meaningful value on error */
-struct tempfile *create_tempfile(const char *path)
+struct tempfile *create_tempfile_mode(const char *path, int mode)
 {
 	struct tempfile *tempfile = new_tempfile();
 
 	strbuf_add_absolute_path(&tempfile->filename, path);
 	tempfile->fd = open(tempfile->filename.buf,
-			    O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, 0666);
+			    O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC, mode);
 	if (O_CLOEXEC && tempfile->fd < 0 && errno == EINVAL)
 		/* Try again w/o O_CLOEXEC: the kernel might not support it */
 		tempfile->fd = open(tempfile->filename.buf,
-				    O_RDWR | O_CREAT | O_EXCL, 0666);
+				    O_RDWR | O_CREAT | O_EXCL, mode);
 	if (tempfile->fd < 0) {
 		deactivate_tempfile(tempfile);
 		return NULL;
diff --git a/tempfile.h b/tempfile.h
index cddda0a33c..4de3bc77d2 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -88,8 +88,16 @@ struct tempfile {
  * Attempt to create a temporary file at the specified `path`. Return
  * a tempfile (whose "fd" member can be used for writing to it), or
  * NULL on error. It is an error if a file already exists at that path.
+ * Note that `mode` will be further modified by the umask, and possibly
+ * `core.sharedRepository`, so it is not guaranteed to have the given
+ * mode.
  */
-struct tempfile *create_tempfile(const char *path);
+struct tempfile *create_tempfile_mode(const char *path, int mode);
+
+static inline struct tempfile *create_tempfile(const char *path)
+{
+	return create_tempfile_mode(path, 0666);
+}
 
 /*
  * Register an existing file as a tempfile, meaning that it will be
-- 
2.26.0.113.ge9739cdccc


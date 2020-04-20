Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC87C55181
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B848920BED
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BB8IijYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDTWvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTWvF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 18:51:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0ADC061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:51:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so1294263pfd.4
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zc0XD++dRLwJ4ra+UEt7rdgDRmaiZzW5KLmOZ/KKi7c=;
        b=BB8IijYCVDZGx4eIYioK5nqXKIYkx71iaJB4xsCz5t0YOCwB/N4984TVbCAMvbOdVw
         eIbX+t/e/lPtjzpnJ2SPj/J/ud7mNXVqML8YpTaifST6Qhecv429GD7oYQBr8PZXF5oB
         SCC85xZzvOdIyw6nNoQh37RUa0t4d06NKS/INsH1yyK7f701F7Qgbe/+UChZwVxs/iLG
         y+K6bJH9w/rW2SyWe4pmkllzKGS27MPJ25l+/YjTFLcTP8Zawjs1HGLxWKDj3mz6rwCN
         EkYU0XBSyjoZChMLze1m/OOxmI+k3wHwYiv+Y1uJ8GfrcednukaKBHCtKrykSOQ4TBKS
         a6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zc0XD++dRLwJ4ra+UEt7rdgDRmaiZzW5KLmOZ/KKi7c=;
        b=ZwBidYGBvMsOHLSsy3l/BjD+bnSLY2XuXf+V6Z1xEM8KZDIgMEd0BatmHW2JX2wt2Q
         nUCMPjhxoMyvf4e0HsCIVHlR1f3JpSFgkwbdFAbVpdeCIx5QQ4wR+RZYqWvbS6CwLRtL
         GP5Xz0XeX+CNiHU4jBG5E7gDanzBHI7w5/73eNyTyLs8lydWWEXib7k1beJaUJOLgTil
         3Rp+9Rn7KW/05E5Y64p9h45P7jf+X6DWRrxRQ+8MCdxzGPRNGFbGFE1Gk3+sMZsA6oqs
         EEJHzXexVFm7umwO3G5iVfM+vKNH8cBJsMdUHQUf0QaBHnLwJrweAYRkIlWDOpPBXnjO
         C4+w==
X-Gm-Message-State: AGi0PubVdEGvQQm/fVhESV8t737frIpV1983p+GE7w2Jj9L0Ct6Q9SeX
        8pRVHsLTOmLCve73hQIRfqnKMBaevmKs8Q==
X-Google-Smtp-Source: APiQypIQQbh4sAQRHmE/OVE7Xaqw0cu+oRg8kEwyRVgKFJtBUl8sB2ivbQuog2n8k9gro56pVFaV9w==
X-Received: by 2002:a62:9a0a:: with SMTP id o10mr10882831pfe.282.1587423064544;
        Mon, 20 Apr 2020 15:51:04 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q201sm552100pfq.40.2020.04.20.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:51:03 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:51:03 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, mhagger@alum.mit.edu, peff@peff.net
Subject: [PATCH 1/3] tempfile.c: introduce 'create_tempfile_mode'
Message-ID: <aa86e8df403eef31295e6036f280995fa74cc3b4.1587422630.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587422630.git.me@ttaylorr.com>
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

Arguably, all temporary files should have permission 0444, since they
are likely to be renamed into place and then not written to again. This
is a much larger change than we may want to take on in this otherwise
small patch, so for the time being, make 'create_tempfile' behave as it
has always done by inlining it to 'create_tempfile_mode' with mode set
to '0666'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 tempfile.c | 6 +++---
 tempfile.h | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

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
index cddda0a33c..b5760d4581 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -89,7 +89,12 @@ struct tempfile {
  * a tempfile (whose "fd" member can be used for writing to it), or
  * NULL on error. It is an error if a file already exists at that path.
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
2.26.1.108.gadb95c98e4


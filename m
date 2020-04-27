Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5BDC54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BE5206D9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="i5vWENl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgD0Q17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727104AbgD0Q16 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 12:27:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91563C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:27:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k18so7174332pll.6
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d2eX3af3CZCo1adjL+hWq+uGifBkGN7Lpw1GojnJ2ak=;
        b=i5vWENl+CYO7BnSBT9NCrQy4KLjR72zcw+esjjxNlqKQ7Ji2lFWdvMKCxFWJpvQFjZ
         btfGfrwCBn9wOfP/aHlbpWe0iv8eS1hxLySmkoOjgpk1Q5XOuUkMSU6ACEiF9ts8e5C4
         oBF55FhQWN2THpc0OZ//unM3qrD3ctQRaFsyGF2mkSBmoCjTv2Vc6s1DdJBPftOuhZhH
         Eli4d9VMqo3KRvbIKb2OOcQ2IGCtz7WKv1NEVryAU1xdS4PADMAV7Wx3Kk7TbxIKTjdn
         yTiueZdk3rM6HfDDByoQxMsJrbUNTXm21CZF8uLdRsHuyaui1bqzdS8y3Ga53LvUF4t3
         oM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2eX3af3CZCo1adjL+hWq+uGifBkGN7Lpw1GojnJ2ak=;
        b=T6p5g3PLIrvVvo+tjZu/F440Owj9M2jtSP4b9YYEsSyvhdR/gOf7+AcNT/buEOuDJS
         zgrYp0x5Dncbk3sSyfdkb1j3WN5RitRxI++uNxFNkH/ODhjdjMMgE4ZXb4tlgaW1bs/A
         1BG78kIzRskf9a4o+xoJ10lxYxAgryahVRvpll2J1Y8JWb2+oAmF96k48yC3gumud6/s
         CIINwVvlEGsDrwwCIojG5vAq4pXua1b3x1dGGuIhE2oFJ/6cB5JjvVpujOhKQ6xebIlp
         FTrGPqJE05hGZQtn6ROcqt0dGteauMvIGXpVXdO/FcoyKrcsBUQbqsk3OsfE/4loJuYa
         roxw==
X-Gm-Message-State: AGi0PuYRcAP2SktCpObuGeIgpC1O/A682Ht7gYPd0M+pLUXDjeDMQyn2
        WEZ9oc8Qj/vZyznBYC2YCanD7e+rlpXrTw==
X-Google-Smtp-Source: APiQypIp1+l1Fi58hpA3mFeBCBNRkZdz1yVFd+L2WtCNgcLquzndcECKHW9ZsDNg9uou5MacmMTonw==
X-Received: by 2002:a17:902:562:: with SMTP id 89mr23077621plf.249.1588004876681;
        Mon, 27 Apr 2020 09:27:56 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c11sm11156528pgl.53.2020.04.27.09.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:27:55 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:27:54 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v2 1/4] tempfile.c: introduce 'create_tempfile_mode'
Message-ID: <03c975b0bd0cd3dd5d693187f12f45fd7565016c.1588004647.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588004647.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588004647.git.me@ttaylorr.com>
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


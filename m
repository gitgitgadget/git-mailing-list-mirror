Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A3BC55181
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C9F20782
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lBdpUQ0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDUAFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgDUAFe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 20:05:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D9C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 17:05:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so5920231pgg.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 17:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LtbDfSABRnEZilRkyVceO9ZfvbVs5EPrY8aDneg9LfY=;
        b=lBdpUQ0C7lJG6SEERfejGud7c395uVKBfyrsgUrFe8g0UCq6Dw/I/7hob7f66vxkxG
         dygddje2uQaLV1mL6fuLcgQkzyNDpwpFdpkTsgRvfk8mOlcggToWC5Rafoe7EG4eZYsA
         cGn0FHSfOG02/LI42XPWH/XFRJ9c8xOOTt9yN7+A04q/zhAw0LgQVlXidAOqagnJMlYK
         br6oCvmAM0endBhX9yv9AGfHDRvCw6DGv46+YopbmurO2fZzLscDkkj6qUyZX11lKrhO
         XuImcaEhpgEa/cXCB0a/joUmN6M82CvMX2wevawaKVLqub8hplSmobRBCuNxKBvOosCT
         dnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LtbDfSABRnEZilRkyVceO9ZfvbVs5EPrY8aDneg9LfY=;
        b=M+yFTiyyy4RoTyJB2a2ObJbnlQQ5IDeojyRZK47BkD1Q06EEbVkgilYgG5jVn5jNiY
         9IOPVhh1LBKE7bEBNUfjIbFl3wFPQelYZx6FOl2ONjxhwo0CC3v/R+JEjISPQ6WGWXCo
         1z1tqikZRuzeFJwN5ISCGvqwEtDxiWA6YuYQsMNY9vPYnuGR+6PWJYjz6HoI7oLXixWu
         p7KUHwNaaMP1pl6cWIhkgmHrN25V5xrqurs4xmjrJzFSfKUR/skQVFiFbqMyJbdbuETI
         nMqC8iZNEDns/zKKwk/0NTt1xKG7BEcr6UoT1bokcEeg0W1qt9mB144NGf3WNJudk3aj
         3yRQ==
X-Gm-Message-State: AGi0Pua8gcmhIsRy3iIUXKnqOQJN3dbdRS6AqwKWIGLYaF/TVZ7H35Cn
        34+0dMFHgD2FOG2ZdtSrWjzIow==
X-Google-Smtp-Source: APiQypL6ZxYhsJg5JeAmEikbhVghOtoPTCpMfvLGHSS8y7mGSJzZssk7p8/eIVOC2jOmK26usSnLRA==
X-Received: by 2002:aa7:8593:: with SMTP id w19mr19225123pfn.97.1587427533679;
        Mon, 20 Apr 2020 17:05:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a30sm490872pgm.44.2020.04.20.17.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 17:05:33 -0700 (PDT)
Date:   Mon, 20 Apr 2020 18:05:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, vd@FreeBSD.org
Subject: Re: [PATCH] diff-tree.c: load notes machinery when required
Message-ID: <20200421000531.GA31800@syl.local>
References: <ce1ba0641e37ac84a104cd44af63e759324feb14.1586997354.git.me@ttaylorr.com>
 <20200416045630.GA21547@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416045630.GA21547@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is an updated version of the patch that should be ready for
queuing.

-- 8< --

Subject: [PATCH] tempfile.c: introduce 'create_tempfile_mode'

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
2.26.2.108.g048abe1751


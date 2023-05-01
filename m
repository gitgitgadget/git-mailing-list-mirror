Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66483C77B7F
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjEAPyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjEAPyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:54:25 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C81172B
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:54:08 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9d881ad689so4198039276.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682956448; x=1685548448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fG7Yv4P5PQIN04A48RlcwOIWt1Cjuq+u1BBNvjRjdrk=;
        b=xobWlNYAYOU6PuqhsB1XLIwcZC907CtB0ohqgUoZJXmdhh60+hqk3naCGg5rNbJCfH
         wWciwbgoZ6wNt83HgSkFRUbG/fB31pNwjE2oVt3yr4hM17mUF0rYBg2WkbLVhOzhRN9K
         yBM5Rem5mn2UoP+zAdxWLIDpTSYrY/haGu3u+TEGUsIlZ4wvPUJD6qlEd/zy4tU6QS3w
         f8LUK6tIq2/6Dl2dqai8U0Sbud/w3X5kSAlZ2jbpQsSUNumGrunGMBF6xexwg9QUyhpj
         K4m3dn/gF+aQnVTYYqns50esVZuUKxsI1el4k/3MugNCSQdwb5wvWWXvMrATGw2rnfWu
         K82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956448; x=1685548448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fG7Yv4P5PQIN04A48RlcwOIWt1Cjuq+u1BBNvjRjdrk=;
        b=RzcOTDnRy5VWhI3WC9x8qrHV6bA6yX5VaaS3ZPu3Wkfn/qx5Oxd3SIz/AXab2N8bmp
         uZflKaN6kBJMiR0IiRIDgMJjzRaVC3o65H8WXVJOWnhbMIJfDOTif3v6uEUWCV98NMRz
         JDF7e5J6L+ZrFUxgtqIJc/ISIUpzIdfBYFex9PtIEIDn4hDXDwJgIsHbvWgkcD6XtXns
         kEdvhnROJKLzCjt2By2CRK9VjYVamTlD+JOz1qf04TPr6QBQDdIlSNPOts4bl+pciehq
         n2tLvkptyaO5BMBZ2M2fqTeQ93iA4Handne9BPTIs8kv3qclQ2L1FAP4ymu7sfaQRgSW
         GTQA==
X-Gm-Message-State: AC+VfDyQGLCy7BcjVFaNWrt/e5dSKb87sVDuAOi59vhPeqjK4LnhMudV
        zWQrk6TJgOWBqVeqDnYViLl3dAymlNiwwjMaCN7xNA==
X-Google-Smtp-Source: ACHHUZ7JM4H53iZyhhQ4CwY4XFN4fnGaHLpKi8JZipVKSPQJ6/KUU4kpfazi1RYZMVC104CL6MRgtg==
X-Received: by 2002:a25:d04c:0:b0:b95:5682:7db0 with SMTP id h73-20020a25d04c000000b00b9556827db0mr15993141ybg.13.1682956447895;
        Mon, 01 May 2023 08:54:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d15-20020a25eb0f000000b00b8f52b11de6sm6760603ybs.42.2023.05.01.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:54:07 -0700 (PDT)
Date:   Mon, 1 May 2023 11:54:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 7/7] contrib/credential: embiggen fixed-size buffer in wincred
Message-ID: <59a934a256a177e1d47f05a772f53f40ff015ced.1682956419.git.me@ttaylorr.com>
References: <cover.1682956419.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682956419.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in previous commits, harden the wincred credential helper against the
aforementioned protocol injection attack.

Unlike the approached used for osxkeychain and libsecret, where a
fixed-size buffer was replaced with `getline()`, we must take a
different approach here. There is no `getline()` equivalent in Windows,
and the function is not available to us with ordinary compiler settings.

Instead, allocate a larger (still fixed-size) buffer in which to process
each line. The value of 100 KiB is chosen to match the maximum-length
header that curl will allow, CURL_MAX_HTTP_HEADER.

To ensure that we are reading complete lines at a time, and that we
aren't susceptible to a similar injection attack (albeit with more
padding), ensure that each read terminates at a newline (i.e., that no
line is more than 100 KiB long).

Note that it isn't sufficient to turn the old loop into something like:

    while (len && strchr("\r\n", buf[len - 1])) {
      buf[--len] = 0;
      ends_in_newline = 1;
    }

because if an attacker sends something like:

    [aaaaa.....]\r
    host=example.com\r\n

the credential helper would fill its buffer after reading up through the
first '\r', call fgets() again, and then see "host=example.com\r\n" on
its line.

Note that the original code was written in a way that would trim an
arbitrary number of "\r" and "\n" from the end of the string. We should
get only a single "\n" (since the point of `fgets()` is to return the
buffer to us when it sees one), and likewise would not expect to see
more than one associated "\r". The new code trims a single "\r\n", which
matches the original intent.

[1]: https://curl.se/libcurl/c/CURLOPT_HEADERFUNCTION.html

Tested-by: Matthew John Cheetham <mjcheetham@outlook.com>
Helped-by: Matthew John Cheetham <mjcheetham@outlook.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .../wincred/git-credential-wincred.c          | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index ead6e267c7..32ebef7f65 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -249,16 +249,27 @@ static WCHAR *utf8_to_utf16_dup(const char *str)
 	return wstr;
 }
 
+#define KB (1024)
+
 static void read_credential(void)
 {
-	char buf[1024];
+	size_t alloc = 100 * KB;
+	char *buf = calloc(alloc, sizeof(*buf));
 
-	while (fgets(buf, sizeof(buf), stdin)) {
+	while (fgets(buf, alloc, stdin)) {
 		char *v;
-		int len = strlen(buf);
+		size_t len = strlen(buf);
+		int ends_in_newline = 0;
 		/* strip trailing CR / LF */
-		while (len && strchr("\r\n", buf[len - 1]))
+		if (len && buf[len - 1] == '\n') {
 			buf[--len] = 0;
+			ends_in_newline = 1;
+		}
+		if (len && buf[len - 1] == '\r')
+			buf[--len] = 0;
+
+		if (!ends_in_newline)
+			die("bad input: %s", buf);
 
 		if (!*buf)
 			break;
@@ -284,6 +295,8 @@ static void read_credential(void)
 		 * learn new lines, and the helpers are updated to match.
 		 */
 	}
+
+	free(buf);
 }
 
 int main(int argc, char *argv[])
-- 
2.40.1.452.gb3cd41c833

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910DFC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5119564EC2
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhBATrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhBATqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D534C061788
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:45:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a1so17964857wrq.6
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hJMMlnG4K85uP3aMIkdMyhFWAilpMetGJKPcVVcf3AE=;
        b=TMSO6uXG+J/PEgsfWImC93OhQoPpnLfoPYsDPQthHd3pz1R2+4F6zW62KFm3JTOGDj
         4Jdgl5k/7wmDKe3cZkOC6v1Q96dup0GL+Y0NlBERyDwKmsWk9S275n8hEz4BUxeMfArm
         FlTXWHMU+uftGvt5bVi5ZUohnHXW10YT7JAVrNAZRtafwSDw2yB/zuevfPLHHHJQWPFl
         rxOaqILdz5w+eXMr7+m9jnx4NkgTbNC2oqwdXbt4G8ngi1f67FCDyR9zLpZVOzLZ2bCz
         QDkV1M90Z/7Q+BKFPnO4MSN3eplQ77nf/j8dEk9rXwpoRelUU6hBIhafZMvE4YPxSvVh
         HiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hJMMlnG4K85uP3aMIkdMyhFWAilpMetGJKPcVVcf3AE=;
        b=LN3CfqxQtrtZZP+50N82eRKoQArEltXb/+nC7xq9ujCLflOBq4xSFvyDgzfK2kPIeY
         msovgShwsXSw5AwrYQKP5mwny8if61gingA5OwOiiEtmEA8dAQ7SqdogNfjn5aqc8Sg2
         aa3Ifst04ZMR746o4YOc3IL5SQhJeI1sObBv0BeRFAVfOsD2HXGJGvxJmDSwIerz5sun
         eIiz3RJTDunuq/yIrzdT/NAKd41IFdwhDSkn43+/fN3CFQhKiKcHb19n+F9Zxm2t5fFo
         87jlDH7GnE6Y8yXxbs38nfThOEF/1i4F2eNeQA8gW/hJTFtLlgF47wlzGwnsmldiPLAh
         Cvaw==
X-Gm-Message-State: AOAM533BgUU/jd0APJSsLTvkpkaAGUzXQRbrP544vCV/BCLEn22vpNOq
        3Up5SH2dNo+tbBp/Zn3E8hU3okAx6Zg=
X-Google-Smtp-Source: ABdhPJxjBoAWRX7RIxL1QeETVxDJWPzqUfVFnjOBTKOewmN+ZnZyWMnVVm7+5Wf6d6nrMLLNDYNEWw==
X-Received: by 2002:adf:f009:: with SMTP id j9mr19842840wro.35.1612208754235;
        Mon, 01 Feb 2021 11:45:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k131sm280991wmb.37.2021.02.01.11.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:53 -0800 (PST)
Message-Id: <43bc4a26b79038a13d042f4538b467b1af94688b.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:38 +0000
Subject: [PATCH v2 05/14] pkt-line: (optionally) libify the packet readers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

So far, the (possibly indirect) callers of `get_packet_data()` can ask
that function to return an error instead of `die()`ing upon end-of-file.
However, random read errors will still cause the process to die.

So let's introduce an explicit option to tell the packet reader
machinery to please be nice and only return an error.

This change prepares pkt-line for use by long-running daemon processes.
Such processes should be able to serve multiple concurrent clients and
and survive random IO errors.  If there is an error on one connection,
a daemon should be able to drop that connection and continue serving
existing and future connections.

This ability will be used by a Git-aware "Internal FSMonitor" feature
in a later patch series.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pkt-line.c | 19 +++++++++++++++++--
 pkt-line.h |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index d91a1deda95..528493bca21 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -323,8 +323,11 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		*src_size -= ret;
 	} else {
 		ret = read_in_full(fd, dst, size);
-		if (ret < 0)
+		if (ret < 0) {
+			if (options & PACKET_READ_NEVER_DIE)
+				return error_errno(_("read error"));
 			die_errno(_("read error"));
+		}
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
@@ -332,6 +335,8 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("the remote end hung up unexpectedly"));
 		die(_("the remote end hung up unexpectedly"));
 	}
 
@@ -360,6 +365,9 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 	len = packet_length(linelen);
 
 	if (len < 0) {
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("protocol error: bad line length "
+				       "character: %.4s"), linelen);
 		die(_("protocol error: bad line length character: %.4s"), linelen);
 	} else if (!len) {
 		packet_trace("0000", 4, 0);
@@ -374,12 +382,19 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		*pktlen = 0;
 		return PACKET_READ_RESPONSE_END;
 	} else if (len < 4) {
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("protocol error: bad line length %d"),
+				     len);
 		die(_("protocol error: bad line length %d"), len);
 	}
 
 	len -= 4;
-	if ((unsigned)len >= size)
+	if ((unsigned)len >= size) {
+		if (options & PACKET_READ_NEVER_DIE)
+			return error(_("protocol error: bad line length %d"),
+				     len);
 		die(_("protocol error: bad line length %d"), len);
+	}
 
 	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0) {
 		*pktlen = -1;
diff --git a/pkt-line.h b/pkt-line.h
index ccf27549227..7f31c892165 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -79,10 +79,14 @@ int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
  *
  * If options contains PACKET_READ_DIE_ON_ERR_PACKET, it dies when it sees an
  * ERR packet.
+ *
+ * With `PACKET_READ_NEVER_DIE`, no errors are allowed to trigger die() (except
+ * an ERR packet, when `PACKET_READ_DIE_ON_ERR_PACKET` is in effect).
  */
 #define PACKET_READ_GENTLE_ON_EOF     (1u<<0)
 #define PACKET_READ_CHOMP_NEWLINE     (1u<<1)
 #define PACKET_READ_DIE_ON_ERR_PACKET (1u<<2)
+#define PACKET_READ_NEVER_DIE         (1u<<3)
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
-- 
gitgitgadget


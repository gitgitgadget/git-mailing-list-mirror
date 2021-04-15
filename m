Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0632AC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8FDB61029
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhDOUsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhDOUsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 16:48:41 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43949C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 13:48:17 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id d1so841165qvy.11
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvORqv00yGcXiUzO6m69xMcppphlQ/9b1aq2cSRkk3A=;
        b=uOhLodDDNjaXopFm2UfXLkTJDFVhrlYXHBjMd8fs5rsYjoW+2AJ8qfWxporppdt2gV
         HPwsaPANS6ohBJyODyrQjD8lbY640NauzphijW7msfDbmZ4YLJnRCrOtzbvj5eekreXe
         ZC+94l8uS+B6QST9SpbsG65PXsHaQ1rLbSb4hg/LQeEiGI0ZRkfzVfshrQHzXsJyhpBw
         LfKyn8ODLfAfPN76lENNEp81A8PC1Q9wqvJSsesN3UF+Ri0AzDuR0avkrdxkWKFxWcah
         RZ42Kco9t0MaunQKPnrFBxdpCa7dEjE4tWJZHYCcFUCJ8s59ZNYmLeFXBasxtC71EgU4
         Ru7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvORqv00yGcXiUzO6m69xMcppphlQ/9b1aq2cSRkk3A=;
        b=CQeTBGe/dNBNbXFa7tmG6r6KKaqVaY4Y5HkAWcbshbAKH5VjDQ7idQHlrTbS75GhWb
         uXr0F7x+eNgJdXCSwIo3d3n4Ak5ReNEVf5cRIJtJ37tey8SVSqiCtUiK6e0ZO9XKqhPd
         55cD3kENzsBLlb49QgHL6jDxQyzpOk/1edtj9WJLzkPZiXOS3dhydmwJMkA8pH4heqkb
         K6659vFJPOaleqfwZGU2XL1gGYu0x3cvWTfvjrmzNw7z9fDlG0b/l1kqyRoJ9Zs7G9BV
         fy+eDwE0hZfeUPJJm7Tlkh4bBf4pjIi9pSjXe5+gyBqOiL5XUKDBOJZ64NnCjUzGF6nW
         bjmA==
X-Gm-Message-State: AOAM532dqHhADMjouvAV3ro+ldPJdkkTss0NAjYxQUgZSmLOFI0t3uYG
        ILG31y7kK5+pGSfT/sWH04vqxiRl3h8mgg==
X-Google-Smtp-Source: ABdhPJwjyLmsR9VWgj0NxB1C1ZHLVAfJhJcAcSaxbUGZnJEXgEZnarDRPI+2SW5SPI8TxJM2Qk5Isw==
X-Received: by 2002:a0c:b303:: with SMTP id s3mr5208898qve.22.1618519696488;
        Thu, 15 Apr 2021 13:48:16 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id d11sm2613855qto.59.2021.04.15.13.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:48:15 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@jeffhostetler.com, git@vger.kernel.org
Subject: Re: [PATCH] pkt-line: do not report packet write errors twice
Date:   Thu, 15 Apr 2021 17:48:09 -0300
Message-Id: <20210415204809.1818959-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <xmqqlf9jp9v5.fsf@gitster.g>
References: <xmqqlf9jp9v5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
>
> > Nice! :) Maybe we could also avoid the static strings without
> > repeating the literals by making `do_packet_write()` receive a `struct
> > strbuf *err` and save the error message in it? Then the two callers
> > can decide whether to pass it to error() or die() accordingly.
>
> Sorry, but I do not understand what benefit we are trying to gain by
> introducing an extra strbuf (which I assume is used to strbuf_add()
> the error message into).  Wouldn't the caller need two messages and
> flip between <error,error_errno> vs <die,die_errno> pair?

Hmm, I'm not sure I understand what you mean by the two messages, but
what I was thinking of is something like this (on top of my original
patch):

diff --git a/pkt-line.c b/pkt-line.c
index 39c9ca4212..98304ce374 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -195,16 +195,14 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 }

 static int do_packet_write(const int fd_out, const char *buf, size_t size,
-			   int gentle)
+			   struct strbuf *err)
 {
 	char header[4];
 	size_t packet_size;

 	if (size > LARGE_PACKET_DATA_MAX) {
-		if (gentle)
-			return error(_("packet write failed - data exceeds max packet size"));
-		else
-			die(_("packet write failed - data exceeds max packet size"));
+		strbuf_addstr(err, _("packet write failed - data exceeds max packet size"));
+		return -1;
 	}

 	packet_trace(buf, size, 1);
@@ -221,22 +219,28 @@ static int do_packet_write(const int fd_out, const char *buf, size_t size,

 	if (write_in_full(fd_out, header, 4) < 0 ||
 	    write_in_full(fd_out, buf, size) < 0) {
-		if (gentle)
-			return error_errno(_("packet write failed"));
-		else
-			die_errno(_("packet write failed"));
+		strbuf_addf(err, _("packet write failed: %s"), strerror(errno));
+		return -1;
 	}
 	return 0;
 }

 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
-	return do_packet_write(fd_out, buf, size, 1);
+	struct strbuf err = STRBUF_INIT;
+	if (do_packet_write(fd_out, buf, size, &err)) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+	return 0;
 }

 void packet_write(int fd_out, const char *buf, size_t size)
 {
-	do_packet_write(fd_out, buf, size, 0);
+	struct strbuf err = STRBUF_INIT;
+	if (do_packet_write(fd_out, buf, size, &err))
+		die("%s", err.buf);
 }

 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)


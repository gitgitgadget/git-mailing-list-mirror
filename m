Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D59C1F428
	for <e@80x24.org>; Tue, 11 Sep 2018 03:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeIKIjo (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 04:39:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34558 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeIKIjo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 04:39:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so11527902pgv.1
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 20:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xc1qtkzOkeAVBrRMZwMEgNqEO4reJ+Q/twBeRTC2lCk=;
        b=jOodxgyA6tnrTw2+/bEPua9amkcNEbB6AgKpJV/CCCQVe4JO3hbd0tB+NRsd+CSmW6
         0wA4QN6GaR5ylLKJdOTq4C8oz4FfD/V+i0tG5OV4hJeKXeIRN4xJC+slOPT2MYNjgkL9
         vFOIibDmgyct/Q0oAfpsyGOKek9ZOdhJ1a/fXFDM2j37+DYUPeXHexHXZbR6TbFrxTvV
         GKNf1Y4sKgS1828shenxyqhfVZsvP/BjxG7rP11p0JX0iZYgnqw7AaDV5XhAI1t0uqN1
         L5V5qCgXX+5Usuh0FHoW7EJKOU5uRUuYHH+59JlmmS7333clD52zTPtEvAWqe6evcGbV
         Yu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xc1qtkzOkeAVBrRMZwMEgNqEO4reJ+Q/twBeRTC2lCk=;
        b=JaSa73ND5jhb6Bh0KlPKHKMsxpNO+ThrIQiMqJm1GnuDLB/nRyGWQsnBtay0UHyab/
         tbNhV+PScU5rClj7KtYdg5KstODEoQO1wnl09FnrRBLV57E2lWQVp6bUB1fyb+lY5gzL
         7bLnG8M9iQFUHl8mfU1l+DeDfDUhzDvHijSf8B2ibepjWlgIyUgTrfRY/fuA87bGLk9S
         y/H+NbNL4Ap2tAUb8cDn76VlR6xWmujs3KhDd6CXgjzrucC316jq1AazAKOV4CuJ4bIX
         pQXbtUDT9ZPsACCOC+qxKWV0wA7CMqIgpnZau603hMGIh0RXwoapJPRpvrqDIHxsYff3
         6j/Q==
X-Gm-Message-State: APzg51AUUoS1oOltmvNUlY83LSHAFKR99Ob3iFz4Pv5v5huGX0Jn0j6K
        isPrKVwgW6LLV3vVPXQQkEE=
X-Google-Smtp-Source: ANB0VdaacLodyzGb9/AKpILhXMXD0gTlaXRB39nSdYN7nXwuwqV99Q97n20UqzGIrRmvXaj3BGqhkA==
X-Received: by 2002:a62:1544:: with SMTP id 65-v6mr26912529pfv.178.1536637349692;
        Mon, 10 Sep 2018 20:42:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v72-v6sm37651788pfj.22.2018.09.10.20.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 20:42:29 -0700 (PDT)
Date:   Mon, 10 Sep 2018 20:42:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: [PATCH] http-backend: treat empty CONTENT_LENGTH as zero
Message-ID: <20180911034227.GB20518@aiede.svl.corp.google.com>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910205359.32332-1-max@max630.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in v2.19.0-rc0~45^2~2 (http-backend: respect
CONTENT_LENGTH as specified by rfc3875, 2018-06-10), HTTP servers such
as IIS do not close a CGI script's standard input at the end of a
request, instead expecting CGI scripts to stop reading after
CONTENT_LENGTH bytes.  That commit taught http-backend to respect this
convention except when CONTENT_LENGTH is unset, in which case it
preserved the previous behavior of reading until EOF.

RFC 3875 (the CGI specification) explains:

   The CONTENT_LENGTH variable contains the size of the message-body
   attached to the request, if any, in decimal number of octets.  If no
   data is attached, then NULL (or unset).

      CONTENT_LENGTH = "" | 1*digit

And:

   This specification does not distinguish between zero-length (NULL)
   values and missing values.

But that specification was written before HTTP/1.1 and chunked
encoding.  With chunked encoding, the length of a request is not known
early and it is useful to start a CGI script to process it anyway, so
Apache and many other servers violate the spec: they leave
CONTENT_LENGTH unset and rely on EOF to indicate the end of request.
This is reproducible using t5510-fetch.sh, which hangs if http-backend
is patched to treat a missing CONTENT_LENGTH as zero.

So we are in a bind: to support HTTP servers that don't produce EOF,
http-backend should respect an unset or empty CONTENT_LENGTH that
represents zero, and to support chunked encoding, http-backend should
respect an unset CONTENT_LENGTH that represents "read until EOF".

Fortunately, there's a way out.  Use the HTTP_TRANSFER_ENCODING
environment variable to distinguish the two cases.

Reported-by: Jeff King <peff@peff.net>
Helped-by: Max Kirillov <max@max630.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
How about this?

 http-backend.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 458642ef72..7902eeb0b3 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -350,10 +350,25 @@ static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **o
 
 static ssize_t get_content_length(void)
 {
-	ssize_t val = -1;
+	ssize_t val;
 	const char *str = getenv("CONTENT_LENGTH");
 
-	if (str && *str && !git_parse_ssize_t(str, &val))
+	if (!str || !*str) {
+		/*
+		 * According to RFC 3875, an empty or missing
+		 * CONTENT_LENGTH means "no body", but RFC 3875
+		 * precedes HTTP/1.1 and chunked encoding. Apache and
+		 * its imitators leave CONTENT_LENGTH unset for
+		 * chunked requests, for which we should use EOF to
+		 * detect the end of the request.
+		 */
+		str = getenv("HTTP_TRANSFER_ENCODING");
+		if (str && !strcmp(str, "chunked"))
+			return -1;
+
+		return 0;
+	}
+	if (!git_parse_ssize_t(str, &val))
 		die("failed to parse CONTENT_LENGTH: %s", str);
 	return val;
 }
-- 
2.19.0.397.gdd90340f6a


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98E220A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 00:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeLLAZ1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:25:27 -0500
Received: from mail-oi1-f202.google.com ([209.85.167.202]:36249 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLAZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:25:26 -0500
Received: by mail-oi1-f202.google.com with SMTP id d62so8749293oia.3
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bbcYZhSwYzWPzh8m6JxtNAQVarOAIZa/M3v7v1dW8CQ=;
        b=ATpKkCivfEMUHGH0KuVx8uzUyADRgac1YRzmt9Gzvb0nsQeSQ/kRagzQqSjoBg6AQC
         kkomn6se6bNB35baNh+UghG7ekRSjZoGzgyS+tBlk1noWRxB0GJuWKj+r/+K95ger6kZ
         Z5ygRi3QafpO8NDJdiMWgUdKhtfwa39JT3fVlVj7OtFJFOeAb9NOX51fz63zwa1o5JiI
         QU2833XEFCn/gN3WHNazX7Tn2K+CoSuSlWhap8vKiUW1iEypTVZDTe/zVSOvtJKWNtGC
         U+7va3o8ckSBUQpqNq4cqymF6NO9CXZibUCNdZgLB8J7dI2njO2s4MwY/ECfbGJ0MRv7
         c1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bbcYZhSwYzWPzh8m6JxtNAQVarOAIZa/M3v7v1dW8CQ=;
        b=SqJbTSDji20Joo2vzFSxzHvIt7/wi/XUiSsPrlwW9/o8JUL2YOPcI+RK6icTC3zt99
         C8lzwCguoJesiKAqwW0YTb6MrtrXjNnybGX+H+hGgOHVyrZaCOMiMbNB0pgLMFo/hds1
         22UB+SuNX/TU4V9WRvl9L6MC1+4M4iTm5K+6kBn9p0UyEJXSJGfGKn/wL+d95nzMzqx1
         SzpTGBURLjLfUWSbe5RvyjM9qF2S3ZicWElemS4xnvvcIw9SN2E/v19uyACiOVJ4kLtI
         145pc8AkW3mv5uKZH+iK6w++EcQzo6PMCnTA2/eNB6rgybKH1Lxy8F/gpKpgtymGVP7H
         SIkw==
X-Gm-Message-State: AA+aEWYdOP/QhIXn/jKm5YlVxwM9eEAyz9lFzVNEdweuGdwfFUAlYQyW
        NaFjo+p4O9usTVEQn1h8lG8xI6E+bw8Mz/e6BV6qPn7vA9JSJ+kInjyGNgAl6wyrSoy3qWrxXQW
        dq6/uGUwYZxWZV0mAZPQh1QBQmVebTtcOgMuhvNc9kijSVsmYZeJOcgceWroPYhM=
X-Google-Smtp-Source: AFSGD/UB2ktzf7Q0NVRCeR2ev7JFxrgL+6IswkYiMz05CXc2nRjKmkBQP64Faqx3siq7PI/7tcltfbj6JZnRtQ==
X-Received: by 2002:a9d:6d93:: with SMTP id x19mr14085960otp.30.1544574325399;
 Tue, 11 Dec 2018 16:25:25 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:25:16 -0800
In-Reply-To: <cover.1544572142.git.steadmon@google.com>
Message-Id: <27da5b6e12f488b4503d0998377dc3299eaccca4.1544572142.git.steadmon@google.com>
Mime-Version: 1.0
References: <20181116084427.GA31493@sigill.intra.peff.net> <cover.1544572142.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v3 2/4] remote-curl: refactor smart-http discovery
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, masayasuzuki@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

After making initial contact with an http server, we have to decide if
the server supports smart-http, and if so, which version. Our rules are
a bit inconsistent:

  1. For v0, we require that the content-type indicates a smart-http
     response. We also require the response to look vaguely like a
     pkt-line starting with "#". If one of those does not match, we fall
     back to dumb-http.

     But according to our http protocol spec[1]:

       Dumb servers MUST NOT return a return type starting with
       `application/x-git-`.

     If we see the expected content-type, we should consider it
     smart-http. At that point we can parse the pkt-line for real, and
     complain if it is not syntactically valid.

  2. For v2, we do not actually check the content-type. Our v2 protocol
     spec says[2]:

       When using the http:// or https:// transport a client makes a
       "smart" info/refs request as described in `http-protocol.txt`[...]

     and the http spec is clear that for a smart-http[3]:

       The Content-Type MUST be `application/x-$servicename-advertisement`.

     So it is required according to the spec.

These inconsistencies were easy to miss because of the way the original
code was written as an inline conditional. Let's pull it out into its
own function for readability, and improve a few things:

 - we now predicate the smart/dumb decision entirely on the presence of
   the correct content-type

 - we do a real pkt-line parse before deciding how to proceed (and die
   if it isn't valid)

 - use skip_prefix() for comparing service strings, instead of
   constructing expected output in a strbuf; this avoids dealing with
   memory cleanup

Note that this _is_ tightening what the client will allow. It's all
according to the spec, but it's possible that other implementations
might violate these. However, violating these particular rules seems
like an odd choice for a server to make.

[1] Documentation/technical/http-protocol.txt, l. 166-167
[2] Documentation/technical/protocol-v2.txt, l. 63-64
[3] Documentation/technical/http-protocol.txt, l. 247

Helped-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 remote-curl.c | 93 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 34 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1220dffcdc..38f51dffb8 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -330,9 +330,65 @@ static int get_protocol_http_header(enum protocol_version version,
 	return 0;
 }
 
+static void check_smart_http(struct discovery *d, const char *service,
+			     struct strbuf *type)
+{
+	char *src_buf;
+	size_t src_len;
+	char *line;
+	const char *p;
+
+	/*
+	 * If we don't see x-$service-advertisement, then it's not smart-http.
+	 * But once we do, we commit to it and assume any other protocol
+	 * violations are hard errors.
+	 */
+	if (!skip_prefix(type->buf, "application/x-", &p) ||
+	    !skip_prefix(p, service, &p) ||
+	    strcmp(p, "-advertisement"))
+		return;
+
+	/*
+	 * "Peek" at the first packet by using a separate buf/len pair; some
+	 * cases below require us leaving the originals intact.
+	 */
+	src_buf = d->buf;
+	src_len = d->len;
+	line = packet_read_line_buf(&src_buf, &src_len, NULL);
+	if (!line)
+		die("invalid server response; expected service, got flush packet");
+
+	if (skip_prefix(line, "# service=", &p) && !strcmp(p, service)) {
+		/*
+		 * The header can include additional metadata lines, up
+		 * until a packet flush marker.  Ignore these now, but
+		 * in the future we might start to scan them.
+		 */
+		while (packet_read_line_buf(&src_buf, &src_len, NULL))
+			;
+
+		/*
+		 * v0 smart http; callers expect us to soak up the
+		 * service and header packets
+		 */
+		d->buf = src_buf;
+		d->len = src_len;
+		d->proto_git = 1;
+
+	} else if (starts_with(line, "version 2")) {
+		/*
+		 * v2 smart http; do not consume version packet, which will
+		 * be handled elsewhere.
+		 */
+		d->proto_git = 1;
+
+	} else {
+		die("invalid server response; got '%s'", line);
+	}
+}
+
 static struct discovery *discover_refs(const char *service, int for_push)
 {
-	struct strbuf exp = STRBUF_INIT;
 	struct strbuf type = STRBUF_INIT;
 	struct strbuf charset = STRBUF_INIT;
 	struct strbuf buffer = STRBUF_INIT;
@@ -405,38 +461,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-	strbuf_addf(&exp, "application/x-%s-advertisement", service);
-	if (maybe_smart &&
-	    (5 <= last->len && last->buf[4] == '#') &&
-	    !strbuf_cmp(&exp, &type)) {
-		char *line;
-
-		/*
-		 * smart HTTP response; validate that the service
-		 * pkt-line matches our request.
-		 */
-		line = packet_read_line_buf(&last->buf, &last->len, NULL);
-		if (!line)
-			die("invalid server response; expected service, got flush packet");
-
-		strbuf_reset(&exp);
-		strbuf_addf(&exp, "# service=%s", service);
-		if (strcmp(line, exp.buf))
-			die("invalid server response; got '%s'", line);
-		strbuf_release(&exp);
-
-		/* The header can include additional metadata lines, up
-		 * until a packet flush marker.  Ignore these now, but
-		 * in the future we might start to scan them.
-		 */
-		while (packet_read_line_buf(&last->buf, &last->len, NULL))
-			;
-
-		last->proto_git = 1;
-	} else if (maybe_smart &&
-		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
-		last->proto_git = 1;
-	}
+	if (maybe_smart)
+		check_smart_http(last, service, &type);
 
 	if (last->proto_git)
 		last->refs = parse_git_refs(last, for_push);
@@ -444,7 +470,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		last->refs = parse_info_refs(last);
 
 	strbuf_release(&refs_url);
-	strbuf_release(&exp);
 	strbuf_release(&type);
 	strbuf_release(&charset);
 	strbuf_release(&effective_url);
-- 
2.20.0.rc2.403.gdbc3b29805-goog


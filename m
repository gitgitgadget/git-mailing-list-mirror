Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB5B1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938990AbcHJTnj (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:43:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34456 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935270AbcHJTnf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:43:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so11571143wma.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:43:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pWhPp0ioVa34kt+jZJedzz1jvt9QdWfKvGMNngnUBMA=;
        b=lN2lX3osgt0ghCi5O3LK+rxjCJh134MF5z5mwhhCbwffBlnsFa3JpfG9A6P1K60bjO
         qQzSjonKM//kK6d90+HWnK3jZlz1ouzhK+WjmubzVVOKI2vuQVLEF6YIH4HNl0yBkAGh
         jnaf0aNfvlteLsiJNAMJRFzIyK6QQf/X5S82Ztbk68EOx9Wl4TeKu0qxgA2RxmIPNnMT
         +Kw/88foE244Zn53NeZUMZMjqXd6X2hlQ4clwlROhQ22OOq/AFqml1fHHMLhb41Zx1DF
         mXuXMmKqSLntUJrvPjrogk1Qviy3WcDhcDXsVOY7vWXuTCKCZO6SHF7WgFiHs+Nkb7VZ
         IADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pWhPp0ioVa34kt+jZJedzz1jvt9QdWfKvGMNngnUBMA=;
        b=T3vnaAt0WHyyvig5LjtwgRxhXXH/wOeaBwDz+flM/Fqrjuq1dxivr6+v2agYkItD/F
         WA6wDmgB32c/PMuKYIzv+EXBaigR54NvQWX1QlfIc9PhGpv9aKDMvEe8X/TIpgwgJAaW
         7L1ntpAyPThli1JC320KgnR+GHHIvl9D/dMo+GRzzoJYAbmYrxEwcq59YoZD3Rz/ddWB
         qHbEZXM0DPfz7flXMjEUiValAvXRrZrZ9/aNKZmC6RyX7kVpA4SBxKMCeKg0L443uhYN
         BycWmDF92dMfeMOadC6RW/eYTGo0Ly0pqoCJnfazSdUqlmm81K9/GMf+xsoPVERF6m4j
         3ziw==
X-Gm-Message-State: AEkoousrxBWywNtAaLi6eyk4mjTa8junQw7f3YEF9HijNwEyhPr6X9qc6sxTgLNXibwnfw==
X-Received: by 10.194.178.193 with SMTP id da1mr4798323wjc.66.1470834256280;
        Wed, 10 Aug 2016 06:04:16 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:15 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 02/15] pkt-line: call packet_trace() only if a packet is actually send
Date:	Wed, 10 Aug 2016 15:03:58 +0200
Message-Id: <20160810130411.12419-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The packet_trace() call is not ideal in format_packet() as we would print
a trace when a packet is formatted and (potentially) when the packet is
actually send. This was no problem up until now because format_packet()
was only used by one function. Fix it by moving the trace call into the
function that actually sends the packet.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 177dc73..9400b47 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -121,7 +121,6 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 		die("protocol error: impossibly long line");
 
 	set_packet_header(&out->buf[orig_len], n);
-	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
 void packet_write(int fd, const char *fmt, ...)
@@ -133,6 +132,7 @@ void packet_write(int fd, const char *fmt, ...)
 	va_start(args, fmt);
 	format_packet(&buf, fmt, args);
 	va_end(args);
+	packet_trace(buf.buf + 4, buf.len - 4, 1);
 	write_or_die(fd, buf.buf, buf.len);
 }
 
-- 
2.9.2


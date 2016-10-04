Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75FDD20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbcJDM77 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 08:59:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34432 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbcJDM76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 08:59:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id b201so14421212wmb.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kIC8By4pmiqU3y9AajtksPZWvst7S+B7n8pWHpbtFW0=;
        b=PRaDjKqA0aLUUoAKXqxDyzaGyiug/CWDKVvQIsqsoFQUekXXMJzwcgI9feW1Iznj30
         DsYl6geD21bIjMG6LjSJ+Qy78yHTf/9jKbKvemEp78IkHbJTDVyyV0lFR1QKrUlGXx1u
         jQgZtfz9S2ndYmVWIsLdRXp/vn4vuWEa0B4hLqDg+9laRGLvFY3wuOO9f4ZLCeiYuK73
         Xn/rcXFNnqVqp3WuM82bPAL/Nj7Qta6PoG5OrwUrGXTQCGiIZ1ZTuMEIUJilK4laV23g
         WbmF+VDkxscrJHSyPrnFjtPOR8Y1E6h66W5CVxN0FiI/HmEVUixR9nYRN0DxlUy4wzdC
         cexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kIC8By4pmiqU3y9AajtksPZWvst7S+B7n8pWHpbtFW0=;
        b=iD1TzvcCZX6k9a6BrNLPyu8Gv7xnPlwNTEyOOMwg1BrAk/A1I0UD9ALf5Xe1kMAEuJ
         8nqJSOStD2PPO7tK2y6Yvik8Ka2U8ALXRWWwsbnYE8BTGa2vmAx5nek+KXjM1QLmpLCf
         sDk1DyTN6SkzaV/KnZAjUFwwKieKz6s4758YbfttyOkgrRADBUlxpRlIkVIo5AVR3qHE
         6HPU331alO8a5goDIz+OaJ2Kxvnk5JV20sq/W+yf0Rw1TFkhCT/E1c13M3kNOPQKzgNp
         4g7XFGkNBN3/GHamgUGQYJnBTLTv5M2x/+EYugUxDermrgFvbdF0sKgzcLFAU/wbzEhV
         +bLA==
X-Gm-Message-State: AA6/9RmYipEObNPzsmsl/NbX5JHYe94Ue4TmCueH5dksFbZULVVqRO1SvwMTk2OG/jM/Og==
X-Received: by 10.194.239.226 with SMTP id vv2mr2913866wjc.219.1475585997134;
        Tue, 04 Oct 2016 05:59:57 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.05.59.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 05:59:56 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 06/14] pkt-line: extract set_packet_header()
Date:   Tue,  4 Oct 2016 14:59:39 +0200
Message-Id: <20161004125947.67104-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Extracted set_packet_header() function converts an integer to a 4 byte
hex string. Make this function locally available so that other pkt-line
functions could use it.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pkt-line.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 0a9b61c..e8adc0f 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -97,10 +97,20 @@ void packet_buf_flush(struct strbuf *buf)
 	strbuf_add(buf, "0000", 4);
 }
 
-#define hex(a) (hexchar[(a) & 15])
-static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+static void set_packet_header(char *buf, const int size)
 {
 	static char hexchar[] = "0123456789abcdef";
+
+	#define hex(a) (hexchar[(a) & 15])
+	buf[0] = hex(size >> 12);
+	buf[1] = hex(size >> 8);
+	buf[2] = hex(size >> 4);
+	buf[3] = hex(size);
+	#undef hex
+}
+
+static void format_packet(struct strbuf *out, const char *fmt, va_list args)
+{
 	size_t orig_len, n;
 
 	orig_len = out->len;
@@ -111,10 +121,7 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 	if (n > LARGE_PACKET_MAX)
 		die("protocol error: impossibly long line");
 
-	out->buf[orig_len + 0] = hex(n >> 12);
-	out->buf[orig_len + 1] = hex(n >> 8);
-	out->buf[orig_len + 2] = hex(n >> 4);
-	out->buf[orig_len + 3] = hex(n);
+	set_packet_header(&out->buf[orig_len], n);
 	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
-- 
2.10.0


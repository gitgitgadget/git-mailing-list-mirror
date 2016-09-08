Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2BD2070F
	for <e@80x24.org>; Thu,  8 Sep 2016 18:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758548AbcIHSVr (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:21:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36820 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758302AbcIHSVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:21:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id l65so9001803wmf.3
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oxErh74cjPFwjV+Dv6pSdxAEpX1yzl4B8+RSy/8Qfuc=;
        b=Oh+7gKSnxdG7G0ztwedEmTlTMFpomjtPy1d/1CVcDO2H9LmDHIn8GzMZwEDy5Mejbw
         KuSuPYgHwUgWdMfHbAdacJoMP2eM2/LK/OSWz6QaTQEYUftEWOrfsbdgMzZS9XsvPlKM
         DAjDdGAtsaDfY/L3wzbPRKRhe67F0Y7vqf2G22mJf6zbPnHJX9EVRKF6vHb6BZt43b1a
         z1qGzNPgs9T+dF3/MYQynccfX3NyO5g6DtutXzjKos0XqbrZJ0YOnaaGGOJBP2KbgXEf
         USxK24faExWF8MK4pfrnYdCMshpsQYM25OYfelo6dH8TLfGZDpuhqrYD98zwScm3qgwb
         dbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oxErh74cjPFwjV+Dv6pSdxAEpX1yzl4B8+RSy/8Qfuc=;
        b=ir/cqk+UOmWVo8UhNY3w2GNTc9/mAd1MlYGYT4ZpUdd6G7nfj8YjoY5UtwjRD0ykhe
         D1WYC7dDXHH+hJG0SmCB0thMNwNMJryTvKhuUolp7H7EXNMixMUNDMbfc0skPKKGltNd
         ztfgzZ1zBg8awMH+0OJEFtpD7LWHEXmf3X8kdIB/3K9GtH1LdSYAM/F2iuDEO9Iey/X6
         HyDQmFfwh5cLeC0KVMHlEzDQITZv7kRHVRPillCBkUHL27yfykef/XkRu4HmVbITMOMa
         Bo7YzO+nVWCn8muWC6EDJc9Wg+gg5zCBLWf8cu29hqSTGPwAzHE/wVvbgO6k0HVyPDdE
         o+ow==
X-Gm-Message-State: AE9vXwN+ed65s7Mik/MsaNDgoQgkR2ou1qH0qnKLzFVg8OGQg3r4I6fJgYm5/TV0/+0q/Q==
X-Received: by 10.28.29.212 with SMTP id d203mr888086wmd.111.1473358900406;
        Thu, 08 Sep 2016 11:21:40 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b128sm10967467wmb.21.2016.09.08.11.21.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 11:21:39 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 02/10] pkt-line: extract set_packet_header()
Date:   Thu,  8 Sep 2016 20:21:24 +0200
Message-Id: <20160908182132.50788-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160908182132.50788-1-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

set_packet_header() converts an integer to a 4 byte hex string. Make
this function locally available so that other pkt-line functions can
use it.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
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


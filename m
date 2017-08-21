Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65162208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 17:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbdHURoK (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 13:44:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38673 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbdHURoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 13:44:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id k10so6145773wre.5
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0aTtHLLbXJJnap5vvp+Qcr3+OyTSHIvedCtwIVL1oQ=;
        b=U1+G/9kowkxd/CIkGSm7KkFTM05aJeTvZZ2A1d++CjZM5pTNtdyJP9fScAEymU4DLl
         GXa4e44x/Y0wMS349hhmR9bYXVNiOFp/ZMIrO50LNZhiQGyA1oUlfQvUp4ADTAk9CYMH
         Cf6JWWY7p8nOKkbnlERgJ7NkI0WtAqUYzTsbUTGSQ665IwdlDVTRq4zDmiMUTUJ4XOMa
         MrS+JlZIiUw7NcCaiUCJsYhiRtEzEPrgGUICv7pz02ngTgjijT+GuqvROUXmaJYdPvi6
         8PwAkZAnt6YUj2ErGN19kJ3+bBK6JxgW5Z2Syk7EM9TTiCXAYQ9y0v5GT9yTISKLtOiv
         eltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0aTtHLLbXJJnap5vvp+Qcr3+OyTSHIvedCtwIVL1oQ=;
        b=Lr8AGVlUXu2YHgR77eLoWUuo2FF8AjQ/bQ+NYDj/VcDmfmhMFf1Przu9sQRt36BiqA
         YCw+pvCIYSjBfF+lMOYD9VMFHCzJlMeKAEnOCIY4hoLbh5TJ2PNQp9RkkIgIaMLVCYvw
         AHP7nIKcsm6sjsCJIayCPURGQ+6WFz3WP6dVdYfDbVnkTzrz/eKUsC14aJ+59MmNO6BY
         FhRz7zpuCJwSXm8fwiTfpG8SSdg1kW3Ts0V32TgAC61BMlBgYpV3be/tYnd/zRTDA9h/
         IOOLzLox4Mbo2s0CeMzP4o4GA39SHb3QCA0WXvdMUvISSaHlRl+7+IMioZ16BBMEd+6Z
         9mkw==
X-Gm-Message-State: AHYfb5hOUkW1j2zKFMO9K5WrD22V6tWuvqYEmwwdzcVW4GWPSTG/QnZ0
        rgCImmR3qYz29bxI
X-Received: by 10.28.16.19 with SMTP id 19mr7057889wmq.83.1503337447246;
        Mon, 21 Aug 2017 10:44:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id y8sm5942458wmg.12.2017.08.21.10.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 10:44:06 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
Date:   Mon, 21 Aug 2017 19:43:47 +0200
Message-Id: <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1503323390.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_setlen(., 0) writes '\0' to sb.buf[0], where buf is either
allocated and unique to sb, or the global slopbuf. The slopbuf is meant
to provide a guarantee that buf is not NULL and that a freshly
initialized buffer contains the empty string, but it is not supposed to
be written to. That strbuf_setlen writes to slopbuf has at least two
implications:

First, it's wrong in principle. Second, it might be hiding misuses which
are just waiting to wreak havoc. Third, ThreadSanitizer detects a race
when multiple threads write to slopbuf at roughly the same time, thus
potentially making any more critical races harder to spot.

Avoid writing to strbuf_slopbuf in strbuf_setlen. Let's instead assert
on the first byte of slopbuf being '\0', since it helps ensure the
promised invariant of buf[len] == '\0'. (We know that "len" was already
0, or someone has messed with "alloc". If someone has fiddled with the
fields that much beyond the correct interface, they're on their own.)

This is a function which is used in many places, possibly also in hot
code paths. There are two branches in strbuf_setlen already, and we are
adding a third and possibly a fourth (in the assert). In hot code paths,
we hopefully reuse the buffer in order to avoid continous reallocations.
Thus, after a start-up phase, we should always take the same path,
which might help branch prediction, and we would never make the assert.
If a hot code path continuously reallocates, we probably have bigger
performance problems than this new safety-check.

Simple measurements do not contradict this reasoning. 100000000 times
resetting a buffer and adding the empty string takes 5.29/5.26 seconds
with/without this patch (best of three). Releasing at every iteration
yields 18.01/17.87. Adding a 30-character string instead of the empty
string yields 5.61/5.58 and 17.28/17.28(!).

This patch causes the git binary emitted by gcc 5.4.0 -O2 on my machine
to grow from 11389848 bytes to 11497184 bytes, an increase of 0.9%.

I also tried to piggy-back on the fact that we already check alloc,
which should already tell us whether we are using the slopbuf:

        if (sb->alloc) {
                if (len > sb->alloc - 1)
                        die("BUG: strbuf_setlen() beyond buffer");
                sb->buf[len] = '\0';
        } else {
                if (len)
                        die("BUG: strbuf_setlen() beyond buffer");
                assert(!strbuf_slopbuf[0]);
        }
        sb->len = len;

That didn't seem to be much slower (5.38, 18.02, 5.70, 17.32 seconds),
but it does introduce some minor code duplication. The resulting git
binary was 11510528 bytes large (another 0.1% increase).

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: no "ifdef TSAN"; moved check from strbuf_reset into strbuf_setlen

 strbuf.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index e705b94db..7496cb8ec 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -147,7 +147,10 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
 		die("BUG: strbuf_setlen() beyond buffer");
 	sb->len = len;
-	sb->buf[len] = '\0';
+	if (sb->buf != strbuf_slopbuf)
+		sb->buf[len] = '\0';
+	else
+		assert(!strbuf_slopbuf[0]);
 }
 
 /**
-- 
2.14.1.151.gdfeca7a7e


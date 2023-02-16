Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA81C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 13:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBPNFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjBPNFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 08:05:17 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF76589
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 05:05:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id kk7-20020a17090b4a0700b00234463de251so5735775pjb.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 05:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+Nl52Uq6OV3BNfLoqqAGtUrjhGSqqW+F982NVvlnGk=;
        b=hWHz9ufyd63sbv3Vwtso/ri/Ume8Zeg3wxC+L/1oXAlecCmvzun/79OG/EUTwK80nR
         XC7CrfBaFSgiSQuKb+gP4MyXc9JCxkfGEUal0f9ZN4TBEaIpKYFS8Go1C4rPZZmrD/i6
         fAuiQYVeW5pcEYvESxuGpApOV0IK7s6XSyDmP69tlwXUFcT1c6FlK8b37cSMm31Vf9+z
         MBeI1XA9HqbTyvcFTa6aXL1K0kZDCdgDWwl2kxQoWdwtNb8Y3UQMWpMzM5pjKmD2VTr8
         yJ1V0xdu/rY6XOHP+dTaBX2QtjHms6z1xATQE8pX2mAQ/KevfmpUageohHb3J78BG2BV
         pOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+Nl52Uq6OV3BNfLoqqAGtUrjhGSqqW+F982NVvlnGk=;
        b=dLH0qtdA+zB0S2U8FDCXX3whW1FwlEi4wF4h0uhja/iOw+KnLZEmxs55D/bEGE5jD+
         gAz95nM1o51f72Iev4tUI6wyoBnMvjJVKqJcvKjJN/ePmNRhHotdbaLfZWZ4cWjlPZ+z
         4new5aT2rLpcqgxWUAja6y37RA7Ph1B6ceVIO7VmHAhgFJ72YY/clYuKdNOlOJSNQ3AS
         ggq8ABLHM0uOC1uMWSxW4xCC6pfzVwqkooVw7wiywb9JSWBrJsikMXf3mhU/zMxUb26X
         GeKm32t0fmvvAqBC8o+WGVgaOqlf7it2O9BoHUKhbjxQIXVC4Nn4yWc+UI8TTrDMwBEx
         PzUA==
X-Gm-Message-State: AO0yUKV6iZWAJkmr82ylut1D4KjcZsczcmu3vUsuNSy8WeZPRKJTnx1D
        JV22hj3n1NLstt3Fwh2gtPQ=
X-Google-Smtp-Source: AK7set9P+7cTl6yMil+fbjtLZmng3YPny9iPRTWY68V1MZT2pQbl+WlPDdGT9Wv5AFuHS/xuEQysrQ==
X-Received: by 2002:a17:902:c941:b0:196:5787:d73a with SMTP id i1-20020a170902c94100b001965787d73amr6595184pla.53.1676552716549;
        Thu, 16 Feb 2023 05:05:16 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id jk3-20020a170903330300b0019a75ea08e5sm1274581plb.33.2023.02.16.05.05.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:05:16 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v5 1/3] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Thu, 16 Feb 2023 21:05:03 +0800
Message-Id: <9a4506692239db52c2632346c079d9ac82946c8d.1676551077.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.39.2.459.g31d98a8e.dirty
In-Reply-To: <cover.1676551077.git.dyroneteng@gmail.com>
References: <cover.1676551077.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's cleanup the unnecessary 'strbuf_grow' call in 'append_edit'. This
"strbuf_grow(&d.buf, size + 1);" is prepared for insert a blank line if
needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
"\n");" will do the "grow" for us.

Best guess may be that the author originally inserted "\n" manually by
direct manipulation of the strbuf rather than employing a strbuf
function, but then switched to strbuf_insert() before submitting the
series and forgot to remove the now-unnecessary strbuf_grow().

Signed-off-by: Teng Long <dyroneteng@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/notes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 80d9dfd2..23cb6f0d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -215,7 +215,6 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 
 	BUG_ON_OPT_NEG(unset);
 
-	strbuf_grow(&d->buf, strlen(arg) + 2);
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 	strbuf_addstr(&d->buf, arg);
@@ -618,7 +617,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		enum object_type type;
 		char *prev_buf = read_object_file(note, &type, &size);
 
-		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
 			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
-- 
2.39.2.459.g31d98a8e.dirty


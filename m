Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A5C43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B98F2074B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9X028VZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDDBMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34163 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgDDBMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id i186so1248965qke.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUgn9onJnc+CLINd2r5YNxqa38tJ7MrR11cbK6unYBI=;
        b=K9X028VZaA1p72GY9uRNbKJwx1RI0wbpZ6b+LX4+VibCLb+dwh9ERGh/CALdgxy0LS
         lXDYMx5dDlHq3Wm+qMLwGKenpSozcO5gtq4UBh8rvV6INAUfPTcMxP/I/wGm6VYywMN0
         TEwXzTTikrBlEA9LsuDCcQ3THCebzApXpVhMBAyMej+LXYt4XViDj+w8PjEXICLY5QF2
         f6e6gz46sqMeOOl3OMpxZ+q3Cgri56Z+dCJX8uO55ZJY8fsX++/+sECQEC5EhkOCQYbx
         AGQGH+ga6Vp74rTPChgw7ncYJmQqZav+5FBi5o7fHt34+Jos1lsHtfx91UTPYMBaY37C
         p3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUgn9onJnc+CLINd2r5YNxqa38tJ7MrR11cbK6unYBI=;
        b=kAgt+8kHaCZYlmlwobzAgERjQvOZ0sCjHfWoqJvYnp8uMNHLF/3ihQgctBuBuUTKVN
         LZ+oj54mXkpZNU9tw03m1wHWiwsrgKabvWpGu07yikpjGFBhW/5lu8Slh9lX4h83xWZg
         kygLf2taN8dBFJcsgVzawz3t8I46ZfFn8Xsdbd7o7v81f6sKaDIfGRmxY7a67aP7doAL
         Hu7Bw6lKSXoh9+VFKnOrwxi4/qUV7E3S+YrXuQSMosPdSTUXZvpMNyPRHnjcTYZZwitW
         zxkdp1ColarKACUXyvq6AwUCQ1ZBeKU5yc1r37xNaY8sNLtcZT8g8Ft1+vDa4MZwcbJk
         CIQw==
X-Gm-Message-State: AGi0PuY8bAiVgGnIht8zZ/5FWo9kUogV2acSrjSps1YBiU4syL09BJOy
        iE96kQY5f67DbajLLMtkbww2S2iN
X-Google-Smtp-Source: APiQypKfyq4P7JIPM6c1SezMd9gzhboFSZ+AdeF0yupROKuFrT6+K7B/TxbIiD5/R/ekIsmd/qHXPQ==
X-Received: by 2002:a37:317:: with SMTP id 23mr11438535qkd.233.1585962738405;
        Fri, 03 Apr 2020 18:12:18 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 18/23] sequencer: unlink autostash in apply_autostash()
Date:   Fri,  3 Apr 2020 21:11:31 -0400
Message-Id: <e703022fda836f2fd6856e8d5861e2264af4d038.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explicitly remove autostash file in apply_autostash() once it has been
applied successfully.

This is currently a no-op because the only users of this function will unlink
the state (including the autostash file) after this function runs.
However, in the future, we will introduce a user of the function that
does not explicitly remove the state so we do it here.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index 8efe0976fd..5dd1c2438e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3740,6 +3740,7 @@ int apply_autostash(const char *path)
 				  " \"git stash drop\" at any time.\n"));
 	}
 
+	unlink(path);
 	strbuf_release(&stash_oid);
 	return ret;
 }
-- 
2.26.0.159.g23e2136ad0


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCBFC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 12:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhKVMhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhKVMhi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:37:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EA8C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 04:34:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x7so13776816pjn.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 04:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvry0IFox4J1dl8EPfBj8fwrysTPYbBFJnqthCiBI/M=;
        b=hwV77o+W5yp++hpRPQtb10Kd/GoaqugWXcqOsJ32dP2iBhNN2RxZG3G3qufcaZAZsG
         3SNhpSndsPhBwyw1Lof8G1V+24Z4AnkJN+XmOMC2ADi4xwj4yoBF2nVeXEBjEaqCbZLe
         RXAcUUedtr0+ezLn/RlKjdfW+3JBzAZV86+OYOHQpQQaSZ2pc6D+Embrx4flx6QYJKvx
         EfLJGInuKHNdfmeJNBzyyPgxMigkGlbgRQ9x4LH+dKOd73ruL1w9kXlrDP616DptspTe
         7YnQQklTLDq0w91K9o42IklNYsB8nMNOEzNiTCERCf6F+rxDOk+GvUWm+LQL6he1VTAb
         +TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvry0IFox4J1dl8EPfBj8fwrysTPYbBFJnqthCiBI/M=;
        b=YlO830ZvuXr3tDbCiJ2jd8JEJwCxcWHCRYgHiMgh8/VAA0eVAFLAoVeHWcFWP7radk
         f4/2z5IDC185Sp+tSiQhgZ+b1+ng+2PNbdsmdtWYgD8Jre6vam+Fzc+WeBg+8siy/8Lv
         CJXfo87mtnjGlD+9z5xtPQVhBTV5ut/eu1TQ1R6GMAm+M3nBPW6N6oODcg84LNV/EKN4
         J1CHOFfja2LgsmaHdWxYxmmI+JsO4m01hsy7Y4naM3USB/LKPJTRkCP8W5nHiMA1FfbW
         1jDSHJiFMu8NtTaCXpKOE0N63daOpt1+rm6vhQB7dfRMe1/d//HbNTCjAD59U1pKwiMl
         nVVg==
X-Gm-Message-State: AOAM530GgnTjfDnKFp197gZRLoJmlafzouxWbDxqwGbEwogt76v/t1D2
        gpCwKvvzL8LYIxdpv+s4RMMzPTulH1w=
X-Google-Smtp-Source: ABdhPJzHfIVv09fSiGfJ0OqKaAMrJhRHNTRSY6tiMCt0aWHqxX7c3uS8ToHX4TZW1UgzTQ6MOG5b2Q==
X-Received: by 2002:a17:90a:c297:: with SMTP id f23mr30975240pjt.138.1637584471751;
        Mon, 22 Nov 2021 04:34:31 -0800 (PST)
Received: from ubuntu.mate (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id t4sm9384794pfq.163.2021.11.22.04.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 04:34:31 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3] fetch-pack: parameterize message containing 'ready' keyword
Date:   Mon, 22 Nov 2021 19:34:14 +0700
Message-Id: <20211122123415.464783-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The protocol keyword 'ready' isn't meant for translation. Pass it as
parameter instead of spell it in die() message (and potentially confuse
translators).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v2 [1]:
   - Add missing closing single quote after the parameter (suggested by
     Eric)
   - Remove stray 'no' at the second message (suggested by Ævar)

 [1]:
https://lore.kernel.org/git/20211118103424.6464-1-bagasdotme@gmail.com/T/#u

 fetch-pack.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3..62d6313708 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1410,9 +1410,13 @@ static int process_ack(struct fetch_negotiator *negotiator,
 	 * otherwise.
 	 */
 	if (*received_ready && reader->status != PACKET_READ_DELIM)
-		die(_("expected packfile to be sent after 'ready'"));
+		/* TRANSLATORS: The parameter will be 'ready', a protocol
+		 * keyword */
+		die(_("expected packfile to be sent after '%s'"), "ready");
 	if (!*received_ready && reader->status != PACKET_READ_FLUSH)
-		die(_("expected no other sections to be sent after no 'ready'"));
+		/* TRANSLATORS: The parameter will be 'ready', a protocol
+		 * keyword */
+		die(_("expected no other sections to be sent after '%s'"), "ready");
 
 	return 0;
 }

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
An old man doll... just what I always wanted! - Clara


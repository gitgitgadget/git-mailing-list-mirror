Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5444C48BE8
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7116613DE
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhFQDTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 23:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhFQDTl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 23:19:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED5EC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:17:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v7so3778105pgl.2
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGI6Is+Wz7vysiC/Tg8KKBXsSfL7fyWwC9dTfE5WJuM=;
        b=qwMfkEbTQXHCyJeaT5U5p9Yf6lSQKbJQMdXsITaQpvd4WSZZdM63b0tt7+lD0hl8nh
         Zka1hLmkTIXnTi2wLaaiV8QuDA67TYA67ZKZWhpMslizzQgq5/QkoeEMv8caIWr5ndd+
         5O/ZkYwqoYnOcH2dqMeYJHjClPaCZMPazsEQ4CE8RRywFARYmU12tm9LySlHLWMhX4tB
         /IPFM4wLKcO2Y3lFGfeDFVbadZCt5R0QFzWLaNueT5V52FhWRLvj0G7bqISCGtUqP59j
         5YgnLw4nKNzREDybpGbyiqiWzQZsN046VRyGkuHDUqqJUMN203sDwQuc95RTlNRxC0dr
         OJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uGI6Is+Wz7vysiC/Tg8KKBXsSfL7fyWwC9dTfE5WJuM=;
        b=HszpeWc5f8Qs2PZPs0WFm+KxddbFU9n6gSa1dCzkG03xCKObRbiii2ZDPCdk+mpnN5
         u1Z+UkJju8Z5nLSB9WAQMGjOhNXnqWHCJxeTjnhIkLtPBwh4cD/DJtTJ4tLkE3TDrERG
         iuymuPOvNEU3aXCEvS8oSkuJNY6lP7mL+tCmEgCZ5/KnjLJUU70zHBlN3hF3/vj9gAa0
         4D6taQdHZxZ7cbBdgeccm+bBodhRkWz4igeWcaN5L8aoXqwlNf8WbV8KWIF4VHIOY19P
         EpSHE0NAe6YXDErio8Gz2bW36f08rPsGI+pWKqAkQ1A3DzGVQQL7hWofoG/cBFgpZzTG
         J73g==
X-Gm-Message-State: AOAM530vr6SwG3GmspkblpneIhn6y+NN/YQEArckZze+/G7lxIodj2om
        UJDdY5lXZCLub4BngZdw2pM=
X-Google-Smtp-Source: ABdhPJw4cvZcUnyNCWs9Ps/f/lzNpQh1sfuuR6gbnCqzy/Hd7memAAoQ5yorE4S8KCDN0eRGCXR2WA==
X-Received: by 2002:aa7:8c02:0:b029:2e9:c513:1e10 with SMTP id c2-20020aa78c020000b02902e9c5131e10mr3155052pfd.2.1623899853240;
        Wed, 16 Jun 2021 20:17:33 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.151])
        by smtp.gmail.com with ESMTPSA id ei10sm3301726pjb.8.2021.06.16.20.17.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 20:17:32 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 1/4] sideband: don't lose clear-to-eol at packet boundary
Date:   Thu, 17 Jun 2021 11:17:24 +0800
Message-Id: <20210617031727.81105-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc0.27.g7b1e85181b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "demultiplex_sideband()" sees a nonempty message ending with CR or
LF on the sideband #2, it adds "suffix" string to clear to the end of
the current line, which helps when relaying a progress display whose
records are terminated with CRs.  But if it sees a single LF, no
clear-to-end suffix should be appended, because this single LF is used
to end the progress display by moving to the next line, and the final
progress display above should be preserved.

However, the code forgot that depending on the length of the payload
line, such a CR may fall exactly at the packet boundary and the
number of bytes before the CR from the beginning of the packet could
be zero.  In such a case, the message that was terminated by the CR
were leftover in the "scratch" buffer in the previous call to the
function and we still need to clear to the end of the current line.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 sideband.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sideband.c b/sideband.c
index 6f9e026732..85bddfdcd4 100644
--- a/sideband.c
+++ b/sideband.c
@@ -183,8 +183,31 @@ int demultiplex_sideband(const char *me, int status,
 		while ((brk = strpbrk(b, "\n\r"))) {
 			int linelen = brk - b;
 
+			/*
+			 * For message accross packet boundary, there would have
+			 * a nonempty "scratch" buffer from last call of this
+			 * function, and there may have a leading CR/LF in "buf".
+			 * For this case we should add a clear-to-eol suffix to
+			 * clean leftover letters we previously have written on
+			 * the same line.
+			 */
+			if (scratch->len && !linelen)
+				strbuf_addstr(scratch, suffix);
+
 			if (!scratch->len)
 				strbuf_addstr(scratch, DISPLAY_PREFIX);
+
+			/*
+			 * A use case that we should not add clear-to-eol suffix
+			 * to empty lines:
+			 *
+			 * For progress reporting we may receive a bunch of
+			 * percentage updates followed by '\r' to remain on the
+			 * same line, and at the end receive a single '\n' to
+			 * move to the next line. We should preserve the final
+			 * status report line by not appending clear-to-eol
+			 * suffix to this single line break.
+			 */
 			if (linelen > 0) {
 				maybe_colorize_sideband(scratch, b, linelen);
 				strbuf_addstr(scratch, suffix);
-- 
2.32.0.rc0.27.g7b1e85181b


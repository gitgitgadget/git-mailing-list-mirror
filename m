Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E9DCE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 15:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjIWPWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjIWPWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 11:22:15 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8FA9
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 08:22:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fe2470d81so3511834b3a.1
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695482528; x=1696087328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueFLlkQl4l4O5xgips18o5j3rK/wmwYQU3cjOOOSRBE=;
        b=crVwBQMxFvmZBp5jKBN7tg1tqdNHL3kx6q8ZiqAIRoJUs4AHFlAV1Np4/br/Qpgn74
         HfQVDOpx/OBLMR/5w64pLxreEfp+d8woFarNxxM6OOXGakS2qn1cRBGzqVAJmS/ZAJqu
         ncj0zPf0Ynse+YTvZ8XElHjJMy7cuMsdZfoSQmxcPBESMEkGvCm0Mvix++sZKF/zeOAd
         b7boWT09m7+qK83t/LSyKOQV4eIOP/cy49swoItCe0V/Ob9UQD5AdJi4igPs2feh2POK
         RcpQH+NxYu9tEGrsutAjK1ILyT330TJu6JonnJ7qrus5c/ogqi9Y9aE1GzmXQWH9YYtf
         YTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695482528; x=1696087328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueFLlkQl4l4O5xgips18o5j3rK/wmwYQU3cjOOOSRBE=;
        b=owxpo/YW2uP6ySiTlO6tQxCKPmlHMoB758mOOFPT2kpwAZxL5suSzXto8TT6u8rTyD
         wWcU6aMf+tLLL5yK2ghyqoWSdO4h0td0lFIagfV8jERTRKsKTSaRhEQV9pvO9mVqnzwC
         WcjAJhFuLOQ4NkdVMBPZNrRgQqOkPVh87IPz2nopXdopc/GExHCcNcpx8I4e6PyIvZ0W
         JnaEVxg5FjTd9ytUtENsqmN1EcSf1B3RacrzT8yo8h72zN+JSnH/0x884zBC/tmnxmnJ
         1ENTMJamOU9LFa0fG1d8QuSLS2TUF3kdWel8n8H5+Ye3b3poW1ThHoS2P8pcR6bsszYu
         gIRw==
X-Gm-Message-State: AOJu0YykrHMqe4brVr3cHNs0ulqGHf7pSUfoHT8Tww1dmtlL56RxGmoB
        IqgwkNu5cQO2DwzSEFGcccM2iuy5Z7g=
X-Google-Smtp-Source: AGHT+IEB0FrcDQoPak6YBBhssF2erZ9bWPK15Nwe0vp/6ZLdUqq7ncPis19GxX00IwFQ8mvWozrOKw==
X-Received: by 2002:a05:6a21:627:b0:15a:4f5d:df64 with SMTP id ll39-20020a056a21062700b0015a4f5ddf64mr2384181pzb.56.1695482528604;
        Sat, 23 Sep 2023 08:22:08 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a001d1400b00692acfc4b3csm3084310pfx.136.2023.09.23.08.22.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Sep 2023 08:22:07 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 2/3] transport-helper: run do_take_over in connect_helper
Date:   Sat, 23 Sep 2023 23:22:00 +0800
Message-Id: <20230923152201.14741-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <xmqqy1h2f5dv.fsf@gitster.g>
References: <xmqqy1h2f5dv.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

After successfully connecting to the smart transport by calling
"process_connect_service()" in "connect_helper()", run "do_take_over()"
to replace the old vtable with a new one which has methods ready for
the smart transport connection.

The subsequent commit introduces remote archive for a stateless-rpc
connection. But without running "do_take_over()", it may fail to call
"transport_disconnect()" in "run_remote_archiver()" of
"builtin/archive.c". This is because for a stateless connection or a
service like "git-upload-pack-archive", the remote helper may receive a
SIGPIPE signal and exit early. To have a graceful disconnect method by
calling "do_take_over()" will solve this issue.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 2e127d24a5..3c8802b7a3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -668,6 +668,8 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
+
+	do_take_over(transport);
 	return 0;
 }
 
-- 
2.40.1.50.gf560bcc116.dirty


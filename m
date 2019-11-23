Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F248BC43215
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA59B206D4
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac5MmO77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKWUut (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:50:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39268 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKWUus (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 15:50:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so9638848wrt.6
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7L6Uys+ehO3fEGNUv7fE+7LdRtjxRTj09IAZWOEm0Mk=;
        b=Ac5MmO77/wY4eOP28+/8iU80O3cCIKTerdGNZ1sy4i4IAat4mdMQaE2Y9gyibT5DBz
         ZH2H5rLlUq0aM2cvjRuz44JETnyw/g9xZQbqA3F76pwqRfOgfMtReP3MlTqf5aSyzZsL
         kBldrf5WMpaZO/mhKavuQMk1lfnF83eUUro5c36SvbicnFgGZegrf0lR9iSEgAV8UskZ
         kF2nRs6GZtkLCFtRDsKCCO4cnp6hmsM7BhL8PwtAQCZI3I0VW7pxpvbwVD5Uar0++mCn
         LAs/qPDjgRRMG/jC+oPuhXvd2I99LDkdRaoJLr0+6qIsHFYt8jIWye8Kwrg5p+hXio/s
         7YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7L6Uys+ehO3fEGNUv7fE+7LdRtjxRTj09IAZWOEm0Mk=;
        b=L1wdu0GVBnQwHbO2WIyBzjCFVu88vLnh7j59aZDQc7y3gad4JA9o9UJfsHmZY2ye7h
         Le7Y1dWjoCNIAWx52dLYlWih33NJHpUnIBJyF8GcVj5MqoE8GVLgFFQyT4+XrKcQml0X
         LpUDEBoIp4ls/Uqfso7h4yanPwoYtgDH+DaRyMeIB51jLbqS8VPGSdYoPHOWguLOOYAc
         eXJDxJjQvOWSDchhpOCUQWVgyEGi0AYipRKWpgAPyy8pe0JdttOOMbk0l0UT8wQq85ob
         gfoBehr0fy7ow5MvbQ6rutcC/t+xpE5HD8JQDVUanHw1iAS7oVPxLAUmJXIISW5M31Ya
         4mzA==
X-Gm-Message-State: APjAAAUI5NsPC3FLVyh7HAhTcPNGcuTqpKqUhOvKsysWLFlmL+vsvB9C
        AGu/Bk8xxQpVy0qhiX1WYHDO0LJo
X-Google-Smtp-Source: APXvYqyUp4QXJ/0n9DDtPQAVS+zT8BR2eK9bmpwgRcKDguQZAFaYvOZwkuxFBIrQf/AoSKhEe8+/AQ==
X-Received: by 2002:adf:db41:: with SMTP id f1mr23239072wrj.351.1574542245635;
        Sat, 23 Nov 2019 12:50:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm3500330wrq.22.2019.11.23.12.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 12:50:45 -0800 (PST)
Message-Id: <fb531064b35814e5f8f87baa2996522d7ca57148.1574542242.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.git.1574542242.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 20:50:36 +0000
Subject: [PATCH 2/8] remote: warn about unhandled branch.<name>.rebase values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We ignore them silently, but it actually makes sense to warn the users
that their config setting has no effect.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5591cef775..3410ea19c7 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -315,6 +315,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				info->rebase = REBASE_MERGES;
 			else if (!strcmp(value, "interactive"))
 				info->rebase = INTERACTIVE_REBASE;
+			else
+				warning(_("unhandled branch.%s.rebase=%s"),
+					name, value);
 		}
 	}
 	return 0;
-- 
gitgitgadget


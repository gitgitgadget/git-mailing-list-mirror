Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9283BC33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A983206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfXxK1UJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgAaSbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:31:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55541 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAaSbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:31:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so9023911wmj.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9gJy8rO8rX3RtYiNe+N6NAtJQNv32fz37U/5D9/Csog=;
        b=EfXxK1UJQyP5i5hr8R4uURmPhyadT9OenPx8DRnRZa73UQxaP2HPrTGArSh2Tz338v
         XBnOrhVYJYjcOGihHZ7WDDmjB4Lga562eX0DlWonntgkRqw0co8IbETWEOaJg0+DeQuT
         3EyFbrYOY76Qxdrdzi180nGqKUY8y48zN3ALNcDfaZGA4Z7EToRGKUajgMhkE08rqn0d
         q0x9OHdZrdDFgbfoq0ZN/h/pRwpPC3QEAOEPk0g5UDrNm7zrkTxn2VzBNE7Zvma3tTjj
         OtnNwZjLcCtblOtWCt7sApLtVIVryXbnzjcDR3lKOuesr/mk7WC6MKYa1l7mV5K+lhSn
         AVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9gJy8rO8rX3RtYiNe+N6NAtJQNv32fz37U/5D9/Csog=;
        b=P8Wf9OUNHt6xQNJx6aShCM9Ure4JPMNyeTgtlnqHQyquz4JykmJnajlT+PfQczu0SR
         H8xw2LrKkIOUz/eSgaq+V+EtRCTh63gGa9n1GkrO2U864LAypRYKdhjAH1g5pj6nL/lw
         SLy4G1cG3MhFzG9FX4MgVE6sL0k802Wjxq7U9yeuJ+4oMKkBd0PoV5CrBOd95/WN7cV1
         dP/bzmH/BZxYdTw8X+9hS9FVI0wSEHRcDxc/BEtbxnheB60PBH4GHrRfX7L9ywISyY9W
         DE8lEzybwQmJKJIvW0qZg70lpt6WJs4rkZe+THzz26ZPMSt+olpn28zX16pXzAmWdiyh
         /UXA==
X-Gm-Message-State: APjAAAVrMa97W6qicuH+aFKzSwtHf4trgvoM+NSqlnNlgEk6NX/zZgWW
        IDmcq6NmF7fRaFIuvgDvSw5FytT9
X-Google-Smtp-Source: APXvYqxM3fXd/brJPopc6jqKC2W+pMVoC24m6xCpee0hazsofU3McYXL25D8P2UM0PDnWqA2SrqFlw==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr13260939wmj.1.1580495489269;
        Fri, 31 Jan 2020 10:31:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21sm11525771wmo.8.2020.01.31.10.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 10:31:28 -0800 (PST)
Message-Id: <2ceb64ae61eccd662922f6156e00d4044bef515c.1580495486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
        <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 18:31:22 +0000
Subject: [PATCH v2 2/6] dir: fix broken comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 68c56aeddb..c358158f55 100644
--- a/dir.c
+++ b/dir.c
@@ -2259,7 +2259,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 					add_untracked(untracked, path.buf + baselen);
 				break;
 			}
-			/* skip the dir_add_* part */
+			/* skip the add_path_to_appropriate_result_list() */
 			continue;
 		}
 
-- 
gitgitgadget


Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F8CC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C26206FA
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7ZDQfdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgCLRKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:10:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36784 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgCLRKO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:10:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so7226809wme.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpP9f4R9H+0TsIxR65aHI1DLVAnIi9F44eJv/dN18Zs=;
        b=n7ZDQfdXPgzDTlj/AWHeUvrfcio4wTb2dlIIUR5NqyqEn/3lyndlzcrejyZ5ossu2W
         R14UH4U8saeb9ECLAdAuwIcTFHB4l2Tm0moyskFNGk9UhaRMAu0PJfS3AqJt3QbWOuFw
         rYVc80+sc5EwtD7/OQvsIRiG2cmDJ+J5CK6de2WDqOV6m+U4ZbMosbm9mB1p9N7nvU+9
         mS7UKQkKQH6QmpaHGVadOZ9okd9As8dGzVLWv0I1xROUHYIIfNjm6muBUyjwkaaon/5L
         IVRGq1m+yvkVm2eMAMkMaveBP3br0c2KUeFZwkCkfdg8cQJMVeVDI7zfwzQc1KmVL+Ow
         qjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpP9f4R9H+0TsIxR65aHI1DLVAnIi9F44eJv/dN18Zs=;
        b=eeYSSEJK+jBwIXSsMCgJ3l5yr3MSpYNzgw/ioyAfh7B3ZNebwFap0TFDHiivY4a3K9
         w78ZKN1WzdkSmUF/5RUL8Ce55uIsPslf40yISTXUepiuAe7gLhrzNUmeuH9hgYUJkOMf
         H1qYzuYE+edb8J0Xzens+3qLt3nLgCtvDvyzGdcDOHeQeK4vMAN1aAZZv4PmWzVtSIZz
         13zV0CbMhhMQxeE0h3JucCcUkhyL4MNQB89Y2QWfcPcrAHsEZ6rxoOLfO2Kt59zJP7/z
         tC+MCFIpYUyKYkVadkBcw4L1m4YrGKgkxSyBXFBNyheEw4xh5CDmwlL1FRgHGHTZaIDh
         1EDw==
X-Gm-Message-State: ANhLgQ1PjcRUdx6z1h4yCQAOGKCRTXP56hIV4AlC1ndJpq+A9tXmdJ8S
        ABaEUsvLLeAm7xdhLGPTgcrpH8sMhac=
X-Google-Smtp-Source: ADFU+vurg7Fsbct6WO5BKKkPi5vqX2pkdyZQRgkSzXyWprtHYDSyZRUqBubOHTaZekmK3xaK0eevVw==
X-Received: by 2002:a05:600c:2f10:: with SMTP id r16mr2265608wmn.92.1584033013145;
        Thu, 12 Mar 2020 10:10:13 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id r12sm21593430wrx.26.2020.03.12.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:10:12 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 0/3] Documentation of pack and repack
Date:   Thu, 12 Mar 2020 18:09:28 +0100
Message-Id: <20200312170931.2392490-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
References: <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch is a small clean up I found when reading the source to try
to understand the behaviour of pack-objects when writing the documentation.

The second patch update the documentation.

These two are not changed from my previous round, except
- I changed the order
- I took into account the typos mentioned by Junio
- I removed the default options section which referred to the default
  options passed to `git pack-objects` by `git repack`

In particular in the second patch the only update to the options description
in git repack is still 'are passed to `git pack-objects`'.

I added a third patch that add some quick description of the options
-l, -f, -F and -q.

Damien Robert (3):
  pack-objects: change the name of add_objects_in_unpacked_packs
  doc: update the documentation of pack-objects and repack
  doc: add a short explanation for git-repack options

 Documentation/git-pack-objects.txt | 27 +++++++++----
 Documentation/git-repack.txt       | 62 +++++++++++++++++++-----------
 builtin/pack-objects.c             |  4 +-
 3 files changed, 61 insertions(+), 32 deletions(-)

-- 
Patched on top of v2.26.0-rc1-6-ga56d361f66 (git version 2.25.1)


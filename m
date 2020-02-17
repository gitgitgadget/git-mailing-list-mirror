Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBFFC34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8239A20801
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAPqoipb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgBQRZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:25:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42149 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgBQRZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:25:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so20696013wrd.9
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rZHYsep9Q/e9w2R6wyQiSbQCvbjll94Qeg8F6f1TEcs=;
        b=HAPqoipbVa+kUkAWN5+qUi92MMO0nuyEXxxYE65H1f04O7WIelsBRn0zhOvCkXyCuT
         0z2Bei+/klTKv5NjN9RBT4pGCJhi7/rJBLdDKoft+jS0eBzVy4Ah1Xd9lWyW7OCPcBEO
         xEgekdygYCBVd5TLNsRV5gnNGz8C74SSPuxAErY5a62YaacvuotxeDZZ/RHo+U53DT8+
         vJH1Xqj93R3+F3VhA0Fymvr/iy+yOBIG3EhB/FMV3T1qZtT1CSb8G4oqgRoQnrmeiF9y
         FEYgJHJpak0VbwAHzybAwqXmXDAS5QnVigLaA2VS9MVLnEx/nA8NWoH/73xjSSXdk0Bb
         O6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rZHYsep9Q/e9w2R6wyQiSbQCvbjll94Qeg8F6f1TEcs=;
        b=hlCsmHJG/XBcF8WW/r8Xwa97KX4+e1htBzwo3k0bIMR14HpHvBUqJ8Nz3ZUjUMd6wa
         Fs4XAbYziv6AstW+TiS5mT6F8IOazwylKDtZ1tmnGHyPoKfcfAZWcGbjoIWKfkBjm4Ks
         Kkb+NmmrNTUJTqROYPg1ucClAWJAeyZigdn0tQb+b/9eW3ztbSdQtWyvJxebDYzmcgG9
         kLac8m/jW+PvmyDj2pexbxmGI5PwNLHSwO3IFAk0U9nJuqJIL31yK435LwHlzvyCeFjJ
         6b150obMgGnaSd9x9KDttbSceKafIoqAXut0q3CwABLQAUOtGxTVPqPCSRrn3tb/EWNR
         PxjA==
X-Gm-Message-State: APjAAAUaoAI0nIhLFTMYR3bAl3HQHmLDYA2+EURHJ4rWwqH2TGlbkeJn
        6351gtslPB1IjPNkc0NNuGEUKVO9
X-Google-Smtp-Source: APXvYqw2rJjzFjiilcLIIjN1AOCWEa65aBOcgyyCB/7cZMba4LTzTTQfEtMFtKin+CBXkgwUM/d29w==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr24617192wrx.103.1581960327331;
        Mon, 17 Feb 2020 09:25:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q130sm151766wme.19.2020.02.17.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:25:26 -0800 (PST)
Message-Id: <764b8668d10d691d3bde5185e32eb5f7264d0348.1581960322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
References: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 17:25:19 +0000
Subject: [PATCH v3 5/8] doc: stash: document more options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index c1c16623cbc..6dc0a5b0eef 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -194,6 +194,18 @@ to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use 
 `--no-keep-index` to override this.
 
+-q::
+--quiet::
+	This option is only valid for `apply`, `drop`, `pop`, `push`,
+	`save`, `store` commands.
++
+Quiet, suppress feedback messages.
+
+\--::
+	This option is only valid for `push` command.
++
+Separates pathspec from options for disambiguation purposes.
+
 <pathspec>...::
 	This option is only valid for `push` command.
 +
-- 
gitgitgadget


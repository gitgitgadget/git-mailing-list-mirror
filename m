Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6580BC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7162078D
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXNLdWyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFJVTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgFJVTi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AAAC03E96F
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q25so3167829wmj.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZdlmUjphEis6GADZQKFtiVllLbtQ5hT/vF/isOU+A7M=;
        b=LXNLdWyKK4EWfbpM9JttpVZt+WUOrnmfA+HFRFJrEMJgf2nYlmAPIA7WUzcndvQ+rv
         LOAC6EPWxV/vI2b3r79UB9JQBNpr+4ZkFQEGlRYXp6Xd5vwXWqkjkEV0Mn3RlzExQNRK
         MaPgWpesIL3zvkxU8x21je9KycsgxOSIJVQhl0OlWei8tDqVcB3uvgshlpR5t4CiOKH7
         eMjBciolekwBdSQbn3NwAeGpFsk29YW/E6lVrekEYQmP1DhXpRRF744+gMiEAbEQ5XF1
         wDVNLSijEc4bD18TxQGWYQnAgDPWPKlgXS7Nav8XMpbyUX8YOVzgC5vC0J0oADmy2Kkt
         z1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZdlmUjphEis6GADZQKFtiVllLbtQ5hT/vF/isOU+A7M=;
        b=BnA4FraxxJ5clQHz0AJ1F0c5W00Ku0vqYq7jXQzWkrjlUD6oJfJm6kbVJvbls7GfFn
         rSAPby4liXL6X6e/rMJ+iTnENXX8hXCu/0mqBtooxuKCpENxwOgRey2jpEUPYi+hKibe
         szXP/ijG/qHTg3R3GyE4Dp8zmotep7sS7m6/DnyoHoA1LpYH7bPI8g/xFeIQ+fGFRW8M
         UZlfaTM6yN65ycFJf+9ac9Z2tXRKyhOiRIbZcN5Q36COL1pkmagAOes6MK/2YBvB6uIO
         ZzlmSpIs+tpEhTLW9GMB/dxO0KLnvYElb/aezDb2eCrzB8plHUEZ1r37OPKmbts3TUnJ
         beXQ==
X-Gm-Message-State: AOAM533LjIDl4A1KuJlIKeEQri6i414iVXJ+t3TuK1L9m7ynsL+Kdx5Z
        5aPpSG8eP/MtZbeRIRmuHEoi9BW6
X-Google-Smtp-Source: ABdhPJzC8lGjd8AXHJJ8AR3OM8b4uZ8FX3ZmG1pKBULXcSyv/ub9flNiLSpxV1N6GoUpAk9b3gwEJA==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr4900800wmb.69.1591823976412;
        Wed, 10 Jun 2020 14:19:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f185sm1120868wmf.43.2020.06.10.14.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:35 -0700 (PDT)
Message-Id: <73cb567cd33e29d22f1a6b853925c68282da5298.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:25 +0000
Subject: [PATCH 4/9] testsvn: respect `core.defaultBranchName`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since the default branch name can now be configured, the `testsvn`
remote helper needs to be told about it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote-testsvn.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 3af708c5b67..a48d74f35cd 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -13,7 +13,7 @@
 static const char *url;
 static int dump_from_file;
 static const char *private_ref;
-static const char *remote_ref = "refs/heads/master";
+static char *remote_ref;
 static const char *marksfilename, *notes_ref;
 struct rev_note { unsigned int rev_nr; };
 
@@ -286,7 +286,7 @@ int cmd_main(int argc, const char **argv)
 			private_ref_sb = STRBUF_INIT, marksfilename_sb = STRBUF_INIT,
 			notes_ref_sb = STRBUF_INIT;
 	static struct remote *remote;
-	const char *url_in;
+	const char *url_in, *default_branch;
 
 	setup_git_directory();
 	if (argc < 2 || argc > 3) {
@@ -294,6 +294,10 @@ int cmd_main(int argc, const char **argv)
 		return 1;
 	}
 
+	remote_ref = git_default_branch_name(0);
+	if (!skip_prefix(remote_ref, "refs/heads/", &default_branch))
+		BUG("unexpected remote_ref '%s'", remote_ref);
+
 	remote = remote_get(argv[1]);
 	url_in = (argc == 3) ? argv[2] : remote->url[0];
 
@@ -306,7 +310,8 @@ int cmd_main(int argc, const char **argv)
 		url = url_sb.buf;
 	}
 
-	strbuf_addf(&private_ref_sb, "refs/svn/%s/master", remote->name);
+	strbuf_addf(&private_ref_sb, "refs/svn/%s/%s",
+		    remote->name, default_branch);
 	private_ref = private_ref_sb.buf;
 
 	strbuf_addf(&notes_ref_sb, "refs/notes/%s/revs", remote->name);
-- 
gitgitgadget


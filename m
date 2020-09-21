Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCD4C43469
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7463F206A2
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmwWUP23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgIUNa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgIUNay (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 09:30:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D25C0613CF
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:30:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so12151110wmd.5
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R+cC6FXI8JE/HCt/Gv5ViqTPLA3K3/Rjz9HVYKkUuHM=;
        b=QmwWUP23gyoWULaoG3aurHRWPvygrFslcmEAyfGAtUiOkO7jp3YzQJsoj/IJAVUzkM
         lwP5Oy+jPZHzfSqs1m7Qi5W4F4Zqp5fxw6WkYajzq6qTLlMUK6KkTEOPF66vrbI/7b7R
         mA7vfDy1msM1tDVqWaIidq0ql9VZ1F6vnxuW7uwLDHCgZMZJfOruziOqyS2YVosPCvNY
         SqHNBc6MlH8AC7qu+WJb6bVbQK5qk/gh0Cf+liRHjuLI3bhYBjoxPWf47bBxuw4U1d7r
         4kMznoS0QfZbpmqG855cV7IW7iTMKN3wIh2pUJO5xOT0FXxocJKVK6LeJeJv9NUIyGc7
         x0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R+cC6FXI8JE/HCt/Gv5ViqTPLA3K3/Rjz9HVYKkUuHM=;
        b=DGg4f/wIzqvOFxxMh9zWIopLCCXJ3QB5Haxd5bN3IQ92SkjQpKhPl/I8l1/aEM2C2I
         G+eicLeReSoWQYIlSsyaNrYQ5zr+MyWhjRSNQviOZeUwku73ICgKISHe7FCMhAUUq87Y
         V0rF5CM71FYu0Nd8Tt8PYioxYUkpnqOPjaiU4piYSC/G4v35RbjX0KCGSzTgJ802ah49
         KK77KtHuleN9y9KTszSXjLlYEBE16B9i1ohYRX4/mlhREcYwKXmfJOdnsKLPzGFfNDGb
         d5TNij+TYA5ngpSl+J2oHC+gtutX1wywn7EjkozS95F15X8RC1PEgqRSmbTzWcqVhqss
         lhrg==
X-Gm-Message-State: AOAM5330BcNwD5vsfwhCNjzpbmJadBgWnHIDaFTpGIJeprhbqUL7ZdvP
        XHuqPxOtV0v9+ibqaZxBzRJoDJbEjqc=
X-Google-Smtp-Source: ABdhPJyawpS0rV1cU84d4RGHd2WW2E40LEZbjj80lQTGFFXrfs+yjbnh6BcXY5H2ny8X7nzlQN9ycg==
X-Received: by 2002:a1c:b703:: with SMTP id h3mr29481621wmf.131.1600695052332;
        Mon, 21 Sep 2020 06:30:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm21607263wrv.25.2020.09.21.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 06:30:51 -0700 (PDT)
Message-Id: <c75566ce322435f3cf3dd67ab08b7cfa83164901.1600695050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.736.git.1600695050.gitgitgadget@gmail.com>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 13:30:48 +0000
Subject: [PATCH 1/3] commit docs: use backquotes when quoting options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Make sure that option names are typeset in a monospace font.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-commit.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..a1d1d1246f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -82,7 +82,7 @@ OPTIONS
 
 -c <commit>::
 --reedit-message=<commit>::
-	Like '-C', but with `-c` the editor is invoked, so that
+	Like `-C`, but with `-c` the editor is invoked, so that
 	the user can further edit the commit message.
 
 --fixup=<commit>::
@@ -99,10 +99,10 @@ OPTIONS
 	linkgit:git-rebase[1] for details.
 
 --reset-author::
-	When used with -C/-c/--amend options, or when committing after a
-	conflicting cherry-pick, declare that the authorship of the
-	resulting commit now belongs to the committer. This also renews
-	the author timestamp.
+	When used with `-C`/`-c`/`--amend` options, or when committing
+	after a conflicting cherry-pick, declare that the authorship of
+	the resulting commit now belongs to the committer. This also
+	renews the author timestamp.
 
 --short::
 	When doing a dry-run, give the output in the short-format. See
-- 
gitgitgadget


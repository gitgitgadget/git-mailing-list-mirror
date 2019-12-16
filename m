Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82E3C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F4D24673
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8Luv0/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLPVb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:31:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41797 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfLPVb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 16:31:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so6326004pfd.8
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+EzFVKu3ifOlxGO3XRQxj82Z7+1W5sSE+/ss0IGOQds=;
        b=H8Luv0/nHv2zfa5JGZkY/9RWkbFNwunYi9h9p+IJb5IF1/d745VXidSSrO8yvXecYE
         fTWq8ovjJ2HtVapawCeb/hp0mFySSVvFLumnShOfsdWdPI7QI0cralgAo7IDjPw3DxWv
         O8YNk8qz3Xfy3E09RcpyFHWDc2jN/fB846coIdFsDJJsGPjKXwyJxFhKWQbmvUXOb4w6
         2+agtSCZ8wKBRXJEHUXq0xv3IyesjnDBHCnOYIYMsAOSkQ5o0XvqEb+8v5+0cul4hoQe
         TLzBPVrMtrB7nGhZb4SXaGWReE4Y3fxf0qr0YQ18LwwjHO28w5cTX7p4H7FXaQ52imLd
         i6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EzFVKu3ifOlxGO3XRQxj82Z7+1W5sSE+/ss0IGOQds=;
        b=s6znXrJrScCDzAsjIXivLwgad8B0rJXrjLatkbe7DHRsCjxsYAz57sUzkePv9Vekym
         WNy0nKmK7q4P9iA9hhkiBJRXiwrCnHbivR5mFAtK9vS0x/3pTgId4La6uAHFuNYhck9c
         4IsR40uRV6sH7q6vohPEgN1K+WwDcppU+tZ2bUDLLkUWy30CR4X5AGNYuDzScVyBY9MI
         y+4WVXzkKaPABG3ZNTpAV0sROclYsuLKoc6s9Fg9I7aMHnQcre4slhWtHY2CsPRzElKg
         gdYABiKTp2aA0VB44ZSztMGbvps5NaoMOaXXUBlrULXrWK4JJ8C/VnuXLicn7Lyw1Jtb
         keRQ==
X-Gm-Message-State: APjAAAWncODv9tctbwparGjVjlpVyhca7zSCnhbT4FPr++ILQzt1SsOk
        +u1nVTdo2FDCvCyBezOe9l8JhGZw
X-Google-Smtp-Source: APXvYqwYOlTiuYWrkNFEV/s3wWyYtGwxoYkDjk0RJx6Iv+4VICUUP5li9YNqnqKl+5rZwqmnA1jYuA==
X-Received: by 2002:a62:8249:: with SMTP id w70mr17691759pfd.253.1576531918550;
        Mon, 16 Dec 2019 13:31:58 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id q6sm23951063pfl.140.2019.12.16.13.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 13:31:58 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH 2/2] contrib/credential/netrc: work outside a repo
Date:   Mon, 16 Dec 2019 13:32:34 -0800
Message-Id: <d22eb1f9e2431199f1b6bea2aefe8473284e966e.1576531851.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.664.g198078bb5a
In-Reply-To: <cover.1576531851.git.liu.denton@gmail.com>
References: <cover.1576531851.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git-credential-netrc does not work outside of a git
repository. It fails with the following error:

	fatal: Not a git repository: . at /usr/share/perl5/Git.pm line 214.

There is no real reason why need to be within a repository, though.
Credential helpers should be able to work just fine outside the
repository as well.

Call the non-self version of config() so that git-credential-netrc no
longer needs to be run within a repository.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/credential/netrc/git-credential-netrc.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
index ebfc123ec6..bc57cc6588 100755
--- a/contrib/credential/netrc/git-credential-netrc.perl
+++ b/contrib/credential/netrc/git-credential-netrc.perl
@@ -423,7 +423,7 @@ sub load_config {
 	# load settings from git config
 	my $options = shift;
 	# set from command argument, gpg.program option, or default to gpg
-	$options->{'gpg'} //= Git->repository()->config('gpg.program')
+	$options->{'gpg'} //= Git::config('gpg.program')
 	                  // 'gpg';
 	log_verbose("using $options{'gpg'} for GPG operations");
 }
-- 
2.24.1.664.g198078bb5a


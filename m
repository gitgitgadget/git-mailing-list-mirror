Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F904C2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FBE20866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBs6arvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfLTSn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:43:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38351 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:43:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so5363207pgm.5
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUS40UZ5F00ovcZ+niEj4PzC5yYCragUfzm1zDTFFR8=;
        b=PBs6arvTMb4pxH3q7aj/Z174bOvNmmTu/YwtKJspa3vQTY0UhFb9GGKC40SBhMttv/
         N/OglOM/mSXRc0jrGQ0WVsCnPezCRrA1B2Fr1fb8CpbYKytna+D2VOVa1SzvDxG89ETw
         odvAVP3FWvF/Cs3JyMjmDx7GTVeC3+Z9J98YKTS3D8lnUCRJA5HWvoh25RSQ9a3RWK8X
         CgXhb8LIzl1eSL4WEs9yyyFNswdiAY3wbXKRLCf9eXNID+RGBqyE6cirwSshIZjyyMCV
         YERCQNWbBDMOQrBGXOGBvWE9lMbxMApMrsR1IMmpMFPt4NM7cxCcgpZFSoYG45ABr+JY
         3VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUS40UZ5F00ovcZ+niEj4PzC5yYCragUfzm1zDTFFR8=;
        b=fmejC3x0M+WNfmXnW8uZZcpp4Qniu8xHd1ePNsGK7u3bA9kW0i1zQ6b26CWGBv76UC
         5GfR7j/2xa1MRhy4JZf7g1FtH/JVTVp2dMoy0Hmldbo45kFOlMDtsizYibSkovobrhqD
         8d5Ld23JFloPg9iDLksJWqEoLd5P+gbCjjlGXtdXB1NmL1eAuZBaSylkFeBRGWLMKMlN
         LMAFg3Isf2Hnm422kfUrhl9wQSiNAWFjsGLnT5VRak5xLiBOYvpAj60AzfKwUBq7S6gE
         r+ySvXEqnzXQNsSTzbGH7qfgfTS/4xbk6OY2MXAbH7syMuODNRqcQaDkm1Oaki3XBuZJ
         S2LA==
X-Gm-Message-State: APjAAAW/PsMNxP78ivuSBJzPiYlfmCBYB6M4hAqBKozLA/dFo3rM2g1s
        GXtTfCALMCCC2rXmvM6X/11ienbT
X-Google-Smtp-Source: APXvYqxS31HcvneiD7V3SlsV7JhlJ8UXmkC3C/6LwDhG262KzJu/kAbPGG5gVdFrfQ691e9/VpL6EQ==
X-Received: by 2002:a63:5f91:: with SMTP id t139mr16146390pgb.185.1576867404619;
        Fri, 20 Dec 2019 10:43:24 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id ce15sm11403553pjb.4.2019.12.20.10.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:43:24 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>
Subject: [RESEND PATCH 2/2] contrib/credential/netrc: work outside a repo
Date:   Fri, 20 Dec 2019 10:45:01 -0800
Message-Id: <d22eb1f9e2431199f1b6bea2aefe8473284e966e.1576867467.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576867467.git.liu.denton@gmail.com>
References: <cover.1576531851.git.liu.denton@gmail.com> <cover.1576867467.git.liu.denton@gmail.com>
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
2.24.1.703.g2f499f1283


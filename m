Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28485C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F652076A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md1ds4kQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgDUNLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728391AbgDUNLa (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:11:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BFAC061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:11:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so155977pfb.10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPGXNRz08nd5NAQZZyjrUa9x/USDr2TA+UONIpWHaEw=;
        b=Md1ds4kQXnNlD8quzjG54Eus1jAuDmvmeZSLgkNkjDj4UIPm+VDaDh/89aChXtdcZ0
         PIt8kyxnFDYTDKLYYZ3n2eYni/SM94qAF83tVP9Zpgo1RzZkrybtTrodCod6CJQETL5z
         GZTUg0GC+kRWX6E0yEC1XPvAZ/3XlLKA+/sXt2hAfRSPFrx2uQ+gtgZ1J8u0a5EGzQRE
         iGfLGjBuS048MAThqyhA7b1ZgQ1+jgjz5z2sojOaHVIa/FjBraLYy/XwunYrjq+LYk3T
         Igtan9lyZzgRkkHokjtvCjnxZnX2GGTRlA92RVnKiy20Ia/Yt6KZ5MLSvjG7uBIGXB3g
         1vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPGXNRz08nd5NAQZZyjrUa9x/USDr2TA+UONIpWHaEw=;
        b=BwHnJFcJmgRStsJuok1mTMWthZrmjIcq5rrsWrUWWWhoKNekHTs4cnb9Om+HwNqHDz
         SRVn59NebpD8POXzS9B7RpeJ5OpMay4Zfcv3Y3wVxvubbeCvGoyr6U+tQeJEYE0vJiNh
         3aE5fvcCrpL5synxyHKVhRpW/90MLHQY3HXLyYDwC7Xg7EoC1do2dW0sd+vHHe2dRtl4
         b2hzPhRUOT7qD/91OG/uZFgqi4qX9Jv1axZdSHqu+t8D7uKvkaUhOJ9Fjryg5oKqJDqx
         p0A3urVUIBvbQLb7sCTaRz10ojqpryn0iiMUAxZYEGbmgi/l/Fg4numASvrE5zeWXOVv
         pkQA==
X-Gm-Message-State: AGi0PuZv7RBIING8VUU5h3/lsByTCbiYVL8SCqXyl6za8bv07k5+TFrs
        F02Wg0dURu06+jUd/YXNpX4JibL7ws0=
X-Google-Smtp-Source: APiQypJWDu2s7oKccBY3/Dw2KgHWlSj+QRJfAXSO7e3xiNRs6uQ9Xph43SUn7wjAjW4lDs9aroHl2w==
X-Received: by 2002:aa7:9484:: with SMTP id z4mr3080739pfk.144.1587474689267;
        Tue, 21 Apr 2020 06:11:29 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id i8sm2529422pfq.126.2020.04.21.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:11:28 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3 2/4] gitfaq: changing the remote of a repository
Date:   Tue, 21 Apr 2020 18:41:10 +0530
Message-Id: <20200421131111.29201-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421131111.29201-1-shouryashukla.oo@gmail.com>
References: <20200421131111.29201-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
changing the remote of a repository, covering various cases in which
one might want to change the remote and the ways to do the same.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 96767e7c75..13d37f96af 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -244,6 +244,37 @@ I asked Git to ignore various files, yet they are still tracked::
 	category, it is advised to use `git rm --cached <file>` as well as
 	add these files/paths in the `.gitignore`.
 
+[[changing-remote-of-the-repository]]
+I want to change the remote of my repository. How do I do that?::
+	A remote is an identifier for a location to which Git pushes your
+	changes as well as fetches any new changes from (if any). There
+	might be different circumstances in which one might need to change
+	the remote:
+
+		1. One might want to update the URL of their remote; in that
+		   case, the command to use is, `git remote set-url <name> <newurl>`.
+
+		2. One might want to have two different remotes for fetching
+		   and pushing; this generally happens in case of triangular
+		   workflows: one fetches from one repository and pushes to
+		   another. In this case, it is advisable to have separate
+		   remotes for fetching and pushing. But, another way can be
+		   to change the push URL using the `--push` option in the
+		   `git set-url` command.
+
+		3. One might want to push changes to a network protocol
+		   different from the one they fetch from. For instance,
+		   one may be using an unauthenticated http:// URL for
+		   fetching from a repository and use an ssh:// URL when
+		   you push via the same remote. In such a case, one can
+		   change the 'push' URL of the same remote using the `--push`
+		   option in `git remote set-url`. Now, the same remote will
+		   have two different kinds of URLs (http and ssh) for fetching
+		   and pulling.
++
+One can list the remotes of a repository using `git remote -v` command.
+The default name of a remote is 'origin'.
+
 Hooks
 -----
 
-- 
2.20.1


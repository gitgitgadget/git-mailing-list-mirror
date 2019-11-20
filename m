Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCBC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5811821D7A
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4YTUTmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfKTJwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:52:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40871 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfKTJwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 04:52:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id y5so875828wmi.5
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 01:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ik6a5XMBhVJhNb4V0CqnL4v8EzjaBP0E0x/XUALEA6Q=;
        b=c4YTUTmOZr+OSXMqWIz//9T/qkr/9QUyycppNiUgEM0yx/UUfOPT72ilfDagsilC7Y
         iVqWE8LBanZK1BrfdbKcdR6TY8iOiu69j4U0Xwnl9mo6aw3issG4e1Yq5vhbv5274ZX2
         G/HXAvegvyQOE5fEJp1FC+IfMTZ9Dyi+Wf2c+bxG3cR+qqUdN7vzr1fj9xl19EKEjfCW
         AIXpVhGWde8mQZeQz/7hVLDS9RWrj4Df0GHzRDuAa4Isz9B8o4fh1VnoNisW4oj+f0rI
         NCxhysU4oGmhESj6dNXz/elKgy8BE2fmD6my+ohdqyma7iTuEag1RljnH3J+SulQ12ak
         HGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ik6a5XMBhVJhNb4V0CqnL4v8EzjaBP0E0x/XUALEA6Q=;
        b=oHixHY7H11QDP3JzXxQaPY5Cnjt4POayfdPVTJO7JpH3aKUREi0RC904HbfuY/ZQGU
         zsWSZvrqB/GZcITzBk3kRwG8hg6XAXXHjNQqZZP3uA/LSh6DiHKoPQDPFdYS8QjwQpAQ
         rcmaA4tZLqAL6xMzZMnJ7F9o7x0cEZLUVIbjzgi91ewVduUzjMEktFQbcGJb6lda77HS
         9QDo8xqnfJkwQY35YAM2z+DPDshz25yMnAQob+cOnLPwbIs2YlFTpZLGBEe0co4qNKGT
         7mlQaOlzBiRiW/VY9denHWLFOnTlWEPp3JOMq4E8veqWcvSTk7n+bCbunrvTfqNMAXHB
         yGZQ==
X-Gm-Message-State: APjAAAW1B5o+5GvDtu/xKIFZi0I9vJo8BQMiUqVX67IAoALxHFvrdBa5
        0sZHRljSfPpsQ5CeDf2MF7oy6fmhzcCO9A==
X-Google-Smtp-Source: APXvYqw+ix6hdpyRQ/MPdZDlblp/boUl/jjQ9onFOXvvizfaxR2yaEuSNpMdt3GQ9XQK2ZrH2urv+w==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr2045617wmc.121.1574243562804;
        Wed, 20 Nov 2019 01:52:42 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id p25sm5992516wma.20.2019.11.20.01.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 01:52:42 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        predatoramigo@gmail.com
Subject: [RFC PATCH v2 1/4] builtin/rebase.c: reuse loop variable
Date:   Wed, 20 Nov 2019 10:52:35 +0100
Message-Id: <20191120095238.4349-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191114163549.7648-1-rybak.a.v@gmail.com>
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Variable "int i" is already defined at the top of the function
cmd_rebase, so reuse it instead of declaring other variables, which mask
the outer "i".

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 builtin/rebase.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4a20582e72..793cac1386 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1747,8 +1747,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (exec.nr) {
-		int i;
-
 		imply_interactive(&options, "--exec");
 
 		strbuf_reset(&buf);
@@ -1769,8 +1767,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (strategy_options.nr) {
-		int i;
-
 		if (!options.strategy)
 			options.strategy = "recursive";
 
-- 
2.24.0.windows.2


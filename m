Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7072C43460
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C9661059
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbhEQQo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbhEQQoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:44:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD3CC0AF561
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p20so7860317ljj.8
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OfjDCFK40CHYWc5u5uSaXiZBcYaZsJ1ZH5HBXLLJ+Y=;
        b=ufjR+iPGgYbF9XLoQ9os3K8efHcFbek5e6rDZUvVlQkoWdVtRSdwx1NMscxuIoxkR5
         A76FkZTeeKDXgeMxLdg/eR3wKBEkrrsdqm0+lVuPK4na/JGsnyT8d2lZXwr+KvQg5IF0
         hpVShE1fwsAOs73BaBGJirbdbPh1zD4hHVTOFLjNxEhxrXxQIYl7rxLjF8kP7AS2tqf0
         e01LVebqySpqly7Nyno2xMPA1vYxhUsngNEwRal1zBw34fCBTTZpE/HbmfzSAALtO+4f
         mP54g+WhVLeAK6VyJDqkwSM6gqQ0rwpcyhP3dlk7FhcGd53bmL7vwTBXnLxg+FBW72RN
         QwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OfjDCFK40CHYWc5u5uSaXiZBcYaZsJ1ZH5HBXLLJ+Y=;
        b=C23k0qX4i3i9SNZB6/EGPPr5DjvkqgZv3UjGXiN5e+ixiUnrtTNOsd6bYyGIkgbNGC
         SX04MgQmMdJ6RnBi8ZEIyVCQItGfXHF7o/0QAGc6p9VJKzwPAfogMW33IpxWRUI4IYnm
         td4Jas9OpA0O9CgfVqV8UJYX2BOceLsP5wTH+bwC7JyW3aw9BONqgYacq/FpnEIdS/4P
         6E2Wk5nuoRTlo1MB1GyrsNI3c7fAvHJNuf5bH3oppvcew0aILGJB3BkoMaLpmoUBNGaN
         3xP6/rrMRLmBfkPZJR1Hfv//mNrd7MAkjklIULnzjwTw1HABekuhfypqOrBwKo00040+
         9vWA==
X-Gm-Message-State: AOAM531y1yn4ABc+BrCbmJLqn3ddEYVJ5mht8vUoBAdWQ+wwIva9bqbR
        aCD6ynNx3SIxCu/Vs5fWGTA=
X-Google-Smtp-Source: ABdhPJyzJteJP83FGbSG+GAQgTl3tqsDTebWUklNaJk8BRzuMNFpAQuWtFWRN+1svPb3iyUdGBmZqw==
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr99311ljh.191.1621267123897;
        Mon, 17 May 2021 08:58:43 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i8sm1996834lfd.12.2021.05.17.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:58:43 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 6/9] git-svn: stop passing "-m" to "git rev-list"
Date:   Mon, 17 May 2021 18:58:15 +0300
Message-Id: <20210517155818.32224-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210517155818.32224-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rev-list doesn't utilize -m. It happens to eat it silently, so this
bug went unnoticed.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 perl/Git/SVN.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index f6f1dc03c608..35ff5a68963d 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1636,7 +1636,7 @@ sub has_no_changes {
 	my $commit = shift;
 
 	my @revs = split / /, command_oneline(
-		qw(rev-list --parents -1 -m), $commit);
+		qw(rev-list --parents -1), $commit);
 
 	# Commits with no parents, e.g. the start of a partial branch,
 	# have changes by definition.
-- 
2.25.1


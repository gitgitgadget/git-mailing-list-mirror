Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8B71F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbdHMTgl (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:36:41 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35036 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdHMTg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:36:29 -0400
Received: by mail-it0-f43.google.com with SMTP id 76so13711627ith.0
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=LDPklrJm4abo47NLadeka/kUmMCgXb0BgyRQA3/Ilkk=;
        b=GbrJjxGD+mn9C6Ak9cPp87xVk/kFlIzMD3v/A2+3c1Z4XTXMcKuKNp53+JeyrY2nGu
         bOrr9zb7eepi8e6UFZwoTDCmtuUzBVLU+yHkOMCHRelYme3H5P7Xdc7g7dQSt4L0xQDn
         QwFS2otd1S/1bFefCoFyMjbvVTbDuA5FZ9PssO7NhjVxJy+Z9MpBt78RXnThGXRjSOp0
         X9LM/sBpPTq0tluP+fs7WJlbzeam9ztJ2MionqkKn+Oq4+mkxdbhWSeTlYXAvBDEZXzO
         zXxTcafP1xdOXMZ7O4rYYk16rCahmFBNbpSskavuAdBYlVZkGW2nqd8M2kZRsWzPetme
         Igyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=LDPklrJm4abo47NLadeka/kUmMCgXb0BgyRQA3/Ilkk=;
        b=W8iU+cRUHFc6n/8CNysmC5DNg5RczNl34iVueJ+MNRSZzdOlq2uzLlcPg3TnYrbwzd
         3Z28s5DzTchGngQ4lmthndqvijVi835Pw0Xz7K7maTFEJyKrY9aEhBrMdQKl0qlP2Dxk
         Qz2yGhHu2lDvAgDuEcPaOldWAA0Kd1BAvqWfPWNESS/1n4LvazvRGIUdy6b24sEkDfDO
         cQ3/+PknUXIAv+n8/8wpP0PTOgGXT+OgwJ1QTRD4g7paPAPy+IndpncITcNS0VtDp0Ue
         WXTPc+vCwGcFhnrX0DV4h0RNPPnBspvBWUe4VNecv2BZyIUSAZGuajtE3malJCofUHsL
         Fq/Q==
X-Gm-Message-State: AHYfb5glIfHL4TUkMWa4h4HOp3OUcv4mrt5Nuleo6uCTpZbu/BiixNmY
        1ubr0norR1E3BE21lD4=
X-Received: by 10.36.14.201 with SMTP id 192mr3708802ite.81.1502652988474;
        Sun, 13 Aug 2017 12:36:28 -0700 (PDT)
Received: from localhost.localdomain ([192.252.136.182])
        by smtp.gmail.com with ESMTPSA id s66sm2045678ita.9.2017.08.13.12.36.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Aug 2017 12:36:27 -0700 (PDT)
From:   Richard Maw <richard.maw@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/7] Treat namespaced HEAD and refs/bisect as per-worktree
Date:   Sun, 13 Aug 2017 20:36:09 +0100
Message-Id: <20170813193611.4233-6-richard.maw@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170813193611.4233-1-richard.maw@gmail.com>
References: <20170813193611.4233-1-richard.maw@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 refs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs.c b/refs.c
index 2e8bace..9a3dcfb 100644
--- a/refs.c
+++ b/refs.c
@@ -536,6 +536,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 static int is_per_worktree_ref(const char *refname)
 {
+	(void) skip_namespace(refname, &refname);
 	return !strcmp(refname, "HEAD") ||
 		starts_with(refname, "refs/bisect/");
 }
-- 
2.9.0


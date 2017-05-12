Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1188D201A4
	for <e@80x24.org>; Fri, 12 May 2017 05:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755324AbdELFEH (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 01:04:07 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34356 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdELFEF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 01:04:05 -0400
Received: by mail-pf0-f169.google.com with SMTP id e64so24309023pfd.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 22:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f5TugFO/JH0LvaT18kLHFF+p717MUhXi/P93zV6pFDs=;
        b=so9FLeJ3v+qz04VvW7R5vE60fIHJXmrXNLVGSUpZIrRRZSBzvSCsixzSAPbvW3LlsG
         gOecRJ9ePDatb/g8IEvgLL0x75WRJWcNOnsRrUYrQH/OPj0T3Bm/yoZ1M5TnoA4JhLCR
         YocljowZjwI1pvM8YyU7g1HN92LCX/K4z7T1bIn16IE5Miq//ZRZZj4pioNvhpn7P6Zq
         +geKbCNqKOxa3W4jti3bpwMxSaQZMXZw9tZjb9i3b9x01gmKClEz81yvp60670cXU108
         sj43Wk5K8YGjDDsAj6alzuFT4UmQKptqhFeY3ST1KbQhYHJxmBZJcJdmFnbS9xiY57G9
         yNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f5TugFO/JH0LvaT18kLHFF+p717MUhXi/P93zV6pFDs=;
        b=W5dEBvEr4m2UHi8jNsY07h1QUU82GQlQ0GAQZkGDIFkF3hVPzd8C9Tcs6QS0ND+G7c
         SpXv+1q+7REuggJPT2hKxRjzK3pcXf1j006UgC8rCFzCIs1Whv6DpeGqJ+nLSU/zSY+U
         PWduKp1nMMp/CVAjmQCmc0A+7zCR4tQdManE11lh2gjnyAlh2MqOKfu8t4THWu7hiSYO
         Nb7aLs5wb13LFbG7pSRL1PHpChu3cfiqsEXPbe8nvtrOf4qLTXiDuL8B7yTA9vHsXXGM
         U+SCd4NGn00lMl13Qx8DM+45qxDTjKSUMMJsXNhS7qEa9LoWPsWcIrHen3HHQcNgA3cw
         aXhQ==
X-Gm-Message-State: AODbwcD8+DWNOV3eyd3kCtR6xKoODJxzEGckZ9XFBmTWM3jEpigiZ9bK
        aKaFoF3oe43w6d99DBo=
X-Received: by 10.98.158.136 with SMTP id f8mr2429937pfk.90.1494565444897;
        Thu, 11 May 2017 22:04:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:ad55:5f17:47e6:6202])
        by smtp.gmail.com with ESMTPSA id p3sm2747654pgd.36.2017.05.11.22.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 22:04:03 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     git@vger.kernel.org
Cc:     Brian Malehorn <bmalehorn@gmail.com>
Subject: [PATCH 1/3] mailinfo.c: is_scissors_line ends on newline
Date:   Thu, 11 May 2017 22:03:45 -0700
Message-Id: <20170512050347.30765-2-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.3.g39c96af
In-Reply-To: <20170512050347.30765-1-bmalehorn@gmail.com>
References: <20170512050347.30765-1-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Needed to work with git interpret-trailers. Since "line" is, of course,
a line, it will always end with "\n\0" and therefore we can safely end
on "\n".
---
 mailinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index a489d9d0f..eadd0597f 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -661,7 +661,7 @@ static int is_scissors_line(const char *line)
 	const char *first_nonblank = NULL, *last_nonblank = NULL;
 	int visible, perforation = 0, in_perforation = 0;
 
-	for (c = line; *c; c++) {
+	for (c = line; *c != '\n'; c++) {
 		if (isspace(*c)) {
 			if (in_perforation) {
 				perforation++;
-- 
2.12.3.3.g39c96af


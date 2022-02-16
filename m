Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9EDC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244948AbiBPABl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:01:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244957AbiBPAB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:01:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F41CA70F
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w11so671895wra.4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRfel5+8I9LxNpEDWU+HQA0GJWuWacY7wBorym40v88=;
        b=aoJqPh2UlpWnRTBka+ohev2hNQpLrxl0xMIljsei0LtRcn0TN6GTNTuzhECgn9W96r
         CLJnrYcKl1K9mYp/UeYlOmJ3qxiq5k8CL6ag/1PHswKXzRw1cRKwWeKBQ8ts8fpdXq4Z
         a+xxqiaCBPuk8MPYsWTfov2tiD823lQFXReIG8BHHNeKcihFSFXDQ7rSwoF5/tTLYJHD
         MokBLqegOyLQ4cltEtSR8pgQisn9VUOUnHVLy5K32+pa9xft/6znSxcuDU639MVeZ/Ib
         JLJdtRvb42BIUQhtCgGhorEj1LHMrJqG9PWQ5cQFcKNUWDmEZhc5gO1+w3ejZpi27a4t
         fZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRfel5+8I9LxNpEDWU+HQA0GJWuWacY7wBorym40v88=;
        b=JAcKTCkj0Q3jAWbHfs8uXXzxjopzZDz/pV/RlalOagZ/7ethW8tg4rnndIZLxWBa/x
         V52oDZLwYyLJwLZGYXTVbhP62VLeNoA6sGYxJO1SQFWN24Uz1kW254RdVbRyt0YGtlT+
         pblYkyNXjPLd8dtF8yeU1CAOjgxn1CxW42FiIzjz0wFua7j69WQZ+c+M+MdyB4RWJ6jK
         nQ6xbjIoezSqb06iMjSwXQ8knW1bPfcZW1oN/qZIMW/pK08IY3UGVWhrCFk1G+Y73ksr
         A2rnV4TOExvm4vXFk2QZrjsTOEImRmSXlxxc0OJN1TZOgaO00TIfvs2AWyvHjpDHiBTp
         GCvg==
X-Gm-Message-State: AOAM5329fNN/Ut6GjlZD0LTpG/TI9yaE+Tfgn1defF9qayBDcvbZ7uLf
        0Ygpi2TzcdEGVEpSLNfjw9VofQ5ernMk1Q==
X-Google-Smtp-Source: ABdhPJxHufROzMcO0oq6ASsBT0130JFJ3bJVqakX3ZLvE1Y+N+ZzUalqvZg04VucT8IT6zQbv+14Dg==
X-Received: by 2002:a05:6000:180c:b0:1e4:a20d:1ad7 with SMTP id m12-20020a056000180c00b001e4a20d1ad7mr201318wrh.697.1644969674914;
        Tue, 15 Feb 2022 16:01:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a12sm17260542wru.99.2022.02.15.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:01:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 09/10] grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
Date:   Wed, 16 Feb 2022 01:00:38 +0100
Message-Id: <patch-v11-09.10-243ceccc1ad-20220216T000006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g9479bb34b83
In-Reply-To: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com> <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code in compile_regexp() to check the cheaper boolean
"!opt->pcre2" condition before the "memchr()" search.

This doesn't noticeably optimize anything, but makes the code more
obvious and conventional. The line wrapping being added here also
makes a subsequent commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 2f6a01c52a5..62f2595f68a 100644
--- a/grep.c
+++ b/grep.c
@@ -492,7 +492,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	p->ignore_case = opt->ignore_case;
 	p->fixed = opt->fixed;
 
-	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
+	if (!opt->pcre2 &&
+	    memchr(p->pattern, 0, p->patternlen))
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
 	p->is_fixed = is_fixed(p->pattern, p->patternlen);
-- 
2.35.1.1028.g9479bb34b83


Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A304C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B782071C
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 18:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFmk3HGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKVS7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:59:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43513 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVS7w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 13:59:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id b1so3723780pgq.10
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 10:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4YTFFMehZqLo1511T3jEEeu/Qr9J+OLe/i3aqoAnoss=;
        b=hFmk3HGttLIgU6oNMSL/ytl5/7JRuXtq15Ubpn59Jng14iL0fADSzgQwJncyoYYf2Z
         T9web6QrA2CaIuKVEklJ6gXsbl6K/kTo/CxtWYE2NbN/7e+NW1iW9ktpgr6Mdi9sUKC+
         Qn3xMnF8QB20dVfPM2A74gU7rYBzh7y1ggyr68yoDJUFIeHZogfL3ReHwgboorf58PQe
         lifYsPJ/uuFZcIxv4MpbqBkOiI8QJNggKuWMDotmxvymQcpXp4n+iOK00WD/RB00FyEv
         4J9jKYTZGQQZYIN8IXgJKNFoDiL/V8YOS2YHUBrAo8FwoE5/3mGIbaHsDO0lR6j+uG/4
         m2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4YTFFMehZqLo1511T3jEEeu/Qr9J+OLe/i3aqoAnoss=;
        b=RlZXjrtcajhKS0GISe+EKdSNxUtIbeEdIdjzst8NP7pGxi4EKHLfe4OhXUlccBCrHM
         v31KBq1MoH3VN1pXTi4NgccoCcAkCyWWx36rpfkiRsmfZJWZp/gmvedpnf3XIW9Ej3/i
         SFEWQljv2MGiuees3vic0wJ+WsoGB+ChzeMYl2XD9+7e+XLlOpxcfNj/c9GVY2bxd26n
         5/PXVDopMXvwtu3Wo4kLUK7/Tr/3lTrrTn5af74rITXrDqq8mCXVHDEJ8A1rUHuiS2+v
         oA731s9l93x9tdNI3Gg6vI4kM9ZBc8s6/WnWu1WGqH4vjyb1yEIknFW1jDOBppPy4tfu
         l5Eg==
X-Gm-Message-State: APjAAAU+OnxuwpINLeOjJZprzt9UHPknnC2nnq8xLbWU2Gh7k8e4GVfa
        hri4esWtZBuGDWNpwA+Xwbq7h2B/
X-Google-Smtp-Source: APXvYqy5ahO92LIJFjMIpdDL5ddC76JL3lyneitmoUXCTIMNMgbRUjMi/RNQDAZu4OWsK+xqSJ6SmQ==
X-Received: by 2002:a62:6385:: with SMTP id x127mr19991902pfb.244.1574449191734;
        Fri, 22 Nov 2019 10:59:51 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id a34sm7597154pgl.56.2019.11.22.10.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:59:51 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:59:49 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 03/22] t0014: remove git command upstream of pipe
Message-ID: <f69e5345ba1c1d7c3cc58fb14864b51e9db53030.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, the `git frotz` command would fail but its return code was
hidden since it was in the upstream of a pipe. Break the pipeline into
two commands so that the return code is no longer lost. Also, mark
`git frotz` with test_must_fail since it's supposed to fail.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0014-alias.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 2694c81afd..8d3d9144c0 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -38,8 +38,8 @@ test_expect_success 'looping aliases - internal execution' '
 #'
 
 test_expect_success 'run-command formats empty args properly' '
-    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
-    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
+    test_must_fail env GIT_TRACE=1 git frotz a "" b " " c 2>actual.raw &&
+    sed -ne "/run_command:/s/.*trace: run_command: //p" actual.raw >actual &&
     echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
     test_cmp expect actual
 '
-- 
2.24.0.497.g17aadd8971


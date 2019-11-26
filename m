Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7B3C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8082F2068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNVcozAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKZBRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:17:54 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:41125 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBRy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:17:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id gc1so7454262pjb.8
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r8wt0iElzEdlUVR3u3fJA/vaW3ImQKr4auWa7LRPo7c=;
        b=HNVcozAMUVF2LGDmoAqCH7HIFBCX5f++ayq5K44oA+gai9RdKSYsAp+KkRYMx8khID
         pJdLzlkwE8rXRenerNEpUV3CA+JePIveczOR4FJDV91oHFmn65XQiAMwx24nzXwhOxlM
         fmWfpiyrtYhUQY/pPjWalPaSrKklikaw4RkuL+XPDPt5D1papHnIfSIh0K5cI4FDXgD3
         iQtuX/GA0PVrGW8mNRljyMkeeJV5WhlKWezxe4gKNSr3/3IAH+3ecP1sjUv5GjR7czSv
         eOJ1O65md73Bn3Er0q9cMevaIvV2dPynoRa5Dtb93smpAtPB7gythiKymVK3yXFsg5dS
         Q9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r8wt0iElzEdlUVR3u3fJA/vaW3ImQKr4auWa7LRPo7c=;
        b=OCKjSm2EYvSZgnLwcU3KxawFBkHkjzAwKVhR/jFoXQDRhTQPjVndlDiLdK14eeWUoZ
         Bl1kmD5SJzJ6R4SQA/ukYseYOgkopZp4WduCmUKELIrRESeByeclBR+eufDKdnBhTYtB
         XZW/7GmRPa/DF66Otr9LQDnsX4CZUdl1P5yQkh0UyMmXpiRz5QQqAcAoPGL39MfQ+zRO
         30dEIGNJr2mFCVNwLqaf6HMMWvEmyOJLo1BPgFagNTQZ9c3aKJh0iqHa+3+j+it3wUDr
         Jrmiu01zdppIzXgq1gSOOdE/lr9cfp1ni7EXd/it4r9vhijE0Nn0l6nedZ0Tx8wbMPFZ
         E3rw==
X-Gm-Message-State: APjAAAUGXSdxMRoKcC52/3KJhxZphg8u4dxiLQLQQl7vqWir5qHC055A
        vw7vISbfolwugHWfMIagIrPiAJVB
X-Google-Smtp-Source: APXvYqyCEzMcbSzMdj/8NeDyTZFTCLZSiN0+Oz9VpkyX9bCUflTT7YOVbzKvKiMmSyZgri/5FO0ttA==
X-Received: by 2002:a17:902:8ec6:: with SMTP id x6mr31443490plo.151.1574731073411;
        Mon, 25 Nov 2019 17:17:53 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id y24sm10377414pfr.116.2019.11.25.17.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:17:52 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:17:51 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 03/27] t0014: remove git command upstream of pipe
Message-ID: <3844e00367de57ec09b1e3282280fd20dd807c0b.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
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
2.24.0.504.g3cd56eb17d


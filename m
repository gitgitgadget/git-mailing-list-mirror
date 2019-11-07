Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AFB1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfKGSva (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33008 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfKGSv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so2162080plb.0
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=olVodVSAYEvL08uENA+7uUiU4nLw+LOIVLFg0xxOF84=;
        b=NtzN5dCOUtNdcaPgh4EEbihZmGoAc/D12DrEIZWQRNDmuMjbpna1H8YBDG1+YFCCfI
         GAGgplAMtxmp/VDbOA0wgbLuqp2ESOsmhGucTgJQy0S+7u7KcgIP2FFE7m9Crn8kIt3z
         Qgg2sNuBunGA31rZu5At71rCucVNcLecHWlulcju/Enxp40yc6vyGxtJhYc7DmsVFVN1
         X+4OAEZ1iLjCRDuOWi31CEhjbTbgX3jY39G8F3eGQ2o9PzAcBlYGUvjcDT97weYFLiy/
         Apxr/yU81gPhWugrLCAN/rlSsDvtCAEeStB+mt+RUWnOj1WsabTnB0pAU3Lwba7XNb2S
         28rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olVodVSAYEvL08uENA+7uUiU4nLw+LOIVLFg0xxOF84=;
        b=ravyOX2Pgt+KTHXQTHgF4vhseTgmcaM2eUEqnXlXhefsnkf1JER7vP7nZf0hJtQg1X
         /6zLf5MKWeBXJXvPQdI0umfN1zoCwYLAOVYHZbpJaoqeEAkl3ucdUSu7MXFd2AgRS05H
         JjA3K+PfTHSsGCEKe9OfWBq0eiir+KIQcM8EC5j79+0SzVSMXrEahepZanXx+95GJkv1
         QQOPocm3yxMYNE73GCnLHQbX07B7pTcjEz/39iDuYa5fBkgIsuPWZmLTD1hDxblBrOxQ
         N2x1eYzFryRj0AeH3YAsT6OM93GGy2fXPdAXyqImJZOcd7gooyT2M7cMDOW5WWs2uHPD
         0N9g==
X-Gm-Message-State: APjAAAWH653TUfOAUcg7e4RzDkfUfzLhKd6wYq31lbKAUYRzzF0vOnFF
        jHTr71qbrxjl6+cg9qepb1LSNtq1
X-Google-Smtp-Source: APXvYqxc/Dk99cjdgRM9hFbkkRSCok5rT3x2ZswaPilJIIVy88Jsam3kolWbZPb+XGGqmhebGL7j7w==
X-Received: by 2002:a17:902:467:: with SMTP id 94mr5347461ple.170.1573152688692;
        Thu, 07 Nov 2019 10:51:28 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id q199sm3152535pfq.147.2019.11.07.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:27 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/14] t5520: let sed open its own input
Message-ID: <d09b59125069eaa9e012e996ed19326606163a1c.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were using a redirection operator to feed input into sed. However,
since sed is capable of opening its own files, make sed open its own
files instead of redirecting input into it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a3de2e19b6..55560ce3cd 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -5,7 +5,7 @@ test_description='pulling into void'
 . ./test-lib.sh
 
 modify () {
-	sed -e "$1" <"$2" >"$2.x" &&
+	sed -e "$1" "$2" >"$2.x" &&
 	mv "$2.x" "$2"
 }
 
-- 
2.24.0.rc2.262.g2d07a97ef5


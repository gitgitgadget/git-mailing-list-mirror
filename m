Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852231F770
	for <e@80x24.org>; Wed,  2 Jan 2019 04:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfABEhb (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 23:37:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43428 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfABEhb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 23:37:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so14033470plb.10
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 20:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tirfwoZRi+TWjoSJF5OV6OF8Anl6V3eevpYRuQN1FNo=;
        b=RncxPpk/kkXm94IDpjDpJGSYaKXKJUXTCVAzQ13H1YaXNqkQlUCit6AUa8ABg7nPT3
         qqdFHqRpdVZLIBgcuw41UHd6VK1zUpN95Aepvuhc/WEnvBiC4BvjV6Z3vwDkAfQXUDev
         NAuHOHSeMplMB4Wy3I/YBo0WKL8vqxH8ULvPppRY5+nJGWcM41r5yq75xln9hUzD4wtN
         P5Z6oP48RgJcsugeNt1HhgBcMfjm5vx/nkd8mcZDmtcoBFYH3YkssMioDI7BmY30aqXi
         qVuirE7oqT6RzpKc/AYD9BY1ZCgFhsiEwMQb3lPGTBBZkMvbayK268THrtIkldPN2lXO
         aNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tirfwoZRi+TWjoSJF5OV6OF8Anl6V3eevpYRuQN1FNo=;
        b=XwkjvMrPKEj4/CmxkOV8wSphdIi8Dzax3Pbt6DCGr3QLsin1QkwebDzYZvyC8EZhif
         djmb8mgow6ZTbeWPlKBrbH4DzPDchkTIUyEN/l7hkuKTQxJaMz0wJJjvxHu063t4e+R4
         FiQb/i97ZbKze9UoJ1KBj2XbtKVvsCCQZ3oVgtvWvXaHRry9gVVPVPZSMcsn2DqzdMGk
         LKpRBpDsiLPStqDVT7Acytt9jJaAKEqNRGGSaO9mcAJz/f+sh2sF2MKLWKX2DB8t3xDL
         nKecRmgb/BsmikD7yFLPzc2KSJoyvwm/3ZLtaNrLtQwJp0ngpgGfGjik158vgX+ym/Ee
         JZ0A==
X-Gm-Message-State: AJcUukfQS1fwnfhF7roLgu7516GtwXs8O5xjtq7rnRvAasZzfiOxeHJ5
        s7MqMdzI6VWlW6Nk1LDu3w4=
X-Google-Smtp-Source: ALg8bN6yoTplm/FO9lCu8lGyotQ/U/Ig4xRdVmcpOGP0Jc2Nz6x1evcm/QgoE0QFLL3jLXRYLHFN+Q==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3mr38191238plo.328.1546403850480;
        Tue, 01 Jan 2019 20:37:30 -0800 (PST)
Received: from GotGit.hz.ali.com ([106.11.34.207])
        by smtp.gmail.com with ESMTPSA id b27sm75904397pfh.113.2019.01.01.20.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 20:37:29 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 0/3] pack-redundant: new algorithm to find min packs
Date:   Wed,  2 Jan 2019 12:34:53 +0800
Message-Id: <20190102043456.15652-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.0.3.gc45e608566
In-Reply-To: <20181219121451.21697-1-worldhello.net@gmail.com>
References: <20181219121451.21697-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sun Chao (my former colleague at Huawei) found a bug of
git-pack-redundant.  If there are too many packs and many of them overlap
each other, running `git pack-redundant --all` will exhaust all memories
and the process will be killed by kernel.

There is a script in commit log of commit 2/3, which can be used to
create a repository with lots of redundant packs. Running `git
pack-redundant --all` in it can reproduce this issue.

Updates of reroll v3:

* Rename test case file from t5322 to t5323, for I see t5322 exist in
  commit 404dead121: "pack-objects: add --sparse option".

Jiang Xin (1):
  t5323: test cases for git-pack-redundant

Sun Chao (2):
  pack-redundant: new algorithm to find min packs
  pack-redundant: remove unused functions

 builtin/pack-redundant.c  | 181 +++++++++++++++++-----------------------------
 t/t5323-pack-redundant.sh |  84 +++++++++++++++++++++
 2 files changed, 152 insertions(+), 113 deletions(-)
 create mode 100755 t/t5323-pack-redundant.sh

-- 
2.14.5.agit.2


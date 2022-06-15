Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B26C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbiFOKgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242777AbiFOKgt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:36:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9150079
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:36:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so14778981wra.4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kK6nGUf644NOi1cwNv31rsBdlsEXyGQh5/2gg1Rm62A=;
        b=Ve/dxNnw2ikEjJ8Q2OvqfEyLcVj/y5zKKYpxIunfineFOEdLSJBW50aGPl8qhDTfel
         3BNNG7efcknwhXcaklBknF/Jdgha+Bw+nV05Zz7DZVje30rPuyz8g2HytvWlD4E+Lcnj
         3YvLtmaE6jmL0Bu9C2lmuea/GsciJEURYaGWd/C4bdBpoQSrPqSPaPlookMj1okCq9c6
         4WYaY32fJxeijhrCgMGlEBGt6wOWd1f22pniakDmquYczHEWdoCdMXFzeO+mI2wa5QYc
         tdjvr4BmJBwHSsQSFRlxanSX4/PCU4qZ+aWLZc2gFnV/vckKkKq4o17+8NERLpZr/MtF
         rsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kK6nGUf644NOi1cwNv31rsBdlsEXyGQh5/2gg1Rm62A=;
        b=mmhLwb4GqeT0MnaHcdcLQl5czox8Zbk4+eWHQrKbqIFv8HTaNhSWiFgYhQhLnBbGE9
         PqyIP++0r0UDrIHNdMgb+lEDLli/D+WLc9yxqQsZl9qJSiCrh9IHZjJ/rC1Kh+928tRw
         Q54H2TKS/kdlyQPl4uOymxQmpANawRutu1tnMPFJ/zTQoTD6yx9LdPy1T33d3fgObW4/
         FTuYxQ+EaGPb5IhcNYIhcqfkj8LztSJ78kkQzKpkL4dJXpWUpSctS6n5WOXtNwBcXI7T
         7izp4ZIC1CZ3T3lxnHE0y2SIUaY8D2CYmKqg4p9XRqy7SMQYsmE7WeBKtq35dbsC2RJ7
         zSRw==
X-Gm-Message-State: AJIora+Slsd5NawKYl1CIUU3eQDYht1TzLLw3ryjzhILH2rhuqsfmHcL
        xRWp3iAKLv8QJahhRNLjW1/yjaA3JGEjrQ==
X-Google-Smtp-Source: AGRyM1v4+gXnOoKN5B04aF7Xzephvpzb+aNYL7D/TrmsYcMf4fIXrBnnDMqP0s7jJh47xT7opF5kBg==
X-Received: by 2002:adf:f610:0:b0:213:b4e1:7276 with SMTP id t16-20020adff610000000b00213b4e17276mr9032243wrp.712.1655289405653;
        Wed, 15 Jun 2022 03:36:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i27-20020a1c541b000000b0039c5ab7167dsm1947810wmb.48.2022.06.15.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:36:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/1] For v2.37.0: fix tests breaking with NO_CURL=Y
Date:   Wed, 15 Jun 2022 12:36:31 +0200
Message-Id: <cover-0.1-00000000000-20220615T103609Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fetch.credentialsInUrl inadvertently broke with NO_CURL=Y builds,
which I'm e.g. spotting in my GCC farm testing. This fixes it.

Ævar Arnfjörð Bjarmason (1):
  tests: add LIBCURL prerequisite to tests needing libcurl

 t/lib-httpd.sh        | 2 +-
 t/t5516-fetch-push.sh | 4 ++--
 t/t5601-clone.sh      | 4 ++--
 t/test-lib.sh         | 1 +
 4 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.36.1.1239.gfba91521d90


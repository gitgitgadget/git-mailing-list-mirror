Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3886DC43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 07:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D297C221EC
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 07:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="DiZBZ64f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgITHsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 03:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgITHsg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 03:48:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50B2C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 00:48:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z1so9611204wrt.3
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 00:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kS5E+HQwMKvcPQuWK1ry2JOMu9NW1qL7UIKiWSTYfNo=;
        b=DiZBZ64fT6RunAhAlv3Ck19nKdAdwbO1Fbhr9w8qalL6nDL9OE26GchadNq5xkmC/+
         YkeeCGG/CJteeZNob5sN379OGH42MchQlisQ8tmjmMHPd3Z8MyzUW4biozPOo/Q4AkAo
         +DLYc5VapB8FpKY77WOvKf9ix7n28ExitlNwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kS5E+HQwMKvcPQuWK1ry2JOMu9NW1qL7UIKiWSTYfNo=;
        b=RCt547pgFdBiY3JnV8aWAPsXMlibPPtEZBiM2bjbjMMYnUCcaOn1ry729RL01vFS5o
         eK8eBppcmvJ8U3zkgc1KaElnhYm4Ncq/+ebw47ul0iFkf4+p/cN2KscKx+41tKCiIXkD
         utnnsb/ln+/K4Bd7c/42c6UKgkCFfyWlbF5u4ZPpJmNjlTJXTW+d3O1JBJxOrBCgbrc0
         VB9WAGMEe2u7lR9y2R3czw3ud1QnL/53jzcaa7DS2FCKez9nJmV+Q0naf7TPlApz5mRu
         7+iNHuemGHq3PvnwJzF/r+xj0+QqLLXrgj3aJkbMa/8rSvvGU3zHGr4e57SVuXl577op
         962w==
X-Gm-Message-State: AOAM533ylN1Tk0Br89I/svqpk9vREm6a9ai6gb5R5V37WXlUnWXjxAiw
        cUWfD5F6Q4NTlM+u2Bls0jXQY37i/mTaMQ==
X-Google-Smtp-Source: ABdhPJwFi8fQPJzc9BoSS6B17ZR5G1tGoj9c3iO00N5KSoYQ4Gr9Itim77REMRWvn4VymcIdEKmm/A==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr45235455wru.89.1600588113779;
        Sun, 20 Sep 2020 00:48:33 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id u17sm15140329wri.45.2020.09.20.00.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 00:48:32 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/2] git-p4: unshelve uses HEAD^n, not HEAD~n
Date:   Sun, 20 Sep 2020 08:48:39 +0100
Message-Id: <20200920074841.17043-1-luke@diamand.org>
X-Mailer: git-send-email 2.28.0.762.g324f61785e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated commits incorporating comments from Eric Sunshine.

Luke Diamand (2):
  git-p4: demonstrate `unshelve` bug
  git-p4: fix `unshelve` bug finding parent commit

 git-p4.py           | 2 +-
 t/t9832-unshelve.sh | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.20.1.390.gb5101f9297


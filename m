Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC894C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3E9613C3
	for <git@archiver.kernel.org>; Wed, 12 May 2021 08:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhELIqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhELIqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 04:46:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709E4C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:45:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z130so377760wmg.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rY+OFnOt9xQ+4ucgoGZ5qEIvsTFJUAc7B4o92DHjUg=;
        b=eMS2Ocb51ldCXULpuSgvahq65LM1mrrNzhLOxyxNGkaRQPDRxctqs125Fbv5FTJkAY
         Ucc9W8+YBqZht26H/fJeqmO58KNxEbZIo0J8+fUF6UmLkRLhMTWeAw6uZTGqkZSqtVvS
         qjqVd76xnIj4n38XKgdybK75MaiIZmEkS18h7U5FqY5VXAlraBP1DPdqLMHQ96LA4Skx
         Ce2+ON0712jAIISClsS11jvtdDjblb/4kHdvWMNfSb5xgZTSyjAtAh28aG/ycWqk8SSW
         l9TfrBHGypk0/x9Ugwph2USrxPMsVjglcCGnX91YD2dS79iLQN6LMY1Oe9PX+LaMRr+D
         oJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rY+OFnOt9xQ+4ucgoGZ5qEIvsTFJUAc7B4o92DHjUg=;
        b=bq3dDD7pEXytJ0rZXH/xak5iW1IvrynI9Ii+s/1mM175t8h9c1hP2RsDxJfMJeGJJq
         5p+Dxumlu4fYouwn2hgA7I1XocpjUOB6LR1gyMj8hVkLxrP1DGTyeLEqIpiMcGCC1lCj
         KA8siMPDBZ93sKE2IePYTyskW1PIs5ZUsHKbeP11nFYRa0TUbRHerNW7MIdUAZr3ScBB
         Ac4eJydV71sqgiySAwpQe8Y8kf3G09rJxSE8BwBYBrroh7O7vSAn5iN56ac8pQooO6OB
         qHHJcO4ltn5O/oG9vS1uHVk6R21bVzJ/UGfSRxiBHlDUwdrzeUltlk5MkPT701TUG3EP
         7Zqg==
X-Gm-Message-State: AOAM5331l1+Ov/49dAKnRxZDBBWTgRZQ77CeaS9zU/e4D3WJdx4l5Aap
        flnTJ5Nz3Zm2qBh2iH7WWNLM569eh/7+5w==
X-Google-Smtp-Source: ABdhPJybCyE9X4gUxXGt0SC5rfWj9bNt64j2XorvNi2U+Ywn+m3U4v/da+zyGdJ23RH8nAr30Qmf7w==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr19968768wmh.186.1620809107375;
        Wed, 12 May 2021 01:45:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p17sm30284051wru.1.2021.05.12.01.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:45:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] SubmittingPatches: a few unrelated minor fixes
Date:   Wed, 12 May 2021 10:44:59 +0200
Message-Id: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few minor updates to SubmittingPatches spotted while paging through
it the other day.

I remembered these when reading
http://lore.kernel.org/git/20210512031821.6498-2-dwh@linuxprogrammer.org

Ævar Arnfjörð Bjarmason (3):
  SubmittingPatches: move discussion of Signed-off-by above "send"
  SubmittingPatches: replace discussion of Travis with GitHub Actions
  SubmittingPatches: remove pine-specific hints from MUA hints

 Documentation/SubmittingPatches | 258 ++++++++++++--------------------
 1 file changed, 95 insertions(+), 163 deletions(-)

-- 
2.31.1.909.g789bb6d90e


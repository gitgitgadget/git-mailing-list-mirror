Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E05C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C4E20770
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlNx4EY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgKZAQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKZAQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 19:16:19 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A62C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 16:16:19 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f12so367941oto.10
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 16:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FsYVN8ctKPfKr8RaukzqakzdZVDwH8kKfhVjvlSa6xk=;
        b=JlNx4EY5PPgNM0bCOuCWRh70LKSP5CuXGA8fpV+nC1IwN7UwGKop73UBWm229kcZ/X
         QcS+yGxi3s2AEy8Owzcy8e0Sj8IsNNJljhxU2Kmh/5JXSHFXd97z29QbM3iFlsTfX4Is
         +78byiyDPqIk4/45ZY9WQvjhYPv+BtnWlDh9JG58P3GZUFFibSuCBMrbEzSkg5Tsed+1
         1YixfGPACbvqUCDT8aJFmdZ580ZsuNhnqvhGjfWxCRP3OD5H9AjAUaSSbZQh62avvFLD
         EOOC39zfbJWyZM8lgqoj3muRvwnBr1rVnARGB0YHPSGb+BIG6N7UuJUSTvZqySnT/GGH
         Hw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FsYVN8ctKPfKr8RaukzqakzdZVDwH8kKfhVjvlSa6xk=;
        b=HsfQlVydlGN33QiZtlR/PnRlALg3eQqoROo6yHjFvgG+oUU83kMK9iAfLB3YezmcfW
         nqkbmH52uj904cFHQcpzl5Kn/tjcMyp8YMKhFk9cMtcaVdbUGNM+17LA6oCEtk1Gfcg9
         4VTYBVBnmrTT7LpXUhVN6ytOngnt5u+sdeG5RO3EAk9hx3MWWmsIqdoBkrGaRJaNmUg3
         7eUhQDwuY/wLTHz4hQgQmwkgqZOzjSU2zpOsULrIHUNU/BbPHFsczqHnjiYoYZXI/pAZ
         uysMgd+9XB5SkU0IEM9z05p1rloKCAsG0snHNWMkwZR7hCEiqBKfv6vEdfswn8YPm0KM
         9Diw==
X-Gm-Message-State: AOAM530aUfMd1vu1n9pXoiu0lUpfV9i1Pp/yu3yo2Qe+khZ/nXmmVpGO
        aeecLOcJLoPywUFS4f4HqoZvWvq2CfVxIg==
X-Google-Smtp-Source: ABdhPJwUAo5pC2AFE1+KgTIQS5YoALSZmN7Jn/qIqhCCuDU1V9UK12JOMpNgAEj1h5b/FqpAHxiHzg==
X-Received: by 2002:a05:6830:789:: with SMTP id w9mr538881ots.243.1606349778599;
        Wed, 25 Nov 2020 16:16:18 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 8sm2025110otv.26.2020.11.25.16.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:16:18 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/3] refspec: make @ a synonym of HEAD
Date:   Wed, 25 Nov 2020 18:16:13 -0600
Message-Id: <20201126001616.663910-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Basically $subject.

Since v3 the body of the tests was changed to single quotes, as Junio suggested.


Felipe Contreras (3):
  tests: push: improve cleanup of HEAD tests
  tests: push: trivial cleanup
  refspec: make @ a synonym of HEAD

 refspec.c             |   5 +-
 t/t5511-refspec.sh    |   2 +
 t/t5516-fetch-push.sh | 106 ++++++++++++++++++++++--------------------
 3 files changed, 62 insertions(+), 51 deletions(-)

-- 
2.29.2


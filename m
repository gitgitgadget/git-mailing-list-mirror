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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B78C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3BB60FC0
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbhHMJPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhHMJPj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 05:15:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BB9C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:15:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso15127988pjb.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmMVicYJiL5YMDv/d5B7/Kjd5Tk+lMkmuL68Kuv4tes=;
        b=PoTjjZOse3CPbzGaAmqwbCMIucL9vtt18s3YCmDIdfEjVCGPgqg8dyYNQPXu59k2+0
         BUnZGKuGmIqUc1TVx4USxEsVr4igAlP5bDpjx7IiWUlc7TKnOz25sFm53ssY3upwr84b
         iEO+g8WRB/A+M4BcPZH/rIUdCsC+MwDx4rA2Vuw8sS2zRqeEc8LtvzvTQARAx6oxF5W0
         sPlbgzpdF9cYK5uJ/KEomRS7Ms3bb9++4p2y9P5B4tJA8vdg/OY5L0W+RTMT8OSy6O+T
         IjSGQrPuC3uW8JLcz2zRLs5w5AB420ds6qFr7/HNiuZfwDfAm0mGFP5bYjesv4oQYIjt
         bN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmMVicYJiL5YMDv/d5B7/Kjd5Tk+lMkmuL68Kuv4tes=;
        b=r0wXAcUpwTo+nbOjqpSKMLblAyE1PtrY2bsrsmTp/z/C18FCvcW1tRg1BALyw+YPVe
         0p1dtToHnmiiBUNx1yLOkpZjwRqfuDjZegsmdvgWDQSErvdnBjUS48qEtWDjmgK+wPN1
         UESLtZ5SHfrpXC5HqkkDRqbIsOrqZJrY1r+n6Jszlp53rlr2bdyHAx7kGYK9M3+0DuSN
         eCzgVTP5jIzPmcgComABeUTzlZlqw1cyT0INfheCkICnfuApaWzAWUBJFasHZU5OBcGX
         6PghJ85aYk++G1zFoAWkIt83XX4bnQBXm2VTGf+lELDk8J3Q5UCKK9+YjDegJin/q5KL
         zArQ==
X-Gm-Message-State: AOAM5300nm0uyhnZU35isinOVbervoFYqjlPlpa/kfltM+zJMXALtSoN
        /HBbwaQy35OnoyGmV3g2L2Q=
X-Google-Smtp-Source: ABdhPJyPbNBmqLk7prlT0C+34k5Rj74saG/qcMKjJ6Cc8QB2BwhEGRrJqiTJwqBPirxr/eQKbg1YnA==
X-Received: by 2002:a17:902:c784:b0:12d:8258:bbb0 with SMTP id w4-20020a170902c78400b0012d8258bbb0mr1286268pla.18.1628846113101;
        Fri, 13 Aug 2021 02:15:13 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.158])
        by smtp.gmail.com with ESMTPSA id p17sm1286968pjg.54.2021.08.13.02.15.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 02:15:12 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, avarab@gmail.com, jonathantanmy@google.com
Subject: [PATCH v1 0/3] packfile-uri: http and https as default value of `--uri-protocol`
Date:   Fri, 13 Aug 2021 17:14:53 +0800
Message-Id: <cover.1628845748.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.1.g0de8fe24d1.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The origin is from the reply by Ævar Arnfjörð Bjarmason:

    https://public-inbox.org/git/87a6m9ru85.fsf@evledraar.gmail.com

Teng Long (3):
  packfile-uri: http and https as default value of `--uri-protocol`
  git-pack-objects.txt: introduce `--uri-protocol` option
  t5702: `fetch.uriprotocols` is configured without value

 Documentation/git-pack-objects.txt |  9 +++++++++
 builtin/pack-objects.c             | 18 +++++++++++++++---
 fetch-pack.c                       | 13 ++++++++-----
 t/t5702-protocol-v2.sh             | 23 +++++++++++++++++++++++
 4 files changed, 55 insertions(+), 8 deletions(-)

-- 
2.32.0.1.g0de8fe24d1.dirty


Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79684C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4973A207FD
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzPSJwzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfLIOxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:53:53 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34671 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIOxw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:53:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so15826926qtz.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 06:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g+guVruWdCB88X7ZJj/qIOfc53dCox6YIxlfPfohEr8=;
        b=dzPSJwzi8pGVPRLIHJlC/BIzDupVCfP1+/kUquVvPt+m/plYjAJ+HrArBa7aNKPyLG
         L7U/Lg30KIHWW7riV2CkKIPIsv2CWb8+Etym12481DWfcFDGL5n7kijwEU+gw+wseL2L
         zkbJiRyABRPFZlBRKDV7LXchHZHLuxyKpCPcPApo0ydORkSA3C0LT0u7O7cTKB8fFVb6
         F440W678AcKamotaaJYP1Dp/xmDaBVu98WtKU5egeSKIlMI/oFkqJOA2NXWH/eMPCS3b
         3a8KJkNavkG2cQk5GL6cycdKWxTCiF16JEkHAxQqyoPN4yicVAomRDV1hNdj1DuC4MHc
         ox9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g+guVruWdCB88X7ZJj/qIOfc53dCox6YIxlfPfohEr8=;
        b=ZJdIBqqS/7WGtLmNwzUKRaunEd565dMwHlIpTsNtIukXOJoZlVB9l2iOJzqY1niBBQ
         hE5CqmXSQ6P1bqpcIHbM7BspKnyhCTa6M65iMRFJDPj+vigPDiAYHC+IbCdi3hE/Jbma
         nslsII+0sUYDiti3lG75pgKMhHktT33J+OefV/HR6sPXubEqksaAlatjrvYK7T8yqcJx
         eAlw8FhqUVEAuzhVogY9Kc4oAjCk0/Xso9Xw4r4Ft+FGU/wg6vRFmX1JbwlLsIS8sUQ4
         Wvj9HQSU7PK5UqgldIL7iGlzkCkuH/vQe0y6ZZ3DZy5T5NLas3B/cEm33vZbS4JxTW7a
         QKpQ==
X-Gm-Message-State: APjAAAUSSYnyT87/VsPLu1ifSOT76FzVHlUEtwQDFDvCQyOo1M5AGMG2
        qoWhWkD5QE82/VIm/+wbihcolaXpVKM=
X-Google-Smtp-Source: APXvYqz52/964oqJC1kYiCZj4MPzUbe5yBclnSV2hwQkzz+INZw03XF+JwT4oHuv/PUBkt1OKVEudA==
X-Received: by 2002:ac8:330d:: with SMTP id t13mr13746198qta.379.1575903231375;
        Mon, 09 Dec 2019 06:53:51 -0800 (PST)
Received: from alex-torok-7530.int.uberatc.com ([216.99.208.253])
        by smtp.googlemail.com with ESMTPSA id 16sm2367855qkj.77.2019.12.09.06.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:53:50 -0800 (PST)
From:   Alex Torok <alext9@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Torok <alext9@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v3 0/1] rebase: fix --fork-point with short ref upstream
Date:   Mon,  9 Dec 2019 09:53:11 -0500
Message-Id: <20191209145312.3251-1-alext9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205235704.31385-1-alext9@gmail.com>
References: <20191205235704.31385-1-alext9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the dwim ref logic into get_fork_point() and return an error code
so that callers of get_fork_point() know if something went wrong.

Alex Torok (1):
  rebase: fix --fork-point with short refname

 builtin/merge-base.c         | 14 +++-----------
 builtin/rebase.c             |  5 +++--
 commit.c                     | 19 +++++++++++++------
 commit.h                     |  2 +-
 refs.c                       | 14 ++++++++++++++
 refs.h                       |  2 ++
 t/t3431-rebase-fork-point.sh | 20 ++++++++++++++++++++
 7 files changed, 56 insertions(+), 20 deletions(-)

-- 
2.17.1


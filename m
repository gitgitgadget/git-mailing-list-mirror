Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496E2C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 22:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0461D2070A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 22:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqQ7QRU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYWPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:15:41 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33978 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWPl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 18:15:41 -0400
Received: by mail-wr1-f52.google.com with SMTP id 65so5528275wrl.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5dx9MfFHNrjTCQSj9pIsOPn1GfIUp5HT74qgO6lMRwU=;
        b=dqQ7QRU+Z42skDMtmAIGRPaoqhQmJH8lukJ/G5oCE2LhsrO+fQhooQeNJwR+idvs/S
         AOdF+GjXtlTuzRKW8mKyAu+It2xlywatmyHzAxtYxDEUiAk4uDYjZBWlRxbRkPojwmmA
         RlwsuBlCJhCE2ZsSVqyQ/Kj8/FRlGRCVZqNorGRSMmXI6++WA3Q2NMZXs41z+6xGk03y
         px5/hpeTfUfgxJP1ki6vdo9MU2hck1plb3vPL5X1Soy6SYH8nEnOf5aXMelbtDBXd35L
         apaDgp41cC8hkX5DH4qqP+uzJcw3jr+NO/XrAb426ULp6U0dEzokiWemnRRWCMg9Vvcn
         NefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5dx9MfFHNrjTCQSj9pIsOPn1GfIUp5HT74qgO6lMRwU=;
        b=hdbFGSn4fV4RmP/vPBb4IpaLSON3NYZrCNaJL47Dn5zST+QfMOSNeGsBsE+MslCjve
         j1LsBpiWKi7UgoRH/JWZ1wVuFJCCmzHsLQOx76XnzryriyZal5wDUhSq3owPlUKiJ5BF
         dETyBckhnOXIq5/jF7Zwqdd/99XPwpXrOGv3s/r96p7BmuZUVDZB/7O0p6osMuuPcYlu
         jU07LIqcAOLDwSukfFOK/qtIqo2p+Un7E9IzP8O4EOdKBYY0M0tE1CFmn68Lqp/FarvU
         MAhdARcNN5pFpf5MBvHNWAswmDInqTxlNXrrBWWMJr/xh4LKdWhMciKceWCHRUYV+yKG
         ibyg==
X-Gm-Message-State: ANhLgQ3W4CdQK7wI6LDOv1rld1ZN0dbx7XhqPjgw38CNycnyQc3G1gnl
        ZIMe/Z6S8vcOOUpE+mcm1bE=
X-Google-Smtp-Source: ADFU+vuF0ytsuwQaMKQxHXEOoxJGhxHht1uxuSvQeJS6wrez9T9IUgrwNIrCWIpt7jS9hHAScByiHA==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr5440326wrp.23.1585174531415;
        Wed, 25 Mar 2020 15:15:31 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 23sm529103wmj.34.2020.03.25.15.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:15:30 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date:   Wed, 25 Mar 2020 23:15:28 +0100
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Documentation of pack and repack
Message-ID: <20200325221528.2cj5vb5vivjdmg74@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Wed, 25 Mar 2020 23:14:15 +0100
References: <20200228154357.1710521-2-damien.olivier.robert+git@gmail.com>
 <20200312170931.2392490-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312170931.2392490-1-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a friendly reminder about this series.

In particular, it would be nice to get a review on
>   doc: add a short explanation for git-repack options
since I am not a native english speaker.

Thanks!

-- 
Damien

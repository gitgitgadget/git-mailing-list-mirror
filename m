Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE71C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1516261981
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhC2QUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhC2QU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:20:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EF8C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v11so13433696wro.7
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9A5xMtWAaRsumNAXI+HoBWeX58zyC8utlceP/8cHDc=;
        b=XehnsXv4fx/rOL7Fvuz7xcAmFYYkgs/WGtc3ZYIJmn01ebchFScOn+9ut15SKAQdcK
         1jZuyE308lJnTbRKjpSXamSA2WRMKZdFnKx3QSLNY5GNnx65ZuB9el9xJKwa72KvQLOg
         QZIVBbn1zfKdpIBlRQ8JP+2DXewVO/oy80qUzstEraWAn43wPqSQ72JHuJDD6RHwkW99
         6o0Bfidca2EX4Bq8FtbBxcOyVf4OJursMjT/j+/8xe2QyoF9nPTxvgfz+eMA/Q/acANu
         erKeZVvhze5k0/JGICWDYVeXL6GIYiC/+l3kDxdDJ2WZbEzcWBLcpaD0h9BfGWq22h4M
         6Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9A5xMtWAaRsumNAXI+HoBWeX58zyC8utlceP/8cHDc=;
        b=Ho741S6B88UUJ0i1gJM7Pw2oqfC/m/sExuO7+fcplaCcwlD3MU2RJohP1T6aA8GTBI
         /kg9fqi0oFPdgnUHOcWJTGUe62cwvbu0ZiXVvdmUxw/S2niI2EVj/fTu999A+L7fO85d
         rUXuYlCMzpUTTxEx78yy3yylMjhhhxdQcNBJVTjU/eCCf/kHZJ6fgtAM7asMacUBuvwD
         Odc+ODmSS1hA1qWl7KLu+Ax/F+g0DLINi/FNxwyAsQY5vOKs9VyR7ioml5E45wE6RVZB
         B7F6Jks3Y8DRHFYgM+tCg4y76p21BQAe5WrlnN8ze+5/okKp0lFSFPjk99nFt1gFFlOG
         /o0w==
X-Gm-Message-State: AOAM532DOGZT0fqhfIqfhmzbCxGrk/3QLu5GuL68fhBVNqsGSoldT3n3
        k7WyU6r6I7BgVvvggAGoFK7mqgtLy8hQDQ==
X-Google-Smtp-Source: ABdhPJwscWg5cqsOrAOKtkb2GtMWQjqGTL2qaFuC26pPS8oCzDfRl+Jx0QqWuphgNyM/OykOm8lpEg==
X-Received: by 2002:a5d:6a86:: with SMTP id s6mr30264088wru.307.1617034825220;
        Mon, 29 Mar 2021 09:20:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm31835353wrf.41.2021.03.29.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:20:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] Makefile: don't die on AIX with open ./git
Date:   Mon, 29 Mar 2021 18:20:07 +0200
Message-Id: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <20210307132001.7485-1-avarab@gmail.com>
References: <20210307132001.7485-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8n
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v2, much the same, but moreso. But now with entirely different
reasons for existing.

Ævar Arnfjörð Bjarmason (5):
  Makefile: rename objects in-place, don't clobber
  Makefile: rename scripts in-place, don't clobber
  Makefile: don't needlessly "rm $@ $@+" before "mv $@+ $@"
  Makefile: add the ".DELETE_ON_ERROR" flag
  Makefile: don't "rm configure" before generating it

 Makefile | 102 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 41 deletions(-)

-- 
2.31.1.461.gd47399f6574


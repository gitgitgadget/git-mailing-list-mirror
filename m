Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F21C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99D86102A
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhDIIdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDIIdR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:33:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A83C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:33:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hq27so7336716ejc.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lc+grMIK2IM7FE9cuxcU1JptpMZGkPWKc49m+7vviAw=;
        b=cioCtpaj28/mHzpIEyIjQ42lRacCZLnulghImZjSzCcDwXVyowszsxUDdmbRpiMr6j
         5e4yt1lcbq3lF3lxyIc97Lq0TbHaN6oHwwiFCof5Cq2xtR0HkZ4i97OU/qodRQnD7QMZ
         favCMxGCYQYy5Fh017Qa1vllsSbRZfI+AjS1owl8I6FJVIvf4aQnVMcBK6TmCr3esOrk
         nYG+2+jGAXnbTcIZvyikUHVBmjhGXTH/tMUz4n5dIF0HWcC/n98DSrYUaXUR7+MeSfzD
         WH59CLWim45sw0S8jZcpiOKVYCafsnAErEoaCu/stGyX4+HXusD3uSC9KBoFB5K+bj29
         Ccuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lc+grMIK2IM7FE9cuxcU1JptpMZGkPWKc49m+7vviAw=;
        b=Ny9qitapfr7H9QSQQoMayQyWpJ5wQgq4yBjdH0obESuHjEvdG9YfBeHOTbdR/seAo2
         P3ZzeC0b7lq018DoRsDLKmXfRDI6CGiYkkxHPHytQRdnLEG8G7gCPE+6G5VUFaFXK1tQ
         t2kYaIUWgCo5LXbkJVAq5Vj15+78BFb4yW2F8A8k4cVW6+KILNPQfCzSWzp+L5fivm7y
         13xh9ACVyGVO9/VwgCfjA+LMxXNwHmgcWL2kVXkQQj8n4Q5yMcFbFHfee7IkidiRAlZa
         jy97yzsPuj1CWQQT8e4dlvqmoTy4zORVu8k65ZdA5mlQReKn1vFWfYaayoYbW9Emdq+u
         maBQ==
X-Gm-Message-State: AOAM533A54S3owLRgvVOxYhMFElARMioH5q52scZVoEEuE9+EiHVmT8/
        fy1HP3tmEfua+u9l9jZGAmaW/unf+pF2qQ==
X-Google-Smtp-Source: ABdhPJyFQ8cGUDvq1K0M3UiqqV1Leh+kZdRuuGRdunnE2JGV/uqZOXED0ZGWtNksIwtasPfimFNXPQ==
X-Received: by 2002:a17:906:4a52:: with SMTP id a18mr15082524ejv.194.1617957183292;
        Fri, 09 Apr 2021 01:33:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n17sm1016707edq.32.2021.04.09.01.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:33:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] {tag,object}*.c: refactorings + prep for a larger change
Date:   Fri,  9 Apr 2021 10:32:48 +0200
Message-Id: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on top of[1] this is part of a split-up of [2] into more
digestable pieces. I've addressed feedback on this part of the series
this mostly-a-re-roll.

1. http://lore.kernel.org/git/cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com
2. https://lore.kernel.org/git/cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  object.c: stop supporting len == -1 in type_from_string_gently()
  object.c: remove "gently" argument to type_from_string_gently()
  object.c: make type_from_string() return "enum object_type"
  object-file.c: make oid_object_info() return "enum object_type"
  object-name.c: make dependency on object_type order more obvious
  tag.c: use type_from_string_gently() when parsing tags

 builtin/blame.c      |  2 +-
 builtin/index-pack.c |  2 +-
 fsck.c               |  2 +-
 object-file.c        | 10 ++++------
 object-name.c        | 25 +++++++++++++------------
 object-store.h       |  4 +++-
 object.c             | 20 +++++++++++---------
 object.h             |  4 ++--
 packfile.c           |  2 +-
 tag.c                | 19 ++++++++++---------
 10 files changed, 47 insertions(+), 43 deletions(-)

-- 
2.31.1.592.gdf54ba9003


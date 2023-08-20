Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930CEE49A4
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 08:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHTI4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 04:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHTI4c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 04:56:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CDC468B
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-317c3ac7339so2092319f8f.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692521681; x=1693126481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxY7HHNNfhuUdc4L24qQGHgvzKxdF7JI7dX7H2VLYvs=;
        b=O/yq0WElUI/aCvUQa3W6nRjazxRKm+xYQbV+VYhTph7LIKc+O1QC/WSMn8VVPh1+JA
         2ua4hurOoeiBdjWIKTVjaCR914gdUb7r0Gp/9ZX6nUbFLDT9IdlpQPzptg+Tgo57u1z6
         6M2poquqYlPU6R2wYzCGoLLhSShfFNK63uqC44G8SBpcofnpOf+uOafRVLSXvRO7NbN7
         dlIyzL4aYyZhAIvrJ8r1fBPngbq6VxEjho3ewvDoa/AtWPPstqhdn3Lxg2R2vcL1A6t2
         I1d05+mhg5unVtMPZt4T+YYEVsQHs+ONKVkRW/aJI0y6qtz7JVbM8PQI89+S8uDrwVqz
         OaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692521681; x=1693126481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxY7HHNNfhuUdc4L24qQGHgvzKxdF7JI7dX7H2VLYvs=;
        b=SHchoejIC4t6hCd4Q/h77SgRRHyWor0Bx5/wUh3FiwX4R1+d6VCdzx4MSgZpCd53m0
         QIML+XSgetqMq/rakg+PZiwaoSIMibnVdDegVbVDPrLQLRpqcoxP+/JrBaGlWVG31PUk
         kRIiRfYpRfP55NyOMqCwL8Prbla2M7sYejTbpti0S7SEsBAe6JiJz334sFrM08GvBMJ3
         FVIeKoSOSOD5n1Zdc+aJ5eDXIMjVBzOZQMD471QCnhwpKkQpXLud9PpXBNHo3dtwQtp8
         HmfCgDKE/7F9RK8KG9IztoZVS0q4+KEKYNjrQ5a/ZYj5klsZN0piuG8qhrKIQxDuCwji
         +l/g==
X-Gm-Message-State: AOJu0YxcJWxvUrVRNsMNCo8cINnGa8dv6nqfzgLA0UmhA0gM9fLMh0k+
        wxyrtEYXsYOZh7PMtdRN0CsytQA4mHFaZBQX
X-Google-Smtp-Source: AGHT+IGJWXGYzTUALvi9/l4Bsa+FGSVDPPRarN81IwsV4E31RrsqEeLxP3twtxin2LRJ7uYmizCfSg==
X-Received: by 2002:a5d:4d85:0:b0:31a:d6cb:7f9d with SMTP id b5-20020a5d4d85000000b0031ad6cb7f9dmr2382221wru.24.1692521680840;
        Sun, 20 Aug 2023 01:54:40 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm8652539wrp.39.2023.08.20.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:54:40 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 0/8] pretty: add %(decorate[:<options>]) format
Date:   Sun, 20 Aug 2023 09:53:28 +0100
Message-ID: <20230820085336.8615-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230810211619.19055-1-andy.koppe@gmail.com>
References: <20230810211619.19055-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to v3, this avoids introducing a compound literal, and splits
part of patch 5 into an additional patch 8.

Andy Koppe (7):
  pretty-formats: enclose options in angle brackets
  decorate: refactor format_decorations()
  decorate: avoid some unnecessary color overhead
  decorate: color each token separately
  pretty: add %(decorate[:<options>]) format
  pretty: add pointer and tag options to %(decorate)
  decorate: use commit color for HEAD arrow

Junio C Hamano (1):
  pretty-formats: define "literal formatting code"

 Documentation/pretty-formats.txt | 47 +++++++++++++-------
 log-tree.c                       | 72 +++++++++++++++++++++---------
 log-tree.h                       | 17 ++++---
 pretty.c                         | 76 +++++++++++++++++++++++++++++---
 t/t4205-log-pretty-formats.sh    | 32 ++++++++++++++
 t/t4207-log-decoration-colors.sh | 44 ++++++++++--------
 6 files changed, 219 insertions(+), 69 deletions(-)

-- 
2.42.0-rc2


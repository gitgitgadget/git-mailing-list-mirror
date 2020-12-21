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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB2C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307BC22C97
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgLUH4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 02:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgLUH4E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 02:56:04 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B8DC0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 23:55:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h205so21451011lfd.5
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 23:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sn/6WWOil/1DviY9QXLRnFbIaNnivSxBAHOU1CFVS4w=;
        b=nh1PDJ1a6gQiM0DFMz0yR0qg8XVnHwCdNmc1VvTUopd1g1GrA35Rvy8LWXs9plqfOZ
         /PSQzX1TcdHmumPuZyATwd9EZPucrqpcGbrDE+l7CJlrdQRDjz9GZsndxB+E8hGDAKly
         P5xxi+PTsdigzTyshx+2r3tZnHBGYBXegBqLDhCXpKV+k6491oA71smYbwirivxE/ua5
         qi3Ne+7TjkOXCRNV72JG+P97s0yUw9XM0o98/Am6EGB3Q+uhgtl6Jgc3LwdB7k5o/7UJ
         eBiRm+QtmcVzb5b+0ahZwzDcMst9VQxxhfFvmeBks1BLN210jQq7pNxvID+T+kqqa2vm
         tReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sn/6WWOil/1DviY9QXLRnFbIaNnivSxBAHOU1CFVS4w=;
        b=jhwDoujblWp7Mox2bQ21/W8ib9fMWBzF6nh8UTu0hrzGQnSVRBExvTQZOAsMX2qFJc
         G//UsQz9ynVrypcsCLbvsQOeCB16SvPUU/3mmv1xBjeaqwfRFsQZNJ7rBkDsBgWZcFSt
         YiMsJ1MmG6zeXzyK6DFjgHJR1EFCOGBFAFtyhOr1puMXOhQhLbmlzpuvxLokohd0UwIY
         QUKV59dEv4jM+AaGyS27YsnAPlgH8D+IyWkWMbD10AzpMsquPTyh3CQGfyhThVQ8h6mc
         FhhIEe7T7rlxQzR0Ife5fNfVEGd2tK1gE01aTOGle0GH/YCM7S49bhDiDns52/KX+qb7
         i01g==
X-Gm-Message-State: AOAM531QWAIezN2Arl3g+7v4s8lKASO53PVnOlCrGrOaSo4GvsgS+cW5
        Rd5ygj6MQrRUjxNYUdKOROywG+4lBIM=
X-Google-Smtp-Source: ABdhPJxzlzWISa+0SRshCym9NqyE2pMfiOlzYUIsKr2LMGlPDTPI/sd5h8tMB38V/u07SBMBQOUfVA==
X-Received: by 2002:ac2:5685:: with SMTP id 5mr6575075lfr.325.1608537323134;
        Sun, 20 Dec 2020 23:55:23 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id t20sm855663ljk.58.2020.12.20.23.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 23:55:22 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Ross Light <ross@zombiezen.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 0/2] pack-format.txt: document lengths at start of delta data
Date:   Mon, 21 Dec 2020 08:54:57 +0100
Message-Id: <cover.1608537234.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <CAEs=z9Pajgjnq56+umA+g9-NFv-Rzo9m5sa-7cow_byckLiJ0A@mail.gmail.com>
References: <CAEs=z9Pajgjnq56+umA+g9-NFv-Rzo9m5sa-7cow_byckLiJ0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ross,

Welcome to the list and thanks for reporting your findings. I haven't
looked at all at the first issue you brought up, about the protocol-v2
doc.

On Sat, 19 Dec 2020 at 18:10, Ross Light <ross@zombiezen.com> wrote:
> 2. In the pack-format doc, the Deltified representation section [2]
> describes the instruction sequence well, but neglects to mention the
> two size varints [3] at the beginning of such an object.

Would something like this be what you have in mind?

Martin Ågren (2):
  pack-format.txt: define "varint" format
  pack-format.txt: document lengths at start of delta data

 Documentation/technical/pack-format.txt | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.30.0.rc1


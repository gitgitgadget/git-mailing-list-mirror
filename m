Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A11C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 04:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiGKEL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 00:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGKEL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 00:11:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BFB18B29
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 21:11:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j3so3785905pfb.6
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 21:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMQccnbGAyJcFTnGFVxiHRUAt49HAtI6sp8BkTciq4s=;
        b=SLJq6yIZARxDSxxwEpFu4WTX6SfGqZBzZ8CsQazEFYhfKqTfQQ5FIL640KhhSPvxiE
         bxNCCtggKJX9/yLJlBDfxZaZWElDL4Cv3XFudkUcNX1BtsdvzBnA6VvBQSPeFqRpxQX/
         6l+rYpwsQ1xVh3i28IqQPztyX/hetOGq5F/MTGIFfYvAAjZgvFZmWqcu9oGbXHpvQJUt
         dZSBuLB1mlI583ImWxZNInJJ7Uw1RPTA/AnE9E5DX4r9jRCEytbH1jpphjDwu4OYuHMT
         yXLHiegqaHFCKBcYRkMFOpIeF3ho9jaEY86s/8Q0y3Mn4qjMMkSFHMEptX4QlckPppoa
         gjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMQccnbGAyJcFTnGFVxiHRUAt49HAtI6sp8BkTciq4s=;
        b=ZKTvu1FlZmwrJ0FuJhmAgbK5RukJh+tWNgxmSgnWQ8sMl2ohoS9cby7zba4zwSDYkm
         8IGzXweCmJzffNjFJBMkf3IV2CGV+WL6K8+xEF6Vr1Uh4ZP4hYyP8qqUTadkGss9PaY7
         8ViEk0Q1bTBHPRngRb0zzsq4uUKIrW5it4RZapkTDOcmoqieL8ctouFjIaMeC4gYS8pl
         SgK6dABgQ8+3SCFjl73lzgABC6EfgQ6LXsxN8uJ9w9iKW4crSefij/HA3BwDMuUC1X2U
         2IpYZsdJtfQlBP/2IT1QeR2O5lLCZks6eoELnafMuKEn7+ejOilDXf7QUxbAj6rW48J6
         GP8g==
X-Gm-Message-State: AJIora9l/qYkcM54KldPeFsI250MwQBlLFwCFRUPcGC1HCZjAi8MTEps
        6Rs3W9ItOcAt0AFnPURtlqw=
X-Google-Smtp-Source: AGRyM1u/uS69ZGr8kQRk7j5d0ARXlkL7VksP2pGkZAmFmJAoYKJ+usokzwMNl3kCGmCsYej46537DA==
X-Received: by 2002:aa7:8649:0:b0:52a:baae:16c9 with SMTP id a9-20020aa78649000000b0052abaae16c9mr10214783pfo.26.1657512715416;
        Sun, 10 Jul 2022 21:11:55 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id x24-20020aa78f18000000b0052ab6590290sm3623371pfr.88.2022.07.10.21.11.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jul 2022 21:11:55 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@jeffhostetler.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 5/5] tr2: avoid to print "interesting" config repeatedly
Date:   Mon, 11 Jul 2022 12:11:48 +0800
Message-Id: <20220711041148.15760-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.g6d80778db5
In-Reply-To: <838e1273-b704-bd11-e9ed-e25390989027@jeffhostetler.com>
References: <838e1273-b704-bd11-e9ed-e25390989027@jeffhostetler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I agree.  Let's not try to dedup these.  IIRC, the tr2_cfg_cb()
> machinery runs during a "read early" or "read very early" scan of
> the config values and the program is still starting up (in some
> sense).  For example, the command line may not have been fully
> processed yet (again, IIRC).  So injecting a call here to force an
> explicit lookup could cause problems.


The "read early" or "read very early" is a little abtract for me I think, I will
take a further look.


> And I don't think it is worth the effort.  Let's just log the
> context (system, global, local) as you described in the previous
> version and be happy that we get multiple-but-now-qualified values.

Yes.

> Also, your new qualification would help us answer support questions
> using telemetry where a user thought they had a feature on (say
> globally) but was actually off at another level (say locally).

That's certainly my original thought.


Thanks.

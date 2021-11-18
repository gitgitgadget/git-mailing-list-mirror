Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F8C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804AC61B3A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbhKRJbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 04:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhKRJbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 04:31:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D826C061570
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 01:28:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x7so4683798pjn.0
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 01:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HHbpMGM0y3SpkiMewG9Oc8xlNhb5x6NRmetErCCJ3c=;
        b=Dpi+pR+klo1gnIesjtdN7ODeqMsqz5EiADOpieZoIFU47NL2Iwbc+Dkl0IhgBaJkOl
         Shz2jnuIZRli9RVvseHnJxAwr8Yjzab+fUvB0+HaDck0x4t5//hlDcnHysDhBnrmQ8P1
         CHVRRAFCcudBPS5C1jRNn5TYdSm8s8cH5JJwgh8YcFGjHFob8xoSzy382SLqKl/vRpt4
         A0+04609XecDKn3PttUFCelI2/qpGkLJMyGvWEderSzdRNe2PZOc5e4YTvKRxmwke3Pp
         pE1hdqkTzgYFiDuN+4TnmUOJ4ZvjwL64/YszmrL7WADkFM4dvU3qUTWoWY5JjK9VxSEO
         Gpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HHbpMGM0y3SpkiMewG9Oc8xlNhb5x6NRmetErCCJ3c=;
        b=Hzek1SI8mdLOv6M0+9uttl/W1C+OKSZYyIAmWzEFSws+Kqt2yEF3qsEyNgbZxLRczH
         nsLoPUwvgpKgVtNbCCcQ7Z0//Ui6KL/E+Gjgqc1hEVWXtqTK8DBONYNjO45tQPrC144/
         lPnLpwrgzPC8cMf2YFvaSHch6xA0dlk14ykHRqD0n7NsAkxrdd77nYN+FZphSrZWKgUC
         QVNoOjTdh1sAUBrPs9EgRA1uvCG0JhToZxiwwul8fxJnqV1Ei/0N8JcUjTOpT8J5+p+D
         iKZo5AIK9r5teBiAGUKhQtNEjmqHNOoth7m0e2QHVXAioxQhsVJKc4UtzORIU9LuueHD
         6tsg==
X-Gm-Message-State: AOAM530Be8o5LIP/RHdgOyx6iqQg/Z/YclQrA+4lzfiax7zTdHqt86Pu
        ua0BRid56AZY6nzOde51WL4=
X-Google-Smtp-Source: ABdhPJwU9SDsZOmDb+VGjni5KO/k6zbkFBeN3StB+DzP+lQgomSPHhl+dGen6La81ProHw1acB4AGg==
X-Received: by 2002:a17:902:e294:b0:143:86a8:c56d with SMTP id o20-20020a170902e29400b0014386a8c56dmr64594711plc.22.1637227691724;
        Thu, 18 Nov 2021 01:28:11 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id d17sm2363592pfo.40.2021.11.18.01.28.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 01:28:11 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH 1/3] ls-tree.c: support `--oid-only` option for "git-ls-tree"
Date:   Thu, 18 Nov 2021 17:28:03 +0800
Message-Id: <20211118092803.78395-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.12.g48302d14a8.dirty
In-Reply-To: <211115.86r1bhsb8x.gmgdl@evledraar.gmail.com>
References: <211115.86r1bhsb8x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> If you make these an OPT_CMDMODE you get this behavior for free. See
> e.g. my
> https://lore.kernel.org/git/patch-v2-06.10-d945fc94774-20211112T221506Z-avarab@gmail.com/	   

Thank you very much for providing this input.

So I try to read this patch your mentioned and try to repeat the idea in my understanding.

First, OPT_CMDMODE() can be used for:

       1. Easy for checking the combined command options, such as "mutually exclusive" conditions.

       2. Die and output the error message consistently when the incompatible options are found.

       3. Brings better extensibilites, no need to change a lot of if/elses.

Then, you suggest to consider about to use OPT_CMDMODE instead of the current implementations.

Did I understand your suggestion right and comprehensive?

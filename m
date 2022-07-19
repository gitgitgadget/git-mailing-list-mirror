Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D07C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiGSOyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbiGSOy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:54:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA7F2CC82
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 07:54:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t3so20000633edd.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=op8t7zqDTpqAx/5YLGZkS7xmN9L/OiUd3kb3djMiCgk=;
        b=ovOav0fOwIoQnse0N8e81mBJtSTEJbkd0114ITEmy/BTWqonH5a4JwZkUulJFvLPLQ
         iGZodTQ0obKqnX4rTV/xoGQd+c3F+WaRrvr02kmXczaNEBC+S6AmdoeMCCCgmgTNZgoq
         hkMHH+E2BsB6iflyIvucO2OuWj1u1eI6gaxYkUQgDkHPAf5UWhnMJRg8gnRNvOtaTthE
         +vrQ7TlRO+4tts+GR3AIYgprtTXLuGsdM02lsYIvyp3EWAevCL9ENkzo07+AkMbi/ged
         3CWI7AxYw/7K+9xNWSJxiX28Fj0+olB/pDxd1nvqVoIIHPIFpNVRhStXvLp+FHzjdHbu
         s8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=op8t7zqDTpqAx/5YLGZkS7xmN9L/OiUd3kb3djMiCgk=;
        b=lL0VFUwMZGw+JPWPemlMt+KWcjK5WdcvJqv3JFDUd5z5DosYiaoGuw4crRm8PnknlT
         o3/qIsV8M4noG0Ko9vtr1hOGC16a7EFLlkHZstfAbbLkea5MgDgCKVRKFZVFTx2xJLe6
         muDhvyfwJNm8Qnc9vVo1c9RpDYxZptCYqB29BzrjRNAIR7sufNDN/duXWx8Ruej2MbUK
         qlt9t0X/WqgV/WFEV3NaIsF6+Sq9Q53XC95mALnrqCKrPrmUqAM9HBih2u+3zVE0vEKe
         J3DdpRJbaPJHuJko09KVjQe2qVt3V8L0LyeGnuQaiT1oiI8+XpZCxeTU1ZUIUTKyxQ3c
         JDBg==
X-Gm-Message-State: AJIora87mVyZxkPMn/0iZYAcHaZ39VLwnH/AXy33n2mzrgJBJmr2spSM
        f0GpRn9BJg9Qhbq0PfpICbQ=
X-Google-Smtp-Source: AGRyM1sK7jJfoYR+hAPNC5B8ffQMcmzcEsAxIHOM/pBPnuQElx6jxFn+TjKz5Aq4rQNogypgFYgXEQ==
X-Received: by 2002:a50:fc83:0:b0:43a:742e:5e42 with SMTP id f3-20020a50fc83000000b0043a742e5e42mr43568617edq.118.1658242464754;
        Tue, 19 Jul 2022 07:54:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7d285000000b0043586bee560sm10587168edq.68.2022.07.19.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:54:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDocA-003ito-2f;
        Tue, 19 Jul 2022 16:54:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com
Subject: Re: [PATCH v1 1/7] t7002: add tests for moving from in-cone to
 out-of-cone
Date:   Tue, 19 Jul 2022 16:52:20 +0200
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-2-shaoxuan.yuan02@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220719132809.409247-2-shaoxuan.yuan02@gmail.com>
Message-ID: <220719.86pmi1up9d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 19 2022, Shaoxuan Yuan wrote:

> +	! grep -x "H sub/d" actual &&
> +	grep -x "S folder1/d" actual

This *might* be a portability problem, but probably not. It's listed in
POSIX:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html

But it appears we have no "grep" use of the "-x" option in-tree, at
least from what I found with grepping..

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C72FC77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 05:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDMFLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 01:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDMFLg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 01:11:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E5F83E6
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 22:11:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-632bcd6cb63so1241289b3a.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681362668; x=1683954668;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcfnHZFxwUja3Ct7vAOkBjZDSKUgUal6ChV9bnXZ/5Y=;
        b=G5QqDYN4tLROk1VKX4vjwjp9l8U86cAA1JQmzXc5QQ3f6PkR6QFrKoqdsXhDBJYKrU
         mVmAr71Vupnd5BCbA2bo3bF4KRb+oTQdUISTd5SbCxdEhZZlb2JCE2YSX8Sko2QZB5+s
         9Z/6EHtw0/4J5rY0hXCVH0rjl0D5f7veKk+d9xSv1r5w4ftE6imQt2foPa1y9BQT7MZB
         PUqYypyJhYfpPPpbz98On9O0DhwrMtCNWr/2SNMyTNQ/U2kW6U1f+b1aL7f1U2OUnwkm
         R4lD4T44/yAYtucXHah3NXVvnsJS9TR+IC9WA+UvIDUQBWksNX4Ux5E6BtliYE76WrOu
         ILkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681362668; x=1683954668;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jcfnHZFxwUja3Ct7vAOkBjZDSKUgUal6ChV9bnXZ/5Y=;
        b=ElRPYjOXEgw0ATG0LAGw9ekymbqt4YD3w56zzVEbJ6gMpIojIL9kg96UkBjqhBEXqC
         D56oitQfu3OQSHP6kLKy1dKAgeZTRiNaQXA90cigqT1XQvzNTwfdBBqMiBQ4pFdPLYwq
         bf00bvQY6JBNjS2eTUd1Uj+TGpNFb3DUHlP4Azg/5t8o3VK4bC4fJQNG+n31dWJaJW7U
         DseWVcJqqd55wD2FJdWj4CzovmCttOjeM1bv3wz+705FDmUNmm1HxrEMDT4D6V1Ead1G
         7Q9MXw5E257lXTu4YKz08DZEGqbrpxb/2YR1jIbxCRuL7QgOJVLhv6Lyt65P2a/N03hV
         SJDw==
X-Gm-Message-State: AAQBX9eXqXUBFUuPp5lfCi/+CrpCfWojlDPXeaqgZWxYMXwETKUGw0q9
        6+RJW2qxwxQ+FBhTfLB97Qk=
X-Google-Smtp-Source: AKy350bfEB3zCS7EZEKHhULO9kroWPNoUGmYhpQ/iXvFryaKtr0A1z0ZwnqTzVWwi/479wE/WdWMtw==
X-Received: by 2002:a05:6a00:1589:b0:639:9089:798e with SMTP id u9-20020a056a00158900b006399089798emr1640623pfk.19.1681362668267;
        Wed, 12 Apr 2023 22:11:08 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id g18-20020a62e312000000b0062622ae3648sm364729pfh.78.2023.04.12.22.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 22:11:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH v2 7/8] repack: honor `-l` when calculating pack geometry
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
        <cover.1681294715.git.ps@pks.im>
        <608dde4ad52c28ef42845b6bfdcb168e252bd29b.1681294715.git.ps@pks.im>
        <xmqqr0sozmc2.fsf@gitster.g>
Date:   Wed, 12 Apr 2023 22:11:06 -0700
In-Reply-To: <xmqqr0sozmc2.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        12 Apr 2023 16:56:29 -0700")
Message-ID: <xmqqmt3cz7rp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Worse yet, even when stat(1) is available, when running
>
>     $ cd t && sh t7703-repack-geometric.sh --root=/dev/shm/testpen -i -v
>
> in my environment (based on Debian), the lists fail to match at
> subseconds.
> ...

A CI run of 'seen' with this topic fails on macOS:

  https://github.com/git/git/actions/runs/4683726291/jobs/8299125722#step:4:2090

Almost the same 'seen' without this topic is CI clean:

  https://github.com/git/git/actions/runs/4683470969


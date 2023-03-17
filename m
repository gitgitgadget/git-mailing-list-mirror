Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E3C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCQPlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCQPlf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:41:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C73CE14
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:41:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cn6so5590533pjb.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067694;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTyT+4dr0VyAZOESbLLLFh54RjqpLdp8U3xFiQMTSc0=;
        b=Lp+fWf/rg2eWacpugdlgEyKuTn+nbUCOKNSzRz26nW4vQXqIqgfI4GUxlBW6WeTqgI
         0O/Z0KJF3t3SlDzfxgaNGiiRmB54QlTCG1rZpJIWFG577/kK4bxlEbA47MScpuTgfOSg
         JRhuBl9WqMpGTeODFyHz0bHsscn4Xu2OAZC0/FFOpvaRRVxGH9U7jmDBf4ass0u+zIeb
         rBQ06bqj3+h6iEf2Snpp/2DAVXUINEfsQ9fshOcLf+efv+nf88b8qW6/GishFTzt3Tp6
         QGKMJjJ5m4uhnBEGYnRN1D7xlDmhAr+PYglqypBRb8Tiaa68N5ZNhBUoGMW6oOWdmjX3
         nUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067694;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mTyT+4dr0VyAZOESbLLLFh54RjqpLdp8U3xFiQMTSc0=;
        b=1Xf3HxH7O3mOTiJTfqf9SQ6804fNGLw9s2XbhP23sDAATn6V30senBE02KhG6Ra7+s
         7QvMA9J96CYo0OJYnFha5bsxmDTjh+NY8qs3DmEmaM7BZI4WDMEANVzRNBeC7SPnD/Nf
         aXIcMi/2MhdJbgo2oUWETgYOmxEJS3wtO9gEybirdEJ7fpYqd0u2QHVlDrJuBrIHE1LR
         eEirer5++lXA7NetbBlx1AiR9ZGr7+K6XjNwYCX+rTLoHDvx1BsiQI6Vdod+lnaLNzZm
         snKl1nwim7awkyuMDOybqMAMGpHqzTfe6a46x+RKiMkYdKpbSt/Ze8VgCg5XC1jglrEz
         FzSg==
X-Gm-Message-State: AO0yUKX2POAOaJz8hy6/fGi8P2pfNMh6IXtPQx/4yBfaDg4gqWKePZyf
        QmiSdW/lXe08QApRl7pG6uJnJAN2PdA=
X-Google-Smtp-Source: AK7set8V1bh4JyTcEn77v+d4nqRZYEri9N10jTKLznBK7m2zaC9K8RncP8A5Ecj7BmNv9lbU1ZyaYw==
X-Received: by 2002:a17:90b:1b07:b0:23f:5247:3334 with SMTP id nu7-20020a17090b1b0700b0023f52473334mr4255093pjb.19.1679067694482;
        Fri, 17 Mar 2023 08:41:34 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ce8-20020a17090aff0800b002339491ead6sm5178846pjb.5.2023.03.17.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:41:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] fetch: deduplicate handling of per-reference format
References: <cover.1678878623.git.ps@pks.im>
        <d45ec31eeaf42ee042bad04efd69668144df3138.1678878623.git.ps@pks.im>
        <xmqq4jqlocqf.fsf@gitster.g> <ZBMwXAnEnD5QjsFE@ncase>
        <xmqqv8j0ljxd.fsf@gitster.g> <ZBQ4Cqkq9v2cB77f@ncase>
Date:   Fri, 17 Mar 2023 08:41:33 -0700
In-Reply-To: <ZBQ4Cqkq9v2cB77f@ncase> (Patrick Steinhardt's message of "Fri,
        17 Mar 2023 10:51:06 +0100")
Message-ID: <xmqq1qlnidw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Maybe the solution is to keep the order, but document intent better in
> each of the patches leading towards the unified printing logic.

;-).

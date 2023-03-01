Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45442C7EE23
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 20:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjCAUCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 15:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAUCB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 15:02:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B645A4DE31
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 12:01:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so401886pja.5
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 12:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24/QoXk+gX9CJE0U+OnuQdIj7DNd49x5Z0XLTKFr+b0=;
        b=deYU1a0CjFKYJqZHW1fQESm0wIuTa4eC0Qb3Tf+A/gOOuhM9bO5ChPk4LZVthPSaZv
         NExSqQ9ctNWlRwp3xHT+XFOJaGLoPsQXfPdpCwFk5POejRXIFmAPuWOQSy18zXGBTEdr
         sd+X0Y7oatHH1P2efSwmFzg5kukVpQuSXcYqdG/FEYbwjUM+YFGrMaQYEcPnuBl56av8
         SdpOlxbVajDnzSMKiCZMZ4FUDxv1kXCg/VlYP66Asy1hCTQnEW+0kV44rbv8+xysLTQC
         JsMA447Rp1eVibK5PpvRidcfVFaQqRW2QLGGcjcwcRO4tEZB3thyKrVUNAyY42sLEt9X
         HWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=24/QoXk+gX9CJE0U+OnuQdIj7DNd49x5Z0XLTKFr+b0=;
        b=Hk/+c5v8eM4px7FHJ5dXr75EtjOurGhVYlgKvV9AG/GRpPwhwsC5WXgfkl2bJqdXl3
         EC6u4CbsmYv9gIk1e5LczkbXmm8Cbo854clkN25AhrTCA165xawFAz0CGqAxaS7WEN0A
         HGEghjmQAGIwhuFNIqVSDcljPfGPklQten3QkGdmyi8yHBdvwG3wq+/AvcIryhV0aHUm
         iEBPpxRreObrdS8J+x/gT3j+a6FURI73vqjd5k9+ISJ7sVcfOEhdXYQZZ/18j7tXK2rn
         aHJhQ9mF0rQk2BqkhflxTWtAqgbe3SoEZvQwUR6so7xe8IzyZnBAIsxns5PySfuc/0Sm
         MBrA==
X-Gm-Message-State: AO0yUKX9Oy4Ury28yMdbV6nLOQbykh10G9jLHmbUNo2Nd/Cgh9qqPniO
        uP79hkfLk5T5f7OYui5ZP3ko6w78NhM=
X-Google-Smtp-Source: AK7set8kudZ8kthGMVhAFyYjN8gi3i8SihlOGnYtU5ITe62V3Tesadgfvhb2O0tHPu4mxLrnXhe3OQ==
X-Received: by 2002:a17:902:f650:b0:19c:fd9e:f88c with SMTP id m16-20020a170902f65000b0019cfd9ef88cmr7542379plg.18.1677700918950;
        Wed, 01 Mar 2023 12:01:58 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b0019a97f180fcsm8887793plb.37.2023.03.01.12.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:01:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: t3206-range-diff failures on non x86 arches
References: <xmqqilfknzen.fsf@gitster.g> <Y/+paI8WGSmEbv/w@pobox.com>
Date:   Wed, 01 Mar 2023 12:01:58 -0800
In-Reply-To: <Y/+paI8WGSmEbv/w@pobox.com> (Todd Zullinger's message of "Wed, 1
        Mar 2023 14:37:12 -0500")
Message-ID: <xmqqv8jkmea1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Junio C Hamano wrote:
>> A release candidate Git v2.40.0-rc1 is now available for testing at
>> the usual places.  It is comprised of 458 non-merge commits since
>> v2.39.0, contributed by 78 people, 30 of which are new faces [*].
>
> On Fedora, rc1 fails most tests in t3206-range-diff.sh on 3
> of the 5 supported architectures: aarch64, ppc64le, and
> s390x.  These tests succeed on i686 and x86_64.  They passed
> on all arches with rc0.

Sounds like something d9165bef (range-diff: avoid compiler warning
when char is unsigned, 2023-02-28) may fix.  Can you try merging it
to rc1 yourself and see how the result does?

Thanks.



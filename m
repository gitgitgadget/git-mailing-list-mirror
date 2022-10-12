Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C612C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 22:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJLWLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJLWK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 18:10:58 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069701A205
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:09:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h11-20020a170902f54b00b001780f0f7ea7so94125plf.9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKnGQaODsj0OmfV14E7oP0VhcmiW48V9M0AavtRBSYw=;
        b=ZbaRkD4UQ2eJaelaFOsZFPtWnA75mv48bcrNC5KgkrEiMXCT+r4iHIRbrxF1DBagiU
         qHjcJZ+UvtTKEqLNCrYG7d3XJsgniDL6mVYlXoM+OTCa26k1+J4FG0Jqt6vcUg3Plefo
         BdJhD1j4HEPB+w8r/vtGETx6ujvGo0679qjCpcSBskxrfwcdEx71qBlKIi+cndqvo7Zw
         CqNvgyMLwfXr+MD4BPICp6DjlI4r3c/QoTkshHbdjjE9eICBtwB4vGBfTdksAhyxE8b+
         oGUwtglSHeqUOPU2DOdqrsG7Nv74+7emVtMYvZru74axOiXixc1q3HTm4nYYWRWqReu9
         kCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKnGQaODsj0OmfV14E7oP0VhcmiW48V9M0AavtRBSYw=;
        b=IgLjAuK5lhZpJOfJsBbF1F95SS3RXmRdlKSYQuFsmCiUt+WhhExnR/TmB67+R0t+fc
         9vd+fuduY6AEX/1ejfu3Z1KYXZ4gVmmkW2PSkSB/Iv8KqzilfqVzlFnpXzOr5Kfg8XjE
         MafkpBpPF2HLBiSbgS/aB8jY5Wzs+k2cFQBqWE2PirIBatBselR/3iPT3FYc+PUdYsfu
         X9AsQEN5ofFsT29YIEqtPKoQ+BB0hwHxMYjBk7WUa7yrNRAMYZuVF8T482RzVQdUGrYh
         0ssQ8s2tv7OTum1arwFu/xnsXyNVTtf6yypIf2b6o+JFPx8xqjxM2yHjodU7nzRVddCg
         71Nw==
X-Gm-Message-State: ACrzQf2deMxZRFFok0a6Fb+REM8LIBZ7+UCg/Y7vIJt60O+OI3YKMET2
        9muKH++CudL5QbAovGktk2KA2N1XqZBIgA==
X-Google-Smtp-Source: AMsMyM6v9m4coaCfaMgeZOWiEun5IMvuZr2a+Qo8vjIiiaH6jOx5bOK1lJFUjf5oEbcVusfj49AcA9o6Y0jL8g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:b417:b0:181:d0e4:3310 with SMTP
 id x23-20020a170902b41700b00181d0e43310mr21211765plr.134.1665612587516; Wed,
 12 Oct 2022 15:09:47 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:09:40 -0700
In-Reply-To: <xmqqv8ookbua.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
 <0ff5b5741a519c63e65ef57d7d0b3148c38c1a52.1665603814.git.gitgitgadget@gmail.com>
 <xmqqv8ookbua.fsf@gitster.g>
Message-ID: <kl6l4jw81yor.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/2] config: respect includes in protected config
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> Not commenting on the code yet as I am in the middle of today's
> integration run, but as I notice a bad pattern being followed, let
> me comment before it spreads too widely.
>
> The "add failing test first and then fix the code with flipping the
> test to success" is very much unwelcome.  For whoever gets curious
> enough (me included when accepting posted patch), it is easy to
> revert only the part of the commit outside t/ tentatively to see how
> the original code breaks.  Keeping the fix and protection of the fix
> together will avoid mistakes.  The post context of the hunk that
> changes test_expect_failure to test_expect_success does not cover
> the test script, thereby hiding the body of the test that changes
> behaviour while reviewing the patch text, which is another downside.

Thanks for voicing this, and sorry. I tried this pattern specifically
because I thought it make it easier to review for folks who don't touch
t/, but I hadn't considered that the reverse might be preferred.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B7DC4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 07:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiL2HDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 02:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiL2HDC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 02:03:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8869F1260B
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 23:03:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso22163252pjt.0
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 23:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLUpzCzK3CQT/3Kph5RW8fbvaVURlll2Bt1na7w4J7c=;
        b=aB+FbTMO3QW4Mh3BwnFju1H27A7WccYPtqO0/2DZRnyvmpTeX/4PgUR0G/MVHsN0pA
         Mvo22xjFeXDdF34EohyIs27j2dSavuh20ORsnk82fFsv4iYMnnGk1Ld/RA7+bJ6sjh4w
         bkjKf+0T9b7VR0L72MEB0kDDHj5H9BCt7SxtVrhXzpA0skmEkvXt/7GAbNPyLOxCrlqe
         /2JHOZnEnTwSwhugfhtAUBv6y6IFOsbHRKbpEbqa5vItZex3f96WXnvStuIj2cHDZJ/9
         hg6ViicHGnIyMapcMvOSYikc2i/kqeTeDV0IXaZ/4AVTttoXCAuvTOvCXZUY5vzAS4yB
         NcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLUpzCzK3CQT/3Kph5RW8fbvaVURlll2Bt1na7w4J7c=;
        b=JsaPZbQbErihkjFxSQq9wQ9XEGbPDHaoIdcGiHBmHUFf8zhxJh/FgTmwVv+DZhefXX
         COyJMRy6hMIi6tartD7SQnCWtZXTwaz9hFWIAxZXnNRBFz1QfIgIrUfjS06sr5aFXmZj
         CE/ex/kDJ09w3GyDUMABMUJBEO5aNgXdq77fCeF+LznP/++PUTQfvIbbU1at2y9ivKXw
         C/cvivkEyZemrryZynPSv+9Q9KH8RoEkgJUr0e3ILmz7WWVSW5rH8ygTlrJ2wuFUt6sM
         MRkjRJ3pHeGKGYUXdnVKLU9lKSObQEqrRUspSBEYtQnixG6h4jCzk/anpEw+lW1dE/yy
         dqMQ==
X-Gm-Message-State: AFqh2krXWctn4Z8HzFI2Bh3LUTzZcdzuUbqS5Mg2shiJfaXYtMwAIKGq
        rZsTnhhu1XmON22FBDq083w=
X-Google-Smtp-Source: AMrXdXsEkUYijr8Y0pkHavnGxEIVlVwwXJ3k5KRWn0BTdFNeW0WzccfNbdMyFQoatKjyvERO0hjdaw==
X-Received: by 2002:a17:902:f38d:b0:192:62df:a3e9 with SMTP id f13-20020a170902f38d00b0019262dfa3e9mr19096045ple.68.1672297379827;
        Wed, 28 Dec 2022 23:02:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e1c900b001927ebc40e2sm6595674pla.193.2022.12.28.23.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 23:02:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 07/20] stash: fix a "struct pathspec" leak
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
        <patch-07.20-e5a0134d1bb-20221228T175512Z-avarab@gmail.com>
        <ac9621a0-1046-30de-872f-0171412049bd@web.de>
Date:   Thu, 29 Dec 2022 16:02:59 +0900
Message-ID: <xmqq1qoiofoc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 28.12.22 um 19:00 schrieb Ævar Arnfjörð Bjarmason:
>> Call clear_pathspec() on the pathspec initialized in
>> push_stash().
>
> This puzzled me for a while.  This patch adds an {0} initializer to the
> declaration of the pathspec.  I assumed that this is necessary to avoid
> giving clear_pathspec() an uninitialized struct.  It isn't, though,
> because the pathspec is handed to parse_pathspec() first, which
> initializes it.  So you can safely drop the first hunk.

It did mislead me too.  I expected that addition of "= { 0 }" was to
remove memset('\0') somewhere else, but that is not the case.

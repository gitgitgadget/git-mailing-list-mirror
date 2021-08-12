Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53DCC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 07:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9927C60FC4
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 07:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhHLHy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhHLHyz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 03:54:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0EAC061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 00:54:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so9299311pjl.2
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 00:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7q6R+ZDDg8tHCDa3IW3LDmUfR6L5CFZbU2G+nemAe8=;
        b=NLSk8YikjkQuRaRSV/0qutLEmPXdpNOzo063HxrLLFYE9/ekTxTpn9jJlXQuCCs8Pu
         ZFlGrSJF/SrR3XoJ7OzkHJ3307l10nbE2x8C9uXIOrj5zI68xIfw/kHyLRELahHeWCh0
         J1Ot+fYxR9y0loT4TCnZSVVNzhKfcxcjPgAfPpnqW1S1bJi8DSbPsZfEHTlyEoTUbdpK
         JdW7xaPKexbntSv5XUfylITfV6If+mar6tALclV089fN1qtDEJdVqNVngo+izLPSQ+xx
         OkzWw6oprXYD9OOeV/T7d7wKcVeNxV5T3wAQ20OhkydtFdnHP/wyjLXlIRaaGi6OC9tv
         6Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7q6R+ZDDg8tHCDa3IW3LDmUfR6L5CFZbU2G+nemAe8=;
        b=hEuk9MmQ4pEd0D0LZ9Ws3fe6jaumFhPQRSXX2to/VTw5pkLbmSz4wWl+7AvspTb7NV
         FSZETMJFls9HAHua9zSuMmuBWZQCRj5bPJmpJl8xIVjYAL31EyurlRkGk+Hn3vY4Ly9q
         bsCNetPpKDmEFHrffJZS7b4TeRg11neQqCwVnSD3Zp378o+stu2+tFJlBmWuzSGPtMJw
         4OGu6XQFI002AvLeKLw90UOkGeSKojTeNHreeYCbAECU4iWNO+T65+EFXvXfBjk8VAPo
         /1WcF1JAG3I2++Ewp/fwllLkA8SpkDAbw5qXU8qMCHTDQKfzSF4pLyyMGSnbDD1vmRyy
         nGZw==
X-Gm-Message-State: AOAM5313FJRMhJw47qupOnpphKgWlHVAJaM8tv0cshA2KM3kW0Oknnk5
        CAZzc3qmdNE33saxVLDzF6+meS+1ljhLxy6VAwI=
X-Google-Smtp-Source: ABdhPJw8L//oyQnCAxvFwBk5DvNFX4CitxfGz/2Lir9jlup5KUHP1le4WaHu7C2jQ4SwnxlEHbwA7A==
X-Received: by 2002:a62:1ad4:0:b029:3dd:a1e0:af30 with SMTP id a203-20020a621ad40000b02903dda1e0af30mr2918846pfa.24.1628754868540;
        Thu, 12 Aug 2021 00:54:28 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.159])
        by smtp.gmail.com with ESMTPSA id b7sm2099121pfl.195.2021.08.12.00.54.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Aug 2021 00:54:28 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] list-objects.c: traverse_trees_and_blobs: rename and tree-wide
Date:   Thu, 12 Aug 2021 15:54:15 +0800
Message-Id: <20210812075415.5114-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.dirty
In-Reply-To: <xmqqsfzf980v.fsf@gitster.g>
References: <xmqqsfzf980v.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Sorry but I do not quite get the " and tree-wide" part of the title.

I may have some misunderstandings about "tree-wide".
Sorry, it will be resolved in the next patch.

>>s/trees_and_blobs/non_commits/ will result in a name that is much
>>shorter and to the point, I think.

Agree and thanks for explanation.

Will follow your suggestion in next patch.

I don't know why I didn't think of this naming at the time (*headwalls*).

In fact, I discovered this problem while contributing packfile-uris
related features (thinking about excluding tag objects), and finally
said to myself "So you are here" (although it didn't take so much effort),
So I decide to make this patch.

>>The call to it at the end is meant to sweep anything
>>leftover---we will not discover any tag while in the main loop of
>>the caller that iterates over commits (as they cannot contain any
>>tag in there).

Some doubts.

I think at the object relationship level: tag> commit> tree> blob

The tag is on top because of the annotated tag. So, why the tag is
in `revs->pending` to deal? I understand it should be the opposite?
A commit should pending to a tag, at least equal.

Maybe my understanding is wrong, if so, why this way?

Thank you.

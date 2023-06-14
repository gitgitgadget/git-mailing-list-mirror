Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78693EB64D7
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 02:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbjFNCHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 22:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFNCHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 22:07:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E56F1989
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 19:07:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-652d76be8c2so6543398b3a.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 19:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686708459; x=1689300459;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AFKAbrsxQe5p52bbcSXX7kC8Xv06aPIXYiGTMdeDfA=;
        b=XvRhpUbV+Vbq1bfR/1lE1alNIsOjhy2HGDBxj5sL/eEoiXedGpz86TKfhiIPB0xo3J
         /HStNByAnnkCXp36m02LnrmxBu6QBnAmPBy62y8UisdkhA8eX4JGDYqoy9DDndOid6jm
         9BF2ZUdKdBEitJF/yvXLgyYjR4+pyM3ws9R5OyJkUbJrvlDMcJeTfXozSGdBDewFNWvx
         k9kcKTkaEiZwVR12He+cT9fyfXRrb2TBX3cCcrXMnKJf/ZfiHVjpSZMD7loLQ2s/rIVP
         teTctkUpKp0fl5p7VmrfFm41/oh2KdPRsI9jLF/Oc0oVJu3oMdpz7KT2mImafbZroSli
         N5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686708459; x=1689300459;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4AFKAbrsxQe5p52bbcSXX7kC8Xv06aPIXYiGTMdeDfA=;
        b=eifk9/AhMhzHP72hgYMPvYdLXzOYCAIlqP3SnDE2i4vW7nlohQaUZXfA0cgg5iuZ52
         gr1zRRhVRDsg45ed01Poi2SFBUVO1kZb3j1itzSJBfRmVOMvARd4CowjFKL/XVUB6+4s
         zPtsbvV35MZ+nKX/u8pXs8RBKHYMdvwT6KOAcoRiKPsF6dR/55FbhDJder0YWMjZj6Kk
         oxsVAoF7HTXQVJcSK9r0LWUW4SuZJCcBX5MlMvH0u0VCak3+DQvhK/dPjC2oHF8Yxp0C
         K9QBkVfiINonf7bERfZ4ZAhhKItN/mrxJVoQmtVe8HKxO/tVDR4EMGqxkmqCcr8XSjTI
         CDfg==
X-Gm-Message-State: AC+VfDxq7x5lQ6/FCKG2IahTt2y3f+F4ondwA5C+tevSKACdLJU/1LX6
        6r9/i+a+5vlNYaLNMeLoQ9HBfmrjhHQ=
X-Google-Smtp-Source: ACHHUZ56Rrb2Hq1vCU/x9r9WzcSP405YthtPOi/XpisVlvr946V5jT3oC6b6T8e8+RTUdBTfMsPWLg==
X-Received: by 2002:a05:6a00:198f:b0:636:f899:46a0 with SMTP id d15-20020a056a00198f00b00636f89946a0mr725907pfl.15.1686708458787;
        Tue, 13 Jun 2023 19:07:38 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78001000000b00634dde2992bsm9200381pfi.132.2023.06.13.19.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:07:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <cover.1682671758.git.dyroneteng@gmail.com>
        <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
        <xmqqh6ra26vq.fsf@gitster.g>
        <CAPig+cRzx2r34tqqi527sBcDXm3h_sLR1Y7_gX9R4uQ4KUKzFA@mail.gmail.com>
Date:   Tue, 13 Jun 2023 19:07:38 -0700
In-Reply-To: <CAPig+cRzx2r34tqqi527sBcDXm3h_sLR1Y7_gX9R4uQ4KUKzFA@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 13 Jun 2023 21:41:08 -0400")
Message-ID: <xmqq7cs623v9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Is this the same issue Peff reported[1]? His proposed solution was a
> bit different.
>
> [1]: https://lore.kernel.org/git/20230519005447.GA2955320@coredump.intra.peff.net/

Ah, I should have checked before merging the topic in 'next'.

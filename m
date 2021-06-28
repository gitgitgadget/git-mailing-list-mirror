Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E78C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA4461C3D
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhF1SIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 14:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhF1SIL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 14:08:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115BDC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 11:05:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v6-20020a0568300906b0290464d9be9510so8225794ott.12
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nCt06aJVSdgKqzDX6LIWOJBlBkCZ/gzxkqnz1x24OKk=;
        b=NlbGAvVggNDC1fQyc9yNK/S+o7uT/HE3VwzvQPkk9ZQVxQ9cVGNUjQ2p4XMtKb+kYh
         fMdTKB5szc6edtyyVW2lUwxplp1Zp6Z7ZD4SdLx4oNNtLRkZOwDq+QxnUumqrfsxYEQ9
         neqAz90brXMNlfbIqDpx9kXYuYSc1+eBT/3OD/hVYKIJXkwtAxPi4eWj78YRfirAcUBg
         WCnqpYdNYykxMqsLMriTaOtb09onNZvFw9JpuTs6jfzxlJYRUZNWjLib5EZjlkNnzEmn
         MDniHc1U7RY6OL7i9gzT1836FZbUA4rbL0epvCJhReph+MmeRDn2BRkZMRpQ8OrKvIi0
         fJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nCt06aJVSdgKqzDX6LIWOJBlBkCZ/gzxkqnz1x24OKk=;
        b=Y/vbrtRtruM5DRTz+FQZ4QPd1FytAt2c8uafkwFjTyknjU87O//ZcDoVm2ZEc93yff
         Ul1ImbmBGYQQqnqpwhbCI6GxQ1BLJ0nSRmt7uAIueisgKxCcZwBd7U9/plmw4ydwW+MW
         FssCpBVKNgFuCEFKeACFhtxxpsOCEBS2Imi/YQ/hZrl0u7OHXQdP09b4Lh036bY+49Mw
         rcDo0ZqI+LrIoklbrjvPuOQ0LVGQawiUCw4/2iNPpaePSU17YKUDP6OrpqQ9gAtAtG19
         odEmZOZkZfSxPxG47Nd38+WsAGGmIxaT2hJEUjY0aqvy0MSpXEMn0wzszeAFkQaz2lGr
         cy2g==
X-Gm-Message-State: AOAM530HI8OFvSJWOeGYmeyVwE3acNdUpsgDmDrEiPSVrsu2wH8ae3jQ
        H4TUzZBOsfhwR47BHMg6odc=
X-Google-Smtp-Source: ABdhPJzuNG/5VmvnMghXQPvZeKxkQHlJSF4UAWfNAO2E0NGOpQ2+29I1PGNKNZVvPiw7jXM6jbvqBA==
X-Received: by 2002:a05:6830:2315:: with SMTP id u21mr687696ote.327.1624903545270;
        Mon, 28 Jun 2021 11:05:45 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id j14sm3584418otn.18.2021.06.28.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:05:44 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:05:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <60da0f7742d73_1b8dc20826@natae.notmuch>
In-Reply-To: <xmqqlf6t7uvh.fsf@gitster.g>
References: <xmqq4ke8pig9.fsf@gitster.g>
 <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
 <xmqqfsxbika3.fsf@gitster.g>
 <87mtrj2faq.fsf@evledraar.gmail.com>
 <YNPKwIuZvpyWSNXH@coredump.intra.peff.net>
 <xmqqlf6t7uvh.fsf@gitster.g>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I'm still entirely unconvinced that this should be in Git at all;
> > pointing GIT_MAN_VIEWER or man.*.cmd at a color-man wrapper seems like
> > it would be sufficient. But it feels like that conversation was not
> > going anywhere productive; I mention it here only to indicate that my
> > response above is not an endorsement of the concept.
> 
> I have the same reaction to the patch.

Do you care to explain why you think so?

What is the alternative in your view? What configuration should users
use instead?

-- 
Felipe Contreras

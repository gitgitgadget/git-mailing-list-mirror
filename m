Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C08C47097
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDBE613D6
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhFBL1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhFBL0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:26:35 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB18C061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 04:24:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso2054829otl.13
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 04:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SyLa7OHTJrhhjTzSYKOv4J7ovWRmHrTpfTmh3JWi/UA=;
        b=oNnFiqbLHphsKbjq/g/WtO+NjdkTbjow+oT5jeEgqyLFhJnzzL633tdW5xXkLgVvoD
         VqcRtfjZ/gg0zHLPRWvy1T9BqwVcvJdI02uq/UVxJJ+BSxjPFbpiCn4EZF/gbp9qSRpX
         Zrvtvb+uTZcFjxcCL4AVpbB5qos2LFEDJgX5frFZLLIvV/t1/4Pkc7gTKS9qdGU5vfro
         FJW/rm3cjN4b8zisH5nulOU6TOsFP86oE4Ez0u5DiPNoNXUmGLq/l7GOGIeCmOornvW+
         EZZv0hnBpXl8B8ieTQ+VPai4Y3qcrA39nHZqXzPWjZMT5wC7/mo+yoRXibvadSspL0fS
         DiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SyLa7OHTJrhhjTzSYKOv4J7ovWRmHrTpfTmh3JWi/UA=;
        b=tuCCp2i+BJ/8ax0KWROHyQycnrBduH0yOgdXVJ84PRsmNrP7wqkOR4j9j3g1kz5EJq
         cz4wUGtMzOUL489Kio/Py4XnIYQ9XrlznMv3RdIDU2+bZ93xfxPgl5zkS8jTMUSufCs+
         Y4qGFkrk4p0h77KYficGkCeToSny09mvyydvhjXll7SbfJ6xGdc9Zd8HcyFoJ6X6VPmz
         GqC46KdMNpxLqXfMP19s6MtjpX2MD0lvLMvLZOVY+wwBIhp8MUec4y8ZuosYegR+Y0Al
         TBTuls2QHWGngRPnk072gYWtcgEkgCDW/ivuV0DYqMIeSdQVGXN6DCXwdNn8q99HRKCv
         GeLg==
X-Gm-Message-State: AOAM5311XOUU11hhv/wFtqA2/VkELgRkh6M2nOMa68nIRqEut53yNKgg
        XcBkHy3pJY/gHz4vBqqCm1swlrahp+BHfw==
X-Google-Smtp-Source: ABdhPJzSSvR6nNECpaatp9j1iMsKzp5lwW9u2CnnbcN24cPZtzZCiJFAoy4oHJHvtj5o37nRGLIxpQ==
X-Received: by 2002:a9d:62d0:: with SMTP id z16mr25013817otk.180.1622633090005;
        Wed, 02 Jun 2021 04:24:50 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s25sm1696532otq.26.2021.06.02.04.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:24:49 -0700 (PDT)
Date:   Wed, 02 Jun 2021 06:24:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
Message-ID: <60b76a804d652_15ec5620819@natae.notmuch>
In-Reply-To: <xmqqo8co7cqe.fsf@gitster.g>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
 <xmqqzgw9qky5.fsf@gitster.g>
 <xmqqv96xqjyr.fsf@gitster.g>
 <60b6c642ba65b_4044208ca@natae.notmuch>
 <9fb1f823-44f8-8046-adb5-d2c0fdb6b5a0@kdbg.org>
 <xmqqo8co7cqe.fsf@gitster.g>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > rerere.autoupdate erases the information which files had conflicts.
> > ... So, I'm strongly opposed to enabling it by default.
> 
> Exactly.  "checkout -m" can use resolve-undo information to
> unresolve the conflicts, but to make effective use of it, you'd want
> to know which paths had conflicts to begin with.

Who is "you" in this case?

Is it the typical git user?

-- 
Felipe Contreras

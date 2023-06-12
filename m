Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCF0CA9EC1
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjFLVKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjFLVIE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:08:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD483AA7
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:05:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3b974fffeso15536995ad.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603916; x=1689195916;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HJ1Fz1zYJbwaow6HucwAdjey9BEmoU1tXXpn6xn2X8=;
        b=VML/MiPDSlsmsJL/Rn6UOBgJsLdL8jPr+AZrbzBEgX0o7HkjK7h9e2TW7+HhY19NQ4
         Eb5RdexhSrwT2BxOZ0ZTQhCUTYZorQruSEhINsQMc8v3ug9eButqbKT0DCyNpFYHPZ67
         Djqk/VbYD/q2GvHvYFkQJFibGJULJSO7f2K1bF3Ofen/UoH5Ptk7Z5lyP1CBAxqxfnZI
         7Zs10J9j0Lqfsh5MXmy20meRaxsmno7/Gevqnug7fpwdMrfBdAkv8a5i3+DE9VDOW6rF
         B6ecL8UyeDVynM0qEenR8QoYDspZXPOa+1eCHcMslT37KSz7tKVo+HXa6R08lLClasIc
         JsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603916; x=1689195916;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HJ1Fz1zYJbwaow6HucwAdjey9BEmoU1tXXpn6xn2X8=;
        b=HaazTrhOZ2ohpUciwphFRAsGCkd3qc3zGS9d1Wh7wsRFWVbnw3NnxxnD5KfExg0yS2
         EV2SpOqyectUJ18SO/HoxRx7ETXS+i8HfFY2o8WuiYZJtfLgAtc1YCbTGRjw7lc0pylS
         DTMdaGItcaJglqPA9UdKANMYJdlWV5cqq1gfRn1jXTiDpPHmNGkGT59T0afltl18gYQK
         JwMk9LFQdefwu0ItGeFUF7Pe6fjwqIhuQgogk2C0AC1DNcgvbM2u6SoDEv2CtXJpgnhR
         UJaPatSGikCA9XWDSeyD7r27wZHI7ootcrIMbON3jrXM93eyfPGCth37XIxqnpz73x/f
         tKsQ==
X-Gm-Message-State: AC+VfDylm9GTpooVA6NydUIdBtT0VSYaSRkLr7r+IPN990tinP3JTWRo
        0yit9oAIfed6QURmma45mOw=
X-Google-Smtp-Source: ACHHUZ57HxPTeb6R5zBNazvjwCT6thv2P67sLuDjWOhwJKpOkEJQOVxrl3qG3Vy0sZ43tFRabp0jwA==
X-Received: by 2002:a17:902:b7cb:b0:1b3:bb42:eac with SMTP id v11-20020a170902b7cb00b001b3bb420eacmr6036520plz.11.1686603915794;
        Mon, 12 Jun 2023 14:05:15 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id ix4-20020a170902f80400b001b3d20ef257sm2245454plb.97.2023.06.12.14.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 00/16] refs: implement jump lists for packed backend
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1686134440.git.me@ttaylorr.com>
Date:   Mon, 12 Jun 2023 14:05:15 -0700
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com> (Taylor Blau's message of
        "Wed, 7 Jun 2023 06:40:47 -0400")
Message-ID: <xmqqzg548k8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is a reroll of my series to implement jump (née skip) lists for the
> packed refs backend, based on top of the current 'master'.

Hmph.  I kind of liked Patrick's suggestion to split this into two
series to make it easier for the earlier half to graduate faster,
but perhaps it didn't make much difference?  I certainly did not get
the impression that "review had stabilized".  During my review of
the initial round, for example, I lost steam in the middle because
it was simply too long a series and didn't have a chance to give the
remainder a proper review.  I do not know about others.


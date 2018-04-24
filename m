Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511791F424
	for <e@80x24.org>; Tue, 24 Apr 2018 01:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932705AbeDXBvi (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 21:51:38 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35391 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932665AbeDXBvh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 21:51:37 -0400
Received: by mail-wr0-f179.google.com with SMTP id w3-v6so46150895wrg.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 18:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ow/lzRDMk3GGr/QHQL4HGastnbyOD/gPiWDUO4M+cNI=;
        b=A70ejWFfCHXfecC1X6Xt14QyhNUMwfkaFs8EEQ1JhwISdvj4gc0XxcDi1a/D3SCrel
         Oa3CZgQd6L8ks11IAxu/TQLwP4bNends9j6QMU81kXUB0jbKuvDD594towSiZmZeMkFe
         AgiqOLZ47JJqVeAY2/J8p0lvQO/Rm26kg++nQM9kqT3Cryo3BV6sbbDx20hksjpFYO4E
         p8iXt7SrEtWEhw+BeVbmq1Eb9qoiRUuPU5BsHXWmu4mp8AmqXFlLS2jq+GfRjWreCq6f
         grRGEPNpxJq5sU8mEBBp7PYLyYFON0LCsbO81/bCvajH0ZXqk1Aqdjut78ET8fX75rd7
         nozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ow/lzRDMk3GGr/QHQL4HGastnbyOD/gPiWDUO4M+cNI=;
        b=ly4vzDpVZhYkSyaT//Y6sqKgXpkmWqca8W+mUyfSZTmHuYManzIED21LH+b68j1vEI
         +YWT2CNrHuhL+iOc+x2Q/8UvDZddtcuLB1EI2SuCruH02Ce3ezxksZtLX7H5KekeCMkM
         X+5se4BH1Tk6XkJkSaT6g3bsiBfG8ftNrjSRGxO9ACoEmki7vbp+vzs+V5by/Osnc9iK
         EF83V57Yg+2+AuH6rE+iNXPOcyUk+M2qUezZRV3Jc4G/y9sa53GZUB9OYbVx1LHKV73m
         a1+cx8h9rf96hYGWegT16rtWY78Iskk/79kPK7RA7lsHVLCBWhXJ8yMPfI63SJCTgKI6
         6S6A==
X-Gm-Message-State: ALQs6tCbD/EpliT1tz05NY3Cn9fM8ZpUxUsFjivgmxCOhwrkZ38O8gLv
        YT9z0o3u/gc0b1JDNnfzE/Q=
X-Google-Smtp-Source: AIpwx4+KLTsRz/RTeO7w/wO8b6L4HNt6qWMU3cBi140GhEHER4luc8lIZWsaWIVY5rE2OjqRakMLEQ==
X-Received: by 10.28.69.133 with SMTP id l5mr10231053wmi.152.1524534696330;
        Mon, 23 Apr 2018 18:51:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h89-v6sm14112763wrh.73.2018.04.23.18.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 18:51:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2] unpack_trees: fix breakage when o->src_index != o->dst_index
References: <CABPp-BGQy=-k1TN-i2U89x7gJ7z8_ciTM3DJzTnVKsvi94LpBg@mail.gmail.com>
        <20180424002423.11373-1-newren@gmail.com>
Date:   Tue, 24 Apr 2018 10:51:35 +0900
In-Reply-To: <20180424002423.11373-1-newren@gmail.com> (Elijah Newren's
        message of "Mon, 23 Apr 2018 17:24:23 -0700")
Message-ID: <xmqqr2n574ns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Marked as PATCH v2, though I marked the previous one as "RFC PATCH v10
> 32.5/36" because I thought I was going to put it in my series.  But it is
> an independent fix that my series needs.

Thanks.  Let's take this before the remainder of the series ;-)

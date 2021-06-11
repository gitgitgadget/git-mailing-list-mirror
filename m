Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0FBC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2974861400
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhFKObo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 10:31:44 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:47069 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKObo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 10:31:44 -0400
Received: by mail-oi1-f182.google.com with SMTP id c13so5972252oib.13
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0HWDrnXckJc0tcbUjgxggDBXyPXqtxCfnvxY/fjv+Ns=;
        b=mBAc9ZFGnsE6ZotD89tp4YwsI+g+tEQ0m/0ygbGthbT1dbxnh/v8t/tfJUAQ+OMNvE
         JhtzMTUqGB3OjDJmivh5uMrLTnsFexncUtwXs9vwFUeOzrV+CtwB2lrfpMo0ev5Ovh99
         /w45l4MfDLrQg2gi59nEYLXdgUUBezT7t4O31lCR8JxN1gU1q0I1obMBvkjkc9oOcTGp
         H/8kaiomCzrfZkh9bj/KiSGbMACof1NF8NfgqCimh/c9IM2Ph0bWxu98XewNDigqzoGA
         QyQInwajFp0xOamc3o3sjh0bQQe8WDRhZZWpYDS/JkDSCX5UVb5AE1IRdmCds6xhZIIk
         cc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0HWDrnXckJc0tcbUjgxggDBXyPXqtxCfnvxY/fjv+Ns=;
        b=YQtUuQQgUBmJFU/DZrqXP+eynZ682d0rWboRLW+9g39+B9pfo9grasJGjfkrOT1u9J
         emx0bkESobVr2wHBZmuwJBE/d/zgzKynk1egc+Ff/oXzT+czpP4D77lEMnpypUgKRy0+
         xm3Zfi1UJh9lCpatk6TmbBpqwwGYLobBtEmFsdV29bUsbkjdxjcgsVho5KKDbpt1F8sL
         k2REys9Rds4EcMda1qkg8A82OB+n2Y7ZNmtYfelrt+K/yXe0sMFiOLfFANWTWy57E6ru
         SZiYTT+vl4UR3WP6yiXjQM5qVC/qqa3BHGwnvL7SM3mrox3eMokcW+oZ4hk03gklkpif
         XNuw==
X-Gm-Message-State: AOAM533lkZCiI/YRh9ONhQhNJoXw1cbbjXtlK3fcJ+M5di6BOwuzgd/E
        dPS70QwrUBeiTCotDLvEqz6y7ECduTByCQ==
X-Google-Smtp-Source: ABdhPJwLIPIGlHjiPSTb/6BwaWl5H5eaPOaj6OlMsLUyrE4wgBRj26IPcu6ElPkC6csLjanUbcz5iA==
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr13887560oih.136.1623421713026;
        Fri, 11 Jun 2021 07:28:33 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f63sm1325561otb.36.2021.06.11.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:28:32 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:28:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c3730f6582b_3ad920842@natae.notmuch>
In-Reply-To: <xmqqo8cc3maq.fsf@gitster.g>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
 <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
 <xmqqo8cc3maq.fsf@gitster.g>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
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
> > The case that inner conflicts are presented sub-optimally under diff3
> > remains, though.
> 
> I agree that until that happens (necessary but not sufficient
> condition), it is premature to recommend diff3 style to be the
> default.

Why? Most experienced git developers have no issue with diff3. So
presumably it's good enough as it is.

Yes, we should consider improving that issue stated above, but
*necessary*? I don't think so.

-- 
Felipe Contreras

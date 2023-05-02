Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70324C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 16:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjEBQi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjEBQiT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 12:38:19 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF24680
        for <git@vger.kernel.org>; Tue,  2 May 2023 09:38:05 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1925ad4953dso1074646fac.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683045484; x=1685637484;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GITRPA9dDFmtCrtkvArPiTHIbCIZngiVM2PW1eOdDc=;
        b=MVdrHf0xil0hkMVnB5PLq+Uwa/VB9JeeYmCRFV2HYo917RmTi5IvxUgWiKXlFRWORa
         OPI612b1sMGuj+N17RHGFK1OiJ/IPmjMN2njPFRDMeDy4EZT3QNWdnzjrUu5QLWXeYMO
         fpwBeW3PlQrgdoyqU2q77zkkoo47Ehje1C1mXCyaQb2CemYcPxfBGG+jIv08zhrKxxzp
         jen0JuunoavPF82Qnh3vdCMe3Rx2cxsH5nQPAP4b+u+kUfIEMrc7HdCJGlUKK8TtKLk6
         teidxqSRRsuvrOebsfkT5Q2VHP/9FaNx5JteyfIyelWHMXKlMnf2TaRnKjKGEtN5M5Nb
         MydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683045484; x=1685637484;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+GITRPA9dDFmtCrtkvArPiTHIbCIZngiVM2PW1eOdDc=;
        b=gOooIXud8bncPcj0whbJFk/0xZr8v01Ox3W8LKbmwBAbq2jRlQIuVPIfoPDz/RI4cX
         sef/v8NOJFotn1IkkGO52gygsZ4/sbHsAxCz5gNiDo1dhdbGUOahG+8L532icEfB+Yuh
         Ph0L7UPA2aSG9C5We2J2G6U6PqMCJcolIeKVdLqmv6pxffoi1UtYmcTU5uaVSyhZmjR3
         2JwpkalvCrb93r/iOB1my2tyv63a5UBCD+cVW5cHW8nmRFitV4BMBCmwXxoY92GvqroG
         rR/OBaa2uzg1HvQtT91omzqzja7m0+bchAGs6w801Sor+jIdfaCLSXm5NdIr9fOs1tk8
         wtRQ==
X-Gm-Message-State: AC+VfDzYwQpsi6+JoZvzEyp5kZxauHXfRR0/L5pSEZu3mEA+9cEHWuEn
        PVb9w1GvqFEZrZ6eyaf1uFo1PNNBKvE=
X-Google-Smtp-Source: ACHHUZ7IdhJXUCKPi4swUKSOvnc2eDVhfjBHd9EMotQAyFqJzhxEMyTqS0g5l/xy4ZPkajIVlVDkeg==
X-Received: by 2002:a05:6870:85c3:b0:18e:e0bc:829 with SMTP id g3-20020a05687085c300b0018ee0bc0829mr8511748oal.17.1683045484386;
        Tue, 02 May 2023 09:38:04 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b1-20020a056870b24100b0018045663fc5sm12361119oam.48.2023.05.02.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:38:03 -0700 (PDT)
Date:   Tue, 02 May 2023 10:38:03 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Message-ID: <64513c6b3531f_1ba2d2945f@chronos.notmuch>
In-Reply-To: <xmqq7ctytv2y.fsf@gitster.g>
References: <20230323162234.995450-1-oswald.buddenhagen@gmx.de>
 <ZElHNTiFCblfIDEe@ugly>
 <xmqq7ctytv2y.fsf@gitster.g>
Subject: Re: [PATCH] t/lib-rebase: (mostly) cosmetic improvements to
 set_fake_editor()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
> 
> > ping!
> >
> > (also on three other unanswered patches from the same day.)
> 
> I would be a wrong person to ping.  
> 
>     $ git shortlog -n -s --since=18.months --no-merges master -- t/lib-rebase.sh
>          2	Phillip Wood
>          1	Derrick Stolee

Also:

https://github.com/felipec/git-related

-- 
Felipe Contreras

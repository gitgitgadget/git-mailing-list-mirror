Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09690C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA7A22B37
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgLUE55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 23:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgLUE55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 23:57:57 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315C8C0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:57:17 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 15so10151956oix.8
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=aOqlC3BhIDitRlakYl9Fd28LPPcLYk0Qmqv2cwA7C6I=;
        b=Er1vL6zuUQav3KQZRuhcuQvQDr5fecoSyF1CDwwFAvxMAtMHho2vqeOMs+xa3nX84p
         SNwn7RG/VqXY1v1+LlVrgSWoEFoTuo0/MXxrx5QKeXwkmeEQ7KYlJ/TaZCaPmlgiyBTx
         scS7meTrGbBj+lJuEBE0dqEThz5hafh5TEW8dMzZywNT9ipcr7Ph1mNGcfeYdwu+RM4v
         SmuLlvJezBJmbeOUFzpBoBxaT2xebj/1VB78bYmcGuhdoLL/c9k6KeH6lD6xnrKvkadI
         YpglPylx1jQgiiLmJBk4v/WH1dp4Ww2AWrm90JjsaJ+iSGPQvIq6Pcw9tTFVPjAloXZm
         K5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=aOqlC3BhIDitRlakYl9Fd28LPPcLYk0Qmqv2cwA7C6I=;
        b=IgROA8qMD1s0FhyMPHYy0V4WO7vPtoc3WK3eHFBOVxzn6z6jN3E2DcC/2bmyQCPKiu
         k+/q/1dMB4atfK8SFL3Pvtz/JH3TOZNjl6tEmJf/NKDqvqjfAYcRqICwDwO+vq8PTqkP
         ULX83qPDCIGiywpWMCfaV/I4ONFc6Fjs5ZYxq929mGNv2+UuBb+V6wd62bkeBq6+7nCs
         QLpp9kqCSNpavxw54hrlOA2dLVmt5kx/giw3qr1PWXcMLmWml/gX+pzAHbpbPBUeHVZh
         mYZ+O3TD8609DWzVccPJjWCDBPJMlGN2LUwvEtxIk6Osv3lDE0tG4x2aRihPDwe9US0b
         nL/w==
X-Gm-Message-State: AOAM533u/J2Q4wNOh1GnH4fdHUIaGzeiMWYC9Sz89f839xvKc4x7I41y
        oeEOi8kw6Cg8pbP928Q8AstKa8LDz3czNA==
X-Google-Smtp-Source: ABdhPJzuiBqCICuYoWhPBJHMkBGsaM62wK9qTvVDgnUMf2Imotg0nfjXe8/7ikiuLoSSCnYcLiO2WQ==
X-Received: by 2002:aca:ba86:: with SMTP id k128mr9756884oif.9.1608520161921;
        Sun, 20 Dec 2020 19:09:21 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t13sm3360763oih.26.2020.12.20.19.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 19:09:21 -0800 (PST)
Date:   Sun, 20 Dec 2020 21:09:20 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <5fe011e0a155_89f1208d3@natae.notmuch>
In-Reply-To: <87czz4thk4.fsf@osv.gnss.ru>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-24-sorganov@gmail.com>
 <CABPp-BEf2nbahjzR6aLLNy0YsHYcHqCozCe6veoZOH3LAM892g@mail.gmail.com>
 <87blercju2.fsf@osv.gnss.ru>
 <CABPp-BGPZiwjSzZw5PLwkctW7hnG2S6UGHmkTGCh1BqgXJ+vEQ@mail.gmail.com>
 <871rfm95b9.fsf@osv.gnss.ru>
 <CABPp-BEZ6VqyTah7QCzkuUm-p7tA_6cnpGPWpgpQbHp_c3Wc5Q@mail.gmail.com>
 <87sg82m2f6.fsf@osv.gnss.ru>
 <87czz4thk4.fsf@osv.gnss.ru>
Subject: Re: [PATCH v2 23/33] diff-merges: fix style of functions definitions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> While we are at it, Linux kernel developers care enough about style to
> provide script that checks patch series for issues and to insist it is
> run before submitting.
> 
> I've used this script to cleanup these series for the next re-roll and I
> think that having semi-automated test makes a lot of sense, so you may
> wish to consider to adopt it for Git as well (it seems to have some
> requirements that are not enforced for Git sources, but not many).
> 
> The script is called scripts/checkpatch.pl in the Linux kernel sources.

Yeah, this has been suggested before.

It would make the job of newcomers that haven't learned the style yet
much easier. And also it would make suggestions about the style of
patches a bit less subjective.

Cheers.

-- 
Felipe Contreras

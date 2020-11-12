Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D32EC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A3D216FD
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHVvg1bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgKLWAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgKLWAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:00:17 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E27C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:00:16 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so7566935wrr.13
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c59XH7SsRZjIN0H0vQpmspJ5eb03/TXEy+mK7Mt+SA4=;
        b=cHVvg1bCktz0FjB//N3yGMefne0ffQLVjfngR4WluERI+FYZcOBqBHIXK6n/TnL14x
         iKgJOsJ197iiorM2zJfxFDhVgkuIVFFPsVADZwso4D7I91roEc/1WKl8XL/EdqNxJ7OY
         LKcT1LnGrpIQXkx3yp2p90hGIblWHZfa7P8kfJf8gh5oZmmyxLGOBkC2ddTeXYdWJPr4
         EPNmO0MBtQ5r7ch02nztKEkKbZFppQ1PRYN2o6kM6yt3nLik2x4wpuW2Nmf0M58UogPZ
         wD42mfQ1hOmPjYn+2WxWhfh0UPiwACkCEjC6Zq7ylnnMzc19XmTLTwKnYJQ7A/15RAoP
         VokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c59XH7SsRZjIN0H0vQpmspJ5eb03/TXEy+mK7Mt+SA4=;
        b=VZ/JjuCPNP1P6asu5olH67GDUSsC7TMePAMeVVjEbT72MVCy8dZc8HITJ3lQx4xfQp
         BxQ79drZF95vIcKTmiBDlwMiA9h+eIx+AdjWN58W6M0/bml2oIgl86xJs+PMPMofw13u
         MYIpKwsscPT2bAelUE6PcYke5XVB/IQ7AajDrr1Zy9e3iH9hOja+jIZ2sqCI1tslHZmI
         aoLRTsfhSR90g7V0bZiQNl9ofeZJ/UYx33N5nHm8DGzuCuD1fUCqvE2WaNz0bjp4YrkH
         zXWxqhOLYFdRfguxEtw+doDLRayC29JE+BW2eodsFmvMEzn6f4r0Z4nPF/n9igNGkOYT
         Ofxg==
X-Gm-Message-State: AOAM531x9vXBxO6TDxox4c5dBygAa0v428wd6rufuEvrRkBk/yPwe6mA
        8A2FCMaaFodUiJ6SJC0FoeKdEfe3OF4KG4pbD5M=
X-Google-Smtp-Source: ABdhPJy9+DXi2h33LIgNu9yIP5bVyHwEWTziY0Ky+PxPR+xi4JiMI76Rt4/5r4WUwr1H7rNxbZxdWDHVW2lGPclsUsw=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr1969492wrv.255.1605218415552;
 Thu, 12 Nov 2020 14:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
 <20201110212136.870769-13-felipe.contreras@gmail.com> <xmqqo8k2cppj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8k2cppj.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 12 Nov 2020 16:00:04 -0600
Message-ID: <CAMP44s2bVqMGGOcBBVUP01f49C5tTxVRZNacRzAqpO8JwE7DTA@mail.gmail.com>
Subject: Re: [PATCH v2 12/26] completion: bash: refactor __gitcomp
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 1:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > We have to chunks of code doing exactly the same. There's no need for
> > that.
>
> You mean "2 chunks"?

Yes. I noticed the error right after I sent the patch.

-- 
Felipe Contreras

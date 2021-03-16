Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E217C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B2765103
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhCPEcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 00:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhCPEb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 00:31:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C050C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 21:31:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j3so19916286edp.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 21:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M+1qFfwBoHkZB/mmEAKu7n3oKd9BiwJS5EzJ5H4STd0=;
        b=FsMWqKlnakG/5qWK9zBOpi5cgQFx/2v0k1ahVAWXB9alcPJlc3IkW1QYWN/b0FH0la
         NAXJct59CsvFU1Pvo8UW7RzEN8jJght0FsyPvyGfXEbas6iQVaIlzH0pHuDQAUpiUBez
         AMTLl3/QMGZqkfBOFC/WRCFvVqHlqQJfV04/xYy/IS+eZBIlxoLDhMXwcaR5RrbscDhU
         VD/KQTYyE0vh0PwKwZYemJrNvOVt4B8dnvrk3zVIL7R8J/jN2u0zAWmoKCmtFQcr7ClT
         dZjgPGqaEzRUFdd0MI8o0Ret7n2MeE5RRMAci3dFQqLiAWNFtaUI4dq/iIU9cz6KWPQr
         TcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M+1qFfwBoHkZB/mmEAKu7n3oKd9BiwJS5EzJ5H4STd0=;
        b=bler7GxptBi4Yl0b9UhoCdmENg2soWOLkzuZsKKTmH7aDg0z03rTirj5ke+vSOgmTz
         mifJl7TM/pbQK1OG/OKDPQnr24LRCsvSHmm7PKDhiL+291Mg8WdWTxKB2FPfurDwrbRU
         VvBy/ylp+Izml8mo2LO/RbopMVlo2xWnqSonVh25N6P5IgdY3zyzaO9pNLQejWI1utqN
         uRd4TAWsL90b4AeO+5l4roJGtPTOtBzBwRydoz9+8aAoCyh1HIfOKSMS+ayHnaVHAU5l
         ZvC9tVpuxyqlK/OYU6US2/tnhkFW8H059yPqFLErafc/DIE0G6IZk7yyshcwi8yg9DP+
         +YdA==
X-Gm-Message-State: AOAM5335rcqNdl/9wNdlIFuTooha9VUUVzDOn170MGDg64sojYoTTYMz
        8Ka+RrHHebbY3T0PxGgaXigJfDooFkCsN48HNQtsFnSizDHfxw==
X-Google-Smtp-Source: ABdhPJy+iqg3q/pAvfxJMLmkUJaCSSe08zlwOHwoy40tIqEWEjNiDzDyuInLPRVUS3MZTcTi6o6565TbSfInQwfBdbI=
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr33243605edb.362.1615869115194;
 Mon, 15 Mar 2021 21:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <191391AB-F82E-4786-A96C-FD14FA173FBD@icloud.com>
In-Reply-To: <191391AB-F82E-4786-A96C-FD14FA173FBD@icloud.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 16 Mar 2021 05:31:44 +0100
Message-ID: <CAP8UFD0v+nF1cLCY62irfzCahHKZWOb5qKAN-Mo+MLA_xNWkTg@mail.gmail.com>
Subject: Re: [Newbie]
To:     Piyush Sachdeva <cosmologist_piyush@icloud.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 16, 2021 at 12:45 AM Piyush Sachdeva
<cosmologist_piyush@icloud.com> wrote:
>
> To whomever it may concern,
> Hi, my name is Piyush and I have no idea about contributing to large open=
 source projects, yet I really wish to get some good exposure. I=E2=80=99ll=
 be more than glad if you could point me in the right direction.

Please take a look at the following page and the documents it points to:

https://git.github.io/Hacking-Git/

Best,
Christian

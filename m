Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF0BC678D4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 12:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCGMJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCGMJX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 07:09:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8774DE3B
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 04:09:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ay14so47580575edb.11
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 04:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678190960;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jtis/mXXHP/P4V6ZTfvgE5YEc3TvgVRkR+KGOZLY2qQ=;
        b=Nxi+gG5JMusFgIcJxHu4iKsOebE+Pi9JmiPZKMhqTQKOQs5Hlz3mZmtnA1JLAHMqP5
         zz/MKR3AkQ5jMB794GQt0q+k0+F2wlv/jNeVDX3mA5cLlkvE8/SWd85pw79Vudz4C1/T
         txBBzslkfg0JX7v0fEaBta32KB4+o35o+ZrB52GA8P4++mr8WLoPWtQnukEIUFPAenLF
         qEgQBP/hs/yMN7Zv6NjTsqyu51mIy6jwknEjGJHU2UoJP4++S3EY5Jq8kaC3Svo3dvqZ
         KtpMA6yG0VwpbuBhf+DFZD48CBD5lJ6NijPEUdO3iMrqPZC/Gz3pe3cq9Vv/CBc0bRDQ
         XtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678190960;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtis/mXXHP/P4V6ZTfvgE5YEc3TvgVRkR+KGOZLY2qQ=;
        b=yWjysRA/s40dcWU1TpMVlx+M50c9GWXgm2tAjhX/php7e4eKvrTMXDVGGeKZ4drdBe
         GjTxURNbi1Hj6c5RDzBdS3CUOOU4o5SzaS3oPx9kYmbIzU9y7aPbs3z1f2dDdewGNtuX
         xVxS4imyiB3zU78a9d8210hkfNKMl7OEgkhvwFnGnA0/uSKq6gpST1VX+mgG/tDUieSp
         mboeWxgEag+Q08d/IHY2BgDlm9IMkpvADsDhgCerXuHY5MDPA0ctIvKGBJgvLJLFgf1A
         K0tYEvsTIl9M4RvTf/fOV921rD8zppwVX5WFWDZZ1vHtnH7+EPjyfGXuGa0cVhdekQSN
         3UkQ==
X-Gm-Message-State: AO0yUKUtMjp0f7TW6oY3xFQJItMheE6XHQy56Z5fIShvFIFJc2GFqa/n
        bBbLoFRbwzrG0+jD6C43JOd/bUBm3ak=
X-Google-Smtp-Source: AK7set9IaxTdtD5yE+axFPRk2/1Hb5yKfvKZIgZ1hHveE2BwXyjZb9sHNPWNri6p2eUYd3FFjLpHFg==
X-Received: by 2002:a17:907:6eab:b0:7c0:efb9:bc0e with SMTP id sh43-20020a1709076eab00b007c0efb9bc0emr18632012ejc.62.1678190960033;
        Tue, 07 Mar 2023 04:09:20 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q1-20020a50c341000000b004bbb691a334sm6711796edb.2.2023.03.07.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:09:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZW87-000hRM-0L;
        Tue, 07 Mar 2023 13:09:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dinesh Dharmawardena <dinesh_dh@outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Let us not call it git blame
Date:   Tue, 07 Mar 2023 13:08:20 +0100
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
 <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
Message-ID: <230307.86sfegzrtc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 02 2023, Dinesh Dharmawardena wrote:

> Hi
>
> I am writing to you to request that the term blame in git blame be
> replaced with something that does not sound so blameful. I=E2=80=99m an S=
RE
> and we actively try promote a blameless culture as such industry
> tooling should also follow suit imo. Progressively phasing this term
> out with a better alias would be great.

You might be interested in a patch I had to address this, posted a while
ago:
https://lore.kernel.org/git/20190401101246.21418-1-avarab@gmail.com/

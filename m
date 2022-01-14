Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF708C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 12:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiANMV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 07:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiANMV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 07:21:56 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D520C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:21:56 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 30so34418730edv.3
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7H5fdUrBxZMA670FXFa0auTQ8raHyuu0q66g1l+D8kY=;
        b=EuL9E9fbe9BRu0tr9Mo//czndq6u5rsUoZhxwDG3tZyGZWKJiRmiSP21C8bCkZAz+l
         KbThmfmRCO/BHKDXLjI4/bIzde08z4ET7oQbUTDRwHYbgqKP4cnGhjHPAd/Ovol4Yh3Y
         0EoHX0RPmrltMHKqIgt2BgLT3sD+afYpfZv8ClmHYk3/BqEhLFZTknWYPuxbo2I5HbAA
         1Qs1pLm7x2RUEN2Sc31fkl+Dr3zdHi8ZRE/DqtDaGVJmDdh6XqZSWb9ZeDXjiqXdQ4Tw
         P0Df/NoVYIOb64VT0elUd78kf8pxtUWQwu1HM5kuCQ7NsprOUlq30YdaI/84e2Ft9n28
         ukfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7H5fdUrBxZMA670FXFa0auTQ8raHyuu0q66g1l+D8kY=;
        b=OnqL4QZ7f6OFFb5qZ7nHZ//seybiQlDN5/v54JYmr/fT/R9ph23rzJBEECsX/w3r1h
         rh0m0zRE68Xk2bgwoAy/cJsSNQnxBf0oVZ/kSyLXZF4MD2DXN1CD+jLoIdFKHn8l7Rk4
         9AB9+LSWl0HehDDOFc/3rjbsiL0ZQYLkzoKp85qP1IUFDpvSMB1ONrPuj+ERwYXxufk5
         KzQO3wu767Pbja270nkbKOzdSni9DdhnEN3UydngLkET4l/CfnS97XBDofCIKT+ASDA/
         EF3OSshtIiErb7xBliTRA0PUHRFSHWjq/xCidvUPaSutNZ/Pdki6zhBr02RiP5wG0mn5
         uaQQ==
X-Gm-Message-State: AOAM530wUqJocaEwA+44fe+i8CPmIATQ8ujqiA7ybmnOuV2tafHJ1WaA
        ZwhaqAm8FcNWglnWkNt48v4=
X-Google-Smtp-Source: ABdhPJyGzxoiSRwc9I5eLaFIUj9KSl/oBqwrudymyTBgglyU7/wQc32E1wWrmMwXshiRLIM1D9Xnmg==
X-Received: by 2002:a17:907:7283:: with SMTP id dt3mr5858668ejc.303.1642162914851;
        Fri, 14 Jan 2022 04:21:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg3sm1777150ejc.37.2022.01.14.04.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 04:21:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8Lab-0015kx-MQ;
        Fri, 14 Jan 2022 13:21:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 0/3] For v2.35.0: refs: ab/refs-errno-cleanup fixup +
 remove "failure_errno"
Date:   Fri, 14 Jan 2022 13:21:44 +0100
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
 <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
 <xmqqo84gu4sb.fsf@gitster.g> <220113.86lezjvn2d.gmgdl@evledraar.gmail.com>
 <xmqq8rvjihzq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq8rvjihzq.fsf@gitster.g>
Message-ID: <220114.86sftqse1q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> So just let me know how you'd like to proceed. I.e. I can re-roll a v2
>> with just 1/3, but I think this v1 is also good-to-go as-is. Thanks!
>
> I can just pick up [v1 1/3] and ignore the rest, which would mean
> you do not have to send v2, right?

Late reply, but yes (and I see you did that already). Thanks!

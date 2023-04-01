Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E91C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 00:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjDAAEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjDAAEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 20:04:13 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3351C1F7
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:04:10 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-545cb3c9898so369567917b3.7
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680307449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHeBMwtFWhztCw32SeEtqoQ9oWBu48V7rPoLjDU+2Z0=;
        b=O5yFDrhlUVu+GMdXDDJaSuMVe4QLb+Fzbn6v3tI+XH+fHrKikXS56v3dLZSKawVXS/
         qSmqeXiAtczJ/XCDfR/QEE+UZyVjXRJkEzZ5E/5yXe8e2+6DTNOuaHLBhuIb3z24HYL2
         opgeTDJgtFjYFaOlP7y0G3IYGf5L2hbLc5+GSf4rafBjxS0Y25J+zuAeZE7jQi9lxann
         5aZr6ojw1JQH3iXQp7GsSCQ6f4vPw1WsNlyuSgU9aoOm/NNq45H83FnBaGZfjGuHVRiU
         ryrG8j+WE9MqJ4VSq2CrSdS63dOhfVyk05qsupqjF/umtJIWl2kQyIppknXAh/iRYfC/
         EvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680307449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHeBMwtFWhztCw32SeEtqoQ9oWBu48V7rPoLjDU+2Z0=;
        b=pVfR5t41kDRkPZlbkUBVok4lv3wePcvevwtnKAzIGJWXh2zMUTLgNd7iv06qIePmQK
         7pqlVVB9KcyUmn8EaTDSMuoXJNIpXuK+zwuRoCo6zrMua0BOTXBHsgY7TVASS0a8m50G
         1nwV6GArECBq/xJ90zA6orRM46RZhl/gXsTXPliVL2CBc5KrcISWk4lzJ/picH+4P3fM
         PheBW5jgcxza6HAAbenkBv2VkMX8YyOD9KqqrEf7LNDTj7vVtO2hNlcZAIbcWoDEUUzt
         TBt42iBtybnQdmQQyG31humiKFv428HR1u9vNVuFS1jCetCIz6wB5Db/6QuZCp35rFrH
         chBg==
X-Gm-Message-State: AAQBX9dJfBMNzKIxxLl25Xw71fmmK/4HP1uj/9KU2YsMPvo6UFQR2grL
        gL62Cv0VS9nFJIjprnuWGqqt7+Fv5KinvurwhwWDVw==
X-Google-Smtp-Source: AKy350ZEsXIoZf49fQhRtsbjnbcT+NHiHkPq5j3NRze/MqJSwBv5MEFHMphJlQ3XBuzhX0Q6kfwb9A==
X-Received: by 2002:a0d:cb02:0:b0:545:6692:40f1 with SMTP id n2-20020a0dcb02000000b00545669240f1mr26792208ywd.17.1680307449694;
        Fri, 31 Mar 2023 17:04:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c4-20020a81e544000000b0054602054239sm830021ywm.92.2023.03.31.17.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 17:04:09 -0700 (PDT)
Date:   Fri, 31 Mar 2023 20:04:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
Message-ID: <ZCd0+MqwYkKBO1DK@nand.local>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net>
 <xmqqh6u3d119.fsf@gitster.g>
 <CAMP44s0eSDBXZEN9fRPdxV4GKLqckKtujMLDPORDjHfsdypDBQ@mail.gmail.com>
 <xmqqa5zu4ka3.fsf@gitster.g>
 <CAMP44s3xVL0UHCHh2Ei=STTx=grkpvUTfj6o9roe3tL35GhG4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s3xVL0UHCHh2Ei=STTx=grkpvUTfj6o9roe3tL35GhG4Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 08:19:08AM -0600, Felipe Contreras wrote:
> > It is my impression, however, that zsh in its native mode is even
> > further out and away, pushing it on the other side of the line of
> > being reasonable to force our develoerps to adjust to.
>
> Just because it's your impression doesn't mean it's true.

Sure, but zsh's incompatibility with bash is clear evidence that it is
further out from the POSIX standard. But I think the argument is missing
the point, anyway, which is that it's incompatible with POSIX.

Is it worth adapting our explicitly POSIX-compatible test suite to work
with a non-POSIX shell? I think not.

Thanks,
Taylor

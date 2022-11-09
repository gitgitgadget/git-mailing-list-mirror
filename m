Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B028FC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 22:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiKIW6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKIW6H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 17:58:07 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793702338E
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 14:58:07 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d123so20188iof.7
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 14:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nHBKYrg7HKuhTLUsOP+9N9QdBxCHXzkE0yA/JT5oLS4=;
        b=b8BHoIuaePQWEAYYfDx2w8iR4eGdLekqewo38vfKCvobGkIhENt4vEn30BvfOQs0Ef
         pssQjVj52bQ9J+UnH+6yGmGeBg780zUelEhxQlP5tNU5g4oUTRRt3lOaQnVoNG4bwvV1
         hfZQwonX3Aj6Agg/J/nvdh6uVz0Vm2/a4hE598LgWzbz/lUxlYihOr4MLcwWOdgdtR87
         fKJWqF2zIQ3DX1Gu5lMJDDRKL+foZWknHlVxpwSsYcVtrffqdc3psUWTCDx+ERkjDZcJ
         JnnjMyqGRKLRmmx8oFxZ0yGJrYDO0jRHVfvfZTIzd82LPHMP6dPWQr1Qn6uDMqFk0IwP
         iVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHBKYrg7HKuhTLUsOP+9N9QdBxCHXzkE0yA/JT5oLS4=;
        b=X14STZ6T/Q2GdENyHm3NAxmzPUsCJJ7zeFkrKsdmuZvudV6l5QR2Qc3zO0lH+guJQs
         EcRa1BiUzR62QKhyRnCnDg2lWcoF85cEKJtXwyox/DgyWSyZxIXoPJ6JxhJxOkuODbO6
         CYBSZaSTBM7tD8wIWqoQXgQxBFn/G6moHQn5uIU7i3V0pIrYckWEPb4hrDRbyuojnECD
         /jCGdYuV3n9H3LTsFO1rGKAX7q0WgrnaOcB526mRUJLLRqG1sFd3204TDaLsT1EYoWR3
         1FNKWZxnTSiq6Cf4KTm3Dc3G9QKj/MP2Jm5GJkSEm7TtOaFc7Qo7gc4Bv74V5nPwcckY
         WNoA==
X-Gm-Message-State: ACrzQf341WJ6Es0cK2sv6mX2PJGjJ1t6q9Wk7Sf95zZSv5EO9HkGb60r
        X9vcL59fTsKebx19+YVdjHKT8A==
X-Google-Smtp-Source: AMsMyM5Di3WHjH+XxiydMXBXIG6Y+zKK2QihkFK9EXG4VJfhGfNPetCDTjFz1WO5NUeO0j9YYih67Q==
X-Received: by 2002:a02:b790:0:b0:375:1a70:9c5c with SMTP id f16-20020a02b790000000b003751a709c5cmr2332176jam.129.1668034686532;
        Wed, 09 Nov 2022 14:58:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a3-20020a027a03000000b00363a4fcd3a8sm5199019jac.5.2022.11.09.14.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:58:06 -0800 (PST)
Date:   Wed, 9 Nov 2022 17:58:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Adam Dinwoodie <git@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix cygwin build failure
Message-ID: <Y2wwfQWrs+KYpWNv@nand.local>
References: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Wed, Nov 09, 2022 at 10:46:05PM +0000, Ramsay Jones wrote:
> Commit 1c97a5043f (Makefile: define "TEST_{PROGRAM,OBJS}" variables
> earlier, 2022-10-31) breaks the cygwin build, like so:

It seems reasonable to me, and I'd like to pick it up rather quickly (on
top of Ævar's branch), especially if this is going to break things
downstream in Git for Windows.

Ævar: this sort of change is a little tricky to review without more diff
context ;-). Do you have any objections to me slotting this on top of
your branch?

Thanks,
Taylor

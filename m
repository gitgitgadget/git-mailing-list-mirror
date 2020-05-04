Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC0C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5889320658
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOFs0UR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgEDV3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDV3p (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 17:29:45 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA17C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 14:29:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id z7so23440qvl.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 14:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=ZXe64vcupvKefUXMNVMxBWwbNO7MdAlmMhhWvabPWUg=;
        b=NOFs0UR+SfyT435ZYTgDOr0BIXOlIzpuqOzb4uFzGA+M/HEYphJU6PeihG8RfGguvD
         XceSpJgUdVmqdbaMmnNVxslH2AbyQMR4fTXHIsB85BShnTqR3EbTFluLa7LdLtqIjFHC
         kwwUz6zjPLSeKwQhlpZhcOnUZl+pRzomqKxIJJ/NJkqQPQqY0jCzLG8o5LGGYvMbSE+q
         tpCy8dAyMpwe2/CCZxd9j+1SEq4eKp57Fe8QYUgmvTl9v1mi12f3s0XpXPkRfeKih6Nd
         5SaaKOHNAZgRm4UrWKNzcL9xxsH/jZuxn1DsZBc5fnwcr5MHIBWR0V83vSwyqv84o0Il
         zlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZXe64vcupvKefUXMNVMxBWwbNO7MdAlmMhhWvabPWUg=;
        b=kzt4wiHPK3WPJbFMtz8a15GsgBj8UwIJSrORkemvNoKIah8o51Mf8OxAadgibsa3+e
         8yV7TDt1b1Ykb/+TFCo2FwXaqzot48SaPhkPm34WIS7vXU9YDHLUn1pXAVAntz3hBxc9
         yDwTeO3c2JiqPs78PRON5Tp+BY7sXDlNyp5o/paSCWjbEEaznVdZEG5j6zcf21eBijgo
         XjOFi8Afcc4lb6AQFVgWEslVfH/nEoedpf1wjbr6kC5VfRTAkt9d8jtdy0ijfT/xkgh4
         osle/iFp36Kc9Da3EqmOTsjS8s3Ea24Kg5QFWg6OFqXYjEQ9TVhydATOu1oVJ4COZ22J
         U8Mg==
X-Gm-Message-State: AGi0PuZTznVO7ErUvEG+yAysm00X2VogLz5ovosSVHW/IB+4xfwnYNcP
        JGYdDQteGsdgoapRlYirXfs=
X-Google-Smtp-Source: APiQypIeO862J3a+OgFD2sHtkeSQSm+Rpn/f62uTs/XiGXjmV+qmaFuk1kKmXinmvIw3hWNI8VXDvQ==
X-Received: by 2002:a0c:9a08:: with SMTP id p8mr9788qvd.54.1588627784066;
        Mon, 04 May 2020 14:29:44 -0700 (PDT)
Received: from LeoBras (179-125-207-129.dynamic.desktop.com.br. [179.125.207.129])
        by smtp.gmail.com with ESMTPSA id p22sm33607qte.2.2020.05.04.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:29:43 -0700 (PDT)
Message-ID: <d2bc3b0ff43461f14ca7b532554759169cda9e83.camel@gmail.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?ISO-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Date:   Mon, 04 May 2020 18:29:29 -0300
In-Reply-To: <20200504203556.GA28192@coredump.intra.peff.net>
References: <20200501105131.297457-1-leobras.c@gmail.com>
         <20200501125308.GE33264@Carlos-MBP>
         <xmqqees3odrb.fsf@gitster.c.googlers.com>
         <20200501222723.GF41612@syl.local>
         <20200501235948.GD6530@camp.crustytoothpaste.net>
         <306703d7687377d6a74ec9f1d63331580a3c109b.camel@gmail.com>
         <20200504203556.GA28192@coredump.intra.peff.net>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-05-04 at 16:35 -0400, Jeff King wrote:
> Yet still,  I was asked for password:
> > Password for 'smtp://mymail@gmail.com@smtp.gmail.com:587': 
> 
> I think the way the host-matching works, you'd need to put the ":587"
> into the credential.*.url config section heading for it to match.

Oh, that makes sense.
It works, thanks!


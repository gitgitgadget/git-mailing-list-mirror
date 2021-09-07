Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6598FC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C778610E8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbhIGWWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241562AbhIGWWm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 18:22:42 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEF6C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 15:21:36 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j15so252232ila.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6Y5d7xvks6DT8vhfhmRlhr2WtUo+O6H+3a4AF2o2YxI=;
        b=XlKDdiN6Lmc2+USdgL2vxZsZcZpuCiU7rFVZdPsOzhjDXzy/SBfTqNQPtm6PBojgTK
         9ku1EXZas4fxnyerJV/aYUE1AanXdvm+MwEESJKwOB5myrDOrForyw266KxfqiAPcmHl
         usiNRyzkP17cqEJx5nvHVPegm2VT0xScvWZlws8Yekmrw68X4kfUVkb3YnVw1W3TcTCU
         IRma87Aq8e5UDfCLxWQlpcT2p+kRHoJQrlIrJuJhpFTpvcyzcT8rUWn3jxiT6sHTfz+R
         3wAM/XtrPioKQEkKNolEJwJu+bxJexnf1+GuALYp+2TLKiWP8LVwmsc4XyPvKyNEDLpf
         1WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6Y5d7xvks6DT8vhfhmRlhr2WtUo+O6H+3a4AF2o2YxI=;
        b=tu1l20/3DMTRgb0XLaUtz1izQVFukhSTg6EkWwUpO/iiV5vyzU0znb/6v5vMC7ePie
         DeBPA1IHKpjMM/jT1WolRXxg9Wre6H0MyXASY/DQeJNHmmx2pbZpmCsNcmCAh4JVrrLI
         W4P89bBKBq3ug/hLrzv4yAO2UWQCpNfiVxRB/6HwVZqj9r4aU7cMsaFq8nYJLMyVbJ7G
         3yUYTE/umkvJiOgj+V8IMUjhmGoqD05fwe8avpTx5XLhpPODyHZgAYY1LHRTBzUNlt27
         A6aZGRVx2iBYdsmKwS478CET8R7JlrpyCoUIDheLDUQzjA4grt/3zNsDGK4ifgqKxfDc
         6d5g==
X-Gm-Message-State: AOAM532tkVmOPeXszH+LREFXdY+VKWEcTG4bzYAS8L3NbViGhXpBB5+o
        7H0iQllGFpmWQl+lDYmw9Jb0ojmmDcK1b74J
X-Google-Smtp-Source: ABdhPJzKI49fS8QGhY0/MS8FNNSkClUTCT7e2D8jGE9C62NSTcxvg8HhUhBrtfB3dLrAaVDxyPW9hQ==
X-Received: by 2002:a92:c6d1:: with SMTP id v17mr339629ilm.302.1631053295480;
        Tue, 07 Sep 2021 15:21:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r11sm239809ila.17.2021.09.07.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:21:34 -0700 (PDT)
Date:   Tue, 7 Sep 2021 18:21:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] pack-write: use more idiomatic strbuf usage for
 packname construction
Message-ID: <YTfl7U93ttUQu2jc@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
 <patch-1.3-0e6ef07ce00-20210907T193600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.3-0e6ef07ce00-20210907T193600Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 09:42:36PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Change code added in 5889271114a (finish_tmp_packfile():use strbuf for

s/Change code/Code/ ?

(I wondered also if the missing space in 5889271114a's subject line was
intentional, but it does appear in the original commit.)

Reading this patch, I'm not sure I agree that this makes the later
changes any easier. To be honest, replacing things like

>  	if (rev_tmp_name) {
> -		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
> -		if (rename(rev_tmp_name, name_buffer->buf))
> +		strbuf_addf(&sb, "%s%s.rev", tmp_basename->buf,
> +			    hash_to_hex(hash));
> +		if (rename(rev_tmp_name, sb.buf))
>  			die_errno("unable to rename temporary reverse-index file");
> -
> -		strbuf_setlen(name_buffer, basename_len);
> +		strbuf_reset(&sb);

Does not much help or hurt the readability, at least in my opinion. One
advantage of the pre-image is that we're doing less copying, but that's
probably splitting hairs at this point.

So, I would probably be just as happy without this patch. You mentioned
that it makes the later changes easier, but I couldn't come up with why.
I may be missing something, in which case it may be helpful to know what
that is and how it makes this change necessary.

Thanks,
Taylor

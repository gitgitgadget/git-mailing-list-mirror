Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF32C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 00:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKBA7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 20:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKBA7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 20:59:50 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49851A832
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 17:59:45 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y6so10869545iof.9
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 17:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LHyUfLYzh4JBDSyW4IbyfrpiNeDM/reaLuH/4fmFgs=;
        b=UMP20gYzYoyqPByFV5A+9ZezmupfcMmwnaJJyztRQN9P/6/4eZ0C9Ujr3o/bgeO/45
         /tzr3+lIGvObCdzIdPeSajHt+vzazu1FxOKVUK/px3dbX54aVe93uXtgko0aq/biMlq1
         WmlBcQZANJNolh5Y6ydYye5lQG+S9/iGoDY+Ed97ioS5mrWEtk0n2KcBP3rUt/tNp3zF
         DLzhQsxTbi/GG20S+0NaBoaei/w32eWPSOxew2Ap58mzZPDEvCwSmek3eGx3kCr7JkRE
         r31nc8s5InMOCUww/zpT3fmJRZQHjLCo64axQYZaJgmsFkFTM+xWyY3Zzwa04o5Gpomv
         SQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LHyUfLYzh4JBDSyW4IbyfrpiNeDM/reaLuH/4fmFgs=;
        b=uJlEVk3MVUtma3KGCaBy9S+ihYQPOMGztTZ0ahrOqzdaWH+oXsWUTc5rwj55nCOPws
         DkhqUoG/av45VXSPyFD4HZyDOU706eYtpTE9XZNb5x3Tx1NrQrjsdBeAJCTGEDtjhkr/
         HNaEv3ICsIByiUSFvmFQdlbAac7w/pcy3EJGu1rS2xzQYHVLltcYEo3REj2N10M99C/m
         1w4GLhWDMiTvOi1ubeONWigwyWPj2WhInEXjpOcdocOEz6gDTZNeLBMz8sL5oVvrKUZu
         eknFN6iIhSSdVYbAiKEr9LSv482fpaPiRR5vhl5ozSHxpGgtKBI8YFSK4MQNIkAYWwHT
         xeWw==
X-Gm-Message-State: ACrzQf1nKtNCDBG5tofa2ChqooE9vaX9xbNdU9TzMN7Lgvb89JofzAzD
        BGhCxGN1YlE0PH3nXbob4zyekg==
X-Google-Smtp-Source: AMsMyM5NI6grGfgf8oTnnVz7ktiSYwDHlK6XLkJQ+lb7PvXV/agWuNaDxLhUKmEl1mvsLaTGvLLxRA==
X-Received: by 2002:a6b:b217:0:b0:6c5:2557:7176 with SMTP id b23-20020a6bb217000000b006c525577176mr13791993iof.206.1667350785241;
        Tue, 01 Nov 2022 17:59:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z18-20020a5ec912000000b006a4ab3268f3sm4623618iol.42.2022.11.01.17.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 17:59:44 -0700 (PDT)
Date:   Tue, 1 Nov 2022 20:59:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Martin von Zweigbergk <martinvonz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in `git branch --delete main` when on other orphan brancht
Message-ID: <Y2HA/8OuAmynVhQp@nand.local>
References: <CAESOdVBpsbJ0obD=qDjHBJg-wwWUL5sQ-7X_h13Vw39Q9QUzHA@mail.gmail.com>
 <Y2DxxZAFbN8juHY6@coredump.intra.peff.net>
 <Y2F9lkCWf/2rjT2E@nand.local>
 <Y2F+MA+cAsEB0Glb@nand.local>
 <Y2GTgB0oTW3rR1HZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2GTgB0oTW3rR1HZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 05:45:36PM -0400, Jeff King wrote:
> I'll try later tonight to integrate that test into the patch you've
> written.

Very much appreciated, thanks.

Thanks,
Taylor

Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B872C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 01:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2071020CC7
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 01:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJOlbw7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfLQBnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:43:24 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:42610 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfLQBnY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 20:43:24 -0500
Received: by mail-pj1-f66.google.com with SMTP id o11so3806427pjp.9
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 17:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sq2hvOgP06ksOXxpKHRx0fAv3/MP1fOkT5a0vHZa+/A=;
        b=WJOlbw7zQXdydn96bORFzYDRomvtU0CeUZMHny+yJFqKShHTfIfWQVm5g3oRHoCNTH
         Ztefqmxh7PZW5rqTNshnVS0XVExu5E2oPgEhqMOFYPuEmVdMCwJXD+4oqN6/+/iK9JL/
         OTGSuOaokwZjn+wqbqQLIZaBMDSm2rY9bV/ula9BgGT6E/dMNqwpuqobvTxTiIHO4F4O
         Uz7yR4gIiSzBQ697QPk6Y5hYP0UPSh2ND3Wf3h5cHQNcJYlMnaYfzFDjJC8RbZBwn4aO
         PSagdvAFFFcfoAY35OcGDjA8NFeFECdmzHqJmfLDoU3QU3yu/G15IQctrqFtgCy7lcfY
         Lv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sq2hvOgP06ksOXxpKHRx0fAv3/MP1fOkT5a0vHZa+/A=;
        b=BRhm0aqm94bxFtWnT4u0ORarjO2fz2lzSnUIpbus7Na0p0JFOftLK66FUQ2PPUYW6i
         159NKwDlXhyBC6xk2D9wRfNQMdhgKGFn3bAj4i6drUCbYy2VZvjfSIIe0bU5/YD8Imx7
         CGGj6xg2vKagzfW2vaV6CFMmNI2KYopKjJJ/JGeWmkpfEb2j8cHkbFkDpubpnGHOB04V
         qceG0Wb1nHerJCFcyQ7aYRrIDqWAPkQAA0h1824SqgUta6gy8uWoAIbkZA7fcHT54U5h
         r9m63yT/eht3Q1sQ5DZW6ehIPaocerbjasAcYq+fo8LLB62rIB9GeE0dfmsNvNyoMSBh
         8Yag==
X-Gm-Message-State: APjAAAXjodCEQoVWNzKccIZ1teBLQ2G+BWYLhcvEPxzxK1oL+IHfWS3F
        s7LjZq+P+f3wBrEMxpTXdA8=
X-Google-Smtp-Source: APXvYqy8D47LJGUvTqT/bbMc5tx0v/Jo7XMrW+ZiADlEboMOQrq4phgc2+e/+l23WoG9u1Wz9hacEg==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr3080839pjv.15.1576547003329;
        Mon, 16 Dec 2019 17:43:23 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id ev11sm975838pjb.1.2019.12.16.17.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 17:43:22 -0800 (PST)
Date:   Mon, 16 Dec 2019 17:43:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: drop GEN_HDRS
Message-ID: <20191217014321.GF10734@google.com>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
 <20191214003820.GA927924@coredump.intra.peff.net>
 <20191214010002.GA945704@coredump.intra.peff.net>
 <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com>
 <20191216192014.GA2678964@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216192014.GA2678964@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I actually wonder if the whole thing would be simpler if command-list.h
> was a static tracked file with the declarations, and we generated
> command-list.c with "extern const char *command_list[]", etc.

Right, or a "command-list.inc" file.

extern-ing it seems like the simplest way to go.

Thanks,
Jonathan

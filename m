Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A1E41FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763416AbdAITaZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:30:25 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:35721 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdAITaY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:30:24 -0500
Received: by mail-io0-f178.google.com with SMTP id j18so41558405ioe.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 11:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9dS4FSTbWYxklvoe5KKialgjFGfhm4X03B2wJbkptUI=;
        b=kRXZ8fs7Uz9xkOCNIDct21x9GvknxQnkNgmXBrMl9AAxIeIZEUvk7146+qFz+IBrBf
         gwlzpkvbAcl5t2bmgqdc0hpGaGpmRlJms28vYNDVOWeAXkFUtvRu48oK0VE3E2aLWCmq
         luex3ZNzXm2tRP3wTjcy9Nxk6MWYLA2Ot99SPXF5ma0T3IeOE3mI9TDaQVpsYygsYXRG
         hJHUdTcLDh0+BnfMQh4QYlG8L6FPDQDpF9k3rOewhdJHwYVVueQU6qqcqk1lTYKcqEGI
         xvws9ZhcLiaaubsUQ5IFKCYVBCRppsIV6JvmGDS3aARhFq8fZiNmODD+rQDfhgCof1Sn
         uvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9dS4FSTbWYxklvoe5KKialgjFGfhm4X03B2wJbkptUI=;
        b=Txokp8LeIqk+ZXnbnwJ+yzsVBtY1MdjbNWbNyojIB41AsgRn9k3Qpq6wBDMg5Hi1TB
         vq+wYh6tY2C834S1AsKVBpCmyW4L3/YGeIpZE//g2ZO2Ni7pclnuE/9/4g+L6QvzbYWc
         ty1NWqarE4yg1184KU0xEiHuxQ6VhexuibDU3fQK9eVacikKOnWXgxBOlLz2ez5MZ7eF
         fOu0ZwSOtERZ7M37D07koZws8xRtUm3Typ44dEGsS+NR7c5omAKimBLt1Q5uN3XypbXq
         YXI1KtpzEtpEwOc0kV8MUyK9NgpQ6lT0HGU5+QEBzs0Pzwu4UbwIOKlexRWfB8k3Wwqr
         0h/A==
X-Gm-Message-State: AIkVDXK+CuSA63mizxEct35EEWOQe3LPGvwLMosMATrXz5Dt7XMFF4r5ZnwbVxcdrWSvYcr05qL9CtVqmxceIpUs
X-Received: by 10.107.16.14 with SMTP id y14mr7579732ioi.164.1483990223067;
 Mon, 09 Jan 2017 11:30:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Mon, 9 Jan 2017 11:30:22 -0800 (PST)
In-Reply-To: <20170107013602.act7aouuzgzpwb54@sigill.intra.peff.net>
References: <CAGZ79kaM=Uosm7KAvAP-8w59Tyfc7LZiV3ZOr=PZnBgMCzr2AA@mail.gmail.com>
 <20170106210330.31761-1-sbeller@google.com> <20170106210330.31761-5-sbeller@google.com>
 <20170107013602.act7aouuzgzpwb54@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jan 2017 11:30:22 -0800
Message-ID: <CAGZ79kbZz5s5TdudGcOADDxYShTAm5sTCHRo81SSCc13MoF7WA@mail.gmail.com>
Subject: Re: [PATCH 4/5] unpack-trees: factor file removal out of check_updates
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 6, 2017 at 5:36 PM, Jeff King <peff@peff.net> wrote:

>> +static int remove_workingtree_files(struct unpack_trees_options *o,
>> +     unsigned cnt = 0;

>
> "cnt" is unsigned here, as it is in the caller. Should the return value
> match?

Yes, obviously. :/

Thanks for catching,
Stefan

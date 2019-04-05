Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679AC20248
	for <e@80x24.org>; Fri,  5 Apr 2019 19:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfDETZ7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 5 Apr 2019 15:25:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55290 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbfDETZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 15:25:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so7838789wml.4
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 12:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+cyZ3zIl+zgEqo3TFfvh1XiACKTkZbfk2lpnzMo1oyQ=;
        b=r4G9K0petiaYyoi6dWhVzM6QEexkI68uFshgCNIEgk3Ge2m7YcZBoUNo8UcfQ36sYh
         XxuOMTnsJvG924hDExjTS8QpvtRNMwSeJrcjBkTRn5tXAFOI18M56AGumyOVdCroKir3
         xNEqkZkvABdci1GPvlizH/m/LgYd+pCHVTb143eOz50cPequ82kzLZQvdmu4prbFyniP
         rTHVrUz759FcxCa2jcksf+Cul/ZYBuWIRlPjH74mZA/23eAnpVwROoxC97fKGFHe5Ns5
         y/QxfO3qHx3gFhGRsP+GfmCnsCQKmjtX0/g0iLQZStGb3PbsFMLLuUbY3mZCD8Rcz6bE
         BvTg==
X-Gm-Message-State: APjAAAXhIiEA8riBHjbWeUom5shQaW7+GvNXK68O0Op4Q+Hszsuc8P5u
        K8av1IUyVkqPk+jI1RzDTpMON4iAG2z/nqfl2uw=
X-Google-Smtp-Source: APXvYqy0HJ+OoESLPBQjUTjQWCKwa5BP1Ugs2WNFdxawB3KEmLUszDJDTRbfkMEN0WgFQiFmNSEFtNk76DA2/ZGYmTU=
X-Received: by 2002:a7b:c769:: with SMTP id x9mr9270698wmk.103.1554492356411;
 Fri, 05 Apr 2019 12:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554435033.git.me@ttaylorr.com> <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev> <20190405182412.GC2284@sigill.intra.peff.net>
In-Reply-To: <20190405182412.GC2284@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Apr 2019 15:25:43 -0400
Message-ID: <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 5, 2019 at 2:24 PM Jeff King <peff@peff.net> wrote:
> On Fri, Apr 05, 2019 at 12:50:33PM +0200, SZEDER Gábor wrote:
> > > +   git cat-file commit $commit |
> > > +           perl -lpe "/^author/ && print q(parent $blob)" \
> > > +           >broken-commit &&
>
> > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> > dependency?
>
> Heh, this was actually the subject of much discussion before the patches
> hit the list. If you can write such a one-liner that is both readable
> and portable, please share it. I got disgusted with sed and suggested
> this perl.

Trivial and portable 'sed' equivalent:

git cat-file commit $commit | sed "/^author/ { h; s/.*/parent $blob/; G; }"

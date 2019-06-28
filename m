Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8761D1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 23:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfF1XqQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 28 Jun 2019 19:46:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42297 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1XqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 19:46:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so7834167wrl.9
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 16:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cuZiil2ZCKecBi04ysxmQHMwJup/LomSkcJZ3z4Vplc=;
        b=Hwxh2b6ZMxgQRfBUOkuwK83GPS69oXY68r3agyY9sFT/pEXRhppm8Rnrs/+tyZw5og
         XQTJvnfUCeJqqbmwuhmt8VwsfHOeJdWyhTy7ZWK48A4FQVRtWqf8K63OQ0Vdy4Rac0am
         3reWvht0HrTeVLky9SI53hecnIi6U+m+1yuBrMVBO+a3ENdg/2Nf4qj31j5RUqKhkfbh
         apAX80OjM8IladgbwuYx+RM/GO7kX+QwRGoE5dK4sFWxQeY7fUaOo6IHjxo+nBvPY9o3
         t+UesaLAietJMlayI99SpI0nXGNgNJ6ExZZ+wC/4ZUST6mbGCRvUygZuUjL/NkeEQsBj
         awBw==
X-Gm-Message-State: APjAAAWQNhONlqQCSFLLaap4htBOx1fDC7K507iG+1XlwJTQ/9W8sXme
        MwsbHXXbhkCsUCR/FPo0lB99s7ItIF8d2gO83hUjTA==
X-Google-Smtp-Source: APXvYqzA6nlpRnZIN+6G9XrHnaHkNZiBP6FpAiwen//h8G1CI6gfDy/iKW46z3pTooWVZrpZmV+njAIhq7tnFqs6vs0=
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr8021522wro.278.1561765574358;
 Fri, 28 Jun 2019 16:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190628093751.GA3569@sigill.intra.peff.net> <20190628093911.GA27329@sigill.intra.peff.net>
 <CAPig+cQAKVOqYH-CcqzViP_zuKwg5fWO2_i8=Z5t=BVf9uoAXQ@mail.gmail.com> <20190628230417.GC21574@szeder.dev>
In-Reply-To: <20190628230417.GC21574@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 Jun 2019 19:46:02 -0400
Message-ID: <CAPig+cQnvotvJakCp1ic_WP3AMojNmfZw-PoinR=VOODmtNBtw@mail.gmail.com>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 7:04 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Fri, Jun 28, 2019 at 05:32:35PM -0400, Eric Sunshine wrote:
> > On Fri, Jun 28, 2019 at 5:39 AM Jeff King <peff@peff.net> wrote:
> > > +       in_dir=${indir:+-C "$indir"}
> >
> > Doesn't this suffer the problem in which some older/broken
> > shells[1][2][3][4] incorrectly [...]
>
> I think we don't need any of those "${indir:+-C "$indir"}" parameter
> expansions and could simply use 'git -C "$indir" cmd...' everywhere.
> $indir is set to empty right at the start of the function, and 'git -C
> "" ...' works and doesn't change the working directory.

I recall the discussion around the meaning of `-C ""` when that
command line option was introduced. The conclusion was that  the
zero-length argument should mean "this directory" since that's how `cd
""` behaves. However, I don't think that behavior ever got documented,
and it's not necessarily obvious. An alternative would be to default
'indir' to ".", which should give the same result and be easily
understood.

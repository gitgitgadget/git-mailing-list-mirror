Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C0EC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 08:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DC62072F
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 08:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJlP6Ec5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgFHIgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgFHIgT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 04:36:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4381C08C5C3
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 01:36:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so16411079wrc.7
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s49oLnHh7ZhYLIuYbuRqxN3uBm/JaYQuBfz+pgXHHA0=;
        b=RJlP6Ec5/UWL8++FWj2HT086ecjk/Yedjc+GuRfSbiB5aYCN5VMgfFa0h7JXz40VJ1
         FNHy72H+nMQLiuB2M5Gq5J57K3VWqMkw1Q1/R9sznKV+yA/vBUlaGHxwXd3m2NsidTz/
         f/EojF5Qa19/aXb9V96fEKjr3bmhUVIeQawx84vL+jLgGnjdqsd4m+GpFhbSyKHsk1LU
         G7+SYsmexIM0FN8qIJ56BTs89qh5lmN04rI3KzUdm9zPfteM+RD2x0A8yFn/pwqziA/w
         qi2g7NAlgrvkTbQWNvDEDRmGYbzaIR0WygdmbmZ5jUpSr9MUQ868RETY2z1Y2gD54l01
         IbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s49oLnHh7ZhYLIuYbuRqxN3uBm/JaYQuBfz+pgXHHA0=;
        b=AJLXCP6W7BJWS1ldqICp8njnuiI1q8WKliWdtFdepx6yMONrwI67aPUj5Dasl9pv3m
         1GT24ez53+M2htP6+UJT6IhiXMRyVFXk9Nt7XA94XVGFDwHTdE8q5EgcXpQMjZJCsa3u
         fXvbUqrTfWnF9caqUPFNrGElXj7wbEISigETDVd6ZkED4PsHYK9Ya+/mBh3fPEeDPR7x
         p7mlxGKRUVdMuETcg1thhZdn/IW0I+2bn1ZZTW/hV/8g0Vhym5yLVp9Wr6+H99q4oWZt
         rw8rsJD5UH5L6izN7aZghfPH5+IbfdA1F++mo9J4K534wWKCeRQEe7u+JU4KgNTnwmv2
         agOQ==
X-Gm-Message-State: AOAM533AiJpQXTAKDvWPExNg9lRQiwhwIrnR/Cv3hUFAVV5w30Wp9XIR
        N7/qONcG39G8MbGZMaJBLI2QU5uv
X-Google-Smtp-Source: ABdhPJz2pUV0zEHjW0QrTQIPmtX8TvS8gCYD3Tuh6qorgIEe1uYp6phzk8SexsAEYcxedk0BUfLRxQ==
X-Received: by 2002:a05:6000:100e:: with SMTP id a14mr22033394wrx.349.1591605377527;
        Mon, 08 Jun 2020 01:36:17 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id p16sm24360298wru.27.2020.06.08.01.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 01:36:16 -0700 (PDT)
Date:   Mon, 8 Jun 2020 10:36:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     stolee@gmail.com, jnareb@gmail.com, git@vger.kernel.org
Subject: Re: [GSoC Patch 0/3] Move generation, graph_pos to a slab
Message-ID: <20200608083615.GD8232@szeder.dev>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <b850637d-a7ca-e8f9-5009-657096ea2975@gmail.com>
 <20200607195347.GA8232@szeder.dev>
 <20200608054827.GA2054@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200608054827.GA2054@Abhishek-Arch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 08, 2020 at 11:18:27AM +0530, Abhishek Kumar wrote:
> On Sun, Jun 07, 2020 at 09:53:47PM +0200, SZEDER Gábor wrote:
> > On Thu, Jun 04, 2020 at 10:22:27AM -0400, Derrick Stolee wrote:
> > > On 6/4/2020 3:27 AM, Abhishek Kumar wrote:
> > > > The struct commit is used in many contexts. However, members generation
> > > > and graph_pos are only used for commit-graph related operations and
> > > > otherwise waste memory.
> > > > 
> > > > This wastage would have been more pronounced as transistion to
> > > > generation number v2, which uses 64-bit generation number instead of
> > > > current 32-bits.
> > > 
> > > Thanks! This is an important step, and will already improve
> > > performance in subtle ways.
> > 
> > While the reduced memory footprint of each commit object might improve
> > performance, accessing graph position and generation numbers in a
> > commit-slab is more expensive than direct field accesses in 'struct
> > commit' instances.  Consequently, these patches increase the runtime
> > of 'git merge-base --is-ancestor HEAD~50000 HEAD' in the linux
> > repository from 0.630s to 0.940s.
> > 
> 
> Thank you for checking performance. Performance penalty was something we
> had discussed here [1]. 
> 
> Caching the commit slab results in local variables helped wonderfully in v2 [2].
> For example, the runtime of 'git merge-base --is-ancestor HEAD~50000 HEAD'
> in the linux repository increased from 0.762 to 0.767s. Since this is a
> change of <1%, it is *no longer* a performance regression in my opinion.

Interesting, I measured 0.870s with v2, still a notable increase from
0.630s.


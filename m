Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED6C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E757206B9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhA0D7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhA0C4c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 21:56:32 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9BDC061355
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:36:25 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c1so467904qtc.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SZN8CfqGl3suEudGkBcWECqoHiaWhRpilsf8zlUM3Y0=;
        b=LFh9WAxc2pmyUgnDa+W+ylgmI58PImBBlHqOzUXicDstGr2y5FCVR1EwxPHy/IqzHC
         MzUGzyrKIlKFW4ay4Pm58+dcRKUqk/CBGngKuboAz7nc0nEElNYYTfLEU96mtN+nzkcx
         TlgYvs0mWeAittDLTUI1sjWB0DdbhpV3cYmZzXXb4oI1J6JyEhSdaTI/IA6PhR9wWnhA
         L8eKHX4cfm3zYQYjzYaRHYGoNYTzmno/R4mXZc56yZzZ44RwKDc8dwwaUIPc0aP7198b
         72d7pXyIs8ELPbZa3SGzP9/YLbweS5v5sbKHLW4GHECrLpqQJ+nkMvKKzl5l4kuBuOoy
         iopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SZN8CfqGl3suEudGkBcWECqoHiaWhRpilsf8zlUM3Y0=;
        b=LAL+yRL+4SWielvQcsdP2/u3o0uYanQtBlCmyjrQS4UbhzdXtN05rlQBTtMd+TVSV9
         dYivHu657Hz404d2dWorGECMlTgZ7q8Y91yDmoX3fQQGfyKZ3N7tPCJh1YitRBd+AcdS
         qx+4z9qVNekBFpqN9/mU2GoDWAKvTXp+X+2D0tXL0G/WtKkVZox6TU0SS5GBHZoPykIm
         u13uqhuhu3MWNg5M+jH8XyM9Rvu4MLCKEjtyofEKdONi99eJ6RkosU2i0hWH74Kk2BiT
         KzEXcoJm8ous0WLFYHNM5ku4x9EXE+griw1hmebMO6Bo2TfVe86zJZNlg1DZuBiO6OGR
         JFRw==
X-Gm-Message-State: AOAM533P9eFkfN8cwsKp9nMquElL9N99G7k40eVoBjJ7YJTJwEqTQDi7
        oL4UvtaidfoJBn2Sl91f5BF4vg==
X-Google-Smtp-Source: ABdhPJzqgeQeo61EvV2bu+ywMGII0feGd2GD3D1kp5r3XfLJrBwRllgTlDArCVr0Y5aYJ7CvFnLBOQ==
X-Received: by 2002:ac8:c8c:: with SMTP id n12mr7853960qti.339.1611714984634;
        Tue, 26 Jan 2021 18:36:24 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5cad:8534:72d4:8c70])
        by smtp.gmail.com with ESMTPSA id n94sm446431qtd.28.2021.01.26.18.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:36:24 -0800 (PST)
Date:   Tue, 26 Jan 2021 21:36:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/17] commit-graph: anonymize data in chunk_write_fn
Message-ID: <YBDRoEzRKO6GIVCb@nand.local>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <09b32829e4ff2384cb35afaf1a34385e25bac8d8.1611676886.git.gitgitgadget@gmail.com>
 <CAPx1GvfQ4K+2mt0BC-1o7e0omHAvC6XhmpOuGa41v-b850w14w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1GvfQ4K+2mt0BC-1o7e0omHAvC6XhmpOuGa41v-b850w14w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 05:53:39PM -0800, Chris Torek wrote:
> Note: this is purely style, and minor, but I'll ask...
>
> On Tue, Jan 26, 2021 at 8:08 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >  static int write_graph_chunk_fanout(struct hashfile *f,
> > -                                   struct write_commit_graph_context *ctx)
> > +                                   void *data)
> >  {
> > +       struct write_commit_graph_context *ctx =
> > +               (struct write_commit_graph_context *)data;
>
> Why bother with the cast on the last line here?  In C,
> conversion from `void *` to `struct whatever *` is fine.
>
> (the change itself looks fine, btw)

Agreed. It's not a correctness issue, but I find these unnecessary casts
to detract from readability. If you do end up rerolling this series,
I'd rather see

    struct write_commit_graph_context *ctx = data;

...but I don't think that this (non-)issue alone is worth a reroll.

Thanks,
Taylor

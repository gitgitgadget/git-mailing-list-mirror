Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1811F453
	for <e@80x24.org>; Thu,  4 Oct 2018 22:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeJEFrq (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:47:46 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:55166 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJEFrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:47:46 -0400
Received: by mail-io1-f74.google.com with SMTP id l24-v6so10238033iok.21
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LObxZ9RZ87Jh7771bpPRfwTs9UtAgFFS/abzQitqsH0=;
        b=alQP4eM1BP1JtrZkAXrplF6rYI3Yuod8MFvGoUhjV0DeUnedxr3kxls10FWMd9grsI
         MBOSZU8ZnvMsZy5duOZAe/IeJDE4NJngk2FIn+oo5o/Jppn2+XSH+glB2w8qpA71APFB
         A1lKFNPP6Lv6o77gQj0jtYC9Jc/TqcqC2xypdSefYF1S+BwAzPasek/jgTWfZy85FdQc
         +UmJ1tFbZ7xjQjvboYqZxUJImAJptIrsw3sacOVHsz/uq2n7bOeq2Q2Si7jtP+hgnPXz
         hVKWT4TMfBXPuerwJw5LCpWqV/UEQAIhnSNc4PZ/OuY/mhZjeP1LKxgeDnnbONO86M4g
         WFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LObxZ9RZ87Jh7771bpPRfwTs9UtAgFFS/abzQitqsH0=;
        b=MHkvPLIh07pBIgsTZuuBPY9eXH8RYXkM2YdC9DS15Rj6NZ3oy/vEOPIoO6KpqaFW3K
         CIyTSBfKdvTJafCiBue5xYp2Dz4Vt83AlIZiHJVkxlkoX4NSjKiVJsCTeP4/iqsREGv3
         4HoFRfTlaqdXT31L3OBuFevv/405KBqlYBFSoQkkrjngAWqqLAhmmkgHcqkgjw0mlcld
         +2/NU+kWjsYOnMu1GbH3u5hFk32ibNWRzCSVY2M0UP5p8Wq7E5JCVkB7AsUwSZfbX8IG
         kfLdmZ1aRewHBiVsm3pUuaQVFFwCqZTkquwIjKdgWSUiJMzDLTG6qzoFjCwvo4Y3Dz4g
         VVQA==
X-Gm-Message-State: ABuFfojJOG/p6eGXKZeFUkyEN8JoGLXIDeywZ4doC2CkSzrnvSwOQTxs
        R9pZFyWub2SwY0EELm8sdZ8y0jp1X5ie9N7Oq/n/
X-Google-Smtp-Source: ACcGV62ttXMtQiHYRr9Siw7bOFzgRBjprGTFuyPk6MYh1ZeCRxhtuUx3PBQu8CjrcH5UCTLd2SgOPpT6DEJY8E0p0DWj
X-Received: by 2002:a24:e48b:: with SMTP id o133-v6mr4165211ith.0.1538693529005;
 Thu, 04 Oct 2018 15:52:09 -0700 (PDT)
Date:   Thu,  4 Oct 2018 15:52:05 -0700
In-Reply-To: <20181004221406.GB28287@sigill.intra.peff.net>
Message-Id: <20181004225205.176593-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181004221406.GB28287@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, l.s.r@web.de, git@vger.kernel.org,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yes, I agree with you that the loops are still entwined. They're at
> least now in a single function, though, which IMHO is a slight
> improvement.

Hmm...originally, the main functionality was in a single loop in a
single function. But I say that because I consider the lazy loading in
tip_oids_contain() as something both peripheral and independent (if the
main loop's logic changes, the lazy loading most likely does not need to
be changed).

> I agree with you that just checking:
> 
>   if (oidset_count() != 0)
> 
> would be fine, too.

OK, we're agreed on this :-)

> Or I am even OK with leaving the existing tablesize
> check. It is a little intimate with the implementation details, but I
> suspect that if oidset were to change (e.g., to initialize the buckets
> immediately), the problem would be pretty apparent in the tests.

I am OK with this too, except that (as far as I can tell) the point of
this patch set is to replace the internals of oidset, so we no longer
have the tablesize check. Unless you meant the khash analog of
tablesize? I would be OK if all tablesize references are replaced with
the khash analog in the same patch that the oidset internals are
replaced.

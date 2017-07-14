Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521762027C
	for <e@80x24.org>; Fri, 14 Jul 2017 00:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbdGNA2H (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 20:28:07 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:36498 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdGNA2G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 20:28:06 -0400
Received: by mail-ua0-f172.google.com with SMTP id n13so5406882uaj.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SX9GOe/i9QWP06YethADeZ+BVxNzrcCK9j0WFBrF8yM=;
        b=Kji/nAQjii49/KrIemOc9q7fG4BsxAeUP6xNI3Q4cKTTFYMO/4hBvHdv+QTNYYgF0v
         TSGlQZuz2SbX+tYCr9LMY8N7owxzBNNV+anc6Blgi2reLtO/pJXBypKHaHF8mApL4UvI
         bAsRSlnQ+kOxLTnNjfMUeYtIxEVkLiA13GLHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SX9GOe/i9QWP06YethADeZ+BVxNzrcCK9j0WFBrF8yM=;
        b=m/Dgl62aMeq+Dim5MpFTNscKbf4YJ49uMo+HGUhCqq4gKlSWIyVEgbP1jK5G6mKRU3
         8RJRPKtn62Z7y6lOyMNmtUmOGyejAU1BUD18e5l8cpoLBtQUFwljgsxbX4C/lAp4Y0C/
         a67maX1pV2rLwXo6ABv/48ftqKjbPXOfl2oBmyVO8cyRA86KHW1oOXSiQvibgHpoCHUM
         Agos5uJzJqa0jOj7AH0itgsReq0HLU8gZCU+GEC0xV197eDvAfNIlWaaLG78t1/quPrV
         VIPvgNOgasxSmfb5lthYY78pNlMKQZy/8OpOBe5odDtQMY1aoyHyjTbQcXLR06HrYZrN
         6HTA==
X-Gm-Message-State: AIVw112WzO0EXS5KZ27F1zUWMUkHSwZKsJ4lrYnM3uTUgaDB/O3moSB7
        K6/7MeYa7TSSsTmj4eLTUjRCLBffjw8V
X-Received: by 10.176.27.81 with SMTP id n17mr4194252uai.58.1499992085185;
 Thu, 13 Jul 2017 17:28:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.71.5 with HTTP; Thu, 13 Jul 2017 17:27:44 -0700 (PDT)
In-Reply-To: <20170713203533.vcfyf5iei46g4tcf@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net> <CAGZ79kbY_t=Xtpb7fy0sZ9TWOy-UOUx8X5+_qLx60Dtg48Ok-g@mail.gmail.com>
 <20170713203533.vcfyf5iei46g4tcf@sigill.intra.peff.net>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Thu, 13 Jul 2017 17:27:44 -0700
Message-ID: <CAJo=hJv7kaT3m6k1nz1-tGuVAMmgnrS0dcfycGfE3PyXjG3xRA@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 1:35 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 13, 2017 at 12:56:54PM -0700, Stefan Beller wrote:
>
> I agree that a full binary search of a reftable is harder because of the
> prefix compression (it may still be possible by scanning backwards, but
> I think there are ambiguities when you land in the middle of a record,
> since there's no unambiguous end-of-record character).

Its impossible to safely binary search this reftable format using a
naive divide byte count in half and find record boundary approach. I
actually did design an earlier version of reftable that was safe to
use this approach for its binary search within blocks, and wound up
discarding it. It was slower and more complex implementation than the
format I shared with the list.


> But I don't think
> it matters. If you binary-search to a constant-sized block, then a
> linear scan of the block is acceptable.

Depends on the block size. :)


> Not that I'm recommending just gzipping the whole packed-refs file. It
> ruins the fast-lookup.

As I just mentioned elsewhere in the thread:

  src file    65306185
  gzip        28338906
  reftable  28782292

The reftable format (for 64k block, 256 restart) is within spitting
distance (432 KiB) of a default level gzip of packed-refs. We can get
fast-lookup, and OK compression.


> We _could_ consider gzipping individual blocks of
> a reftable (or any structure that allows you to search to a
> constant-sized block and do a linear search from there). But given that
> they're in the same ballpark, I'm happy with whatever ends up the
> simplest to code and debug. ;)

This does help to shrink the file, e.g. it drops from 28M to 23M.

It makes it more CPU costly to access a block, as we have to inflate
that to walk through the records. It also messes with alignment. When
you touch a block, that may be straddling two virtual memory pages in
your kernel/filesystem.

I'm not sure those penalties are worth the additional 16% reduction in size.


>> When Shawn presented the proposal, a couple of colleagues here
>> were as excited as I was, but the daring question is, why Shawn
>> did not give the whole thing in BNF format from top down:
>>
>>   initial-block
>>   content-blocks*
>>   (index-block)
>>   footer
>
> Yeah, I agree it took me a bit to figure out what was going on. A
> high-level overview of the format would have been nice.

Noted, I've added this to my writeup.

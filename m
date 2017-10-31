Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AB720437
	for <e@80x24.org>; Tue, 31 Oct 2017 13:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbdJaNBv (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 09:01:51 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:53368 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdJaNBu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 09:01:50 -0400
Received: by mail-qk0-f175.google.com with SMTP id y23so20263928qkb.10
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7AIbrZiEKGiGab/E+orZZRXF7Y19P2usL3JkgjBWAbk=;
        b=fObl6rwybjHPga8ufJBNbZv98cmE+h9fFzkwJzOwJdd5U2zmMa1TFQ8QwrOo5MqWq/
         On20XXlb6H41qJOEgoREAoVT/DAobifAq/fSy3bvY51lsp5S7SmDaCQsQPhO4saL6t+z
         6TkAQFcOdyr63R4F7qYAlRQv4/+fsn9vD/R+8JBF+V8bxKDskMBKGUkEZMG3+InYCAdk
         c0q8Kwob+3Mm1a+Tqe9of3gwXkn1oYUKeE8yDmwHYxgctyuy58TBLsJE0Ax418BUZ1WP
         xt/eUgU2ctkIf5v1zlg1JBiV4SoS9uz2G5SnYx/hv7Q5T8tjOoRwM18r6Kz5idthQxU7
         HmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7AIbrZiEKGiGab/E+orZZRXF7Y19P2usL3JkgjBWAbk=;
        b=URsNvDcUmYD9YQkhRt5OoQFHYV1ptsDS/mgZB0SyZtY0Aw6jvPU415d7FxyDoq4bn/
         FxQsFjn29pY2mliXgy33Jpe1eFU98U1+zByMT018NfBShStoYP+MyEsXupLk0whxEu5q
         JZ4FAvkSErlrFdaudR5Ui1p3oUZy2V9jfpNQiR1LKqoW53SrMTcxvh+pmv3IaxrEtLZV
         Bu/dkYspLauoSpZoaEpN5jHXXdgyXDpUsotwmK72Ey7eReiVd8t30zdjXRvno9SQ1n0f
         nE1GGMgG1ZDpNSHOowQTEg2O+GOFZmyme6hSNYpnJrAGuu5IZDEfKMtrBRT3ZMTa1yVE
         12pQ==
X-Gm-Message-State: AMCzsaXAmzpOaGeuZSCyqIaOX0pKJmQhcFI6CB1c0z+2lsKiz1BNlzjb
        RNMekeen9Qr5cJANOF5QkyY=
X-Google-Smtp-Source: ABhQp+T3PP4OQ79zTBB6oxhCxNn48qCEcGAmdMnVuyVer+CfWAdmv0qRGHS0gtAfrjevV4HJy5bZoA==
X-Received: by 10.233.216.199 with SMTP id u190mr2403997qkf.203.1509454909933;
        Tue, 31 Oct 2017 06:01:49 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id c10sm811129qtj.29.2017.10.31.06.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Oct 2017 06:01:48 -0700 (PDT)
Subject: Re: [PATCH v2] read_index_from(): Skip verification of the cache
 entry order to speed index loading
To:     Alex Vandiver <alexmv@dropbox.com>, Jeff King <peff@peff.net>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        gitster@pobox.com, chriscool@tuxfamily.org, t.gummerer@gmail.com,
        l.s.r@web.de, jsorianopastor@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20171018142725.10948-1-benpeart@microsoft.com>
 <20171024144544.7544-1-benpeart@microsoft.com>
 <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com>
 <20171030180334.ddursnmj5wqgimqu@sigill.intra.peff.net>
 <alpine.DEB.2.10.1710301727160.10801@alexmv-linux>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f671ea09-d4aa-64aa-8225-c1fbf2eac175@gmail.com>
Date:   Tue, 31 Oct 2017 09:01:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710301727160.10801@alexmv-linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/30/2017 8:33 PM, Alex Vandiver wrote:
> On Mon, 30 Oct 2017, Jeff King wrote:
>> On Mon, Oct 30, 2017 at 08:48:48AM -0400, Ben Peart wrote:
>>
>>> Any updates or thoughts on this one?  While the patch has become quite
>>> trivial, it does results in a savings of 5%-15% in index load time.
>>
>> I like the general direction of avoiding the check during each read.
> 
> Same -- the savings here are well worth it, IMHO.
> 
>>> I thought the compromise of having this test only run when DEBUG is defined
>>> should limit it to developer builds (hopefully everyone developing on git is
>>> running DEBUG builds :)).  Since the test is trying to detect buggy code
>>> when writing the index, I thought that was the right time to test/catch any
>>> issues.
>>
>> I certainly don't build with DEBUG. It traditionally hasn't done
>> anything useful. But I'm also not convinced that this is a likely way to
>> find bugs in the first place, so I'm OK missing out on it.
> 
> I also don't compile with DEBUG -- there's no documentation that
> mentions it, and I don't think I'd considered going poking for what
> was `#ifdef`d.  I think it'd be reasonable to provide some
> configure-time setting that adds `CFLAGS="-ggdb3 -O0 -DDEBUG"` or
> similar, but that seems possibly moot for this particular change (see
> below).
> 
>> But what we probably _do_ need is to make sure that "git fsck" would
>> detect such an out-of-order index. So that developers and users alike
>> can diagnose suspected problems.
> 
> Agree -- that seems like a better home for this logic.

That is how version 1 of this patch worked but the feedback to that 
patch was to remove it "not only during the normal operation but also in 
fsck."

> 
>>> I am working on other, more substantial savings for index load times
>>> (stay tuned) but this seemed like a small simple way to help speed
>>> things up.
> 
> I'm interested to hear more about what direction you're looking in here.
>   - Alex
> 

I'm working on parallelizing the index load process across multiple 
threads/cpu cores.  Specifically the loop that calls create_from_disk() 
and set_index_entry().  The serial nature of the index formats makes 
that difficult but I believe I've come up with a way to make it work 
across all existing index formats.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6FF1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeIQWGe (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:06:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35179 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeIQWGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:06:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id f62-v6so9348781qke.2
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V74cORWyas8LGJbgxkCyPJnaOwaSosxzmlYM3Uh0Je4=;
        b=hGgUxEgEXR+Be7YPYBPvgI3hEwB9mstPeeZw6KWRJ8Nk9RDScN0bzhfaAZcpmGURhp
         SpIx/H5ZEXr/NVyCy0AMRtpN4q826tV8PB9cxmRHXzfIF9dPr4SYxny0bmSSsu/qakeU
         XAlulSYpTNyxmO2xNa3X7d0RNFOwimSLuuRp7H4+BczOHVRGzQ+Gk5HTaXr+J/2TiGvn
         IOT+3CB1vJq3FYtyvvLQiDO74rxoKwHpM7DVbdDvAn+J16b0ywk6AyCv4Vwdc0dVwzpe
         SveqCjc9ezUNK3EKNOAxGm9FHd2LCRnjSdK153tBCyB6vgz02k+MHAN2pP8+s2k7pce5
         28yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V74cORWyas8LGJbgxkCyPJnaOwaSosxzmlYM3Uh0Je4=;
        b=uFmWmrsQ3F2DL6VGsDJZHYu/OrODZsl4QZ0fxKl+wWRDrTv5WBBIS7QhcPaREr5XWC
         DiLwulqQRrCR0M6MGpqrO4FcTr8QMGzIAR/lmeZyOyVpWwVNuHaC03kOo9xRDUr9jyaT
         OhUDYn1PImiZ0RQxgxdzaxH2OBlqvlT3V5zx30CgKNyEnlE8pWkOpY+ccVTIhCwmoDlW
         reV7WiOEDffGi7mijT7wFUEYPXl56rQbgjNRMdgTPnl2YffHy//4oSeVzzNxL8ceUjrT
         SZkN1zB2tmc6FSa1Do5QLqLegk9Ndv87MlfDVaqeRLsroyX2zAOzC+ePshitl/6zqwEJ
         nTMA==
X-Gm-Message-State: APzg51A8Jj0VMVRenD/5KKjmtopRYgDClLgpiH8n33ORAA7XmgROl1hd
        SxQdw1igny9R1ahiOR3hmiM2D4pa
X-Google-Smtp-Source: ANB0VdaHjQnnYDTBti5gyFatdHT0Iahg0aeEOq+L3oYvfBkNRE+AUsyqGzwRebF77N13dHzCpSY28Q==
X-Received: by 2002:a37:7b01:: with SMTP id w1-v6mr16844641qkc.354.1537202305512;
        Mon, 17 Sep 2018 09:38:25 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id y47-v6sm11142403qtk.27.2018.09.17.09.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 09:38:24 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] read-cache: load cache extensions on a worker
 thread
To:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com>
 <20180912161832.55324-3-benpeart@microsoft.com>
 <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
 <CACsJy8D-sM2SSfTMmsR0uKnP0FM9fGrN0Z-pH5irMsH1=-jrmQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <bfb8d836-86a4-a4f0-cdaf-aba25424d4cf@gmail.com>
Date:   Mon, 17 Sep 2018 12:38:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8D-sM2SSfTMmsR0uKnP0FM9fGrN0Z-pH5irMsH1=-jrmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/15/2018 6:24 AM, Duy Nguyen wrote:
> On Sat, Sep 15, 2018 at 12:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
>>> @@ -1944,6 +1993,26 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>>>          istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
>>>          istate->initialized = 1;
>>>
>>> +       p.istate = istate;
>>> +       p.mmap = mmap;
>>> +       p.mmap_size = mmap_size;
>>> +
>>> +#ifndef NO_PTHREADS
>>> +       nr_threads = git_config_get_index_threads();
>>> +       if (!nr_threads)
>>> +               nr_threads = online_cpus();
>>> +
>>> +       if (nr_threads >= 2) {
>>> +               extension_offset = read_eoie_extension(mmap, mmap_size);
>>> +               if (extension_offset) {
> 
> One more thing I forgot. If the extension area is small enough, then
> we should not need to create a thread to parse extensions in parallel.
> We should know roughly how much work we need because we know the total
> size of all extensions.
> 

The only extensions I found to be significant enough to be helped by a 
separate thread was the cache tree.  Since the size of the cache tree is 
driven by the number of files in the repo, I think the existing 
THREAD_COST logic (that comes in the next patch of the series) is a 
sufficient proxy.  Basically, if you have enough cache entries to be 
benefited by threading, your extensions (driven by the cache tree) are 
probably also big enough to warrant a thread.

>>> +                       /* create a thread to load the index extensions */
>>
>> Pointless comment. It's pretty clear from the pthread_create() below
>> thanks to good function naming. Please remove.
>>
>>> +                       p.src_offset = extension_offset;
>>> +                       if (pthread_create(&p.pthread, NULL, load_index_extensions, &p))
>>> +                               die(_("unable to create load_index_extensions_thread"));
>>> +               }
>>> +       }
>>> +#endif
>>> +
>>>          if (istate->version == 4) {
>>>                  previous_name = &previous_name_buf;
>>>                  mem_pool_init(&istate->ce_mem_pool,

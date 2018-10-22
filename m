Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BBB1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 02:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJVKbE (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 06:31:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55806 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeJVKbE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 06:31:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so8568831wmb.5
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 19:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LHwcs4wowV6KB3BkABzF7eb3NTGuHB9b69iYowcoy4M=;
        b=ZwcQzXiKf4v4jrKJiG+U4rvlNcD9j0dDKnQLuVpWTBOQPwzcLxR12PbCXPbvUhpVSk
         jxeyCH2qqmVkl+xkNf/39mK4uCSLS45JIL+MbVGLMjN8IvdUWPD53FiZZTO3rvgaR+xt
         NoWu0AFsZr4qsBWB0U91u4f5CD2TObOfinVMket5berSasJ5md5FnuJHJr96layL5pbV
         qwRXFoLgTuOF4UQG6MoN/yBsA0hHA2D4vR62kOMF8H2QArCXkgCB1iXftkd/RL8253I5
         +6R8SIklwJflrEP8v/PuvcKdi4IXIuRtfbzHEePsLfSua+HyAflu7Z5NbPHVDUnkS+R5
         9ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LHwcs4wowV6KB3BkABzF7eb3NTGuHB9b69iYowcoy4M=;
        b=Bj/dcJbUD75fMu3IFnmGFvLvKtxPB3/TYT7bfftci5jp5VNbcJLQD68z12rfyXrlav
         q5hofWIpl/GhK742HlPYA+IUJw6GnNrlb11csAFLE9a9hi5ZqQrECTYOSsjBg8DpjIcD
         KTRgHgFbMDImciopMxmow9moLOklG3wqs4eQazVWOeaa/6UNmX7b4afG2KZpAqccRlFP
         WUiGU8qFk4kArJLxGhr0QuJ+5HNJlDzVtMqEdMDgZ/evwsJsv0DSn6QXt839NjR90dqA
         hSTt7V8RSnGdIGTo3narSajID7HpSNmugX7+GQ2dkmLezkA2gDU7nXxSV4NVPa0nDZSi
         o3Xg==
X-Gm-Message-State: ABuFfoinPcbHqiNzEnqxqcUPJQJbuSE5zB6TLCFPlD82jizAKWx4pvof
        E22OeO3VRPW4ISRu6MPyjPTcJz7+k8o=
X-Google-Smtp-Source: AJdET5dWHwHgBgfvPpBJW5CBa7PtVQu3yaQ3rm0oqQa0k2+P6gctN+SyHwipyoyuLCgZU8DVTNjz/g==
X-Received: by 2002:a1c:820d:: with SMTP id e13-v6mr14004505wmd.91.1540174474107;
        Sun, 21 Oct 2018 19:14:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x8-v6sm81042634wrd.54.2018.10.21.19.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 19:14:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v8 7/7] read-cache: load cache entries on worker threads
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181010155938.20996-8-peartben@gmail.com>
        <20181019161118.GA8100@sigill.intra.peff.net>
Date:   Mon, 22 Oct 2018 11:14:32 +0900
In-Reply-To: <20181019161118.GA8100@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 19 Oct 2018 12:11:19 -0400")
Message-ID: <xmqqsh0yybg7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 10, 2018 at 11:59:38AM -0400, Ben Peart wrote:
>
>> +static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
>> +			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
>
> The src_offset parameter isn't used in this function.
>
> In early versions of the series, it was used to feed the p->start_offset
> field of each load_cache_entries_thread_data. But after the switch to
> ieot, we don't, and instead feed p->ieot_start. But we always begin that
> at 0.
>
> Is that right (and we can drop the parameter), or should this logic:
>
>> +	offset = ieot_start = 0;
>> +	ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);
>> +	for (i = 0; i < nr_threads; i++) {
>> [...]
>
> be starting at src_offset instead of 0?

I think "offset" has nothing to do with the offset into the mmapped
region of memory.  It is an integer index into a (virtual) array
that is a concatenation of ieot->entries[].entries[], and it is
correct to count from zero.  The value taken from that array using
the index is used to compute the offset into the mmapped region.

Unlike load_all_cache_entries() called from the other side of the
same if() statement in the same caller, this does not depend on the
fact that the first index entry in the mmapped region appears
immediately after the index-file header.  It goes from the offsets
into the file that are recorded in the entry offset table that is an
index extension, so the sizeof(*hdr) that initializes src_offset is
not used by the codepath.

The number of bytes consumed, i.e. its return value from the
function, is not really used, either, as the caller does not use
src_offset for anything other than updating it with "+=" and passing
it to this function (which does not use it) when it calls this
function (i.e. when ieot extension exists--and by definition when
that extension exists extension_offset is not 0, so we do not make
the final load_index_extensions() call in the caller that uses
src_offset).

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8591F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbeHMSsB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:48:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42694 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeHMSsA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:48:00 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so17918998qto.9
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=opcOJyl791jYsFfi9mcmYG2CkqKQCXM7JEGCKhFp1Jc=;
        b=shK5/6gfnZ6gx2L02lfBOo5rpY+2f9Ai5FfScz14mT7I0fyt+gJO0xdOqVtM3spIHg
         owQy1Ihl0DiqH1U+TtZaoSt5NyOjhVDOQRccB7J0oVIddWjN1o4f0MJHe9Cy9ZVymYMN
         blWrhNFyE1cvAXemofh5UdH9CSJFRDMlPUBzDDaxQaOxgVCBKOT9NkbmrZlU5h9t8ir9
         i2RlLAbemUGDqAcxFQUNXf5Ea+/w5PqnxESkZt+2dCPAOaCiNvQDXLeLz6oUS9+NhnV/
         elCWfwkhH3c5nPrsUTWsWbYBDm6majjzc72iSQ5I80gYASPQQv3J6zpMueqyGGIUVDm0
         bCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=opcOJyl791jYsFfi9mcmYG2CkqKQCXM7JEGCKhFp1Jc=;
        b=HqkUcLDKkZCkmR1MTWFr7ApwtJh9WDZmrHRZeYNmUqGWQUVtBSCbneDIEToUKHpD7d
         wTH7iW99Hy71QYxSci1Cw04x2JnHnHWmXO137qHKbRqzNYMuyLc5N8rs6Lfn+H87s4g/
         7w5Swg7CxG56069TFhO0wUorYXECKuoJm4HMkgtZMcbqG7U/hDr167DJIE7P0N4kd5Fw
         WctPjbf0Oru4GGYTOm27wcqYiB6gYqYoOI4DEn41eK7S4ok+QyHaLaP0uFwE2Niz+Rlw
         d/VhBRgAEAA8UMTqnCKCHRa7IrE/fAxxv1H6quSIWOFmBTst0k15b2Wdk/b812k/SgV8
         aQ5A==
X-Gm-Message-State: AOUpUlEqw9vWMTnDPpTVg2djQw7ZMlxgfG9X6LmNp+tT//QXK9caC9Uh
        8UyecApH+9KBECWOLNJilxY=
X-Google-Smtp-Source: AA+uWPzX8hK6vlnkgG7TIVHrp4q91FT/pPLlc/ffFo9ds/b2so2JeTGakKzNoU9BBNYtoeuzRWZ2XA==
X-Received: by 2002:a0c:92e4:: with SMTP id c33-v6mr15357108qvc.178.1534176308530;
        Mon, 13 Aug 2018 09:05:08 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f63-v6sm10513636qtb.64.2018.08.13.09.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:05:07 -0700 (PDT)
Subject: Re: [PATCH v4 5/5] unpack-trees: reuse (still valid) cache-tree from
 src_index
To:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-6-pclouds@gmail.com>
 <CABPp-BEDQfzyZjD0CuZKhvj3iUi0H6Ar0Fgm2UhehjP1pnWKgA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a8543f33-eb1a-4122-87a4-f8d888af7381@gmail.com>
Date:   Mon, 13 Aug 2018 12:05:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BEDQfzyZjD0CuZKhvj3iUi0H6Ar0Fgm2UhehjP1pnWKgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/13/2018 11:48 AM, Elijah Newren wrote:
> On Sun, Aug 12, 2018 at 1:16 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>>
>> We do n-way merge by walking the source index and n trees at the same
>> time and add merge results to a new temporary index called o->result.
>> The merge result for any given path could be either
>>
>> - keep_entry(): same old index entry in o->src_index is reused
>> - merged_entry(): either a new entry is added, or an existing one updated
>> - deleted_entry(): one entry from o->src_index is removed
>>
>> For some reason [1] we keep making sure that the source index's
>> cache-tree is still valid if used by o->result: for all those
>> merged/deleted entries, we invalidate the same path in o->src_index,
>> so only cache-trees covering the "keep_entry" parts remain good.
>>
>> Because of this, the cache-tree from o->src_index can be perfectly
>> reused in o->result. And in fact we already rely on this logic to
>> reuse untracked cache in edf3b90553 (unpack-trees: preserve index
>> extensions - 2017-05-08). Move the cache-tree to o->result before
>> doing cache_tree_update() to reduce hashing cost.
>>
>> Since cache_tree_update() has risen up as one of the most expensive
>> parts in unpack_trees() after the last few patches. This does help
>> reduce unpack_trees() time significantly (on webkit.git):
>>
>>      before       after
>>    --------------------------------------------------------------------
>>      0.080394752  0.051258167 s:  read cache .git/index
>>      0.216010838  0.212106298 s:  preload index
>>      0.008534301  0.280521764 s:  refresh index
>>      0.251992198  0.218160442 s:   traverse_trees
>>      0.377031383  0.374948191 s:   check_updates
>>      0.372768105  0.037040114 s:   cache_tree_update
>>      1.045887251  0.672031609 s:  unpack_trees
> 
> Cool, nice drop in both cache_tree_update() and unpack_trees().  But
> why did refresh_index() go up so much?  That should have been
> unaffected by this patch to, so it seems like something odd is going
> on.  Any ideas?
> 

I was part way through writing a patch that would copy the valid parts 
of the cache-tree from the source index to the dest index but the 
observation that the source index cache tree was already being 
invalidated properly which allows the simple pointer "copy" is much better!

I run some tests on a large repo and the results look very promising.

base	new	diff	% saved	
0.55	0.52	0.02	4.32%	s:  read cache .git/index
0.31	0.30	0.01	2.98%	s:  initialize name hash
0.03	0.02	0.00	9.98%	s:  preload index
0.09	0.09	0.00	4.86%	s:  refresh index
5.93	1.19	4.74	79.95%	s:   traverse_trees
0.12	0.13	-0.01	-4.15%	s:   check_updates
2.14	0.00	2.14	100.00%	s:   cache_tree_update
10.63	4.29	6.33	59.59%	s:  unpack_trees
0.97	0.91	0.06	6.41%	s:  write index, changed mask = 28
3.49	0.18	3.31	94.91%	s:    traverse_trees
0.00	0.00	0.00	17.53%	s:    check_updates
3.61	0.30	3.31	91.77%	s:   unpack_trees
3.61	0.30	3.31	91.77%	s:  diff-index
17.28	8.36	8.92	51.62%	s: git command: c:git.exe checkout

Same methodology as before, I ran "git checkout" 5 times, threw away the 
first 2 runs and averaged the last 3.  I entered 0 for the "new" 
cache_tree_update line as it no longer reports anything.

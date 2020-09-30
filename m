Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660ADC4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D8B20739
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Cc45WGXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgI3UST (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:18:19 -0400
Received: from avasout06.plus.net ([212.159.14.18]:34522 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3USS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 16:18:18 -0400
Received: from [10.0.2.15] ([195.213.6.24])
        by smtp with ESMTPA
        id NiYIkzn6LhO4HNiYKkS2Ah; Wed, 30 Sep 2020 21:18:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1601497097; bh=B5TgWlVIcAACJwO98S75EpUz9Nh6NDaqFeoU+yMT9HA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Cc45WGXVXhNBFAJZ1e6dVGZLQf5df0Aq0fBO4d1/UW2wrvwceU/3KIRq4YJ2zXRFK
         eqJ9ObgmQdvoUOfWNu6lF3f4sgbQ2OMZkqXr96HwG+LIc/vf7sn+RhHQSAR66DVf/1
         kSSgTVffEIRPAsu7XQTbJ/bmzgQofSErrW3FhSe/TKksx+fq38+HhuNJmWurL15Ruo
         EKlDz49vCYjsMYUB2Z3D+fMJCofhYX6UqPGORiEgoK/H1HXm1bnrFGDAEQDKaU7ztC
         ucHbKlgvhqgE+LB2izPICmCIcovoWQ73rLFYWbB4A+zKsbv+gNNW6w5WDVjaO0c+q1
         CJZLthaiOkvrg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=ZbLTZYmGBvpB9CrD5UJtoA==:117 a=ZbLTZYmGBvpB9CrD5UJtoA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VwQbUJbxAAAA:8 a=GelTGUqr1t6Zi-U3L54A:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] reftable: fix some sparse warnings
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <eaf4629b-d8c4-0ddc-8c85-6600399a8229@ramsayjones.plus.com>
 <CAFQ2z_PNT0g2yAbMkWEQW3UjbMbzALfkAfLDzpiUZjOE0b29vw@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d3c6bd3d-9f1c-00e3-fa31-67ad0d45fdbf@ramsayjones.plus.com>
Date:   Wed, 30 Sep 2020 21:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFQ2z_PNT0g2yAbMkWEQW3UjbMbzALfkAfLDzpiUZjOE0b29vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBf8pmJsPaObIiP6AhCL+k9rlY05rKlUJLwEaV0fEo78hCneGCqH14lAQ/Bv7OkS8gjuXdgoE7cJeAxTmwpBktWpaOwz2wVzxQA/hz4CwjSZYIb6gsJx
 SKE65/qtqkF9hAvOZ9ghGezeexRwnacr5mhJY7KsPfFF/K3V+6gviodyv7NhsQVeo7S/jOstfGJypA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/09/2020 17:51, Han-Wen Nienhuys wrote:
> On Wed, Sep 23, 2020 at 12:47 AM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:

>> If you need to re-roll your 'hn/reftable' branch, could you please squash this
>> into the relevant patches.
>>
> 
> Thanks for the heads-up. I fixed some of these issues in the source at
> google/reftable. I've seen a Helped-By footer used to acknowledge
> these types of contributions, but I'm not sure on which of the 13
> commits I should put that; suggestions?

I will leave you to decide, but I didn't actually do much (sparse
did most of the heavy lifting)! ;-)

> 
>> This patch is based on top of 'seen' and removes 20 sparse warnings (19 of the
> 
> Could you tell me how I can run these checks myself?

  $ make sparse

You will need to install a suitably new version of sparse, of course.
I believe (but don't quote me) that debian testing has a suitable
version based on the 'maint-v0.6.2' branch. ('git describe maint-v0.6.2'
shows that it has four commits on top of the last official release
version: v0.6.2-4-gb47eba20). Having said that, v0.6.2 should also be
fine (I build from source, so have version v0.6.2-201-g24bdaac6).

[for more sparse info, see: https://sparse.docs.kernel.org]

> 
>> Just for your information, you may want to look at the following 27 symbols:
> 
>>   > reftable/merged.o   - reftable_merged_table_hash_id
>>   > reftable/merged.o   - reftable_merged_table_max_update_index
>>   > reftable/merged.o   - reftable_merged_table_min_update_index
>>   > reftable/merged.o   - reftable_merged_table_seek_log_at
>>   > reftable/publicbasics.o     - reftable_error_to_errno
>>   > reftable/publicbasics.o     - reftable_set_alloc
>>   > reftable/reader.o   - reftable_reader_seek_log_at
>>  > reftable/stack.o    - reftable_addition_close
>>   > reftable/stack.o    - reftable_stack_auto_compact
> 
> These functions are part of the public API. We'll need to get the
> reftable glue code into seen. Perhaps some need unittest coverage too.

So, do I take it that the other 18 symbols are now marked 'static'?

[you would need 'static-check.pl' to catch symbols like the above].

ATB,
Ramsay Jones



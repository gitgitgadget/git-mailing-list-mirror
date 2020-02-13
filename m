Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9CAC352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1620848
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 23:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mjU4QqCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBMXYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:24:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56642 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMXYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 18:24:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C226140B5E;
        Thu, 13 Feb 2020 18:24:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zh9i4e3z9GZeHUGHSAyVrpIG0QE=; b=mjU4Qq
        CBkr+xTFwwxrPPjt8XeA93mLqYYXOqt0x3bq8seLahnK3iywGVwuPBX0Gt6Sggu+
        RNH3uBHMIzoO+spsuaJpPeb04/IB3+kCpbctutXiW1gk9mfo4yWxnTvLi49keFSG
        +CrHW8lHyeFt0ZnFdv84sWWIhWe8jI+Jss/hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XRUS/o1YYTWLDhPQ35EBmb+xh5Zfh3G9
        +AL00vMLFe+G+skdQXIe7HMKaumFB/Yh+dHwq64ASrfmD0HR88NYHKyYMmJAsg2F
        GZqsHt3k9R5hlnCUekDYo5C544+X6UqsTjM0oHCCkxR8/weueltS3oTFF4M7tI86
        uMZ6ubeMIwA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B20D40B5D;
        Thu, 13 Feb 2020 18:24:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E1F140B5C;
        Thu, 13 Feb 2020 18:24:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v6 01/15] help: move list_config_help to builtin/help
References: <20200206004108.261317-1-emilyshaffer@google.com>
        <20200206004108.261317-2-emilyshaffer@google.com>
        <20200206013533.GA3993@danh.dev> <20200213225834.GI190927@google.com>
        <CAPig+cRDbOyDQm6wx7+fZoKDfehLjkPc3qenR5Mhc8OkeFJqbw@mail.gmail.com>
Date:   Thu, 13 Feb 2020 15:24:04 -0800
In-Reply-To: <CAPig+cRDbOyDQm6wx7+fZoKDfehLjkPc3qenR5Mhc8OkeFJqbw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 13 Feb 2020 18:07:59 -0500")
Message-ID: <xmqq36beqdez.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDF3C250-4EB7-11EA-A366-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Feb 13, 2020 at 5:58 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>> On Thu, Feb 06, 2020 at 08:35:33AM +0700, Danh Doan wrote:
>> > -     while read line
>> > -     do
>> > -             echo "  \"$line\","
>> > -     done
>> > +     sed 's/^/       "/; s/$/",/'
>>
>> Thanks for the suggestion. You're right that I didn't look into the
>> contents of this script much, because I was just moving it; I modified
>> your sed expression slightly so it performs just one operation:
>>
>>   sed 's/^.*$/    "\0",/'
>
> This isn't portable and won't work with 'sed' from BSD lineage,
> including Mac OS. More portable would be:
>
>     sed 's/^\(.*\)$/    "\1",/'

Or just replace Emily's \0 with &; that should be in POSIX.

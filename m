Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F28C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8CD22209
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GaeSwP2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgIKTIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:08:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55306 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgIKTIT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:08:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2906C81AA1;
        Fri, 11 Sep 2020 15:08:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K24OJav6hpBe9Tz2d9K4ZkM6hbg=; b=GaeSwP
        2mcdB5iDXo59igs2HLVdLSC8TBrtrDkSo0Wr+wKysQESFwSx7QxTGX/503RnSclp
        xsVZVuWfSj2GU5bDJDunMusNhTBRfENMN8E4P8k7MrXDnGnW06d7lq2WAzGtchdS
        KpPX3zG03U0QnV4RDPurXy7APddnKKGWBeRwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MqhKeVZALT24Vpi3qSAEKVVIG0GanPCa
        HSo9gqlIMWWkgzVbgjM10nIqpMK/bJyVE19ItdS742K+D7Q/tyd/jSHm1Lu/6c4a
        rX3L7aspFm/m9xk7HcbooHj61rTrWm2YxWqN2oVX8jOnMP0Z3u5jT7hvKVFJKPw6
        UtY8Vlp6XHc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2129781AA0;
        Fri, 11 Sep 2020 15:08:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9DC2781A9E;
        Fri, 11 Sep 2020 15:08:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Daniel Stenberg <daniel@haxx.se>,
        Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org
Subject: Re: Git doesn't honor NO_PROXY environment variable while cloning
References: <CA+B51BGRuLfF7FpiK93Wih0XhsC7rJLGjkF2CzrEsUkBEif+jw@mail.gmail.com>
        <20200911135928.GA1986935@coredump.intra.peff.net>
        <alpine.DEB.2.20.2009111729530.6227@tvnag.unkk.fr>
        <20200911164656.GA2641000@coredump.intra.peff.net>
Date:   Fri, 11 Sep 2020 12:08:15 -0700
In-Reply-To: <20200911164656.GA2641000@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 11 Sep 2020 12:46:56 -0400")
Message-ID: <xmqqo8mcnnc0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25D098C4-F462-11EA-9BB0-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 11, 2020 at 05:31:16PM +0200, Daniel Stenberg wrote:
>
>> On Fri, 11 Sep 2020, Jeff King wrote:
>> 
>> > So I dunno. This seems like a libcurl bug, but it's possible we're
>> > feeding it data wrong somehow.
>> 
>> I didn't check very closely, but it certainly sounds like this one:
>> 
>>   https://github.com/curl/curl/pull/5902
>
> You know, I almost cc'd you, but I didn't want to bug you until I was
> more sure it was a curl issue. But here you are anyway. :)
>
> That indeed looks a lot like the same issue. And building the tip of
> libcurl's master and linking git against it makes the problem go away.
> So that is almost certainly it.
>
> Thanks for the quick response!

Thanks, both.

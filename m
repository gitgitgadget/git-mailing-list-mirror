Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01433C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 06:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EB2221E5
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 06:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DwvJcwgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgHGGmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:42:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58634 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgHGGmt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 02:42:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D990AEB66C;
        Fri,  7 Aug 2020 02:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vN5RwJg4AhUOFSoGr60nFAf55js=; b=DwvJcw
        gYbmklJZaJ3n3qKb0gZqKds06tnJfcZ4W7S62F1Vaf7/xrCu+dEyDeW7s6FPXQTQ
        u7CZADTEAITHSktkpfXFzAKUUZylkV6QiDz0N9G/S5rmOLzDw+pW2rdj/VRMtyDj
        YKRtf7Kxoo5EJNRp3XLSKDo7ubcMyAECFrmuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tQhjJo8jI7jzJ2ZDD+hcBZGfNtrLSnEX
        BNaR/dh4mvSEpaiT6jkK6CwNaQTQpArEreqDljVtoSyzp/LB5XVff0nffC5yJ32a
        0GnbHP1LP5EUaMatHLy63KdDPLxxoPqGHBkrT4zadBhzy57S9svpt9ObKDnX0BP1
        VuFM0szKk9s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1BABEB66B;
        Fri,  7 Aug 2020 02:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2644DEB66A;
        Fri,  7 Aug 2020 02:42:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: "#define precompose_argv(c,v) /* empty */" is evil
References: <xmqqy2mribft.fsf@gitster.c.googlers.com>
        <20200807000126.GC8085@camp.crustytoothpaste.net>
        <xmqqpn83i9sk.fsf@gitster.c.googlers.com>
        <20200807032723.GA15119@coredump.intra.peff.net>
        <xmqqh7tfhzb1.fsf@gitster.c.googlers.com>
        <20200807043436.GA21829@coredump.intra.peff.net>
Date:   Thu, 06 Aug 2020 23:42:43 -0700
In-Reply-To: <20200807043436.GA21829@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 7 Aug 2020 00:34:36 -0400")
Message-ID: <xmqqd043hs7w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 334FC362-D879-11EA-B45B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Yes, of course, but as I wrote in my response to Brian, the whole
>> point of using these replacement implementation macros is so that we
>> do not have to sprinkle the main code with such #ifdef/#endif, so
>> I think the code like that is what needs to be corrected ;-)
>
> I'm not sure if I made my point clearly. ...

Sorry, indeed I missed it.  

Using the implementation of precompose_argv() itself as an example,
instead of generic looking some_func(), does help to explain why at
some point we are bound to have some API calls that are compiled on
some platforms and not on others.


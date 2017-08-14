Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6890B20899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbdHNWmX (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:42:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53147 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752275AbdHNWmW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:42:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B52379B5E5;
        Mon, 14 Aug 2017 18:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f3VYaMOkgbu4e4BzaXWrzkCgp8Q=; b=JiccMD
        Sl+3HxlaPuSxYPSOgxKsuPtBl6lClfOmMANOB3H+ubvW26PCK8BLSbVXgkdzOY54
        yJPpdQhfyWNG/284JRNBvxShAX00RhJF9HGZs4jrn2phzBwqmTwOvZk/mVm9h8Ir
        J4W+E/dWfDd5MgSkPw2LpsaIDMUnfVJaou+fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TSpbbBBFtbCwwjZLM86ixTq+U7k3sN1V
        vKz1yci3s8W3oOaD22Rz52ywKFeWOzTFeQnHEpDWmlpdMT0sAE6hjkwHDSm8ukYx
        jmQnvjLypU1C4ImXUS4LLbaODwMn7xo1QheZrbfhKDsJpspQWs57cTRQvS3qsTvZ
        4wXL9vLPKoo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD02F9B5E4;
        Mon, 14 Aug 2017 18:42:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13CA89B5DB;
        Mon, 14 Aug 2017 18:42:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/2] format-patch: have progress option while generating patches
References: <20170531150427.7820-1-kewillf@microsoft.com>
        <20170810183256.12668-2-kewillf@microsoft.com>
        <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
        <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
        <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
        <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net>
        <xmqqpobyw11t.fsf@gitster.mtv.corp.google.com>
        <xmqqshguuhe2.fsf@gitster.mtv.corp.google.com>
        <20170814222947.edvuz7b2hxuwcsqj@sigill.intra.peff.net>
Date:   Mon, 14 Aug 2017 15:42:14 -0700
In-Reply-To: <20170814222947.edvuz7b2hxuwcsqj@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 14 Aug 2017 18:29:47 -0400")
Message-ID: <xmqq8tilu5yx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D267E890-8141-11E7-8C27-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If it's smooth, the (50,1) case is slightly nicer in that it puts the
> progress in front of the user more quickly. I'm not sure if that's
> actually worth pushing an additional decision onto the person writing
> the calling code, though (especially when we are just now puzzling out
> the method for making such a decision from first principles).
>
> So I'd vote to drop that parameter entirely. And if 1 second seems
> noticeably snappier, then we should probably just move everything to a 1
> second delay (I don't have a strong feeling either way).

Sounds like a good idea to me.  

I've already locally tweaked Kevin's patch to use (0,2) instead of
(0,1) without introducing the simpler wrapper.  It should be trivial
to do a wrapper to catch and migrate all the (0,2) users to a
start_delayed_progress() that takes neither percentage or time with
mechanical replacement.


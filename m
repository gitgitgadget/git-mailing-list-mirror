Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0D662022D
	for <e@80x24.org>; Mon, 21 Nov 2016 19:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbcKUTMm (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 14:12:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753191AbcKUTMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 14:12:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81E924EE80;
        Mon, 21 Nov 2016 14:12:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EAMxTz7ch2r3FSuw3j0PYxtUh1c=; b=Aavn6g
        x8h337ar5mDzebBh06QwoRAlXzLYAjrdJNya4EgiDAd42qC8Z2yo0g0d+IDfIHas
        +UHM8W6umjOTK9ofl9G7ZrZlLqpDs6IDHv2Amy1CSWhOG/bwKi+aPMUgaMroxpuT
        6G7/2CKARtxyUh89eCp6uvZnVMuHskpr5Wzlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FthxGmlDfmbqggXj7lsnoKq7gTqRSIpH
        v8xyMqIPLFSYX9yJanfOB/520IZnDiomvnUJD1gp4p9E7bNO3XWx3JpVB8S4ihW5
        LnoI01486JUJ7T2gEYBWCZZm+bBdO833dolbZyb7ObFDapplTPXNjXwHKX+w/Tcy
        2YpmHFSm1x8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 795284EE7C;
        Mon, 21 Nov 2016 14:12:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E61994EE79;
        Mon, 21 Nov 2016 14:12:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: identify problems with core.commentchar
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <f47dce15719954d6d4d8a550856757366871143e.1479737858.git.johannes.schindelin@gmx.de>
        <xmqqbmx8k8c0.fsf@gitster.mtv.corp.google.com>
        <20161121184931.36nuhg2h7u6mjsld@sigill.intra.peff.net>
Date:   Mon, 21 Nov 2016 11:12:39 -0800
In-Reply-To: <20161121184931.36nuhg2h7u6mjsld@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 21 Nov 2016 13:49:32 -0500")
Message-ID: <xmqqtwb0ir4o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79331028-B01E-11E6-A912-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 21, 2016 at 10:15:43AM -0800, Junio C Hamano wrote:
>
>> > +	test_cmp expect actual
>> > +'
>> > +
>> 
>> Is this a recent regression?  When applied on top of 'maint' or
>> older, it seems to pass just fine.
>> 
>>     ... Goes and looks ...
>> 
>> Interesting.  Peff's b9605bc4f2 ("config: only read .git/config from
>> configured repos", 2016-09-12) is where this starts failing, which
>> is understandable given the code change to builtin/stripspace.c in
>> [2/3]. 
>> 
>> The analysis of the log message in [2/3] is wrong and needs
>> updating, though.  In the old world order it worked by accident to
>> call git_config() without calling setup_git_directory(); after
>> b9605bc4f2, that no longer is valid and is exposed as a bug.  
>
> Yeah, I noticed that while reading the patch. My b9605bc4f2 did regress
> this case, but called out the fact that "cd subdir && git stripspace"
> would never have worked. So one step back, 2 steps forward, and Dscho's
> patch is the right step forward.

Yes, absolutely.

I sent out a set of proposed amends, and the one for this step 1/3
runs the command inside a subdirectory to force it not to find the
.git/config file relative to its pwd, which can reveal the existing
breakage without help by b9605bc4f2 ;-) hence can be forked for
older maintenance tracks.

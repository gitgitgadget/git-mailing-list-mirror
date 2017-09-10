Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324771FAD6
	for <e@80x24.org>; Sun, 10 Sep 2017 07:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdIJHgh (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 03:36:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51802 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751077AbdIJHgg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 03:36:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74EA794CFB;
        Sun, 10 Sep 2017 03:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=E1bEi249yz73w0sKh0WPu3381g0=; b=COrDK/
        JiFRBe6dKGnJnHdo0M8aMcPIMT5eog6xcF32hzVOvXDJr0vDvUVxNp5ztJn9SmlU
        ArLrOTvTtxqlAslGcQK13ue+xXmroPEy8QDzHm30ZqOA0uI4PU4WEEbR7UfkdmEf
        J8wBXeAT8B1Zrzhvrt9cUshfk00bOL0GntFdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=glrC+U0RAjSRrsNr4UVytbewL3lrAiEJ
        hC6dOz234K4tpOzkndccUp3Z3IsK/mM/OfYuN9CjOvAkx+EdJHR7uMtxrj7Hj/qJ
        QhjSY1Y0AH2utP65jRT9bWy3LGHAt3bH1eUEpeoG9eRHCr3L7ddYaLqgpBdGgJ62
        P18ZoUHEQS0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C9F394CFA;
        Sun, 10 Sep 2017 03:36:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBFC594CF9;
        Sun, 10 Sep 2017 03:36:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?0JLQsNC70LXQvdGC0Lg=?= =?utf-8?B?0L0=?= 
        <valiko.ua@gmail.com>, "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git shortlog -sn --follow -- <path>" counts all commits to entire repo
In-Reply-To: <20170909065247.wob3nuxvox4f65gg@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 9 Sep 2017 02:52:47 -0400")
References: <CAJrPYn8_n1JD3hL1LSAVz2Khs=dZRVaZ-gpru5AV+ottv5WfAw@mail.gmail.com>
        <CAGZ79kZAeCERKn6he2LzAj97BXEJ5U+Fy4sorAPNmW_XaCS9Vg@mail.gmail.com>
        <20170908051015.ybq4egdrddecl4se@sigill.intra.peff.net>
        <xmqqo9qlzodi.fsf@gitster.mtv.corp.google.com>
        <20170908074910.reoyb47navgsg6kt@sigill.intra.peff.net>
        <xmqqbmmlytv3.fsf@gitster.mtv.corp.google.com>
        <20170909065247.wob3nuxvox4f65gg@sigill.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
Date:   Sun, 10 Sep 2017 16:36:31 +0900
Message-ID: <xmqqh8wbxaww.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C47607B2-95FA-11E7-8CC9-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Sep 09, 2017 at 02:37:20AM +0900, Junio C Hamano wrote:
>
>> Using log-tree traversal machinery instead of just get_revision()
>> would probably mean we would slow it down quite a bit unless we are
>> careful, but at the same time, things like "git shortlog -G<string>"
>> would suddenly start working, so this is not just helping the
>> "--follow" hack.
>
> I didn't notice that, but I'm not surprised that there are more options
> that shortlog doesn't quite work with.
>
> I don't plan on working on this myself any time soon, so maybe it's a
> good #leftoverbits candidate (though it's perhaps a little more involved
> than some).

I agree that I do not mind seeing those who haven't really touched
the inner core of the system to try this change, so marking this
discussion with #leftoverbits may be a good idea, but I have this
gut feeling that "a little more involved" might be a bit of an
understatement ;-)

But still I think it is a very good suggestion to allow log-tree to
filter things more so that "shortlog $args" can become a more
faithful imitation of "log $args | shortlog".

Thanks.

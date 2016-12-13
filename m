Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29581FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 07:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbcLMH2d (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 02:28:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51469 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752359AbcLMH2d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 02:28:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD7274D8D1;
        Tue, 13 Dec 2016 02:28:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wAmoS1Jxkdur0+3ZwfUBxku9oAo=; b=McNjMq
        evdPHW0fwnwH17IqLZ8AQ/8qBBhXyZSmQW+SpQG86Fh/i1QMs7QvY76OsGG3o/2R
        zW1ErMMTfqUtGmWPW9Dkl3u2SnWIbLqnnqqWSZFxxPBX5HfE27ZrN6pRP/ugM++A
        Mlcy78kgAvi+9TdSioULWz+99R+fSYP8dd6OM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mVrIpZlPpVAFcJiJXHlMXA6ezl0Jo8Co
        UNXg730MX8uowh02fjvnpDRgSgq+UkOAoo6p3MFa3pgot7C9ge3DNhJKkaDNyhGQ
        uinw/xAD38kDpYuFObmEnAyo4D7rJEyw00Tej+s3VwGPZpKnc2EO5gQD1lmI14Ob
        arGw3asYBvo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACB224D8D0;
        Tue, 13 Dec 2016 02:28:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2556A4D8CF;
        Tue, 13 Dec 2016 02:28:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
References: <20161213014055.14268-1-sbeller@google.com>
Date:   Mon, 12 Dec 2016 23:28:29 -0800
In-Reply-To: <20161213014055.14268-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 12 Dec 2016 17:40:49 -0800")
Message-ID: <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF68C798-C105-11E6-9720-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The "checkout --recurse-submodules" series got too large to comfortably send
> it out for review, so I had to break it up into smaller series'; this is the
> first subseries, but it makes sense on its own.
>
> This series teaches git-rm to absorb the git directory of a submodule instead
> of failing and complaining about the git directory preventing deletion.
>  
> It applies on origin/sb/submodule-embed-gitdir.

Thanks.  I probably should rename the topic again with s/embed/absorb/;

> Any feedback welcome!
>
> Thanks,
> Stefan
>
> Stefan Beller (6):
>   submodule.h: add extern keyword to functions
>   submodule: modernize ok_to_remove_submodule to use argv_array
>   submodule: add flags to ok_to_remove_submodule
>   ok_to_remove_submodule: absorb the submodule git dir
>   t3600: slightly modernize style
>   rm: add absorb a submodules git dir before deletion
>
>  builtin/rm.c  |  21 +++-----
>  cache.h       |   2 +
>  entry.c       |   5 ++
>  submodule.c   |  77 +++++++++++++++++++++++-----
>  submodule.h   |  64 ++++++++++++++---------
>  t/t3600-rm.sh | 159 +++++++++++++++++++++++----------------------------------
>  6 files changed, 182 insertions(+), 146 deletions(-)

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECE31F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 02:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbeKXNSm (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 08:18:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50845 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKXNSm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 08:18:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8358712682F;
        Fri, 23 Nov 2018 21:32:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aO5VF1YrouhcNsdXZYNLXNHZBMU=; b=EGCdjn
        1AqGTtAOxWn6QlYzX6b+nwEdwY8XNrcuBRYJXWsG9cHw3XYbOnm9i/3cuGiNVw6T
        4vs77zsO7tEz643pTgzwoCRW5hJfx5vzPB7ue+kap0qt/m74w3iBNfh1XBgG1F7Z
        s2PT85VR7B+qWNcJ+NtY6um7zxR3Q1cnrUXeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tEcK1ASoSU1laWY8ZA4Y34dfN2Sf+chn
        1ZlscWB8NJH42p76SeLGi9wetq3kEO6g2JI/nv3Npalb1G/beF14iV+njhBvEXL4
        55eJvCoJRlF5I9VS626LzUD157DDElmYlNceysuVGK+eKDKZhk2eKPwhgD69Nz9X
        figDTG9heuA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C47C12682E;
        Fri, 23 Nov 2018 21:32:03 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E35A412682D;
        Fri, 23 Nov 2018 21:32:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
        <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
        <20181122162024.GD28192@sigill.intra.peff.net>
Date:   Sat, 24 Nov 2018 11:32:01 +0900
In-Reply-To: <20181122162024.GD28192@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 22 Nov 2018 11:20:24 -0500")
Message-ID: <xmqq1s7b434u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2080DFDC-EF91-11E8-AF86-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
>> +	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
>> +	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
>> +		return 0;
>
> If the user passes "-a" to treat binary files as text, we should
> probably skip the binary check. I think we'd need to check
> "o->flags.text" here.

Yeah, I forgot about that option.  It would give an escape hatch
that has a sane explanation.

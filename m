Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8255D203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934060AbcLMTLL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:11:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51605 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932547AbcLMTLK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:11:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F87A53DE2;
        Tue, 13 Dec 2016 14:11:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wXRArdv6a/qBPPPGOc6xBu6ZFls=; b=pEMvnu
        SwjB1OVbutTVy0lkEACv99W9VXj+4MAgPMdAI5HUhsiXy4Wvzz+8yKUvOWHgOCV4
        dA28Ela/tpcUsCmwxDJpNRC6pdsK4Cs8HiOkxXOP8P/nESjGm7XEHjb4u0sNV+D1
        cQa7CK5u3SIiDOO53a6hCytw35r0IgDaBDclk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jlF7bDDV2+oRAFrnHry06GQHOBAf05du
        431Q7ZbUD0PrKUKjZgWSetw2Yrx7XXDt2UpVeI3uwCFJnmB3Jdnzlma5fyK8LYVH
        HDdbRg6h6gYQ+ffFrHzbj7dQhS7K5MZrcyNl3YLBDhd3CAhPF7CEwI6UN050PEgn
        3IdhWNADD5M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7501653DE1;
        Tue, 13 Dec 2016 14:11:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E07FB53DE0;
        Tue, 13 Dec 2016 14:11:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
References: <20161213014055.14268-1-sbeller@google.com>
        <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
        <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY_E8xnOpCAFQo_91FeQCs9X3fkassFYunG=adx81AcBg@mail.gmail.com>
Date:   Tue, 13 Dec 2016 11:11:05 -0800
In-Reply-To: <CAGZ79kY_E8xnOpCAFQo_91FeQCs9X3fkassFYunG=adx81AcBg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Dec 2016 11:07:32 -0800")
Message-ID: <xmqqtwa73ara.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6349656-C167-11E6-B830-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I do not think there is no dispute about what embedding means.
>
> double negative: You think we have a slight dispute here.

Sorry, I do not think there is any dispute on that.

>>  A
>> submodule whose .git is inside its working tree has its repository
>> embedded.
>>
>> What we had trouble settling on was what to call the operation to
>> undo the embedding, unentangling its repository out of the working
>> tree.  I'd still vote for unembed if you want a name to be nominated.
>
> So I can redo the series with two commands "git submodule [un]embed".
>
> For me "unembed" == "absorb", such that we could also go with
> absorb into superproject <-> embed into worktree

With us agreeing that "embed" is about something is _IN_ submodule
working tree, unembed would naturally be something becomes OUTSIDE
the same thing (i.e. "submodule working tree").  However, if you
introduce "absorb", we suddenly need to talk about a different
thing, i.e. "superproject's .git/modules", that is doing the
absorption.  That is why I suggest "unembed" over "absorb".

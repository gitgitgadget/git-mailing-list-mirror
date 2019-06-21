Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A0B1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 19:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfFUTJo (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 15:09:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51311 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFUTJo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 15:09:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 619236A187;
        Fri, 21 Jun 2019 15:09:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zHBi25hqwhVwHs+d0+ruKC3o+M4=; b=azW4zv
        b562PVcsup7dko9Kgdn4kPnhfT0A3yEqNWWDoLArgJqZ5zYxtV1BDTElhH5IsjtP
        hSCLmeJeXvRCdiGue6cSF5yaJXUqhZgAKOq4ND1vr7qlRgqNF9zM6xa2/8EHbrbi
        Jl+fgZJDCz2DaNa0GMfccjuUd9fBS1nxN/Kjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IMtx++edNywfev4LSCBc7xi3GY7wOfSZ
        +8uMb/FS3Cr1gqY75p817aQrvla8hclYuAa+FNMANWsqNvLvd2o3L2ghhxwbujxN
        J9t0se+8GQd+Y/0qvHrCb1e7r1dX6maiPejKEwamf56QXWRsJR/55rJ2J89DeZhF
        Y9E+DJaxv7I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 590716A185;
        Fri, 21 Jun 2019 15:09:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F3466A184;
        Fri, 21 Jun 2019 15:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: Re: [GSoC][PATCH v6 0/5] Teach cherry-pick/revert to skip commits
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
        <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
Date:   Fri, 21 Jun 2019 12:09:37 -0700
In-Reply-To: <20190621091800.17686-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Fri, 21 Jun 2019 14:47:55 +0530")
Message-ID: <xmqqd0j6kb66.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DFDED4C-9458-11E9-97C0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> I've covered the advice message behind `advice_resolve_conflict` variable and
> changed the order of error and advice to match that of 1/5.

I think the updated text reads much better, i.e. taking from your
range-diff:

>      +	cat >expect <<-EOF &&
>     ++	error: there is nothing to skip
>      +	hint: have you committed already?
>      +	hint: try "git cherry-pick --continue"
>     -+	error: there is nothing to skip
>      +	fatal: cherry-pick failed
>      +	EOF

we say "why we failed" upfront with "error", and then for those who
would need more clues, we give "how you might want to proceed" as an
additionao "hint".  That looks more logical, besides being more
consistent with how advice messages are given in other codepaths.

> I believe that we
> don't have any advice variable appropriate for advice in 1/5.

If there is nothing, perhaps you would need to invent one.  Perhaps
"advice_sequencer_in_use" or something?

Other than that, looks quite good.  Will (re-)queue.


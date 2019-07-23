Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7924D1F461
	for <e@80x24.org>; Tue, 23 Jul 2019 20:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391869AbfGWU5M (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 16:57:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51565 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389140AbfGWU5M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 16:57:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32D9916F2ED;
        Tue, 23 Jul 2019 16:57:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GsOHXVN4PTMr2Ztcg6+HwTPK2RM=; b=vnlAd5
        LdHAvTo++l98B+uI1l7dlGxZ9E5aduqeHY3nH4uYfekSJd+76vp3s4oEZRebkobV
        BUHmim39KtgZwNwiYh31onnOcxu/FMxU8bt0J1LZwH3nG5DctiMezE48HIj1Aij2
        eVff7/rz9FA3qv5sQLO9/Qc+gfJZ1ssnVz0D8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AbAv4Z2wBfWd4aoWKcJlsMTrMWZe1jU9
        zOmSrr+d6uTNCLV7I3fhwyDrvp5DFaQbE0WKy55bF39mvv3y9GhfygBLCtVG7TqY
        wbWEMIY8NPJG7HnmkSE3NULh3yn/q1Urd/72schmn60PsOTVf3kzINRgJROn6vIV
        iMsqTtTRU/k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28E6116F2EC;
        Tue, 23 Jul 2019 16:57:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8198216F2EB;
        Tue, 23 Jul 2019 16:57:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin <martin.agren@gmail.com>, Thomas <t.gummerer@gmail.com>,
        Elijah <newren@gmail.com>, Phillip <phillip.wood123@gmail.com>
Subject: Re: [GSoC][PATCH v2 1/1] rebase -i: add --ignore-whitespace flag
References: <xmqq5znxvhdu.fsf@gitster-ct.c.googlers.com>
        <20190723195932.16951-1-rohit.ashiwal265@gmail.com>
Date:   Tue, 23 Jul 2019 13:57:08 -0700
In-Reply-To: <20190723195932.16951-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Wed, 24 Jul 2019 01:29:32 +0530")
Message-ID: <xmqqmuh4sc4b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FDFB184-AD8C-11E9-9544-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> Hi Junio
>
> On Fri, 19 Jul 2019 14:33:49 -0700 Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> >  t/t3431-rebase-options-compatibility.sh | 66 +++++++++++++++++++++++++
>> 
>> Isn't 3431 already taken?
>
> It is not in git/git[1].

That's a very selfish attitude ;-)  Pay attention to what others are
doing while you are working on this topic (hint: do not limit your
check to 'master', but make sure your changes also work well when
merged to 'next' and 'pu'---make a trial merge or two and run test
suite, for example).

>> > +	git checkout --orphan master &&
>> > +	q_to_tab >file <<-EOF &&
>> > +	line 1
>> > +	        line 2
>> > +	line 3
>> > +	EOF
>> 
>> This will trigger "indent-with-space".  Instead of using q-to-tab,
>> perhaps something like this would be more appropriate (not limited
>> to this piece, but also other ones in this script that actually do
>> use Q to visualize a tab)?
>> 
>> 	sed -e "s/^|//" >file <<-EOF &&
>> 	|line 1
>> 	|        line 2
>> 	|line 3
>> 	EOF
>> 
>
> Oh! My mistake, I should have used cat instead.

I am not sure how you would avoid indent-with-space with "cat".
With the use of "sed" like I showed above to spell the left margin
explicitly out, we can---I am not saying it's the only way, but I do
not think of a clean way to do the same with "cat".

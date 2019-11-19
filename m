Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837551F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 02:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKSCEd (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 21:04:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54934 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSCEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 21:04:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41443375BD;
        Mon, 18 Nov 2019 21:04:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kc4GpS3M7pYEjoIfVuBA8disg2A=; b=KQnLdz
        LLEqjoNYynBy6AgGzi8I8lGH42zZwK2Ot/ehpgTchI1+3/FXUvNgsvMxb4raXjRs
        iZd/nOL3Ux6HaKQ7hCJyYuJLbU+/58LAAiOYQXN8oLUvRLaEzNYoSF0lQbP+IP2j
        XLrK937zlTeCZwO7LCXoBgwRz+dvFavtzLhZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HhkkIp7d5LxDFAIH51OFlxsusZQ/Hep2
        y2lUu6aXvhUrSZCCjyyEUqlWiXOY1BcK/qMv5iTNpaWlNNgEj71gbB37lLDrijx3
        r5mhxUN4fPz9AlYV2ygLgq+XZMq6MiwsxDeJbzi2j2UBBIGOc+HdqTeyua7kg3Rs
        7NJib530J+0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38D6C375BC;
        Mon, 18 Nov 2019 21:04:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C16E375BB;
        Mon, 18 Nov 2019 21:04:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>, git@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Signal conflict on merging metadata-differing patches
References: <20191118172917.GA6063@vmlxhi-102.adit-jv.com>
        <20191118173517.GA599094@kroah.com>
        <20191118184523.GA6894@vmlxhi-102.adit-jv.com>
        <20191118194804.GA662468@kroah.com>
Date:   Tue, 19 Nov 2019 11:04:28 +0900
In-Reply-To: <20191118194804.GA662468@kroah.com> (Greg KH's message of "Mon,
        18 Nov 2019 20:48:04 +0100")
Message-ID: <xmqqo8x8zknn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBC799C4-0A70-11EA-8EBE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

>> I don't advocate for "git merge" to fail in the above scenarios. No.
>> I just say that Git could likely detect such scenarios and help people
>> like you not pushing v2 and v5 of the same patch into the main tree.
>
> But what should it do in either of those above situations?  Fail the
> merge?  No, that's not ok as those different branches were just fine on
> their own and I will never expect them to be rebased/rewritten just for
> something like this.  That's crazy.

;-)

I agree that the requested "feature" would make no sense for kernel
maintainers at various levels, as long as they are dealing with
merges among published branches.  What's done at the submaintainers'
trees are better treated as "already cast in stone".

It may be a useful feature when one maintains a bag of local/private
branches that haven't been published, though.  I however do not know
what its implementation would look like X-<.


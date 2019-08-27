Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6011F461
	for <e@80x24.org>; Tue, 27 Aug 2019 22:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfH0WQu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 18:16:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54926 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0WQu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 18:16:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 482AF15C126;
        Tue, 27 Aug 2019 18:16:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SmLSgZr/3DpqjYj+NDxP9gs3GzA=; b=mhK3ux
        C8hhrMMTpaa7hVyXCeqCk8GvShw3lHWLysFdgMsCwV04S1dhrKjq+JfPdvCny0Qr
        PASyTxGWhj/jf430TmbVkWxpQGW+XmhnLcxOdhKaFEXvx3r5KNPPul8EOEd3KPw9
        Zblmcx85gWgZgPvKg7VZuHyIiIQanlIQeyELk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ay6UcMtVwVvwdizIoRcPgW/b8HjKrZyj
        xPfofw5G4o1Ps/pmvxfUqXoD7iWnrYE+/cn5Z3jzwQQJfigLw5F6o9hmbjA4J6g9
        hq/Hec1qSYXG1G49i67pSqGO9SWIEGRSOzrxyGnVsqC3fwdd3Bp9o3oKJoySYJzR
        VQxlvXyro/8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F21215C125;
        Tue, 27 Aug 2019 18:16:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92F7615C124;
        Tue, 27 Aug 2019 18:16:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 04/11] hashmap_entry: detect improper initialization
References: <20190826024332.3403-1-e@80x24.org>
        <20190826024332.3403-5-e@80x24.org>
        <nycvar.QRO.7.76.6.1908271108410.46@tvgsbejvaqbjf.bet>
        <20190827094923.6qhwqosiucsi43td@whir>
Date:   Tue, 27 Aug 2019 15:16:46 -0700
In-Reply-To: <20190827094923.6qhwqosiucsi43td@whir> (Eric Wong's message of
        "Tue, 27 Aug 2019 09:49:23 +0000")
Message-ID: <xmqqa7bu2r01.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C491C26-C918-11E9-87B5-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I renamed it to intentionally break my build.

This cuts both ways.  If you work without any throw-away merges, it
is GOOD to make sure any new use other people added will be spotted
by the compiler by breaking the build.  It will force you to resolve
all such breakages until you can move on to other topics, and it
will also force you to commit to your topic that deliberately breaks
the build by renaming.

If you want to avoid committing to the current iteration of topic,
however, then that would mean you'd need a reliable way to rebuild
evil merges (aka resolution of semantic conflicts) so that you can
keep parts of more recent history more flexible (similar to how 'pu'
is managed).

My plan is to have ew/hashmap topic for a few days while ejecting
the js/add-i topic which semantically conflicts with the changed way
hashmaps ought to be used temporarily, and when I have enough time
and concentration, try to see if I can come up with a good semantic
conflict resolution that I can keep reusing (aka refs/merge-fix/).
If it happens, we'll see both topics, and if it doesn't, I'll then
drop ew/hashmap and queue js/add-i and rinse and repeat from there
;-)

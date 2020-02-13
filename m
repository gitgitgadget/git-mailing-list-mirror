Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916B4C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447F820659
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RjMxjlr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgBMSKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:10:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62585 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgBMSKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:10:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C097BC0CC;
        Thu, 13 Feb 2020 13:10:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3es/gS7REYlvr362oJZAUSzUfN4=; b=RjMxjl
        r9OzHsxPtPzXueWQ3UewSzkyXOVECKtwXJVY1mQro5XFubjyvUJvdpRr3z99MLmD
        wJ7kUhMaSstO9LbU3H0Lc2SAyyJy90Wfl/9sRroOBawTix34XF51ZBk0ngHgPeGp
        JRycIkHYykyLjjSLs0bfEAmLZ3sBP+cSJVvhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LkbTpXdMQPpxcAQ5brI6McQG80iTuTt5
        mCB43G8VPEZ+dBrfMuLUHOR/sKPtR29AJd6u1ASGgJ4rWI+3vV0/dK6rgrsXredL
        IK6rfQ87yV6Z/M43leg41eIt4I/Ff2lVlmK0Tt+5IMxwkLCAw338gQjnyoqPoSr2
        xu8K4NU8WPk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63C08BC0CB;
        Thu, 13 Feb 2020 13:10:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 932E2BC0C7;
        Thu, 13 Feb 2020 13:10:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Parth Gala via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Parth Gala <parthpgala@gmail.com>
Subject: Re: [PATCH 2/5] object.c: lookup_unknown_object() accept 'r' as parameter
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
        <16dd64618ab6a086727685e9eca3850fabc46437.1581535151.git.gitgitgadget@gmail.com>
        <20200212202540.GD4364@syl.local>
        <xmqqtv3vtst5.fsf@gitster-ct.c.googlers.com>
        <20200213180030.GF45518@syl.local>
Date:   Thu, 13 Feb 2020 10:10:45 -0800
In-Reply-To: <20200213180030.GF45518@syl.local> (Taylor Blau's message of
        "Thu, 13 Feb 2020 10:00:30 -0800")
Message-ID: <xmqqh7zus6hm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28DD0538-4E8C-11EA-9185-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Feb 12, 2020 at 01:11:02PM -0800, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > ... same question about why assigning:
>> >
>> >   struct repository *r = the_repository;
>> >
>> > and passing 'r' everywhere is preferable to simply passing
>> > 'the_repository' in directly.
>> > ...
>> >>  static void mark_object_for_connectivity(const struct object_id *oid)
>> >>  {
>> >> -	struct object *obj = lookup_unknown_object(oid);
>> >> +	struct repository *r = the_repository;
>> >> +	struct object *obj = lookup_unknown_object(r, oid);
>> >>  	obj->flags |= HAS_OBJ;
>> >>  }
>> ...
> Right, but my suggestion was that this advice doesn't apply to this
> particular instance since I don't expect that we'd ever passing
> something other than 'the_repository'.
>
> Specifically, I was worried that we'd get bitten by re-assigning 'r' in
> the middle of the function and then end up in some odd broken state.

"git fsck" works only in a single, "the", repository, so I guess you
are right to be worried about unnecessary complexity here.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B6E82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjI0T5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjI0T5X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:57:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD41993
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75E7A204DC;
        Wed, 27 Sep 2023 15:56:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=VCXGRgzQC0Rk7QxtvNHeGOPdNx/yhF4K+EbfWN
        4vgps=; b=lZXZp4ay5Y5kz0UeYEhYlFAtjYT++Un9f92KEPjQyZbHVD6GuI6gqa
        8O1wMtu3J6PalbKjTyIY0+gFtKXdWH+AGSS26AbSNcEdFTyt9sM57q6GUCDiwrnJ
        XnwveXDblQzodLtuEo9bK12w2lcEwN6d5iFbWB6+aJdrXT/FLIwjY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E352204DB;
        Wed, 27 Sep 2023 15:56:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F2A5204DA;
        Wed, 27 Sep 2023 15:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup: Only allow extenions.objectFormat to be
 specified once
In-Reply-To: <87r0mjn4ly.fsf@gmail.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 27 Sep 2023 08:11:05 -0500")
References: <87h6ngapqb.fsf@gmail.froward.int.ebiederm.org>
        <xmqqr0mkmx9b.fsf@gitster.g>
        <87r0mjn4ly.fsf@gmail.froward.int.ebiederm.org>
Date:   Wed, 27 Sep 2023 12:56:39 -0700
Message-ID: <xmqqwmwbl79k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9EB8B18-5D6F-11EE-A516-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> For me the fundamental question is if we allow multiples compatibility
> hashes or historical hashes how do we specify them?  Have the option
> appear more than once?  A comma separated list?

As you found out, we tend to use both, but the former does look more
natural to me.

The "usual" pros and cons [*] involve how easy it is to override the
settings given by more general low-priority configuration files with
more specific high-priority configuration files, and does not apply
to the extensions.* stuff that are by definition repository
specific.


[Footnote]

As I said, this does not apply to the topic of this discussion, but
just for completeness:

 * comma separated list allows overriding everything that was said
   earlier wholesale; there is no ambiguity, which is a plus, but
   there is no incremental updates, which may be a minus when
   flexibility is desired.

 * multi-valued configuration variable allows incremental additions,
   but ad-hoc syntax needs to be invented if incremental
   subtractions or clearing the slate to start from scratch is
   needed.


Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB54C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 13:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C782A20708
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 13:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p+qjusFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGINvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:51:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63212 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgGINvm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 09:51:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD735EE480;
        Thu,  9 Jul 2020 09:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YZ5bqDZML5RYGvquDXaHN2AweXM=; b=p+qjus
        FEMvkhZB6quBS5En0lBO1oooNM4BVPFoF5vpU9h3fHBGdh4fGfNaXMvDIn9Jxt3l
        WeHeWDyk/IbkfoknJwz3tGsMk15n2o94f3t+q8tmA0Dz+EH+6wuC/ei4beu1aehA
        lW1eZ++ooIPJuyFFqQWpGwvhSGQHRUGlJawzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P4SmiWdoLa/+LFbQkM69Lc0uWu2tPcPA
        +R1Pw5LFedK+KSaTchb9CjpVRZivvC3RgWDt/p5+VW4LqUE6F8wkSq9K04p+Am8X
        MFev0f0y07Mx9hTVvZk8s3cPGm8LgPPzeblODFk1CzlAtXBqHHW4axAHlO8NoBNR
        hhZEwQpbAGo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B41E2EE47F;
        Thu,  9 Jul 2020 09:51:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05C69EE47E;
        Thu,  9 Jul 2020 09:51:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, derrickstolee@github.com,
        dstolee@microsoft.com
Subject: Re: [PATCH 08/21] maintenance: initialize task array and hashmap
References: <5cdd38afa60cdf768dd194f90ae0b2190123fdea.1594131695.git.gitgitgadget@gmail.com>
        <20200709022519.38407-1-jonathantanmy@google.com>
        <329a6be3-df8f-971d-14ac-5d4f9377a25f@gmail.com>
Date:   Thu, 09 Jul 2020 06:51:35 -0700
In-Reply-To: <329a6be3-df8f-971d-14ac-5d4f9377a25f@gmail.com> (Derrick
        Stolee's message of "Thu, 9 Jul 2020 09:15:35 -0400")
Message-ID: <xmqqzh88yexk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EB81C0C-C1EB-11EA-938B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/8/2020 10:25 PM, Jonathan Tan wrote:
>>> This list is also inserted into a hashmap. This allows command-line
>>> arguments to quickly find the tasks by name, not sensitive to case. To
>>> ensure this list and hashmap work well together, the list only contains
>>> pointers to the struct information. This will allow a sort on the list
>>> while preserving the hashmap data.
>> 
>> I think having the hashmap is unnecessarily complicated in this case -
>> with the small number of tasks, a list would be fine. But I don't feel
>> strongly about this.
>
> You're probably right that iterating through a list with (hopefully)
> at most a dozen entries is fast enough that a hashmap is overkill here.
>
> Now is the real test: can I change this patch in v2 without needing
> to mess with any of the others? The intention here was to make adding
> tasks as simple as possible, so we shall see. :D

Adding a new element to a list would be simple no matter how the
list is represented.  But I think the real question is what access
pattern we expect.  Do we need to look up by name a single one or
selected few?  Do we need the iteration/enumeration be stable?  etc.


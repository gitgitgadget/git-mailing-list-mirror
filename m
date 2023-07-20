Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146A7EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 20:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGTUaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTUaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 16:30:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671909E
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:30:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6C701AF73F;
        Thu, 20 Jul 2023 16:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rMVg9DMidghz2Pz7qn1drHuFymVpVd3Z7CuNd2
        g/6lU=; b=X3b3rEKrZtNnyjFU6PtWeEQ3KuLnNmuOcFSljYwfEPFDNYiOyTkOf4
        1BhvsOaXQfKLxEFroXsyNIQUO5wSrjV5trD6D+GPJpl3JM2ToaVf5QScBRylVYVL
        +fhKS5R6bsOguTcgDdVrxvWQaPy9S4Q2YqsB8ipuQ8DYAEco/uPgQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF6BA1AF73E;
        Thu, 20 Jul 2023 16:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A85D1AF73D;
        Thu, 20 Jul 2023 16:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>
Subject: Re: [PATCH v3 1/2] ref-filter: add multiple-option parsing functions
References: <20230714194249.66862-1-five231003@gmail.com>
        <20230719162424.70781-1-five231003@gmail.com>
        <20230719162424.70781-2-five231003@gmail.com>
        <xmqqjzuv5vvg.fsf@gitster.g>
        <kl6lzg3qzdhn.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 20 Jul 2023 13:30:13 -0700
In-Reply-To: <kl6lzg3qzdhn.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 20 Jul 2023 10:42:12 -0700")
Message-ID: <xmqqzg3q1g2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B490942-273C-11EE-BEFC-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> 	So whatever framework we choose, it should allow adding a
>> 	test or two to this patch easily, without being too
>> 	intrusive.  Would that be a good and concrete evaluation
>> 	criterion?
>
> Perhaps, but the biggest blocker to adding a unit tests is whether the
> source file itself is amenable to being unit tested (e.g. does it depend
> on global state? does it compile easily?).

Perhaps.  

Now would this particular example, the change to ref-filter.c file,
be a reasonable guinea-pig test case for candidate test frameworks
to add tests for these two helper functions?  They are pretty-much
plain vanilla string manipulation functions that does not depend too
many things that are specific to Git.  They may use helpers we
wrote, i.e. xstrndup(), skip_prefix(), and git_parse_maybe_bool(),
but they shouldn't depend on the program start-up sequence,
discovering repositories, installing at-exit handers, and other
stuff.  It was why I wondered if it can be used as a good evaluation
criterion---if a test framework cannot easily add tests while this
patch was being proposed in a non-intrusive way to demonstrate how
these two functions are supposed to work and to protect their
implementations from future breakage, it would not be all that
useful, I would imagine.

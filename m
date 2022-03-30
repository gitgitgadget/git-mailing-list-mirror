Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4610C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 00:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbiC3Auu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 20:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbiC3Aus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 20:50:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3623C6253
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 17:49:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B309170208;
        Tue, 29 Mar 2022 20:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ukwXikADnHhdrPaTBocJCdmubdNkeBz2abYMYK
        pCoX8=; b=Ojog2u2ahQC/BqRJfPb5VaPCGhbKFvjKsWnMtAl1aMwvcvaHHF4CbS
        sOxP8e6wIIKxVlwOHebQtlUdE33m3IRz+kPUwN4gkaWbQZmrC6NpcDxyLn6qA8vQ
        bZD2R5fqOojzygsJVoNzdXEkO2cyEF7qkaUdsKAbA+D2KI4fQQKp0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83DB8170206;
        Tue, 29 Mar 2022 20:49:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E57F91701FB;
        Tue, 29 Mar 2022 20:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
References: <20220208235631.732466-1-calvinwan@google.com>
        <20220328191112.3092139-1-calvinwan@google.com>
        <20220328191112.3092139-4-calvinwan@google.com>
        <xmqqmth8qsiv.fsf@gitster.g>
Date:   Tue, 29 Mar 2022 17:49:00 -0700
In-Reply-To: <xmqqmth8qsiv.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        29 Mar 2022 15:54:16 -0700")
Message-ID: <xmqq4k3gqn7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3123DDA8-AFC3-11EC-B6E7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Shouldn't we be making the part that we truly need to reuse into a
> separate API out of fetch-pack and either (1) allow new commands be
> easily written reusing the code to create "git remote-object-info"
> and "git remote-blame", or (2) come up with a single "do things on
> remote" command with various subcommands, i.e. "git over-there
> object-info" and "git over-there blame"?

For completeness, we could also make the "git archive" the gold
standard.  If we want "git blame" that is mostly executed on the
remote site, we could teach "git blame --remote <there>", which may
be where a user, who does not know nor care about how things are
implemented, would expect to find the feature.  Is "object-info" in
principle like executing "cat-file --batch-check" remotely?

I think that "Object 'size' is currently the only one the server
knows to emit", combined with the lack of any client side support so
far, means that it is not too late to rework the object-info thing
and possibly reuse more from "cat-file --batch-check".

If we can create a system where running things locally and remotely
are comparable in feature, that would be great, but I do not think
that is a realistic goal to aim for.

Thoughts?




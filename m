Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56DDC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 17:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963BF613E7
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 17:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhFCRmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 13:42:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51449 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFCRmM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 13:42:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EB72C7D19;
        Thu,  3 Jun 2021 13:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xB+HwGTPcVcSuUeNaL0V4RNvX+pmOiPfzQtIgC/xt4g=; b=V1Ny
        RQLCDdt8mGH5XMR7EqHEEGZDwuEsRGaWFsGpc0uakVtFK1ubkY0ZxQOmD229gl7K
        Njkj7T4JmRCgan1sULbi7jNNqAOQCjg7DrDZrQUDHX2gQaT36zJ6rnltjVfEMfsE
        6B6Aj7wivJ8bo940HGyhKt9/rVlhnQqgQ0t+XHA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56AC5C7D17;
        Thu,  3 Jun 2021 13:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF710C7D16;
        Thu,  3 Jun 2021 13:40:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Ilias Apostolou <ilias.apostolou.zero@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request feature: =?utf-8?Q?=E2=80=93no-submodule?=
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
        <YLfqiLbpPXWXHlBi@nand.local> <xmqq8s3r7oma.fsf@gitster.g>
        <YLg/dLqYFEqHZJUn@nand.local>
Date:   Fri, 04 Jun 2021 02:40:25 +0900
Message-ID: <xmqq7dja6e46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C79ABEA4-C492-11EB-8BF8-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Mmm, that's a convincing set of reasons to think that this is a bad
> idea. (And I was sort of on the fence about it anyway by posting the
> whole thing as a short diff instead of a polished patch).
>
>> I wonder if the "attr" magic of the pathspec, that allows you to
>> choose paths based on the attributes you set on them, is what the
>> original requestor missed.
>
> Maybe... but relying on the attr magic for this particular case would
> force the requester to set that attribute on all submodules in their
> project, and constantly keep that in-sync with their .gitmodules.

Well, it contradicts with the above "convincing" adjective, and
shows that you are not convinced that "submodule"-ness is not all
that essential and it merely is an artifact that the paths that the
original requester happens to be uninterested in are all submodules.

But if we agree that focusing too narrowly on "submodule"-ness is a
bad idea and open our mind to elsewhere, we'd realize that once we
learn that we can "mark" any path with attributes and use that in
magic pathspec, we can mark not just submodules but a subdirectory
as "uninteresting", which will not become useless even when it turns
out that "submodule"-ness wasn't really what the request was about.

Besides, you can iterate over the available submodules with "git
submodule foreach" fairly mechanically, and maintaining the
attribute per path shouldn't be all that hard, I would imagine.

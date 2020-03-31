Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BB7C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587DF20784
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o+Kds7dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCaSnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:43:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50910 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaSnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 14:43:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6242BB6F58;
        Tue, 31 Mar 2020 14:43:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OW+iK2MoPM0vWmY/WwYLORVk5Pk=; b=o+Kds7
        dlx6/CKN8zNXCA9/YOgsoX+i1IOwsYFpxCif+zBFBpkL77t/s7NS2e4fyCexWm2p
        qXoKtc2XOlxqzv5JnAcZcIKGpe/Qzot7rI1V2PntPw3eDI+dZlTv7q0V0iHk6gXJ
        C0MwSpHEfF/YiICxa3dNw6flf8GMyVxxJ+LqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HLk3h0hqoYoA7Jv0bHhQDXiCe9menwcq
        Nh6apEC7QWsDwuqcz7zwlTeqnc7pWx/ZJN/3Rjo6YAmKthCIwYb9EdHaDcUz229G
        zHvB5mUn+y8K28avMs9xrrOANYWlDNyLMIer+KAya/5RG3fj4ED0OVvCCKHJuGmJ
        AOqQMV6WHDg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59E48B6F57;
        Tue, 31 Mar 2020 14:43:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A38ADB6F56;
        Tue, 31 Mar 2020 14:43:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>, congdanhqx@gmail.com,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
References: <20200309205523.121319-1-jonathantanmy@google.com>
        <20200330040621.13701-1-jonathantanmy@google.com>
        <CABPp-BGew8HWChsMVH3ZNS4DuH=nE-GF5ouifP7DhLP-xQ_xbg@mail.gmail.com>
        <xmqqh7y474r3.fsf@gitster.c.googlers.com>
Date:   Tue, 31 Mar 2020 11:43:40 -0700
In-Reply-To: <xmqqh7y474r3.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 31 Mar 2020 11:34:24 -0700")
Message-ID: <xmqqd08s74bn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AEA0042-737F-11EA-9BBC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> True.  So instead of letting the machine match commits on the both
> sides up, the end-user who is rebasing will find matches (or near
> matches) and manually handle them.  It would be a good idea to
> describe the pros and cons for the option (which I think has already
> been written fairly clearly in the proposed patch).

Sorry, strike the part in (parentheses) out.  I was looking at the
description in an earlier version with --skip-cherry-pick-detection,
which had a good explanation on "if such detection is not done,
then..." but with the latest one seems to have lost the description
altogether.  Minimally something like this from the earlier round
should probably be resurrected.

    ... these duplicates will be re-applied, which will likely
    result in no new changes (as they are already in upstream) and
    drop them from the resulting history.

Thanks.

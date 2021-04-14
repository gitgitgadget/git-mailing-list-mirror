Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9392CC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C2E60FF1
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhDNVx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 17:53:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57848 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhDNVxs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 17:53:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F3C112D41A;
        Wed, 14 Apr 2021 17:53:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LiE5AFcb+Oi+FcBMskhp/4Db3iI=; b=kKc5mq
        qOxYY802rOXj+tTIfcXi/dwyKxTvAmiEhvAkaBZJ+qPhTcMzqFGirKiCHFbrQpxp
        ZTHlscsJcoEB1XBx0JZUEDpjcZ8H5t3l8z5P1OCpSTK/ZcSrAxX7JAVGKQHnpilf
        NfLd95PA3pj44NrB7QKGazs7qrXzHK9wPnbOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ddhS2+b7PSDcrpz4/o7IkdYY1yD5NhJM
        yX567+9aG8HyB/E++vhBIAFsMeh4fNEHK/0MECWfrbYJgxzfdf29UoVL6XQaZ4A8
        2gZLkjRP7SZA9p7HctsPtFWT7fJpAfD0Urix+DqD7bRLm5e8nVPicPf9l0GWyTD/
        ynNRa1IrlUE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77C5A12D419;
        Wed, 14 Apr 2021 17:53:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8C8012D418;
        Wed, 14 Apr 2021 17:53:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: What's cooking (draft for #4's issue this month)
References: <xmqqmtu1zn3o.fsf@gitster.g> <YHa5NE3tj/R5kF8N@ncase>
        <xmqqeefcy35i.fsf@gitster.g>
Date:   Wed, 14 Apr 2021 14:53:19 -0700
In-Reply-To: <xmqqeefcy35i.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        14 Apr 2021 14:20:09 -0700")
Message-ID: <xmqqv98own1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3F03394-9D6B-11EB-BFFB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> The following patch fixes this, which
>> I'll include in my next reroll of this series.

Hmph, I am not sure if that is wise.  The offending "-1 no longer is
accepted" comes from a topic that is not even in 'next', so you may
not want to depend on it.

It turns out that the two-argument form that passes -1 to the
function we see below as the preimage in your fix-up patch comes
from my conflict resolution.  Your original has

	type_from_string_gently(v0, -1, 1);

and the other topic wants to make two unrelated changes to the API,
i.e. making -1 no longer a valid "please count, as it is pointless
to force callers to always count" option, and drops "is this asking
to be gentle?" parameter.  It may be better to just update what is
recorded in my conflict resolution machinery, without making it

	type_from_string_gently(v0, strlen(v0), 1);

as it would be necessary to adjust when both topics are merged
anyway.

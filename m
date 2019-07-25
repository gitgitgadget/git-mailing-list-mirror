Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DD11F462
	for <e@80x24.org>; Thu, 25 Jul 2019 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbfGYQOL (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 12:14:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57730 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389047AbfGYQOK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 12:14:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EB3315CF0B;
        Thu, 25 Jul 2019 12:14:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z8tET9UOam13
        XV+68Dt2PGcFOiM=; b=P46kkxGiyPUgQA8ePXzNiznxEb7kNFzrue17VDqWu4IZ
        +BhnPErojyv12mOHqOwwJzZmNRyn0uf8IyHM0/6OcTCpx1JMyeLeSnYkkgn0ljzn
        Q+TSKdOK3ZfXVEQ7NSi7z1bPSVPsmX7Syly5faTqJmbcJtzVhNNQWxuBPl8IOuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YiO3VZ
        oBzxjzrPQEnPizsojOzI9PBRhLxytsyla7Mq9PhERLu1AcFdAP20td+tPusLTIcF
        J3JYRsKCjQy6ZU3SU/PYpwBDn0A8b6ItzuNmILLgXeT5WpnYO/Pe7OI8IJn0SCPf
        Lumhs7gDr5jhuIyvkQvFXLcUXSSjc7IV1EP98=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 968AE15CF0A;
        Thu, 25 Jul 2019 12:14:08 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05E6415CF07;
        Thu, 25 Jul 2019 12:14:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, avarab@gmail.com, peff@peff.net,
        jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
References: <cover.1560295286.git.steadmon@google.com>
        <cover.1564009259.git.steadmon@google.com>
        <20190725111803.GL20404@szeder.dev>
Date:   Thu, 25 Jul 2019 09:14:06 -0700
In-Reply-To: <20190725111803.GL20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 25 Jul 2019 13:18:03 +0200")
Message-ID: <xmqqd0hyqegh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3AEF3D5C-AEF7-11E9-B8E0-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> I would appreciate any feedback on better ways to integrate the
>> validator into the CI suite.
>
> How about adding a test script dedicated to JSON schema validation,
> which runs only as many git commands as needed to cover all trace2
> events.

Sensible, but might be hard to arrange, as the trace2 annotations on
codepaths are not frozen.

I wonder if these schema definitions can somehow be read in reverse
by machine to automatically generate helper functions that would by
definition produce schema-valid json objects, and the current
callers of trace2_*() that logs stuff can be updated to call them?
That way, we'll automatically and always be producing valid output,
or am I dreaming?


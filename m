Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E063C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA20205C9
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KlaD5IQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLKWHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:07:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60944 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKWHy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 17:07:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC0DA95A12;
        Wed, 11 Dec 2019 17:07:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bKnQehqAduJSmjzqO8ZUnvk2Uwo=; b=KlaD5I
        QN0yx9XBTFvyKtuQuiESqZxw6IIZgCbabdkV93c0x/rwAciVE5It/6oCVYWGtHfM
        fCc4YmpPOU8ifCG2XDS2xiJxujY8QjU0ZE3LBbbkJwuHKgJ65k8ZY+wAvYamOAZX
        usLwDxE0uaTbBfFRqcrqPkfxuJ/hhzDTh4G/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bPSuXVLdolMy7HTysWSq9fhd3fl5EZtO
        xVIIRiQji0ItBrosacxajHEboiTcCUdPXNdq1+DYhkK8fdF8/8fGYV10zg3+EQ1u
        TBfzcVKigL4Z49ZQzc/02l5m1i+qLiEgEF50K9r2SDUeriSCuyy0lOsUjRdEEULl
        caVYQrv2ghU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4F0395A11;
        Wed, 11 Dec 2019 17:07:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37CC295A0E;
        Wed, 11 Dec 2019 17:07:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] hook: teach --porcelain mode
References: <20191210023335.49987-1-emilyshaffer@google.com>
        <20191210023335.49987-7-emilyshaffer@google.com>
        <xmqqimmmodwt.fsf@gitster-ct.c.googlers.com>
        <20191211220039.GB8464@google.com>
Date:   Wed, 11 Dec 2019 14:07:45 -0800
In-Reply-To: <20191211220039.GB8464@google.com> (Emily Shaffer's message of
        "Wed, 11 Dec 2019 14:00:39 -0800")
Message-ID: <xmqqwob2ms7i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA947806-1C62-11EA-9A38-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> So, a Porcelain script cannot learn where the hook command comes
>> from,
>
> Not as I had envisioned.
>
>> or what the precedence order of each line of the output is?
>> 
>
> They're printed in the order they should be executed; the explicit order
> isn't provided.
>
>
> I suppose I had considered really just the one use case listed in the
> commit message, especially since other inquiry into the hooks to be run
> can be done against the config files themselves. But - I'm of course
> open to use cases. What did you have in mind?

A tool to diagnose why the hooks are not firing in the order the
user intended them to, for example?

Or a tool to help editing the list of hooks.


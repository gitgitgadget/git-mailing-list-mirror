Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B753C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299FC2078B
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iSr3zjl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHZQ5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:57:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64327 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgHZQ5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:57:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E52BC7D7E1;
        Wed, 26 Aug 2020 12:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X7uLBJx5T55DHRoEllyYce+IKlw=; b=iSr3zj
        l1ZfCa+kR0QrM4BL5UkFyU8nl1+XR3J2i6I5z2gfIshozLHdQim32fG2eGWjML/m
        PcWEkyQfXrKwRs53GZnVhGE2PqaXp2+Knmd+F+LWwXEIr9HRC+fwkYB8Oet86fEs
        sQ9vufBVpzEjl7zforg6TJIiwagXQfEtmEQ8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kTE14oCJOiRr+UHJnHIEtyofY3vbDQ/x
        lghDO9FiOKl9fBiDoYAJpP+nlTOLn+1XzZOLsZL7+xnxg81/KXXduY0+b+DVk4nG
        W/39vGRW3v2yHfgDJrKSIlbORnp0gYvdUWUVg3jeuYHSZ2RQGU2AnL5MVKtoJRtA
        GaZmuXuWlt4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA5E57D7E0;
        Wed, 26 Aug 2020 12:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 472CE7D7DE;
        Wed, 26 Aug 2020 12:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/7] maintenance: optionally skip --auto process
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
        <5fdd8188b1d9b6efc2803b557b3ba344e184d22e.1598380805.git.gitgitgadget@gmail.com>
        <xmqqlfi2z9ht.fsf@gitster.c.googlers.com>
        <1e107b2e-364a-4c17-90b8-0371e8e27878@gmail.com>
Date:   Wed, 26 Aug 2020 09:57:28 -0700
In-Reply-To: <1e107b2e-364a-4c17-90b8-0371e8e27878@gmail.com> (Derrick
        Stolee's message of "Wed, 26 Aug 2020 08:29:10 -0400")
Message-ID: <xmqq4kopwdjb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39D2D28A-E7BD-11EA-9792-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Before the maintenance builtin, it would be natural to see "gc.auto=0"
> and do this same behavior, but that will not be general enough in the
> future.

I do think it is an excellent change to move the check done in
the need_to_gc() to check the value of gc.auto to run_auto_gc()
for exactly the reason the log message of this patch gives.  And
after the function is renamed to run_auto_maintenance(), at some
point the variable that gets checked would also be updated, and
we'd eventually reach the same state, I would think.

But it is so small a change that it probably is not worth the
book-keeping burden of remembering that the maintenance topic needs
to build on the patch to update auto-gc.  

> If you prefer, I can pull this out into a series on its own to be
> tracked separately.

So let's leave it as-is.

Thanks.

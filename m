Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06234C001DC
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 18:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjG0Sox (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjG0Sow (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 14:44:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733AF2D4D
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 11:44:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 845BD21B56;
        Thu, 27 Jul 2023 14:44:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=l0GiDIKQ1zIhAOymTjztW03dVRODMYwLkW0qDc
        2mDoo=; b=ODMJgf3MQ3imYI/SZgwxqsmkHTh6yFcI2lJQYuGdHYyF2we8u39VW5
        l5O/Ysa5cjIb34SF4i93T7daA05L/GmCRavoiylqyMpkC7HkrvvKaZWatM+zxoEE
        YJj6gEne/Sb67MAqVqV8l5HU+qaH6/Cj600vMNpOeZtvCkxpFSoOA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D44121B55;
        Thu, 27 Jul 2023 14:44:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1898421B54;
        Thu, 27 Jul 2023 14:44:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
In-Reply-To: <xmqqzg3ib2ma.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        26 Jul 2023 17:49:01 -0700")
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1689889382.git.jonathantanmy@google.com>
        <xmqq8rb2csr1.fsf@gitster.g> <ZMG3kEO0BzKPaG75@nand.local>
        <xmqqzg3ib2ma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Thu, 27 Jul 2023 11:44:44 -0700
Message-ID: <xmqqpm4db3dv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7CB1E04-2CAD-11EE-A08C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  How hard it would be to construct a test
> case that fails if filter computed as v1 is marketed as v2?

There may be a more effective way for future-proofing, besides
ensuring the test coverage.

Although this series added a way to see which version the on-disk
data is using using the version field, I do not think it touched the
"struct bloom_filter" and "struct bloom_key" that represent the
in-core data.  If we had a member in these structures that
get_or_compute_bloom_filter() can fill in from the on-disk structure
or the version it used when it computed the filter anew, would it
become easier to catch the case where we try to add a version 2
computed key to a filter that was read from version 1 on-disk
structure, presumably at add_key_to_filter()?

Thanks.


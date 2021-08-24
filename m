Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B89AC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDA06135F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhHXVNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:13:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50708 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhHXVNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:13:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E7F9151C7F;
        Tue, 24 Aug 2021 17:12:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QhR0OT8MRbd95swFL4GRJZfrSphkM0+n+OBnmi
        dLpAU=; b=NGOr6EPJIIw7HhzaLWBiGi9rKGVHf5wYaFSI1t7A4I5bFn39qRifCT
        tyNl10TM4gcart0DfDokihy469PgQV/EmhKAT+YEMsgPZ8Zh+Du8S1OGja+Y/+HB
        H+Rw8fvm9Vhm2nIMh9ghFDvVXmSV9Cwim1sXyPsztWV0z4Nu1wA88=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 891A5151C7E;
        Tue, 24 Aug 2021 17:12:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C493F151C7D;
        Tue, 24 Aug 2021 17:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <cover.1617991824.git.me@ttaylorr.com>
        <cover.1629821743.git.me@ttaylorr.com>
        <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
        <xmqqa6l6oafd.fsf@gitster.g> <YSVX18UXh9vX+Zhp@nand.local>
Date:   Tue, 24 Aug 2021 14:12:42 -0700
In-Reply-To: <YSVX18UXh9vX+Zhp@nand.local> (Taylor Blau's message of "Tue, 24
        Aug 2021 16:34:31 -0400")
Message-ID: <xmqqr1eimtrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05EDDB64-0520-11EC-899B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> This needs to take object_dir into account, no?
>
> Yes and no; clear_midx_files_ext() still takes a pointer to a 'struct
> repository' until we pick up [1].

I was hoping that [1] will become part of this series as a trivial
clean-up and bugfix, perhaps in its early part.


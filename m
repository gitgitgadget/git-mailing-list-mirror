Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B74C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5258022C9F
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xb4FDwO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgHGV6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:58:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51140 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGV6k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:58:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57169D147B;
        Fri,  7 Aug 2020 17:58:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3n/jyBbbR0U8OJjUeoEULBb1azA=; b=Xb4FDw
        O+Ilr8yQUmjlPYRe+CB1AU3eEm6qgSgIaPb+4jQvWbhtXhH7wjZ4v6EsY41R+l6Y
        fkn6fd2CBBKK7f1HtnhbSEvsQOsGefnp2JpMTU+alvWjPVDDqf3FaKHLyO69gZ5v
        h2t7sQ2DxSM+gTzDGMGOok3Pcop410wWbnUTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uniR59tfNDyYivAyT+is2VCmlVcMkMC2
        F4CcLf+g7QVCa33MQEZRhHCY/ONBGKff3bRmLNzOj/c744MjfaHlFoJmEBLB9hGS
        gLFa4+1mCArwODAhyxb4ipDde8YkzaP4LXtMeYXLQ1R+AwQ2rQD3P2BFwzO1tLqS
        ILOvSdAueD0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F3ACD147A;
        Fri,  7 Aug 2020 17:58:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 97F74D1479;
        Fri,  7 Aug 2020 17:58:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 4/7] fetch: --stdin
References: <xmqqft90omsw.fsf@gitster.c.googlers.com>
        <20200807211028.2736644-1-jonathantanmy@google.com>
Date:   Fri, 07 Aug 2020 14:58:34 -0700
In-Reply-To: <20200807211028.2736644-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 7 Aug 2020 14:10:28 -0700")
Message-ID: <xmqqbljmf791.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 245726D6-D8F9-11EA-A077-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Yes, and I only implemented the reading in fetch_one() because
> fetch_multiple() does not read additional refspecs from the command-line
> (it does not take "argv"). Looking at the code, this seems to be on
> purpose - there is the error message "fetch --all does not make sense
> with refspecs", and when --multiple is set, all args are assumed to be
> remotes.

OK, that does make sense.  so the multiple one is just a short-hand
for 

	for remote in ...
	do
		git fetch $remote
	done


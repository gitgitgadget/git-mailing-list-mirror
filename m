Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421C0C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7F820EDD
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MdbCGqm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410428AbgJPTHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 15:07:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53205 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410373AbgJPTHE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 15:07:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B10880FCC;
        Fri, 16 Oct 2020 15:07:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jz1fzG60ImmGENkY37MC58h+hTQ=; b=MdbCGq
        m96+JfnaYsSuzA4dLvwd8YxnrFXK24wgj2XxLPlxz3s7QJicD/SlpP72D7AQmCco
        tb7/ywLRMdIt/UR36F9RUmTjWvIiBfQjgFqt1FhwZkRIVPa+TpSueA/2N+01vY7u
        OSlUXAOityRv2Cpk7dQXm7L3tkSEa52i14Mvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V/PGJ7sG2LQD8aevq5iMYLE0TanFXC2r
        thsduMbxJz2PMiYTaRrXx2tlUyfZtncV29kSPXoKQxWxeJ3u2u00K9qD0eOYb2z9
        kuUpyumDWgqiPScYOZemjdHedEv0wjT6kKOKPxSIqKX0foy8O83B+aAHUpU5hono
        UEOurv/CBfs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E19CF80FCA;
        Fri, 16 Oct 2020 15:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CFEF80FC9;
        Fri, 16 Oct 2020 15:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 04/11] merge-index: don't fork if the requested
 program is `git-merge-one-file'
References: <20200901105705.6059-1-alban.gruin@gmail.com>
        <20201005122646.27994-1-alban.gruin@gmail.com>
        <20201005122646.27994-5-alban.gruin@gmail.com>
Date:   Fri, 16 Oct 2020 12:07:01 -0700
In-Reply-To: <20201005122646.27994-5-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 5 Oct 2020 14:26:39 +0200")
Message-ID: <xmqqv9faat2i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6026106-0FE2-11EB-9B71-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Since `git-merge-one-file' has been rewritten and libified, this teaches
> `merge-index' to call merge_strategies_one_file() without forking using
> a new callback, merge_one_file_cb().
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---

I do not know how much of the change in this patch survives when the
previous step gets adjusted, so I'll skip this step for now.

Thanks.

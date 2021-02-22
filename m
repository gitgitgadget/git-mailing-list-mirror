Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D944BC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 20:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A37E60C3D
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 20:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBVUMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:12:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61477 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhBVUMw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 15:12:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 322E9BC54B;
        Mon, 22 Feb 2021 15:12:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rul1HK4jYrll
        HRA8JuEIVKEKP4E=; b=rS758YypAPeY/mcOWDtguI+HaExTTmMdPFXRrrdqI5RH
        rx+IKfouu+SToevY4tEiN1f5FZVsHCRqbV7upNG5gvPsroshEGMvJ/JmZtRGq7Te
        GJyVr3v1/jcCyAQRLvvaOXGRDOnottR2ACWalMgt9ivJI9jA+Eb8FmI62uCidjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bFTk9+
        c9lHk1a8//lfMTXATXcJOKanVBTOZR360sfVvv1GYdmkt9Z7iBNyDD7rySejqlNK
        6veOrp7AjrAMwYOuXDRf3yLRTe8dR6k6lQhwXda/sAp7QCc51YrEy3Yg+ys74ULd
        0UTCK0DwPNI6hTbuAFOyqwg8tk7Q7dVkWGBt0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 298B1BC54A;
        Mon, 22 Feb 2021 15:12:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89B3BBC548;
        Mon, 22 Feb 2021 15:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v2 0/4] Check .gitmodules when using packfile URIs
References: <20210115234300.350442-1-jonathantanmy@google.com>
        <cover.1614021092.git.jonathantanmy@google.com>
Date:   Mon, 22 Feb 2021 12:12:08 -0800
In-Reply-To: <cover.1614021092.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 22 Feb 2021 11:20:05 -0800")
Message-ID: <xmqqft1n7tgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3E28B046-754A-11EB-8E19-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Here's v2. I think I've addressed all the review comments, including
> passing the index-pack args as separate arguments (to avoid the
> necessity to somehow encode in order to get rid of spaces), and by usin=
g
> a custom error function instead of a specific option in fsck.
>
> This applies on master. I mentioned earlier [1] that I was planning to
> implement this on =C3=86var's fsck API improvements, but after looking =
at the
> latest v2, I see that it omits patch 11 from v1 (which is the one I
> need), so what I've done is to use a string check in the meantime.
>
> [1] https://lore.kernel.org/git/20210219004612.1181920-1-jonathantanmy@=
google.com/

I only looked at the difference between this round and what is in
'seen', but everything looked reasonable to me (including the code
that is near NEEDSWORK comment, and what the comment said).

Will queue.  Thanks.

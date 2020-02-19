Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965F8C34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A25A24654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 21:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sZtZCnPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBSVgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:36:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59324 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSVgr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 16:36:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A85EC5E2E;
        Wed, 19 Feb 2020 16:36:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WcksNdBerVgUZUdFasLZMnRIYnc=; b=sZtZCn
        PXFAJcygWZEB4xVOWGfWYleXPjyv1C096vAo+Nf4yIUO6lxT/LMFCZ2U5k2WLciX
        Nf4oF17V+/4gfiUn5ERXc07fMSXnllsm8Jt6wVepASenP2m6hNzC/O1N116i3en7
        uaGn7yX6PUVPXQwYM84mv2V4mEiywqPK5D1Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o6fycJtK/9DGLmfi7153C8XZagW/zLMs
        AKlpo78rFIVww2LqZDRD0+4EUkQjpiWQGSQOCg4VZcHIkShD5qgMKiBX2SUxvl6a
        uWS/jq0QthlQAOI/esF2LU1BIzVVakH8DIA3CKb2sSSPFS8f2ij075BKEVL+8oOl
        UImFxVrY5SM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02BBDC5E2D;
        Wed, 19 Feb 2020 16:36:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A26DC5E2C;
        Wed, 19 Feb 2020 16:36:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] check-ignore: fix handling with negated patterns
References: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com>
        <xmqqimk5ks39.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEbojaeYkSMR7vntW0SkWf6dVOko5H=jqT-Yv2USRerxA@mail.gmail.com>
        <xmqqeeutkkur.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHaTK62W4_rUaJXNUPSfu9cBD5MrmjgbJeMuA+7s3+rGg@mail.gmail.com>
Date:   Wed, 19 Feb 2020 13:36:39 -0800
In-Reply-To: <CABPp-BHaTK62W4_rUaJXNUPSfu9cBD5MrmjgbJeMuA+7s3+rGg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 17 Feb 2020 13:07:46 -0800")
Message-ID: <xmqq7e0idztk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB3D3E72-535F-11EA-9B8A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> No, it is not more like that; the check-ignore manpage currently claims this:
>
>        For each pathname given via the command-line or from a file via
> --stdin, check whether the file is excluded by .gitignore (or
>        other input files to the exclude mechanism) and output the path
> if it is excluded.

Thanks.  I wasn't paying attention to what happened to the manpage
(or to the command for that matter) after I wrote it as a debugging
aid X-<.

The updated version looked reasonable to me.  Thanks.

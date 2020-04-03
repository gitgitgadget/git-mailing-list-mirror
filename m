Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B99C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF182080C
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZW/jb+hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgDCTfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:35:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52678 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgDCTfg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:35:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 902385B01F;
        Fri,  3 Apr 2020 15:35:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iiL2L9dmUS3KhaEu2S7ABNfXbmQ=; b=ZW/jb+
        hURBQCh2gbKgK3ztkoZFI4WM4JWQwXKl/RR1TmpSaJycidMZ0L7Wps4CpPWQnqHb
        MMOpO2ZAJj0TAvawTjToRb4HIqYl2X26pMeNbhHFm2ykOXLJjaBHQCDaiDaj9Gq6
        McH1mD/b2n1sJICiPmhReHw80YScCYH37bPyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QH+G5MVeYx6wNCgaeSFjlWcGW32ciomM
        bAHriwsuiw11MI+kty5gIgOzsbZJnKipS2jUGhQEUkjNaYuLGdPrIbFJvTO2FVJF
        AM9lYkOUMIoJHemtA3QmntGW6l5X2SnVZBDBRxh/eMEtj2lf/m7pQrGYh9KLrvMx
        O3O8+1tJqLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85C245B01E;
        Fri,  3 Apr 2020 15:35:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DCC75B01C;
        Fri,  3 Apr 2020 15:35:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] git-rebase.txt: add another hook to the hooks section, and explain more
References: <pull.749.git.git.1585888520572.gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 12:35:32 -0700
In-Reply-To: <pull.749.git.git.1585888520572.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Fri, 03 Apr 2020 04:35:20
        +0000")
Message-ID: <xmqqk12wz7jv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48AF6A22-75E2-11EA-8EFA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  The apply backend has not traditionally called the post-commit hook,
> +while the merge backend has.  In contrast, the apply backend has
> +traditionally called the post-checkout hook while the merge backend
> +has not.  However, the calling of these hooks in both cases was by
> +accident of implementation rather than by design (both backends were
> +originally implemented as shell scripts and happened to invoke other
> +commands like 'git checkout' or 'git commit' that would call the
> +hooks).  Both backends should have the same behavior, though it is not
> +entirely clear which, if any, is correct.  We will likely remove both
> +of these hooks in the future.

I'd phrase, instead of "remove", "stop calling from 'git rebase'".
These hooks will still be called from their intended context ;-)

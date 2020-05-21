Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A37C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A191D207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 21:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jlFN19Xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgEUVL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 17:11:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62608 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbgEUVL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 17:11:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9D67BE0F3;
        Thu, 21 May 2020 17:11:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cw6NSoHYY/GhYfbXGhmxAeLzUMg=; b=jlFN19
        XmUMk/gEGTehPZUv/wjX0TDPJSPNZIALQqsORjsCLWFM+NzI0rTzQWAfdABNDsd3
        i8LX9aJYTma9c4swrktMZQN7O2zR4oQedZ57NuoR9bZTP5Tl+seaamoNQSraslgb
        vf5bE7BZvqu8CYhQ2JKo7wqEx6xpqX8leWA8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JdvF5hhOH6YQ9+ZvZtZm+LfhK3r1W/DQ
        PFjU7rKSFYY8MVfTQvIXCe0PSKRHlCBJuCejsOx6HuUwxUGHRcKF1dovYl+7QuAU
        YYKomZwKJNOFrRgqi+/33orBXwG0OT69sPPVVQuGO/6WY7Il3HycKsmR8kj8Re7w
        eByQ7MpPWak=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1248BE0F1;
        Thu, 21 May 2020 17:11:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F272ABE0EF;
        Thu, 21 May 2020 17:11:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] lib-submodule-update: pass OVERWRITING_FAIL
References: <cover.1588162842.git.liu.denton@gmail.com>
        <cover.1590019226.git.liu.denton@gmail.com>
        <48598e3f9859dc525ec878cd7f3eaadee8bb61b1.1590019226.git.liu.denton@gmail.com>
        <20200521182928.GA1308647@coredump.intra.peff.net>
Date:   Thu, 21 May 2020 14:11:53 -0700
In-Reply-To: <20200521182928.GA1308647@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 21 May 2020 14:29:28 -0400")
Message-ID: <xmqq8shlro12.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2D0CC26-9BA7-11EA-9D03-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You solve it here by passing OVERWRITING_FAIL down into the callback
> functions. And that does work. But I think it may be easier to
> understand if we invert the responsibility. Let the outer caller specify
> two callbacks: one for setup/prep that must succeed, and one for a
> single operation where we might expect success or failure.
>
> The changes in lib-submodule-update look something like:
> ...
> And in the caller we can simplify greatly:
> ...
>   +test_submodule_switch "reset_branch_to_HEAD" "git pull"
>   +test_submodule_switch "reset_branch_to_HEAD" "git pull -ff"
>   +test_submodule_switch "reset_branch_to_HEAD" "git pull --ff-only"
>    KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
>    KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
>   -test_submodule_switch "git_pull_noff"
>   +test_submodule_switch "reset_branch_to_HEAD" "git pull --no-ff"
>    
>    test_expect_success 'pull --recurse-submodule setup' '
>    	test_create_repo child &&
>
> I suspect this approach involves touching more lines than yours (it has
> to add $prep everywhere $command is used). But IMHO the result is much
> simpler to understand, because there's no spooky-action-at-a-distance
> from magic environment variables.

Yes, spooky-action-at-a-distance was what made me go Eeeeek when I
saw the original approach.

> A more complete patch is below, which is enough to get t5572 passing. I
> think it would need the other test_submodule_switch() function updated,
> and other scripts would need to adapt to the 2-arg style.

below where?

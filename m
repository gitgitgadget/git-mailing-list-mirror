Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D6DC433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 07:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359249AbhKZHox (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:44:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50886 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359258AbhKZHmv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 02:42:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0591316C9E6;
        Fri, 26 Nov 2021 02:39:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SHlM299zYUeQ+mRONZgHbz8zSU7FkeMjCfrIRQ
        db4uA=; b=VL1LNvqCrPj5OSsbad7qMtdHUwhDlzIQs2ZVDhvf9QwoLQIWoJMOT6
        0N+E24+lyDtxbyTlELkK+sI8lVLQsFRBpYpvgPZGt8NsYfDwKnTVWT3+LXbpqJQk
        sBGURr/8WdQz0ozJQXWU22CwCEpME3a054hC2/1BBIB1UmCjUzIFY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E380F16C9E5;
        Fri, 26 Nov 2021 02:39:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F21AF16C9E4;
        Fri, 26 Nov 2021 02:39:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] t1404: mark directory/file conflict tests with REFFILES
References: <pull.1148.git.git.1637855828856.gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 23:39:33 -0800
In-Reply-To: <pull.1148.git.git.1637855828856.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 25 Nov 2021 15:57:08
        +0000")
Message-ID: <xmqq35nj8ix6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 005C2146-4E8C-11EC-8000-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -test_expect_success 'D/F conflict prevents add long + delete short' '
> +test_expect_success REFFILES  'D/F conflict prevents add long + delete short' '

Two spaces after REFFILES here but ...

>  	df_test refs/df-al-ds --add-del foo/bar foo
>  '
>  
> -test_expect_success 'D/F conflict prevents add short + delete long' '
> +test_expect_success REFFILES 'D/F conflict prevents add short + delete long' '

... only one space here and then ...

>  	df_test refs/df-as-dl --add-del foo foo/bar
>  '
>  
> -test_expect_success 'D/F conflict prevents delete long + add short' '
> +test_expect_success REFFILES  'D/F conflict prevents delete long + add short' '

... two spaces here?  Let's be consistent.

>  	df_test refs/df-dl-as --del-add foo/bar foo
>  '

As all these df_test instances _expect_ to fail, not causing any
changes in the refs, I think skipping them would hopefully not
reveal unpleasant reliance of side effects by later tests.

And presumably, without REFFILES prerequisite, these operations
would be supported?  E.g. we can have 'main' branch, with 'main/1',
'main/2',... refs, at the same time, with reftable?  That would be
quite interesting.


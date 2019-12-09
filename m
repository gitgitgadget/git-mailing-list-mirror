Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD9C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7776120721
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TFhmpCoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLIVgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:36:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56693 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIVgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 16:36:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99A2BAA293;
        Mon,  9 Dec 2019 16:36:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OqVJky4gqGGp6Q4K0g8jOcdXOwQ=; b=TFhmpC
        oBJa55kr5UjXBx5MsK4DAogzunw6+xXyjZ56cv0PFH+LJnC2JBPGWBTC4z7PFuYd
        0pL8j4158rT7Ove/iskVqp2MrOREL7C3PsI9Ixo+pC4lTR79LyqT1zCAoU9Oq8Qn
        JQtRs1cduJ8zMtxuoozWnqjAiyH8Xe+rC1kSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K4ne6l278zo4iRdZ40R+dT5+QK6FmtzO
        mjLdGp3q5j5kydUBTjnc50N/pLrSyBZeGFlytpDf04Q74R3Z6FEid0AGTXTYqaLO
        GVFWxl5HFkcQr+GjNNM2Ku8S5MSqBv/OfBgtTDIXanG7bpytZ3nrd5siTxn5Xkin
        mA1vNJO7XBY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91F38AA292;
        Mon,  9 Dec 2019 16:36:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A90FCAA291;
        Mon,  9 Dec 2019 16:36:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Subject: Re: [PATCH 0/5] format-patch: improve handling of `format.notes`
References: <cover.1575896661.git.liu.denton@gmail.com>
Date:   Mon, 09 Dec 2019 13:36:34 -0800
In-Reply-To: <cover.1575896661.git.liu.denton@gmail.com> (Denton Liu's message
        of "Mon, 9 Dec 2019 05:10:36 -0800")
Message-ID: <xmqqmuc1tc4d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA3ACDEE-1ACB-11EA-BAF4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> ... This series uses
> the way `--notes=<ref1> --no-notes --notes=<ref2>` is handled as a model
> and structures the handling of `format.notes` in a similar manner,
> allowing one `format.notes = false` to override previous configs.

Makes sense.

> Also, in the same email, it was pointed out that git_config() should be
> called before repo_init_revisions(). In 13cdf78094 (format-patch: teach
> format.notes config option, 2019-05-16), the order was reversed. This
> series changes it back such that git_config() is called before
> repo_init_revisions().
>
> This series is based on top of 'dl/format-patch-notes-config'.
>
> It has minor textual conflicts with 'pu'. The merge resolution can be found at
> https://github.com/Denton-L/git.git on branch
> 'published/published/pu-format-patch-notes-config'.
>
> [1]: https://lore.kernel.org/git/CABPp-BF44+6gvZVNimKf-k7AWbOjw3OK-cJeFunNR96wvZGkcw@mail.gmail.com/
>
> Denton Liu (5):
>   notes: rename to load_display_notes()
>   notes: create init_display_notes() helper
>   notes: extract logic into set_display_notes()
>   format-patch: use --notes behavior for format.notes
>   format-patch: move git_config() before repo_init_revisions()
>
>  builtin/log.c           | 26 +++++++++-----------------
>  notes.c                 | 30 ++++++++++++++++++++++++++++++
>  notes.h                 | 21 ++++++++++++++++++---
>  revision.c              | 22 +++++-----------------
>  t/t4014-format-patch.sh | 32 ++++++++++++++++++++++++++++++++
>  5 files changed, 94 insertions(+), 37 deletions(-)

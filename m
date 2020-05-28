Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8845C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6202074B
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FhjDUc3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407363AbgE1Uwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 16:52:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58053 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407319AbgE1Uwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 16:52:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0305D485D;
        Thu, 28 May 2020 16:52:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ndCv+Df7xUtNcsvP+DwNXJcOce8=; b=FhjDUc
        3PMngL7zNYB4lM8J7m5/KVp/jXPrqYglTnnmoaLkUyqu624e2FvQI7FG4YcWisi4
        R9wLXaN3LncmVkIAVqZZkKZTuKOHMWqD2xg0El0/8aARmYofe0XDz1Z9bdeuzjj5
        nGQSDH+ZQkyNvxJyeGK9jGPQcNHjbPrmIXWA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=inIYd5jr5mCMeu83pGplgCPvJWmSSsuX
        JC+Ur0X6NLJ9fI5SkS7JJhrpPLX0R/27wRXnZJD+r2rsxg4Urt8u2Ko4deOV3n4D
        s7CJ+h2ALyqQbvWss+CdIQAARtFWEDxh+OisMk6qOI0Luhk8GzV5Xc0Giq8RtpSW
        QczkkP6aENc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8332D485B;
        Thu, 28 May 2020 16:52:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9FCF8D4853;
        Thu, 28 May 2020 16:52:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v15 03/13] Treat BISECT_HEAD as a pseudo ref
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <60a82678a1b0b221b6d43434f70f9475a929d2a6.1590695210.git.gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 13:52:26 -0700
In-Reply-To: <60a82678a1b0b221b6d43434f70f9475a929d2a6.1590695210.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 28 May 2020
        19:46:39 +0000")
Message-ID: <xmqqd06n3hpx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2483A104-A125-11EA-9B3B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Both the git-bisect.sh as bisect--helper inspected the file system directly.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  builtin/bisect--helper.c | 3 +--
>  git-bisect.sh            | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Makes sense.  

A topic that adds more callers to the git_path_bisect_head()
function has already been in flight for quite a while; I wonder if
we can meet the topic in the middle.  For example, would it have
helped if we had a helper like this one:

        static inline int bisect_head_exists(void) {
               return ref_exists("BISECT_HEAD");
        }

on this side, and have the other side have something like:

        static inline int bisect_head_exists(void) {
               return file_exists(git_path_bisect_head());
        }

Then the caller(s) of bisect_head_exists() don't have to be changed
at all.

Anyway, it's just a lesson that communication and collaboration
between developers may help coming up with correct integration
results.

Thanks.  Queued.

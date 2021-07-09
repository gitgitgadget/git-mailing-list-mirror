Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8EBC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8C461380
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhGIQGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 12:06:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64064 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhGIQGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 12:06:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B26A2D296F;
        Fri,  9 Jul 2021 12:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fqc0pLPpYmoakvD57uzpZYkh0i+6f/GOokJD9O
        3PKEo=; b=bd5RQ30UTUIbCCIXR5DevnVmav+S6MretI+X6/SXLWCTjdVT1SaihO
        Fm9WucL1jAdjF9ZfQzUfh4E5C1w1qoJcZhhJxgac16l50LlKZu0UJmVYnEZjXFqG
        RUZZ3xUxPMOseCA4Y6qPOtT6Zrj32zf8/VP0xCjbqDpmTCNIcW1iU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9CB3D296E;
        Fri,  9 Jul 2021 12:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 290E7D296D;
        Fri,  9 Jul 2021 12:03:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stephen Manz <smanz@alum.mit.edu>
Subject: Re: [PATCH v2 0/3] worktree: teach add to accept --reason with --lock
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
        <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
        <YOf+tANuox4LRD7d@flurp.local>
Date:   Fri, 09 Jul 2021 09:03:38 -0700
In-Reply-To: <YOf+tANuox4LRD7d@flurp.local> (Eric Sunshine's message of "Fri,
        9 Jul 2021 03:45:56 -0400")
Message-ID: <xmqqv95j79ut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39766DA4-E0CF-11EB-B859-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The reason I suggested re-purposing `add_opts.keep_locked` is to avoid
> polluting that structure with members having overlapping meaning, thus
> reducing the confusion-factor for clients of that structure (assuming
> that a tri-state `keep_locked` is indeed less confusing). That doesn't
> preclude adding a new variable or two local to the `add()` function to
> facilitate keeping `add_opts` pure. For instance, it might be as
> simple as the below patch.

True.  It is less trivial to construct the command line option
parser so that --reason=<why> and --lock can be given in any order
(e.g. they no longer can be a simple OPT_BOOL and OPT_STRING that
can be given independently but needs some postprocessing like your
patch did), but it is not rocket science and keeping add_opts struct
leaner will reduce the risk of runtime confusion, I would think, but
at the same time, the room for runtime confusion would probably be
minor to begin with---so I am fine, if the coder cannot cleanly
write the option parser to do so, with the code as posted.

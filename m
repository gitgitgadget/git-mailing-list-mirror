Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676EBC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C35C20720
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B/FW+YFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgEKOts (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 10:49:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63231 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbgEKOtr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 10:49:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 102514D33F;
        Mon, 11 May 2020 10:49:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JIEVL3B0CTiLu5GaZ+xcHbQYPgk=; b=B/FW+Y
        FaFKJep26ZOw1CIvOGLOwaUmxag5OqQbGfODOh6BsOBWSCuRJ30yNLkcoRSScrRp
        bxufzc5g/TU3dKK1CJ/qpsa1af0WxQfAN5e8il0WOOLuOLUFxVhKjt9ZhNFrT3o/
        6O4J7Q9bf1r/slJUD7zUGSK64Sh5YuahyFAM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dsul+PLOitysDMElQL2dTYLGhUzfHzgS
        KmI6rdk7Ukr5eU5Dj6aeX9BpGzyYvZpLeYaUdfFO87obuWzvUV02DWWlqtWTB4IJ
        geHyiBao38fuYPXJa0Q8fNC3qsgNYWGPc3Cg+Qwjyvt5avFLssjYlm/YPBtZvE4B
        9KFJOINYfSI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 073084D33E;
        Mon, 11 May 2020 10:49:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FB764D33C;
        Mon, 11 May 2020 10:49:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v12 03/12] refs: document how ref_iterator_advance_fn should handle symrefs
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <6553285043b2f004cca646aefd59c509324d4da3.1588845586.git.gitgitgadget@gmail.com>
        <xmqqd07exnhs.fsf@gitster.c.googlers.com>
        <CAFQ2z_NQuSpCwqZM25KZL7AshZZD01Cn9tfWgEjT6A2N3bk3yA@mail.gmail.com>
Date:   Mon, 11 May 2020 07:49:42 -0700
In-Reply-To: <CAFQ2z_NQuSpCwqZM25KZL7AshZZD01Cn9tfWgEjT6A2N3bk3yA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 11 May 2020 13:42:46 +0200")
Message-ID: <xmqqwo5isf09.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A66D2E66-9396-11EA-BA06-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, May 8, 2020 at 8:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Makes sense.
>>
>> I wonder if I should take 1-3/12 as a separate "clean-up" series and
>> merge it before everything else down to 'master'?  That would reduce
>> the churn somewhat.
>
> That would be great. Do I need to send them separately, or do can you
> cherry-pick the changes out of this series?

For the past several days, my tree had two topics, hn/refs-cleanup
(4 patches---1, 2, 3 and 11 from this series) and hn/reftable (the
rest) queued separately.  If everybody (including you) is happy with
the former, we can just treat it as a separate "preliminary
clean-up" topic and merge it down thru 'next' to 'master' and
hopefully we can do so before the end of this cycle, as I do not
immediately see anything controversial in them.  The other topic
builds on top of it, and it may have to get into a reviewable state,
but at least the early "good bits" split out into a separate topic
shouldn't have to wait.  Then we only need to iterate on the latter
part.

I am wondering if we can also throw the file format documentation
into the "more or less uncontroversial" pile.  There may be a lot to
dislike in the current "implementation" in reftable/*.c, especially
when viewed in the context of this project, that makes it less
appealing to review, but my understanding is that the feature as
designed by Shawn and described in the format document is already in
use in JGit, so even if the code may need a major update only to
become viewable from some reviewers' point of view, the design it
aims to implement, at least a major part of it, is more or less cast
in stone.  Unless we collectively decide that we will never support
reftable in git-core, we need to adopt the format documentation and
the way the subsystem is supposed to work as-is to be compatible,
which makes it "more or less uncontroversial".  It may need some
copyediting, though.  Also it is not clear to me if the base part
(without "hash id" and incremented format version) is the only thing
in such a "the other system already implements it, so compatibility
concerns leave little room to change the design at this point"
state, or the updated variant that allows us to support SHA-256 and
other hashes is also in that state.


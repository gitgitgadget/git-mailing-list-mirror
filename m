Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E6DC43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F320775
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHyhDcWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCXSah (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:30:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54212 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgCXSah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 14:30:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2886DCBBAF;
        Tue, 24 Mar 2020 14:30:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pGi7qOuNiCycfzttk0eeYp3OIwE=; b=jHyhDc
        WsOgwEYHBr9cgqureGe+LB5YeXsZw1x8XaQc6wHW1o3zNXm5g3pDx/ZuAqY/Wft3
        EeErJNnqxsYevLyaNU4ThE4oD2MFsZjtYUK8Z+Mf3xK4Y3rvIma6XFqO3g/712TJ
        n2bseAyUpWWqA5eygVmGIuoSwpriiwXO0V+Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T/X5Mr1NNPb4cE+FRcqiuUNY0U5j/Qy9
        BRKjAKeg20E9u751msESmETPYIebaJk4CBuNvUrNNmP9bSElii+HLPDNhsIYdxHQ
        o94K+JEXlVbX2dCISoy+gtffs1OGAKKJ3QuMXqi1EKtvmA9vIZhV0ya7EQzKliDJ
        +ciXZCAYJGc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 202CECBBAD;
        Tue, 24 Mar 2020 14:30:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33494CBBAA;
        Tue, 24 Mar 2020 14:30:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
References: <cover.1585027716.git.matheus.bernardino@usp.br>
        <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
        <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
Date:   Tue, 24 Mar 2020 11:30:27 -0700
In-Reply-To: <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 24 Mar 2020 00:54:54 -0700")
Message-ID: <xmqq7dz938sc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89ADFC7E-6DFD-11EA-988D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Mar 23, 2020 at 11:13 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>>
>> In the last commit, git-grep learned to honor sparsity patterns. For
>> some use cases, however, it may be desirable to search outside the
>> sparse checkout. So add the '--ignore-sparsity' option, which restores
>> the old behavior. Also add the grep.ignoreSparsity configuration, to
>> allow setting this behavior by default.
>
> Should `--ignore-sparsity` be a global git option rather than a
> grep-specific one?  Also, should grep.ignoreSparsity rather be
> core.ignoreSparsity or core.searchOutsideSparsePaths or something?

Great question.  I think "git diff" with various options would also
want to optionally be able to be confined within the sparse cone, or
checking the entire world by lazily fetching outside the sparsity.

> * grep, diff, log, shortlog, blame, bisect (and maybe others) all by
> default make use of the sparsity patterns to limit their output (but
> can all use whatever flag(s) are added here to search outside the
> sparsity pattern cones).  This helps users feel they are in a smaller
> repo and searching just their area of interest, and it avoids partial
> clones downloading blobs unnecessarily.  Nice for the user, and nice
> for the system.

I am not sure which one should be the default.  From historical
point of view that sparse stuff was done as an optimization to omit
initial work and lazily give the whole world, I may have slight
preference to the "we pretend that you have everything, just some
parts may be slower to come to you" world view to be the default,
with an option to limit the view to whatever sparsity you initially
set up.  Regardless of the choice of the default, it would be a good
idea to make the subcommands consistently offer the same default and
allow the non-default views with the same UI.



Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B62BC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C7320748
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wIheiPkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0PvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:51:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59764 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0PvV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 11:51:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C72260230;
        Fri, 27 Mar 2020 11:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r+GIBbLBcxIMtLKuvqIISTyHSN8=; b=wIheiP
        kI+fJbkl2dHQy3vhsFJ+0jgZD5UlX/J7SH+iGgJw9A/4mqLjP96Ba3WePiN5mJEj
        tDmbmQffk9jE56hk3GY3x8xqD7ScTOilk8MQzWiZZORUieFbmnsbuuK3N9q5gVup
        RxXJWYaz5JPE0l5GSDhLGQaOJlcg0aZY58TOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OA7JzTMiu7IqU5Y8MNRkT+k4F2xfpzzp
        3UJ5jXYzSLBx0mP6MEhSHq319vFwV2V0Ce60HDMUT9HmZIzZyLkfDe2/RD05Gby+
        /eakIZs6H2TJHL8Jr8PF+eUts7obMPcttX5HFEH/ZIGlDy7cq5GoDUWrIQbfgA/B
        hEs0/aMcqKc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7487E6022F;
        Fri, 27 Mar 2020 11:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 027706022E;
        Fri, 27 Mar 2020 11:51:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
References: <cover.1585027716.git.matheus.bernardino@usp.br>
        <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
        <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
        <CAHd-oW6ANf_iNmYkgXt4jo1seB-AEx1TSH384v+oh1bicG8RDA@mail.gmail.com>
        <CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com>
Date:   Fri, 27 Mar 2020 08:51:19 -0700
In-Reply-To: <CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 25 Mar 2020 23:02:20 -0700")
Message-ID: <xmqq369tiyo8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD277E52-7042-11EA-9EBD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Sometimes, code that wasn't meant to be used together accidentally is
> used together or the docs suggest they can be used together.  ...
> ... but that's the
> type of accident that is easy to have in the implementation or docs
> because it doesn't even occur to people who understand the design and
> the data structures why anyone would attempt that.

The above is not limited to "git grep", but you said so clearly what
I have felt, without being able to express myself in a satisfactory
manner, for the last 10 years.

> ... (Side note: I think this kind of
> issues occurs fairly frequently, so I'm unlikely to assume options
> were meant to be supported together based solely on a lack of logic
> that would throw an error when both are specified.

Amen to that.

By the way, and I am so sorry to making the main issue of the
discussion into a mere "by the way" point, but if I understand your
message correctly, the primary conclusion in there is that a file
that is not in the working tree, if the sparsity pattern tells us
that it should not be checked out to the working tree, should not be
sought in the index instead.  I think I agree with that conclusion.

I however have some disagreement on a minor point, though.

"git grep -e '<pattern>' master" looks for the pattern in the commit
at the tip of the master branch.  "git grep -e '<pattern>' master
pu" does so in these two commits.  I do not think it is conceptually
wrong to allow "git grep -e '<pattern>' --cached master pu" to look
for three "commits", i.e. those two commits that already exist, plus
the one you would be creating if you were to "git commit" right now.
Similarly, I do not see a reason why we should forbid looking for
the same pattern in the tracked files in the working tree at the
same time we check tree object(s) and/or the index.

At least in principle.

There are two practical issues that makes these combinations
problematic, but I do not think they are insurmountable.

 - Once you give an object on the command line, there is no syntax
   to let you say "oh, by the way, I want the working tree as well".
   If you are looking in the index, the working tree, and optionally
   in some objects, "--index" instead of "--cached" would be the
   standard way to tell the command "I want to affect both the index
   and the working tree", but there is no way to say "I want only
   tracked files in the working tree and these objects searched".
   We'd need a new syntax to express it if we wanted to allow the
   combination.

 - The lines found in the working tree and in the index are prefixed
   by the filename, while they are prefixed by the tree's name and a
   colon.  When output for the working tree and the index are
   combined, we cannot tell where each hit came from.  We need to
   change the output to allow us to tell them apart, by
   e.g. prefixing "<worktree>:" and "<index>:" in a way similar to
   we use "<revision>:".

Thanks.

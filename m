Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CDC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5A560249
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJ1T52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:57:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60973 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJ1T52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:57:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA910154F90;
        Thu, 28 Oct 2021 15:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MBwi4DDUN5ZMwXbDtbCWIVAhevchRt1oAGpcQU
        iFmeE=; b=PgxX/JM2lduscElLqomzKoZlKmHDyBxvpsSvbtEBpY69+YV1qLjrRq
        lyQAxQ29lbXRS/xrCkM02ZhIQNEgn2rPN9fhrCMUCF+VIXKdOctw4d77lUpndmXx
        gICA+sHqHrPdFZYyhxvXFC00c0v2EQS1W0CHYlGnCWX2pHJ1PgN0s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9798154F8A;
        Thu, 28 Oct 2021 15:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20C89154F89;
        Thu, 28 Oct 2021 15:54:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicholas Bransby-Williams <nbransby@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: conflict markers in markdown files
References: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
Date:   Thu, 28 Oct 2021 12:54:57 -0700
In-Reply-To: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
        (Nicholas Bransby-Williams's message of "Thu, 28 Oct 2021 15:00:08
        +0100")
Message-ID: <xmqq5ytgrkku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDD23E80-3828-11EC-98A5-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicholas Bransby-Williams <nbransby@gmail.com> writes:

> Would it make sense to add an option to merge-file so merge tools can
> specify a custom marker that is statistically much less likely to
> clash with the kinds of text files that are typically stored in git
> repositories?

Is the conflict-marker-size attribute sufficient?  If not, why?

In our documentation, we do need to have literal runs of '<<<',
'===', etc. to illustrate and describe the conflict markers, so we
have these in .gitattributes at the top-level:

    /Documentation/git-merge.txt conflict-marker-size=32
    /Documentation/gitk.txt conflict-marker-size=32
    /Documentation/user-manual.txt conflict-marker-size=32

so that the auto-inserted conflict markers will be very long,
instead of just the default (was it 7?  I do not remember offhand
because I do not have to).  Most importantly, these "32" are written
by folks who wrote these documentation pages and *knew* that there
is no runs of '<', '=', '|' or '>' that are 32 letters long, so it
is safe and can be updated to stay safe when the documentation files
change.

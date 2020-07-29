Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F17C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCB12074B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KvjnXmDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgG2U5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:57:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55639 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2U5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:57:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C207E55CC;
        Wed, 29 Jul 2020 16:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zSKKsx2FDeBwZIwp4S5jUy/1sOs=; b=KvjnXm
        DrXyfLQxShv8+tamE2QrN7lVM/IC603aD8ZHtFJc80e7ro/6cAG6KyI6piAHL4vF
        znfZ7kBx56O4couiRJmhuc/43AsMm9WmzHQp0ZYK6Ofd4nHQQ/LgxUPzU+2JFpwn
        gXryeYciRkj7vYmBloA0ffPac00ggY0/naGuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MqoKCppQRUuzd+AEUgnNvQNwInl5pLr1
        pvCVMC11qO4gZy0atAia87hF7frK2SGhAoT5R8LkpKzajb+c70B7t0zcoAVbRtAH
        kPwkxdoJ/5NtiBMFScsSGG3gBEaghQESjwO4AAiPqhyYpQsW0cZCq8ccGEQODtlq
        R1XgmR7NcWY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25623E55CB;
        Wed, 29 Jul 2020 16:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C67FE55C9;
        Wed, 29 Jul 2020 16:57:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 4/7] doc/git-log: move "Diff Formatting" from rev-list-options
References: <20200729201002.GA2989059@coredump.intra.peff.net>
        <20200729201116.GD2989342@coredump.intra.peff.net>
Date:   Wed, 29 Jul 2020 13:56:59 -0700
In-Reply-To: <20200729201116.GD2989342@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Jul 2020 16:11:16 -0400")
Message-ID: <xmqq5za69h0k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CB86160-D1DE-11EA-8FBF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Our rev-list-options.txt include has a "Diff Formatting" section, but it
> is ifndef'd out for all manpages except git-log. And a few bits of the
> text are rather out of date.
>
> We say "some of these options are specific to git-rev-list". That's
> obviously silly since we (even before this patch) show the content only
> for git-log. But moreover, it's not true; each of the listed options is
> meaningful for other diff commands.
>
> We also say "...however other diff options may be given. See git-diff-files
> for more options." But there's no need to do so; git-log already has a
> "Common Diff Options" section which includes diff-options.txt.
>
> So let's move these options over to git-log and put them with the other
> diff options, giving a single "diff" section for the git-log
> documentation. We'll call it "Diff Formatting" but use the all-caps
> top-level header to match its sibling sections. And we'll rewrite the
> section intro to remove the useless bits and give a more generic
> overview of the section which can be later extended.

Makes sense.  I first was afraid of regressing "git show"
documentation because the conditional inclusion was

    > -
    > -ifndef::git-shortlog[]
    > -ifndef::git-rev-list[]
    > -Diff Formatting
    > -~~~~~~~~~~~~~~~
    > -

but it seems that Documentation/git-show.txt does not even include
this section being moved in the first place.

We might move these to a new file and include it from both git-log.txt
and git-show.txt but that can be left outside the topioc.

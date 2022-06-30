Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17BCC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiF3VSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiF3VSx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:18:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47245784
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:18:52 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4A39135B12;
        Thu, 30 Jun 2022 17:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WtJGQ19i0HQKSsztncvyzXqtGQu1kzzls9nzqc
        2ylEk=; b=dzsp9JThS4IXxa7oiiC2hCnbk4CZvsrpVY45LKGY6fyzcIZkHgXPf0
        mUY0M5tJ2NZvPUeH1ZuWDaYfjah5aGL+asJkdRZ13G/2rE7MUVRnvCQN/oZr/E6k
        qBS5+CbSWpidxOIggsNnkejbmE3E98GjIxHRbPzDuCgoiKDn8ioYw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9B22135B11;
        Thu, 30 Jun 2022 17:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2ECC6135B0F;
        Thu, 30 Jun 2022 17:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for mailmap in cat-file
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
Date:   Thu, 30 Jun 2022 14:18:47 -0700
In-Reply-To: <20220630142444.651948-1-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Thu, 30 Jun 2022 19:54:41 +0530")
Message-ID: <xmqqpmipdf48.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C5EBBEE-F8BA-11EC-8F4B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> So, this patch series adds mailmap support to the git cat-file command.
> It does that by adding --[no-]use-mailmap command line option to the
> git cat-file command. It also adds --[no-]mailmap option as an alias to
> --[no-]use-mailmap.

So does this kick in only with "git cat-file commit <object>" and
never with "git cat-file $type" for non-commit object types?  For a
payload like CREDITS file, people may want the blob contents
filtered by applying the mailmap, so limiting it to only commits may
or may not be the best idea.

How does/should this interact with "git cat-file -p"?

Does it also work with the batch mode?

For a single-request-single-answer invocation like "git cat-file
commit <object>", I think a "--[no-]use-mailmap" option is OK, but
for something like the batch mode, we may want a way to obtain both
the original and mapped name(s).  E.g. with this option in effect,
in addition to the "author" and "committer" headers of the commit,
the output may get a "mailmap-author" and "mailmap-committer" fake
headers that show the mapped idents.

Soliciting too many questions mean the cover letter is doing a good
job to pique interest from readers, and is not doing a good job to
explain adequately what it really does ;-)

Let's read on.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97C4C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 19:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiGKTbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 15:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKTbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 15:31:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99DF77A6E
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 12:31:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3F7D12B1D5;
        Mon, 11 Jul 2022 15:31:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SKoYh33FBeo1F201dizFf8V3/khb/cHFkjsL3x
        e+d1E=; b=jyyEDn46dS0d4TiX7YWssNPq1N304R3uf3opw592cQiLLdgMQwtKAV
        vVJkePOXsm8i5n2fGojYSy8GBru+dlPiFnATp9VWplkO7AJDPB46hS9iOU1NtHZb
        gJftwS5EJkESRdeOCjlDiOmUqSiFpMLc3eZq+KBL0GVkcjnQcemdU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C18912B1D4;
        Mon, 11 Jul 2022 15:31:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6550112B1D3;
        Mon, 11 Jul 2022 15:31:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     me@alirezaarabi.com
Cc:     git@vger.kernel.org
Subject: Re: Suggestion for 'git add' CLI
References: <84b593cf1bacc4541a7a4ca24a5e98fa@alirezaarabi.com>
Date:   Mon, 11 Jul 2022 12:31:05 -0700
In-Reply-To: <84b593cf1bacc4541a7a4ca24a5e98fa@alirezaarabi.com>
        (me@alirezaarabi.com's message of "Mon, 11 Jul 2022 11:28:21 +0430")
Message-ID: <xmqqsfn7o39i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03657B4A-0150-11ED-B6DE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

me@alirezaarabi.com writes:

> hi there, I have a suggestion about git CLI.when I use 'git add -A' or
> 'git add --all' it stages all of my files but when I use git add 
> <file_name> it adds the file name to the stage, not all files. but
> when I use ' git add <file_name> --all ' it also works and adds all
> the files to the stage. I think it's better to provide a warning for
> this situation. thank you.

If "git add -A Documentation/" silently ignores the pathspec and
does not limit the application of "-A" to the Documentation
directory, then I think that is a bug worth fixing.

    $ git init trash && cd trash
    $ mkdir t s
    $ >t/1 && >s/2
    $ git add -A t
    $ git ls-files
    t/1

It does seem to honor the pathspec "t" and refrains from adding s/2
to the index, so I do not think there is anything to fix here,
though.

By the way, on the command line of "git", dashed command options
come before the non-dashed command line arguments, so make it a
habit to spell "git --add <file_name>".



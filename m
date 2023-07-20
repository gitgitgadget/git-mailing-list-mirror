Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A2EB64DD
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 22:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGTWwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTWwW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 18:52:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07953171A
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 15:52:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A8081908DC;
        Thu, 20 Jul 2023 18:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Olhqt120lUtjYmmI6n4tR9HGHMMtu89NGMWMnK
        xzlt0=; b=TlHEcLc2v89K+rzjiHILyqPfG3q0He12S12vQsI4xIBmJtLA0EAp4j
        DaopJ19vcCw6aEnZ9AO7sZ9BANUcZEoYxTkd94W07NFPd4yDshshdLlSbNpmBRra
        qprygrQ9dCrlURPuw2orRwFx5u9TkWlYdgWCH4cAoa29E36vYQjBA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02F711908DB;
        Thu, 20 Jul 2023 18:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D31091908DA;
        Thu, 20 Jul 2023 18:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 0/2] Add new "describe" atom
References: <20230714194249.66862-1-five231003@gmail.com>
        <20230719162424.70781-1-five231003@gmail.com>
Date:   Thu, 20 Jul 2023 15:52:12 -0700
In-Reply-To: <20230719162424.70781-1-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Wed, 19 Jul 2023 21:45:04 +0530")
Message-ID: <xmqqr0p219ib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12A89F8E-2750-11EE-9884-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> PATCH 1/2 - Left unchanged expect for small changes in the commit
> 	    message for more clarity.
>
> PATCH 2/2 - We now parse the arguments in a seperate function
> 	    `describe_atom_option_parser()` call this in
> 	    `describe_atom_parser()` instead to populate
> 	    `atom->u.describe_args`. This splitting of the function
> 	    helps err at the right places.

This topic may be getting rerolled but from the CI logs,
comparing 

 * https://github.com/git/git/actions/runs/5603242871 (seen at
   77ba682) that passes the tests

 * https://github.com/git/git/actions/runs/5605480104 (seen at
   29f0316) that breaks linux-gcc (ubuntu-20.04) at t6300 [*]

output from "git shortlog --no-merges 77ba682..29f0316" [*] makes us
suspect that this topic may be the culprit of the recent breakage.

The linux-gcc job is where we force the initial branch name to be
'main' and not 'master', so if your tests assume that the initial &
primary branch name is 'master', that may be something you need to
fix.

Thanks.

[Reference]
 * https://github.com/git/git/actions/runs/5605480104/job/15186229680

 * git shortlog --no-merges 77ba682..29f0316
Alex Henrie (1):
      sequencer: finish parsing the todo list despite an invalid first line

Beat Bolli (1):
      trace2: fix a comment

Junio C Hamano (4):
      short help: allow multi-line opthelp
      remote: simplify "remote add --tags" help text
      short help: allow a gap smaller than USAGE_GAP
      ###

Kousik Sanagavarapu (2):
      ref-filter: add multiple-option parsing functions
      ref-filter: add new "describe" atom



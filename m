Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEEEEE8018
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 15:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbjIHPmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjIHPmO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 11:42:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B21FC6
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 08:42:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8298D38BE4;
        Fri,  8 Sep 2023 11:42:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Qx5K8sFuCu44Zdvni6ADfdH7LGSv7MZl4bd1lN
        tE2ag=; b=QLZEU00meqNK2sS2hFlZf/LndLO8wtNRD6Zo15wm3anbjyfdKPMwDL
        F3/PQqx54Zq5gaz1h/DUJGEWrdo7Vgqp8xR95Yjh8nWnf+GF4iBAg0g4YGSZv8lr
        PKDlmIUqI2VPzIngFT1xeJZz9hw/aiFXymdWR3+Bib9nDFeoTpax4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B2C538BE3;
        Fri,  8 Sep 2023 11:42:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B69138BE0;
        Fri,  8 Sep 2023 11:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] start_command: reset disposition of all signals in child
In-Reply-To: <pull.1582.git.1694167540231.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Fri, 08 Sep 2023 10:05:40 +0000")
References: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
Date:   Fri, 08 Sep 2023 08:42:06 -0700
Message-ID: <xmqqedj8vfht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44206BFC-4E5E-11EE-BD51-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> [3] This is really a work-around for not moving the child into its own
>     process group and changing the foreground process group of the
>     controlling terminal.

I am puzzled, as I somehow thought that "does the user conceive a
subprocess as external and different-from-git entity, or is it
merely an implementation detail?  many use of subprocesses in our
codebase, it is the latter." from Peff was a good argument against
such isolation between spawning "git" and spawned subprocesses.

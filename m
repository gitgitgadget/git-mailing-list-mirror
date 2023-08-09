Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6D9C001DE
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 21:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjHIVob (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHIVoa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 17:44:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1DD1702
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 14:44:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B705A237D6;
        Wed,  9 Aug 2023 17:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sJ7kF7ODc6tVEE21bdtRQEvvWlUB7DftAOsWpu
        iP3tM=; b=nSdV+TbXwgywB4O9g+eVlM27YuZojYG8PiHiQMkjseAHBpjrbzYCNH
        ImbsCdOYpwks+bFtAr6m2KOanKueB4UODQYwWeVtjksyX5apidBkNgi+GzNdwyav
        V4VWfWs/urrTjg3ahUh0XKrmxEZNe5vilZVB2G2/B5eBucUZkCNlU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1095237D5;
        Wed,  9 Aug 2023 17:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4A81A237D4;
        Wed,  9 Aug 2023 17:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] sequencer: rectify empty hint in call of
 require_clean_work_tree()
References: <xmqqa5v2ehba.fsf@gitster.g>
        <20230809171531.2564829-1-oswald.buddenhagen@gmx.de>
Date:   Wed, 09 Aug 2023 14:44:25 -0700
In-Reply-To: <20230809171531.2564829-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Wed, 9 Aug 2023 19:15:31 +0200")
Message-ID: <xmqq7cq3lwli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E943988E-36FD-11EE-8001-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> The canonical way to represent "no error hint" is making it NULL, which
> shortcuts the error() call altogether. This fixes the output by removing
> the line which said just "error:", which would appear when starting a
> rebase whose initial checkout worked fine despite a dirty worktree. This

Thanks for adding this info.  

"git rebase" does not seem to start (i.e. does not perform "initial
checkout") from a dirty working tree, with

	error: cannot rebase: You have unstaged changes.
	error: Please commit or stash them.

at least from my quick attempt.  I am not sure if this is actually
triggerble?

In any case, I've replaced v2 that I had with this version, as the
description is much better.  The change to the code does look
correct but now it does not seem to trigger, it is unclear to me if
the fix is merely theoretical (a command-by-command transcript would
have helped here).

Thanks.


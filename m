Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE12C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 23:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiDMXix (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 19:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiDMXiw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 19:38:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94F377FB
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 16:36:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66852128A82;
        Wed, 13 Apr 2022 19:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9p//w4slw8iuUqya7RjqY4ai1YiLeOMQ1RV79mrAapk=; b=lQdP
        CrTtq9AEdLI7/tzraSZ5LoOqve4hrM91KUY/AuFfDazwNbIUbWJ7uyC8D5PLaQcS
        ChOjOfZez3IzDL1ID48QBoywlnOdNup5ycRBm+SYLVu2f4SE9evNze3v1O1nIsa8
        hm22i6zdeiJgHYWS2U681Lb6dPO+1FUvmJgtQ6I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DCBC128A81;
        Wed, 13 Apr 2022 19:36:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC4EE128A80;
        Wed, 13 Apr 2022 19:36:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 13 Apr 2022 16:36:26 -0700
Message-ID: <xmqqwnfs4kud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A0D2F8A-BB82-11EC-8ADD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Martin observed that, viability aside, there's another approach that I
> haven't discussed:
>
>   == 5 Disable bare repo discovery
>
>   We could introduce a config value that disables bare repo discovery
>   altogether. This would only disable _discovery_; a user can still use
>   the bare repo by specifying the gitdir (e.g. via `--git-dir=.` or
>   GIT_DIR).

Does it or does it not count as "allowing discovery to do its job"
if you go to the directory, knowing that the directory is a bare
one, and expect Git to work in it?

I am guessing that your definition of "discovery" is not even
consider if the current directory is a repository and always force
the user to tell us with --git-dir or GIT_DIR.  I am not sure that
is realistically feasible (I am thinking of cases like "git fetch"
going to the remote repository on the local disk that is bare to run
"git upload-pack"), but if the fallout is not too bad, it may be a
good heuristics.


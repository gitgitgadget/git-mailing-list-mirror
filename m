Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B20C433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 21:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiFAVV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiFAVV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 17:21:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF07AE454
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 14:21:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CED1187C86;
        Wed,  1 Jun 2022 17:21:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DQG0h7ZvqWrCZVj95qYEo3xnwUOvnuewDBHRaF
        tSIno=; b=mfsPuKWcC28Y85V0HEVfoT2Bsg+WmXzH8KXFdd9x8q+kyAKJGzSoB7
        NUBzFOhHZvpo8/VUv3YYPU8YlwgGwDj00KMvpUwwI5yp/+Fpcjr4R0BmDFMR4EYd
        +K9ndyYjPbW4hM8ipjUs27s680d/lcYcRe+KB+bpnNxo8EhIE5IIg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35348187C85;
        Wed,  1 Jun 2022 17:21:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9ED1E187C84;
        Wed,  1 Jun 2022 17:21:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>
Subject: Re: [PATCH 2/2] remote.c: reject 0-length branch names
References: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
        <f947cf221c0b5320d0b7438b88a0d94a5bd3a70b.1654038754.git.gitgitgadget@gmail.com>
        <220601.86leug261j.gmgdl@evledraar.gmail.com>
        <kl6lilpke31e.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 01 Jun 2022 14:21:21 -0700
In-Reply-To: <kl6lilpke31e.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 01 Jun 2022 09:55:57 -0700")
Message-ID: <xmqqzgiwozam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C942D2E2-E1F0-11EC-A4E9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> It truly makes no sense because `branch..remote` fits the schema of
> `branch.<name>.remote` where <name> is "", but "" isn't a valid branch
> name (and it never has been AFAIK). So such a key would never be useful
> to Git, and it would be extremely hacky for a non-Git tool to use such
> a key.

Yup, we might want to reserve a bogus key or two that can never be a
branch name to allow us express "this configuration is in effect for
all branches" (e.g. "branch.*.rebase = never"), but the natural such
name would be "*" and does not have to be an empty string.


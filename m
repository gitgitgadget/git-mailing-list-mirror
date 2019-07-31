Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC0B1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfGaVhF (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 17:37:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61200 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbfGaVhF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 17:37:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6233C15B859;
        Wed, 31 Jul 2019 17:37:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=riznuzal+7kULlZGLQv3CGHPNhU=; b=INk/dm
        iPWOyZUHVvpoJ6QRB8qQ7SLp2BEqtmgOdACAjBAUM5cFfpuU53JxDXjgRvEhZzjE
        Gx+Hpyq6VIc2Nh97v1PHGgWIkioyUJtscyoFAJKgdrayH8tSTHTPGni7NwF2f2/c
        ANXnQ/rRlsiCSk4DwcuNbmZ6WMKxbGabbC9NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SRsD2eRnOPLXNFajNyTbs300AjNqAZZk
        qudBfAoaJiA7UUgYn4ErOIG1Um/QGDnrkW4vSKXxWyLe6GhpcIdS/CfaFQuvnz2u
        ON49Gwe5Td5dqWGdNvgbL0R6pLzL9wtiRFuKfI4KkLEg6yqtFhxdHIDwwXljkaRS
        lVUMiWowu/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5925815B857;
        Wed, 31 Jul 2019 17:37:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B959415B856;
        Wed, 31 Jul 2019 17:37:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Schindelin <johasc@microsoft.com>
Subject: Re: [PATCH 1/1] config: work around bug with includeif:onbranch and early config
References: <pull.300.git.gitgitgadget@gmail.com>
        <4aa88340132b03c9480c781cb5cb3c5b5513e944.1564602830.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Jul 2019 14:37:01 -0700
In-Reply-To: <4aa88340132b03c9480c781cb5cb3c5b5513e944.1564602830.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 31 Jul 2019
        12:53:51 -0700 (PDT)")
Message-ID: <xmqq7e7xq41u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55A792C8-B3DB-11E9-A7DC-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Let's work around this, simply by ignoring the `includeif.onbranch:`
> setting when parsing the config when the ref store has not been
> initialized (yet).

Interesting chicken-and-egg problem.

> Technically, there is a way to solve this properly: teach the refs
> machinery to initialize the ref_store from a given gitdir/commondir pair
> (which we _do_ have in the early config code path), and then use that in
> `include_by_branch()`. This, however, is a pretty involved project, and
> we're already in the feature freeze for Git v2.23.0.

Postponing the proper fix to the next cycle (or later) is good.

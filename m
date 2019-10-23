Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A04A61F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 03:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfJWDwS (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 23:52:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60039 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbfJWDwS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 23:52:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F348F806FB;
        Tue, 22 Oct 2019 23:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V2GAVKDEapW/jo8ygP4RBu3h4g8=; b=SnuTNE
        s7maDpO/X67XllJxWLQN34o4E/UeILy60kweoeluncSAhFRlWyqkifeIA9BMYwzH
        btEzS8RJtZO2LUBP0RB2u1fsis3YNLkJD3/6Lun9Czr7UuhQN0f/OYYlnP+gZA62
        g+0GK7Hlqjy6ivPJt4FuTuxbx4YIVn/vSJfjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A31OX+Rzi8AGlw10KJxamt8n8/O4TIUr
        PRnlRZ+MtZwcSJNc3mLaGiwTkAybwkw2haBVcl8Mi2aYA71g4vCyGdtmKAr5Gv8A
        IMsvn7y9LUQLlyD+vXl/n+A6U4KmGMMOfVqH9GeqCKTEFd8DeZG/vsJv9pBJ/NC/
        Ne50kixKY3o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB058806FA;
        Tue, 22 Oct 2019 23:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2764D806F9;
        Tue, 22 Oct 2019 23:52:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 00/17] New sparse-checkout builtin and "cone" mode
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 12:52:10 +0900
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 21 Oct 2019 13:56:09
        +0000")
Message-ID: <xmqqeez4i0et.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F2F71F2-F548-11E9-A323-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> V4 UPDATE: Rebased on latest master to include ew/hashmap and
> ds/include-exclude in the base.
>
> This series makes the sparse-checkout feature more user-friendly. While
> there, I also present a way to use a limited set of patterns to gain a
> significant performance boost in very large repositories.
> ...
> Updates in V5:
>
>  * The 'set' subcommand now enables the core.sparseCheckout config setting
>    (unless the checkout fails).
>    
>    
>  * If the in-process unpack_trees() fails with the new patterns, the
>    index.lock file is rolled back before the replay of the old
>    sparse-checkout patterns.
>    
>    
>  * Some documentation fixes, f(d)open->xf(d)open calls, and other nits.
>    Thanks everyone!

Thanks.  I quickly scanned the changes between the last round and
this one, and all I saw were pure improvements ;-)  Not that I claim
to have read the previous round very carefully, though.

Will replace and queue.

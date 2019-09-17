Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E55F1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 22:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfIQWXW (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 18:23:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54650 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIQWXW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 18:23:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AB7E330C3;
        Tue, 17 Sep 2019 18:23:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ylxOnPIN3FXtFvWof1+fr7hBNI=; b=ciu7H0
        iKSfrSCzbsj5RqAUDUEE4EZOis1r1825iVYr476my8osW3B/+B+kaO7mXmhIzCWv
        Ru/7YTxG0kZ7Ug+03xj9zAH0PEDF0GKP/aI9tKP4y/J/G7iHvDkuqOEABHaZw0/t
        tSm4ihlTE+Oor1+9asmnw8by9HJWoxZvRxs9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JvHNqtc+Q1ClQdc5lgoqzVtRAxtm4ggb
        ROVe36f5+rlcKF5GD6Z9m/OyR/2J8JaBCNl3AipOVxx4MKsd8hAk7NIwj0t7tMoo
        663qFmLJghdJ2qNGNa62lTFiClRXC8hes7E6IW8CdNPAdVTMm6tDJYO3Ct2NwtmS
        q1D7e9RIj04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12D92330BF;
        Tue, 17 Sep 2019 18:23:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66DE43307C;
        Tue, 17 Sep 2019 18:23:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [RFC PATCH] merge-recursive: symlink's descendants not in way
References: <CABPp-BHpXWF+1hKUTfn8s-y4MJZXz+jUVS_K10eKyD6PGwo=gg@mail.gmail.com>
        <20190917215040.132503-1-jonathantanmy@google.com>
Date:   Tue, 17 Sep 2019 15:23:18 -0700
In-Reply-To: <20190917215040.132503-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 17 Sep 2019 14:50:40 -0700")
Message-ID: <xmqqh85a7eax.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0805CB8-D999-11E9-A166-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When the working tree has:
>  - foo (symlink)
>  - foo/bar (directory)

Whoa, wait.  I assume, since this is about merge, the assumption is
that the working tree is clean with respect to the index, so 'foo'
is a symbolic link that is in the index.  Now, if foo is a symlink,
how can foo/bar (whether it is a directory or something else) exist,
which requires foo to be a directory in the first place?

> and the user merges a commit that deletes the foo symlink and instead
> contains:
>  - foo (directory)
>  - foo/bar (file)

This side is possible.  If foo is a directory, then there can be
foo/bar.  But I do not get the initial setup you start with.

In any case, if the working tree has 'foo' as a symlink, Git should
not look at or get affected by what 'foo' points at.

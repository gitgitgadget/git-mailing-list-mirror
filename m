Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDAE41F454
	for <e@80x24.org>; Wed,  6 Nov 2019 02:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfKFCdr (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 21:33:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61464 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfKFCdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 21:33:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C7A82AF3A;
        Tue,  5 Nov 2019 21:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b1tztxysjy2DHa6ISxXkhaVl8QE=; b=lnklV6
        btgEXMhX/0SbYVb0IpoXjz6aserdWs9Mx13Shw8lPJusFj+VJ96FR5y9x/caBgQf
        DkTX3ygT2+59dvMEmcKhkY+B6S9LFbUA+6hXyrwjo9b8ek3HB2fSiZM3EdMYuOJH
        FyyB0ZD00jeFffe8AX7eCuWpI4qUveCAzUYgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VYApXwluWnZt1kVIlmfIvbmIBFjEi/bk
        rLvVdw9x1iBywxmRS/afFCXh8Yl5J7C0a8ZyfCURvm6AfXTmdfb9n9WVn781erHU
        8qSQKG/SeNSVg1bpv2L7cSfpz8SlA4KHQE3uKldV3XVMW+qoRgPcLwxbFbmohIIS
        htwlAqOlVK8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93CA72AF39;
        Tue,  5 Nov 2019 21:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A1F72AF38;
        Tue,  5 Nov 2019 21:33:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric N. Vander Weele" <ericvw@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] status: teach "status --short" to respect "--show-stash"
References: <20191104100334.60537-1-ericvw@gmail.com>
Date:   Wed, 06 Nov 2019 11:33:42 +0900
In-Reply-To: <20191104100334.60537-1-ericvw@gmail.com> (Eric N. Vander Weele's
        message of "Mon, 4 Nov 2019 18:03:34 +0800")
Message-ID: <xmqq36f1wx6h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA1DD5F4-003D-11EA-B788-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric N. Vander Weele" <ericvw@gmail.com> writes:

> Enable printing the entries currently stashed away in the short format.
> This prints the stash information after the path status to be symmetric
> with "status --long --show-stash".
>
> Signed-off-by: Eric N. Vander Weele <ericvw@gmail.com>
> ---
>  Documentation/git-status.txt |  4 ++++
>  wt-status.c                  | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 7731b45f07..c1afc3282c 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -244,6 +244,10 @@ If -b is used the short-format status is preceded by a line
>  
>      ## branchname tracking info
>  
> +If --show-stash is used the short-format status is followed by a line
> +
> +    ## stash: <n> (entry|entries)
> +

Hmmmm.  Would readers misinterpret we are talking about a branch
whose name is stash something?  I am not suggesting to change ##
introducer to some random letters, which would break scripts even
worse.

Doesn't the Porcelain Format v1 call the same codepath as
shortstatus?  We promise that its output never changes to support
existing scripts, but now they will start seeing "## stash:" that
they do not understand and barf?

Isn't this information available to scripts that want to read from
porcelain v2 output format (which is meant to be extensible by
allowing easy-to-parse optional headers, which this stash thing
exactly is).

Thanks.

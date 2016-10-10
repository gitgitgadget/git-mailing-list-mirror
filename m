Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BCF20989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbcJJSJv (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:09:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64348 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751148AbcJJSJu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:09:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45F5944FA8;
        Mon, 10 Oct 2016 14:09:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uscKGUBAYBYsiDwKCxqk80OKYjQ=; b=FSSwQo
        1px6QqKkOnrxYkHwMf4AdYkdnKLSs8JIz23hU/bGQGsAUf+D36hSSzLTX2C3Z/da
        J6+DlP9IC7Ghwyu7jXb4v6xxdOvtVPo6uS29WqqMGhQFMDGuZ+pl7Ja39Fb6ADsU
        BpX6wqLXwelzFT8RCxq24FaAC0Zbn+e0RX7Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=seWOpd8JFjWD9Yft1r/sxbz469s6/Tnw
        VMRKqKbmrTlPj7ayjno/JerX7X91nOBis9JkSSS0zVPoYsTX3cxb/oDjY+iXSHkp
        f+lL5ISIXkU0ERwS7cznohcmi5UzpL99gN34Qosgin/r+YhicRaOjset35qvqfU7
        11V5XV5jbWk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A0B944FA7;
        Mon, 10 Oct 2016 14:09:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FD7344FA6;
        Mon, 10 Oct 2016 14:09:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net
Subject: Re: [PATCH] documentation: clarify submodule.<name>.[url, path] variables
References: <20161006235149.10232-1-sbeller@google.com>
Date:   Mon, 10 Oct 2016 11:09:17 -0700
In-Reply-To: <20161006235149.10232-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 6 Oct 2016 16:51:49 -0700")
Message-ID: <xmqqpon8f54i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA0FF222-8F14-11E6-900F-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:
>  submodule.<name>.path::
> +	The path within this project for a submodule. This variable is
> +	kept in the .gitmodules file. See linkgit:git-submodule[1] and
> +	linkgit:gitmodules[5] for details.

What does it exactly mean to be "kept"?

Does it mean "never appears in .git/config, and when it appears it
will not be used at all"?  If so we shouldn't even list it here.

I doubt there is any reason for .path to exist in .git/config; where
each submodule appears in the working tree is what is recorded in
the tree object, and the "identity" (i.e. that which links a
submodule in a tree to one of the repositories kept in
.git/modules/*) by reverse look-up of submodule.<name>.path from
in-tree .gitmodules, not from configuration, and it is not something
a per-repository configuration should be able to change at the
conceptual level.

>  submodule.<name>.url::
> -	The path within this project and URL for a submodule. These
> -	variables are initially populated by 'git submodule init'. See
> -	linkgit:git-submodule[1] and linkgit:gitmodules[5] for
> -	details.
> +	The URL for a submodule. This variable is copied from the .gitmodules
> +	file to the git config via 'git submodule init'. The user can change
> +	the configured URL before obtaining the submodule via 'git submodule
> +	update'. After obtaining the submodule, this variable is kept in the
> +	config as a boolean flag to indicate whether the submodule is of
> +	interest to git commands.  See linkgit:git-submodule[1] and
> +	linkgit:gitmodules[5] for details.

I think it is great that you are describing that this serves two
purposes, but "as a boolean flag" is very misleading.  It sounds as
if at some point "git submodule $something" command stores
true/false there.

 - It overrides the URL suggested by the project in .gitmodules and
   replace it with another URL viewed from the local environment
   (e.g. the project may suggest you to use http://github.com/ while
   you may have a local mirror elsewhere).

 - Its presence is also used as a sign that the user is interested in
   the submodule.

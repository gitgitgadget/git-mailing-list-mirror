Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF79D1FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 19:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdGRTgS (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:36:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53710 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751413AbdGRTgS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:36:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FAE07D503;
        Tue, 18 Jul 2017 15:36:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xmEzPB2FeaymH6RxfIR4yVJocbg=; b=PmEUAa
        ZynY7zdv+5ZY2hRcf5wKndLEh2wEsHMPEI2ggvzmRa/m0/kQRs4fTTHOzEqklO6I
        jTJJ9pwSJmn7+cQgC99o15MrNJ9ASfKIGp86UnjfFWAuwgNEWBfl6jakncPMpwdg
        WmNsyKzMpCsC5d9VTXt2XTj4VqFJSb35IaYQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bhnrl/Kltga0XnjVdq1fGSck3WHxFD4Y
        2GZ0GG8V0460zx7kdjWi0cA7h3aulgtSDDmHF+KXuPSSGwaJGisnvVq7vydVKjrb
        NzD5OCPKycE0zZ2x9g0I73eqWElQW7N/NsOqtlYq6lmYM4HHshY56yui8aRVxnpZ
        VU2H8AVfric=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2106D7D502;
        Tue, 18 Jul 2017 15:36:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FEAF7D500;
        Tue, 18 Jul 2017 15:36:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 00/10] Convert grep to recurse in-process
References: <20170714222826.81148-1-bmwill@google.com>
        <20170718190527.78049-1-bmwill@google.com>
Date:   Tue, 18 Jul 2017 12:36:14 -0700
In-Reply-To: <20170718190527.78049-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 18 Jul 2017 12:05:17 -0700")
Message-ID: <xmqqo9sho7v5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D67CED6-6BF0-11E7-AA5B-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Changes in v3:
>  * Fixes a bug with repo_read_gitmodules() where it was possible to
>    segfault when a repository didn't have a worktree.  
>  * In order to fix the above bug repo_read_gitmodules() and gitmodules_config()
>    were merged so that there won't be any duplicate logic.  In order to merge
>    these functions the parsing of submodule.fetchjobs and
>    fetch.recursesubmodules were removed from the submodule-config parsing logic
>    and instead moved into fetch and update-clone.  This also makes it easier to
>    ensure that no additonal non-submodule specific configuration like this will
>    be added to .gitmodules in the future.

Sounds good.  

Has this been rebased and if so on top of what?  It seems that I am
getting "am -3" conflicts at around 05/10---I think I can cope with,
but it is one unnecessary source of potential bugs, so...

> Brandon Williams (10):
>   repo_read_index: don't discard the index
>   repository: have the_repository use the_index
>   cache.h: add GITMODULES_FILE macro
>   config: add config_from_gitmodules
>   submodule: remove submodule.fetchjobs from submodule-config parsing
>   submodule: remove fetch.recursesubmodules from submodule-config
>     parsing
>   submodule: check for unstaged .gitmodules outside of config parsing
>   submodule: check for unmerged .gitmodules outside of config parsing
>   submodule: merge repo_read_gitmodules and gitmodules_config
>   grep: recurse in-process using 'struct repository'
>
>  Documentation/git-grep.txt  |   7 -
>  builtin/fetch.c             |  26 ++-
>  builtin/grep.c              | 396 ++++++++++----------------------------------
>  builtin/mv.c                |   2 +-
>  builtin/rm.c                |   2 +-
>  builtin/submodule--helper.c |  17 +-
>  cache.h                     |   2 +-
>  config.c                    |  17 ++
>  config.h                    |  10 ++
>  git.c                       |   2 +-
>  grep.c                      |  13 --
>  grep.h                      |   1 -
>  repository.c                |   6 +-
>  repository.h                |   8 +
>  setup.c                     |  12 +-
>  submodule-config.c          |   8 +
>  submodule-config.h          |   1 +
>  submodule.c                 | 147 +++++++---------
>  submodule.h                 |   6 +-
>  19 files changed, 240 insertions(+), 443 deletions(-)

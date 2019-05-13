Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DBBC1F461
	for <e@80x24.org>; Mon, 13 May 2019 03:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfEMDox (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 23:44:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57618 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMDox (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 23:44:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10DD7155D9E;
        Sun, 12 May 2019 23:44:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TMAbaWiEd0WklyIbYTiHBnveR7A=; b=Ve80uc
        wx0iuBhTDO5omoU0TpzilsH8uPBOYpe0JKIZB5xvtrsKUe4dc8OrjRSVfaVhF+5d
        IBcHkSBXbz9v91FIZ4mVN3LMa0yeP+LpzbDaZ1TAX5MdU+ewatlEmOxUvu/SBRRo
        vbZtLbH+pIw9B7S9wwM9TiKBWSP71i48HcW8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oNpH2eVo6KbpmX0YFQ8LHAjtq7N0kY7C
        SpyOC4Kiu++eIdvptkbb+7bZrN8pDNbEBSt/ufjGZ3ebBL4wB376cSfyTnB0HAHc
        n5AJkZjLN6165ZC3lCaqxqxa5TKkvkaEw7kb29PUQICE3LrG/taqgoKY3Mh5b+Z/
        0ai3jXD5uuo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07D64155D9D;
        Sun, 12 May 2019 23:44:51 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 695D3155D9C;
        Sun, 12 May 2019 23:44:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 03/11] commit-graph: collapse parameters into flags
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
        <469d0c9a32ba5a3f797b5bb50f37d6ac7746385b.1557411749.git.gitgitgadget@gmail.com>
Date:   Mon, 13 May 2019 12:44:49 +0900
In-Reply-To: <469d0c9a32ba5a3f797b5bb50f37d6ac7746385b.1557411749.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 09 May 2019
        07:22:33 -0700 (PDT)")
Message-ID: <xmqqy33bc91q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75F6EA76-7531-11E9-9FAE-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The write_commit_graph() and write_commit_graph_reachable() methods
> currently take two boolean parameters: 'append' and 'report_progress'.
> We will soon expand the possible options to send to these methods, so
> instead of complicating the parameter list, first simplify it.

I think this change to introduce "flags" and pack these two into a
single parameter, even if there is no plan to add code that starts
using third and subsequent bits immediately.

We are no longer adding anything beyond PROGRESS and APPEND in this
series, no?

>
> Collapse these parameters into a 'flags' parameter, and adjust the
> callers to provide flags as necessary.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/commit-graph.c | 8 +++++---
>  builtin/commit.c       | 2 +-
>  builtin/gc.c           | 4 ++--
>  commit-graph.c         | 9 +++++----
>  commit-graph.h         | 8 +++++---
>  5 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 2e86251f02..828b1a713f 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -142,6 +142,7 @@ static int graph_write(int argc, const char **argv)
>  	struct string_list *commit_hex = NULL;
>  	struct string_list lines;
>  	int result;
> +	int flags = COMMIT_GRAPH_PROGRESS;

Make it a habit to use "unsigned" not a signed type, when you pack a
collection of bits into a flag word, unless you are treating the MSB
specially, e.g. checking to see if it is negative is cheaper than
masking with MSB to see if it is set.

> ...
>  	result = write_commit_graph(opts.obj_dir,
>  				    pack_indexes,
>  				    commit_hex,
> -				    opts.append,
> -				    1);
> +				    flags);
> ...
> -int write_commit_graph_reachable(const char *obj_dir, int append,
> -				 int report_progress)
> +int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
> ...
>  int write_commit_graph(const char *obj_dir,
>  		       struct string_list *pack_indexes,
>  		       struct string_list *commit_hex,
> -		       int append, int report_progress)
> +		       unsigned int flags)

OK, so the receivers of the flags word know the collection is
unsigned; it's just the user of the API in graph_write() that gets
the signedness wrong.  OK, easy enough to correct, I guess.


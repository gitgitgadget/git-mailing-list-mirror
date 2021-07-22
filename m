Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB89C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA2D60EB2
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhGVWQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 18:16:58 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:46261 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231596AbhGVWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 18:16:58 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m6hdC-000C6X-9K; Thu, 22 Jul 2021 23:57:31 +0100
Subject: Re: [PATCH 7/7] fast-forward: add help about merge vs. rebase
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
 <20210722000854.1899129-8-felipe.contreras@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <76d59e73-ae5d-3bef-4aa3-5d1af9611577@iee.email>
Date:   Thu, 22 Jul 2021 23:57:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722000854.1899129-8-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

minor nit/query on format..
On 22/07/2021 01:08, Felipe Contreras wrote:
> Now that we have a locus for merge versus rebase documentation, we can
> refer to it on the diverging advice.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-fast-forward.txt | 48 ++++++++++++++++++++++++++++++
>  advice.c                           |  4 ++-
>  2 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-fast-forward.txt b/Documentation/git-fast-forward.txt
> index 38c920964f..1989fdec4a 100644
> --- a/Documentation/git-fast-forward.txt
> +++ b/Documentation/git-fast-forward.txt
> @@ -50,6 +50,54 @@ synchronize the two branches.
>  
>  THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOUR MAY CHANGE.
>  
> +MERGE OR REBASE
> +---------------
> +
> +The decision to whether merge or rebase depends on the situation and the
> +project. Traditionally git has prefered merge over rebase, but that creates a
> +new commit, and that's frowned up on some projects, so you can't just simply
> +choose to merge blindly.
> +
> +------------
> +    D---C---B---A origin/master
> +	 \
> +	  X---Y master
> +------------
> +
> +The nature of distributed version control systems make this divergence
> +unavoidable; you must decide how to synchronize this divergence.
> +
> +Should you choose to merge, the two heads (master and origin/master) will be joined
> +together in a new commit:
> +
> +------------
> +	  origin/master
> +		|
> +		v

.. here, in my email reader, the arrow doesn't align to the commit
because of the single char (+) indent relative to tab spacing. Does this
cause any problems when formatted in the html/web style?

It was my impression that, for ASCII art diagrams, we used space
indenting, leaving tabs for regular text indents. I quss you have an
auto tab setting that converts the 8-spaces to tabs in the source txt.

It is good to have diagrams for the visual learners!

> +    D---C---B---A---M master
> +	 \	   /
> +	  X---Y---+
> +------------
> +
> +This new commit is called a "merge commit" and has two parents (A and Y).
> +
> +Rebasing on the other hand rewrites the history:
> +
> +------------
> +	  origin/master
> +		|
> +		v
> +    D---C---B---A---X'---Y' master
> +------------
> +
> +The commits that diverged (X and Y) are rewritten as if they were created on top
> +of the new base (A). This creates a linear history, which is cleaner, but some
> +people prefer to preserve the original hsitory.
> +
> +In both cases it's likely you would have to resolve conflicts, the difference is
> +that in a merge you would have to do it all at once in one commit, while with a
> +rebase you would have to do it on every rewritten commit.
> +
>  SEE ALSO
>  --------
>  linkgit:git-merge[1], linkgit:git-rebase[1]
> diff --git a/advice.c b/advice.c
> index 60de7fbc4e..7f422b05d3 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -337,5 +337,7 @@ void diverging_advice(void)
>  		"\n"
>  		"or:\n"
>  		"\n"
> -		"\tgit rebase\n"));
> +		"\tgit rebase\n"
> +		"\n"
> +		"For more information check \"git help fast-forward\".\n"));
>  }
--
Philip

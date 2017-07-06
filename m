Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3E6202AE
	for <e@80x24.org>; Thu,  6 Jul 2017 04:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750977AbdGFEqn (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 00:46:43 -0400
Received: from ikke.info ([178.21.113.177]:45608 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbdGFEqm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 00:46:42 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id C75404400BE; Thu,  6 Jul 2017 06:46:40 +0200 (CEST)
Date:   Thu, 6 Jul 2017 06:46:40 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] merge-message: change meaning of "empty merge message"
Message-ID: <20170706044640.GA11020@alpha.vpn.ikke.info>
References: <xmqq60f9mo6b.fsf@gitster.mtv.corp.google.com>
 <20170706033149.6275-1-kaarticsivaraam91196@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706033149.6275-1-kaarticsivaraam91196@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 06, 2017 at 09:01:49AM +0530, Kaartic Sivaraam wrote:
> In the context of "git merge" the meaning of an "empty message"
> is one that contains no line of text. This is not in line with
> "git commit" where an "empty message" is one that contains only
> whitespaces and/or signed-off-by lines. This could cause surprises
> to users who are accustomed to the meaning of an "empty message"
> of "git commit".
> 
> Prevent such surprises by changing the meaning of an empty 'merge
> message' to be in line with that of an empty 'commit message'.
> 
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  builtin/merge.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 703827f00..db4bf1c40 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -748,6 +748,39 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
>  	exit(1);
>  }
>  
> +/*
> + * Find out if the message in the strbuf contains only whitespace and
> + * Signed-off-by lines.
> + *
> + * This function is the "rest_is_space" function of "commit" with the unwanted
> + * parameter removed.

The function is called "rest_is_empty".

But isn't it better that commit and merge use the same code, instead of
duplicating it again? Otherwise one may be updated, and the other
forgotten, getting differences in behaviur, which is what you want to
solve.

Kevin


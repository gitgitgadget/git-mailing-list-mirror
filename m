Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CAF202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 19:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbdJSTQn (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:16:43 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:54691 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbdJSTQm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:16:42 -0400
Received: by mail-io0-f194.google.com with SMTP id e89so10941472ioi.11
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mi/keI/zRsXa8f7gkrnBBQmQyJ5Hk4Z+GLSYhjHY40g=;
        b=ajbS7mXQruy9G/ibQoqR56X7l1usuyDAJBHJYLqGP+tfAfwR1y2PeB7Ma9zcdnG437
         C9rkIU3thfs/I/l1FvR5Lap7HeisnJA3JDRtEJ+XHzLeEUw2WFZ/f2cEWpOGKybqwMxS
         H480bfTwtmlnY96AiNd/YDRfD1y5G7NbrWb8VRJd4NuaoDzbg/U+oCklxz49X8fW9Uga
         xKHZrYcyp7zJNmGgPalVtjq0scny9riw+U87Vdj+RJNGyjnk+kwj/l7oetJp6L2b/LUa
         tveqkjXjZeTtriuP2DOkEkRCTrnu0wj2D/32LwuGK9ZzAGhRLFSl/Obv4pyycAKTLvpm
         vJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mi/keI/zRsXa8f7gkrnBBQmQyJ5Hk4Z+GLSYhjHY40g=;
        b=C6BVj54SRxwAVfCqhT8P9o6Ho5RSniNDUfnvh7QOWp5qBA5j1Dh2U2oKinHmEbt6Th
         YUmPw0GiAEEYlp4QEbfWVuPBkvOlj+drgArGo4VLqH6azJbWCAR9Y26ASp9ch4Wj72Ar
         sp3fmhVBEbd95/pJhAI0pmOF8V/6XMhgErbyLtyyij3szlfaMvz6xUDmam7gdyilLvxN
         aQQEbt2KeyipYHd0Us24kBPuWV6bPvB4sgxZWTe7krDFtiu7pbdm+aLHsl7om1H4QQcY
         ARznqEmaN3+uNYC5gToFwRK6jJrpZHu9VKPFTSoasDMkR7TqZYZXvBRShryV3kc6dxva
         pSHA==
X-Gm-Message-State: AMCzsaWhXcOYrJDzYaUOOOCS59OMsTHnjUyHz3xfS8nO9o2CnuC2LqXw
        X5LyHJmQCycWOpVekgXezO34OA==
X-Google-Smtp-Source: ABhQp+RbIZyzUw4izcN52I46S8qiHNOYdkdkBvar29X5RFLkzBDPv40Xk0nwFg8W/5ZhxDbs7TV61g==
X-Received: by 10.107.12.216 with SMTP id 85mr3427101iom.80.1508440601527;
        Thu, 19 Oct 2017 12:16:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:fddd:f883:fab:81b1])
        by smtp.gmail.com with ESMTPSA id 78sm989783itz.12.2017.10.19.12.16.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 12:16:40 -0700 (PDT)
Date:   Thu, 19 Oct 2017 12:16:38 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] submodule: simplify decision tree whether to or
 not to fetch
Message-ID: <20171019191638.GA84767@google.com>
References: <20171016135623.GA12756@book.hvoigt.net>
 <20171016135905.GD12756@book.hvoigt.net>
 <20171018180322.GA155019@google.com>
 <xmqqshegj7mo.fsf@gitster.mtv.corp.google.com>
 <20171019153844.GA41283@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019153844.GA41283@book.hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/19, Heiko Voigt wrote:
> On Thu, Oct 19, 2017 at 09:36:47AM +0900, Junio C Hamano wrote:
> > Brandon Williams <bmwill@google.com> writes:
> > 
> > > On 10/16, Heiko Voigt wrote:
> > >> To make extending this logic later easier.
> > >
> > > This makes things so much clearer, thanks!
> > 
> > I agree that it is clear to see what the code after the patch does,
> > but the code before the patch is so convoluted to follow that it is
> > a bit hard to see if the code before and after are doing the same
> > thing, though ;-)
> 
> That is why I would appreciate some extra pairs of eyes on this :) I
> tried to be as careful as possible when refactoring this, but since it
> is quite convoluted something might have slipped through. The testsuite
> does not show anything, but there might be corner cases that are not
> tested I guess.
> 
> Will hopefully have time to look into the comments to the main patch of
> this series tomorrow. Did not get around to properly do that yet.
> 
> Cheers Heiko
> 
> > >> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > >> ---
> > >>  submodule.c | 74 ++++++++++++++++++++++++++++++-------------------------------
> > >>  1 file changed, 37 insertions(+), 37 deletions(-)
> > >> 
> > >> diff --git a/submodule.c b/submodule.c
> > >> index 71d1773e2e..82d206eb65 100644
> > >> --- a/submodule.c
> > >> +++ b/submodule.c
> > >> @@ -1187,6 +1187,31 @@ struct submodule_parallel_fetch {
> > >>  };
> > >>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
> > >>  
> > >> +static int get_fetch_recurse_config(const struct submodule *submodule,
> > >> +				    struct submodule_parallel_fetch *spf)
> > >> +{
> > >> +	if (spf->command_line_option != RECURSE_SUBMODULES_DEFAULT)
> > >> +		return spf->command_line_option;
> > >> +
> > >> +	if (submodule) {
> > >> +		char *key;
> > >> +		const char *value;
> > >> +
> > >> +		int fetch_recurse = submodule->fetch_recurse;
> > >> +		key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> > >> +		if (!repo_config_get_string_const(the_repository, key, &value)) {
> > >> +			fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> > >> +		}
> > >> +		free(key);
> > >> +
> > >> +		if (fetch_recurse != RECURSE_SUBMODULES_NONE)
> > >> +			/* local config overrules everything except commandline */
> > >> +			return fetch_recurse;
> > >> +	}
> > >> +
> > >> +	return spf->default_option;
> > >> +}
> > >> +
> > >>  static int get_next_submodule(struct child_process *cp,
> > >>  			      struct strbuf *err, void *data, void **task_cb)
> > >>  {
> > >> @@ -1214,46 +1239,21 @@ static int get_next_submodule(struct child_process *cp,
> > >>  			}
> > >>  		}
> > >>  
> > >> -		default_argv = "yes";
> > >> -		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> > >> -			int fetch_recurse = RECURSE_SUBMODULES_NONE;
> > >> -
> > >> -			if (submodule) {
> > >> -				char *key;
> > >> -				const char *value;
> > >> -
> > >> -				fetch_recurse = submodule->fetch_recurse;
> > >> -				key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> > >> -				if (!repo_config_get_string_const(the_repository, key, &value)) {
> > >> -					fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> > >> -				}
> > >> -				free(key);
> > >> -			}
> > >> -
> > >> -			if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
> > >> -				if (fetch_recurse == RECURSE_SUBMODULES_OFF)
> > >> -					continue;
> > >> -				if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
> > >> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
> > >> -									 submodule->name))
> > >> -						continue;
> > >> -					default_argv = "on-demand";
> > >> -				}
> > >> -			} else {
> > >> -				if (spf->default_option == RECURSE_SUBMODULES_OFF)
> > >> -					continue;
> > >> -				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
> > >> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
> > >> -									  submodule->name))
> > >> -						continue;
> > >> -					default_argv = "on-demand";
> > >> -				}
> > >> -			}
> > >> -		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
> > >> -			if (!unsorted_string_list_lookup(&changed_submodule_names,
> > >> +		switch (get_fetch_recurse_config(submodule, spf))
> > >> +		{

I looked through this one more time and I was able to convince myself
again that it's doing the same thing.  Instead of repeating the same
logic over and over again (via copy and paste of code) in deeply nested
if's, you are first determining what the value of fetch_recurse is and
then based on that doing a set of specific things.

Only nit would be to move this brace onto the previous line :)

> > >> +		default:
> > >> +		case RECURSE_SUBMODULES_DEFAULT:
> > >> +		case RECURSE_SUBMODULES_ON_DEMAND:
> > >> +			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
> > >>  							 submodule->name))
> > >>  				continue;
> > >>  			default_argv = "on-demand";
> > >> +			break;
> > >> +		case RECURSE_SUBMODULES_ON:
> > >> +			default_argv = "yes";
> > >> +			break;
> > >> +		case RECURSE_SUBMODULES_OFF:
> > >> +			continue;
> > >>  		}
> > >>  
> > >>  		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
> > >> -- 
> > >> 2.14.1.145.gb3622a4
> > >> 

-- 
Brandon Williams

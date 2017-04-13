Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E837320960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755145AbdDMSES (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:04:18 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35180 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755313AbdDMSEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:04:05 -0400
Received: by mail-pf0-f176.google.com with SMTP id i5so31747424pfc.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M9ipOpAndaZwPT/ywllokAPAQQD9gEQiky7XNmTY6hk=;
        b=Sr5SqZ2q2QIYF6/0RZJeKUs/CqUYG76rtLDJV486lWoPOfPYgeFqIAzjSR18wTobT/
         kcZFric+1Vg4BlA8Xf6RSdG53q3ONmNncby5s9qhftWDWN+z3JHRZ1z1qEZgMw2iir2W
         0+11SOWJ7++htJFZg5zRiU4NNiz/ze3IySfwcOTA7EyfWAwmU2TKgVvfRGsJdGkXj8UQ
         ABYG5EX2Kfp6gFOK+XBYy8GSeR1q7RzOp22qHtYvsiVPaI3BREv23jNm4JE1Ynt72thC
         Iha+pAY4DEZz+CQkLlMq/fuzJu1vGgFqa3LktchLoPlszpFSY/fWd4fhZT9IlklPo3+Q
         c1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M9ipOpAndaZwPT/ywllokAPAQQD9gEQiky7XNmTY6hk=;
        b=MWo0W5AeSY7kQDEwjIT/e9x1Xv/h4SEcCCi8RtUQDNW8iVYcMtN7InicH0U8rAJQAJ
         W4GEA1Tgqv78yLd8OFpnI44iM4y0wp5/8yjepJg7dqW1i2wswxSu9af0VLnwKxrSfzvW
         gHKB+YFt7X7fvbtNnvfNgPeT87tveizHlYXSr1KhRdjdeGPrV1017ipIs9D//7plXoLd
         BQfjapOflyWGGMirG0j/uB3XKzj3xQim8HMjaMUoxGuJMGkd1kKaRkXZoXG042aPI7b5
         weK7j35zUrkOal8woUvbQsMqyYj896AH6kOAPZL/7E3JMdxEOeH0nqj9wNaKCYMYlBFt
         0spA==
X-Gm-Message-State: AN3rC/5xtoZZaOoA5d2/xyWoYjv1k8Xjph40nW06mtWSoL4lCy/jDBtf
        NrLScVCWBgbgKjvc
X-Received: by 10.99.98.135 with SMTP id w129mr4290057pgb.134.1492106639920;
        Thu, 13 Apr 2017 11:03:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id 2sm43762911pfx.107.2017.04.13.11.03.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 11:03:58 -0700 (PDT)
Date:   Thu, 13 Apr 2017 11:03:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 1/2] ls-files: fix recurse-submodules with nested
 submodules
Message-ID: <20170413180357.GA96917@google.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413171224.3537-1-jacob.e.keller@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Since commit e77aa336f116 ("ls-files: optionally recurse into
> submodules", 2016-10-07) ls-files has known how to recurse into
> submodules when displaying files.
> 
> Unfortunately this fails for certain cases, including when nesting more
> than one submodule, called from within a submodule that itself has
> submodules, or when the GIT_DIR environemnt variable is set.
> 
> Prior to commit b58a68c1c187 ("setup: allow for prefix to be passed to
> git commands", 2017-03-17) this resulted in an error indicating that
> --prefix and --super-prefix were incompatible.
> 
> After this commit, instead, the process loops forever with a GIT_DIR set
> to the parent and continuously reads the parent submodule files and
> recursing forever.
> 
> Fix this by preparing the environment properly for submodules when
> setting up the child process. This is similar to how other commands such
> as grep behave.
> 
> This was not caught by the original tests because the scenario is
> avoided if the submodules are created separately and not stored as the
> standard method of putting the submodule git directory under
> .git/modules/<name>. We can update the test to show the failure by the
> addition of "git submodule absorbgitdirs" to the test case. However,
> note that this new test would run forever without the necessary fix in
> this patch.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>

This looks good to me.  Thanks again for catching this.  Dealing with
submodules definitely isn't easy (I seem to have made a lot of mistakes
that have been cropping up recently)...it would be easier if we didn't
have to spin out a process for each submodule but that's not the world
we live in today :)

> ---
> I updated and reworded the description so that the problem would be more
> obvious. It doesn't occur always, but only when run nested with properly
> absorbed gitdirs for the submodules. This explains the reason why the
> test case had not caught the issue before.
> 
>  builtin/ls-files.c                     | 4 ++++
>  t/t3007-ls-files-recurse-submodules.sh | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index d449e46db551..e9b3546ca053 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -15,6 +15,7 @@
>  #include "string-list.h"
>  #include "pathspec.h"
>  #include "run-command.h"
> +#include "submodule.h"
>  
>  static int abbrev;
>  static int show_deleted;
> @@ -203,6 +204,9 @@ static void show_gitlink(const struct cache_entry *ce)
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	int status;
>  
> +	prepare_submodule_repo_env(&cp.env_array);
> +	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
> +
>  	if (prefix_len)
>  		argv_array_pushf(&cp.env_array, "%s=%s",
>  				 GIT_TOPLEVEL_PREFIX_ENVIRONMENT,
> diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
> index 4cf6ccf5a8ea..c8030dd3299a 100755
> --- a/t/t3007-ls-files-recurse-submodules.sh
> +++ b/t/t3007-ls-files-recurse-submodules.sh
> @@ -77,6 +77,7 @@ test_expect_success 'ls-files recurses more than 1 level' '
>  	git -C submodule/subsub commit -m "add d" &&
>  	git -C submodule submodule add ./subsub &&
>  	git -C submodule commit -m "added subsub" &&
> +	git submodule absorbgitdirs &&
>  	git ls-files --recurse-submodules >actual &&
>  	test_cmp expect actual
>  '
> -- 
> 2.12.2.776.gded3dc243c29.dirty
> 

-- 
Brandon Williams

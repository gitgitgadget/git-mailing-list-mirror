Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291E4C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFE722AAA
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbhATLd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 06:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbhATLBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 06:01:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA027C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 03:00:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c128so2445495wme.2
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QEykC1jWqFwd+1sW1eHkYnxrEdjjogO3BtgbiPsntpk=;
        b=IreA7VYsvWDL8BmCCEotsMJ29XkSLDgQu5LHN10OplZEoS0wGnKfRLtHDWvE6OhLQf
         UCId1dGuv30XX950XbNDvKCN/92QwJUaxpObGTTPZEljOrT5aJVaff20bmmiN+RPz/5k
         2jgba3TIjDyOLI9M8F1G8YcKSXx2scm+uopiv385d88HgEYkBFNRtZvmQOHpTDRBmsC6
         c2DnUzdFlkWgbva01ZXhn23y5a8JcjdErgkd0mc5PEn/gM5zabCGJE++qiC0TnUwj5ly
         YD0e3ylnR4Ggz5tNXkc5T13DiICf0STKMavxs55FGIpccXgOdNCtKMXkQnXfvKsVS05t
         Ayig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QEykC1jWqFwd+1sW1eHkYnxrEdjjogO3BtgbiPsntpk=;
        b=qKyVPmGvyxMs1dPyTmJH2AhaCNlZDTFjkXySXJi0RpRTI9BrVbpIAV0WQlhsDU8NBJ
         sF3kgJOzT/PDs5BXeeC51RAhGm7vTkz32Njf7bseBqVRsKIFfv8FOVEM0WRiIzsSQIj8
         LOX/KotMW6+7c1sejU2dFNj9Yuh7R5nZ5LJZDCaIrw1JNRuQ4wqC92vsntjtIDbcEjNw
         lhwCa/jC4FEGZ6XHyH4yQ/GPZM+fCXXuU+/Gv6YzyYQ/MusZb5oZM60Gxz1BlplJuOfY
         nIccXTVy9QjfY/V5l2OKA4zsw7X4gc/ODaQrgLKcro/ZaGAqw0iwI5ahW2V+R7mllNKH
         p/1g==
X-Gm-Message-State: AOAM533SszqL/5ZFWU73S51aZJ9rRxpYhccNstGSFUebUSuBsZ48jsQT
        UKMld+8Y00lqeCOz+++tyZEVMZgzIlw=
X-Google-Smtp-Source: ABdhPJwzIBrG8VgrikGN7YkA/WHwzH0hbUYi1lHPSeA+Qv8K+FwEgVtpyUP3P08BaXnLirgOkG0kZQ==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr3923605wmb.153.1611140437649;
        Wed, 20 Jan 2021 03:00:37 -0800 (PST)
Received: from [192.168.1.240] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.gmail.com with ESMTPSA id b13sm3253945wrt.31.2021.01.20.03.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 03:00:36 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/7] worktree: teach `list --porcelain` to annotate
 locked worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-6-rafaeloliveira.cs@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <be24c164-3d03-145f-abc0-4f41ed225b4e@gmail.com>
Date:   Wed, 20 Jan 2021 11:00:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119212739.77882-6-rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rafael

Thanks for reworking this to use c_quote_path(). I have a couple of 
comments below.

On 19/01/2021 21:27, Rafael Silva wrote:
> Commit c57b3367be (worktree: teach `list` to annotate locked worktree,
> 2020-10-11) taught "git worktree list" to annotate locked worktrees by
> appending "locked" text to its output, however, this is not listed in
> the --porcelain format.
> 
> Teach "list --porcelain" to do the same and add a "locked" attribute
> followed by its reason, thus making both default and porcelain format
> consistent. If the locked reason is not available then only "locked"
> is shown.
> 
> The output of the "git worktree list --porcelain" becomes like so:
> 
>      $ git worktree list --porcelain
>      ...
>      worktree /path/to/locked
>      HEAD 123abcdea123abcd123acbd123acbda123abcd12
>      detached
>      locked
> 
>      worktree /path/to/locked-with-reason
>      HEAD abc123abc123abc123abc123abc123abc123abc1
>      detached
>      locked reason why it is locked
>      ...
> 
> In porcelain mode, if the lock reason contains special characters
> such as newlines, they are escaped with backslashes and the entire
> reason is enclosed in double quotes. For example:
> 
>     $ git worktree list --porcelain
>     ...
>     locked "worktree's path mounted in\nremovable device"
>     ...
> 
> Furthermore, let's update the documentation to state that some
> attributes in the porcelain format might be listed alone or together
> with its value depending whether the value is available or not. Thus
> documenting the case of the new "locked" attribute.
> 
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
>   Documentation/git-worktree.txt | 16 ++++++++++++++--
>   builtin/worktree.c             | 13 +++++++++++++
>   t/t2402-worktree-list.sh       | 30 ++++++++++++++++++++++++++++++
>   3 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 02a706c4c0..7cb8124f28 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -377,8 +377,10 @@ Porcelain Format
>   The porcelain format has a line per attribute.  Attributes are listed with a
>   label and value separated by a single space.  Boolean attributes (like `bare`
>   and `detached`) are listed as a label only, and are present only
> -if the value is true.  The first attribute of a working tree is always
> -`worktree`, an empty line indicates the end of the record.  For example:
> +if the value is true.  Some attributes (like `locked`) can be listed as a label
> +only or with a value depending upon whether a reason is available.  The first
> +attribute of a working tree is always `worktree`, an empty line indicates the
> +end of the record.  For example:

I think it would be helpful to document that the reasons are quoted 
according core.quotePath.

I'm not sure if it is worth changing this but I wonder if it would be 
easier to parse the output if the names of attributes with optional 
reasons were always followed by a space even when there is no reason, 
otherwise the code that parses the output has to check for the name 
followed by a space or newline. A script that only cares if the worktree 
is locked can parse the output with
l.starts_with("locked ")
rather than having to do
l.starts_with("locked ") || l == "locked\n"

Best Wishes

Phillip

>   ------------
>   $ git worktree list --porcelain
> @@ -393,6 +395,16 @@ worktree /path/to/other-linked-worktree
>   HEAD 1234abc1234abc1234abc1234abc1234abc1234a
>   detached
>   
> +worktree /path/to/linked-worktree-locked-no-reason
> +HEAD 5678abc5678abc5678abc5678abc5678abc5678c
> +branch refs/heads/locked-no-reason
> +locked
> +
> +worktree /path/to/linked-worktree-locked-with-reason
> +HEAD 3456def3456def3456def3456def3456def3456b
> +branch refs/heads/locked-with-reason
> +locked reason why is locked
> +
>   ------------
>   
>   EXAMPLES
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index df90a5acca..98177f91d4 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -12,6 +12,7 @@
>   #include "submodule.h"
>   #include "utf8.h"
>   #include "worktree.h"
> +#include "quote.h"
>   
>   static const char * const worktree_usage[] = {
>   	N_("git worktree add [<options>] <path> [<commit-ish>]"),
> @@ -569,6 +570,8 @@ static int add(int ac, const char **av, const char *prefix)
>   
>   static void show_worktree_porcelain(struct worktree *wt)
>   {
> +	const char *reason;
> +
>   	printf("worktree %s\n", wt->path);
>   	if (wt->is_bare)
>   		printf("bare\n");
> @@ -579,6 +582,16 @@ static void show_worktree_porcelain(struct worktree *wt)
>   		else if (wt->head_ref)
>   			printf("branch %s\n", wt->head_ref);
>   	}
> +
> +	reason = worktree_lock_reason(wt);
> +	if (reason && *reason) {
> +		struct strbuf sb = STRBUF_INIT;
> +		quote_c_style(reason, &sb, NULL, 0);
> +		printf("locked %s\n", sb.buf);
> +		strbuf_release(&sb);
> +	} else if (reason)
> +		printf("locked\n");
> +
>   	printf("\n");
>   }
>   
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> index 1866ea09f6..1fe53c3309 100755
> --- a/t/t2402-worktree-list.sh
> +++ b/t/t2402-worktree-list.sh
> @@ -72,6 +72,36 @@ test_expect_success '"list" all worktrees with locked annotation' '
>   	! grep "/unlocked  *[0-9a-f].* locked$" out
>   '
>   
> +test_expect_success '"list" all worktrees --porcelain with locked' '
> +	test_when_finished "rm -rf locked1 locked2 unlocked out actual expect && git worktree prune" &&
> +	echo "locked" >expect &&
> +	echo "locked with reason" >>expect &&
> +	git worktree add --detach locked1 &&
> +	git worktree add --detach locked2 &&
> +	# unlocked worktree should not be annotated with "locked"
> +	git worktree add --detach unlocked &&
> +	git worktree lock locked1 &&
> +	git worktree lock locked2 --reason "with reason" &&
> +	test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
> +	git worktree list --porcelain >out &&
> +	grep "^locked" out >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list" all worktrees --porcelain with locked reason newline escaped' '
> +	test_when_finished "rm -rf locked_lf locked_crlf out actual expect && git worktree prune" &&
> +	printf "locked \"locked\\\\r\\\\nreason\"\n" >expect &&
> +	printf "locked \"locked\\\\nreason\"\n" >>expect &&
> +	git worktree add --detach locked_lf &&
> +	git worktree add --detach locked_crlf &&
> +	git worktree lock locked_lf --reason "$(printf "locked\nreason")" &&
> +	git worktree lock locked_crlf --reason "$(printf "locked\r\nreason")" &&
> +	test_when_finished "git worktree unlock locked_lf && git worktree unlock locked_crlf" &&
> +	git worktree list --porcelain >out &&
> +	grep "^locked" out >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'bare repo setup' '
>   	git init --bare bare1 &&
>   	echo "data" >file1 &&
> 

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E412013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbdBOVuL (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:50:11 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36862 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbdBOVuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:50:10 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so12125383pgf.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 13:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X06qPBDARambXz0lUWELP8XledLmI7KiFcgq/3QnLdU=;
        b=fzKud8VXJlLXsrRkGnOWGf3YvQKQfZWR2FhQGUeS2u9rLtIdgYVdoZCozCQ887vG6n
         bk5mzYayOFs4C0e0DwuwWkLn/L4mszLgBYdDxaZnKXwpYMbSMzEq6exQFY7oEyxyXgph
         IVGDvWPFrh8WYZgf/rFJ3zwFnz3KydiMyxvtboIzKG9OZbuxhwsyh3ycGFSCy5+C9BIS
         GdQMhFd0VipTEnaUmEXeBxwOKHVdkb1SpvqLRwwb9qgM+jcuv4RhtfcQj3ezhWzdX+qm
         u4Thkil5w2nj47llDBwNsTXLD2yPh93VIDupeBFo2B0VTDVXkAdfdYTTjL+hEZyYTYDN
         iK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X06qPBDARambXz0lUWELP8XledLmI7KiFcgq/3QnLdU=;
        b=HfXvQ0SdUjzjRKjhpXtvgkULFEbJqJxQp7HWfnp3nKv+Vzt8t9NP0OB6WNvMgMtdGo
         mZp25SyUMr1LguLYw4h0P76zYoyZ7YIkjakcEErwd2gXxobtEaTfhCpSQhZ4STy2p8IZ
         58tcZ5dtxKe4/U7qR1eUImpvAAhccF2Jw5z4tMVrS2WYv7slXEZo3aSO0NwVj30Gd4ht
         R7CzyvmtmMoIZM87Jw5fP17inqputkA8dczDfIbKHm7nR2n+Q4+V+HYYwt/UtcPTWNrp
         lxZXQRsk5OevX2CfZijHlQljMyP7vW7HNQhfOtP9T1bdBlB0rP6gIiqqbB9H++dSSoht
         ew2Q==
X-Gm-Message-State: AMke39lyEGD6c8cC2i9mOq4AS8Zk/oh9ccKk2C3hDw0RqGnNl8qxwYe7I6B6cF0chGz8Lw==
X-Received: by 10.99.155.18 with SMTP id r18mr40564348pgd.193.1487195409215;
        Wed, 15 Feb 2017 13:50:09 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id m6sm9261844pgn.58.2017.02.15.13.50.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 13:50:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] show-branch: fix crash with long ref name
References: <20170214154816.12625-1-chriscool@tuxfamily.org>
        <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
        <xmqqlgt88t0r.fsf@gitster.mtv.corp.google.com>
        <20170214195513.7zae6x22advkrms6@sigill.intra.peff.net>
        <CAP8UFD0EfUgfmTB4dj-A+rw79F7SWKxYvatNfR+Nj-8ukWYAQA@mail.gmail.com>
        <20170215214052.5py4pxkcz4g2bmtk@sigill.intra.peff.net>
Date:   Wed, 15 Feb 2017 13:50:07 -0800
In-Reply-To: <20170215214052.5py4pxkcz4g2bmtk@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Feb 2017 16:40:52 -0500")
Message-ID: <xmqqfujf2kfk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I see the patches are marked for 'next' in the latest What's Cooking.
> If it is not too late in today's integration cycle, here is a re-roll of
> patch 3 that squashes in Pranit's suggestion (if it is too late, then
> Pranit, you may want to re-send it as a squash on top).

Thanks.  

I think that matches what I queued last night, except for the
Helped-by: line.  Will replace.

> -- >8 --
> Subject: [PATCH] show-branch: use skip_prefix to drop magic numbers
>
> We make several starts_with() calls, only to advance
> pointers. This is exactly what skip_prefix() is for, which
> lets us avoid manually-counted magic numbers.
>
> Helped-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/show-branch.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 404c4d09a..19756595d 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -275,8 +275,7 @@ static void show_one_commit(struct commit *commit, int no_name)
>  		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
>  		pretty_str = pretty.buf;
>  	}
> -	if (starts_with(pretty_str, "[PATCH] "))
> -		pretty_str += 8;
> +	skip_prefix(pretty_str, "[PATCH] ", &pretty_str);
>  
>  	if (!no_name) {
>  		if (name && name->head_name) {
> @@ -470,17 +469,14 @@ static void snarf_refs(int head, int remotes)
>  	}
>  }
>  
> -static int rev_is_head(char *head, char *name,
> +static int rev_is_head(const char *head, const char *name,
>  		       unsigned char *head_sha1, unsigned char *sha1)
>  {
>  	if (!head || (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
>  		return 0;
> -	if (starts_with(head, "refs/heads/"))
> -		head += 11;
> -	if (starts_with(name, "refs/heads/"))
> -		name += 11;
> -	else if (starts_with(name, "heads/"))
> -		name += 6;
> +	skip_prefix(head, "refs/heads/", &head);
> +	if (!skip_prefix(name, "refs/heads/", &name))
> +		skip_prefix(name, "heads/", &name);
>  	return !strcmp(head, name);
>  }
>  
> @@ -799,8 +795,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>  				has_head++;
>  		}
>  		if (!has_head) {
> -			int offset = starts_with(head, "refs/heads/") ? 11 : 0;
> -			append_one_rev(head + offset);
> +			const char *name = head;
> +			skip_prefix(name, "refs/heads/", &name);
> +			append_one_rev(name);
>  		}
>  	}

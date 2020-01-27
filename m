Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A236AC32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BD324679
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 23:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDBkqbli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgA0XwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:52:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41998 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgA0XwR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 18:52:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so4352005plk.9
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 15:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nUtz7i/DO7l8fJB3OIrwA9zL/YDdZw3rKi8uEkWgDaA=;
        b=sDBkqbliZek418HMrAJBD1Q1R/AiRPGcalOrAkfAjTD4QmbWhZwlfZ2R2u42MxIi8j
         dWvsDpfYwyufsHBICxxBI/n4dVLu26z/zjKl3upDhSfXXqPMedjrAi+9Yg5L261gA/52
         /9conaVSdw+5XmNzljvVMspHhOV4MbmP4ZruX9B6ukaUQC+oqskuil0l5A2hzUUyNTQf
         TlKasFFkdUL1ijUnW7/44bc8IuzAmgg1fBeimE5vPc0JRI14kZXoMVJl97noKD5WTgtw
         MetCWrJ5ZeOaeukmFIJ1joS0EztXkq+lgAj0oUxBsIA4wv1gK1LpmNbo6Z27ckDMhTcX
         3O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nUtz7i/DO7l8fJB3OIrwA9zL/YDdZw3rKi8uEkWgDaA=;
        b=JqVnv0TVjQSzE+NGMNMiPb52GYjW/PQ2a/cKGS3emUmsSvO+7yFXvkSexGDgh7c0A9
         dzb2yw5kZUhjtDlGIXe83c9XNGt7BkKsRnI7uN99efpu9PfEmwroX1hqThi9k267erw0
         4pfeaM5PiH/mShmOQUYNZKX4pkvF3vgiLwK9hqcGMFjbdEb941MpR5fyHVwkXqXz7/Tx
         h62nIu7hob188D7b4S14WciRMtJLUEYyHJ9UH2sP2VGrZLGQSfw2aflzunY/hXDQ0tWM
         YgCyGPY3s2cPzT+MydiXazYpeqXLJyFKWqKDp2lPwZxhbW5o/UeKjbkdORdZYzWuyd6p
         6Hdg==
X-Gm-Message-State: APjAAAXzhCIHx5Rri8w0emfDWgP6uLF4tPNm/UDhaDsmA7tgbXK3SYv6
        x6wHEUNU6Uva7ECah1lfFKEDTw==
X-Google-Smtp-Source: APXvYqyDc6sick14pOs3HaWc1BvAkUEQdt21ubY5BWN/1ZVaUb2AagGnSqZw2k8x+ish3zA9+T5HaA==
X-Received: by 2002:a17:902:d918:: with SMTP id c24mr20323885plz.167.1580169135904;
        Mon, 27 Jan 2020 15:52:15 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w123sm17372432pfb.167.2020.01.27.15.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 15:52:15 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:52:10 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] add: use advise function to display hints
Message-ID: <20200127235210.GC233139@google.com>
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
 <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
 <9f9febd3f4f7f82178fceac98fcc91cb28a1b3b9.1578438752.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9febd3f4f7f82178fceac98fcc91cb28a1b3b9.1578438752.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 11:12:32PM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Use the advise function in advice.c to display hints to the users, as
> it provides a neat and a standard format for hint messages, i.e: the
> text is colored in yellow and the line starts by the word "hint:".
> 
> Also this will enable us to control the messages using advice.*
> configuration variables.

Looks like this slipped through the cracks over the holidays. Sorry! :)

> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  advice.c       | 2 ++
>  advice.h       | 1 +
>  builtin/add.c  | 6 ++++--
>  t/t3700-add.sh | 2 +-
>  4 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/advice.c b/advice.c
> index 249c60dcf3..098ac0abea 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -31,6 +31,7 @@ int advice_graft_file_deprecated = 1;
>  int advice_checkout_ambiguous_remote_branch_name = 1;
>  int advice_nested_tag = 1;
>  int advice_submodule_alternate_error_strategy_die = 1;
> +int advice_add_nothing = 1;

Here's the global advice setting we can look at.

>  
>  static int advice_use_color = -1;
>  static char advice_colors[][COLOR_MAXLEN] = {
> @@ -91,6 +92,7 @@ static struct {
>  	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
>  	{ "nestedTag", &advice_nested_tag },
>  	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
> +	{ "addNothing", &advice_add_nothing },

Here's the name of the advice config, e.g. advice.addNothing.

Hmm, I wonder if addNothing really makes sense/is understandable when
I'm configuring? I see two cases you're addressing; first, adding an
ignored file ("Use -f if you really want to add") - which "addNothing"
doesn't really make sense for - and second, "add" with nothing
specified ("did you mean 'git add .'"), where "addNothing" makes sense
in context. Out of context though, perhaps "hint.addIgnoredFile" and
"hint.addEmptyPathspec" make more sense? Of course naming is one of the
two hardest problems in computer science (next to race conditions and
off-by-one errors) so probably someone else can suggest a better name :)

>  
>  	/* make this an alias for backward compatibility */
>  	{ "pushNonFastForward", &advice_push_update_rejected }
> diff --git a/advice.h b/advice.h
> index b706780614..83287b0594 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -31,6 +31,7 @@ extern int advice_graft_file_deprecated;
>  extern int advice_checkout_ambiguous_remote_branch_name;
>  extern int advice_nested_tag;
>  extern int advice_submodule_alternate_error_strategy_die;
> +extern int advice_add_nothing;
>  
>  int git_default_advice_config(const char *var, const char *value);
>  __attribute__((format (printf, 1, 2)))
> diff --git a/builtin/add.c b/builtin/add.c
> index 4c38aff419..57b3186f69 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -390,7 +390,8 @@ static int add_files(struct dir_struct *dir, int flags)
>  		fprintf(stderr, _(ignore_error));
>  		for (i = 0; i < dir->ignored_nr; i++)
>  			fprintf(stderr, "%s\n", dir->ignored[i]->name);
> -		fprintf(stderr, _("Use -f if you really want to add them.\n"));
> +		if (advice_add_nothing)
> +			advise(_("Use -f if you really want to add them.\n"));

Here's where we add the guard, and use the new config.

As mentioned earlier, I'm not sure that tying this advice to the same
config as the next one you change really makes sense.

Nitwise, it's somewhat common for advice hints to also tell you how to
disable them; see sha1-name.c:get_oid_basic's 'object_name_msg' for an
example.

>  		exit_status = 1;
>  	}
>  
> @@ -480,7 +481,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  
>  	if (require_pathspec && pathspec.nr == 0) {
>  		fprintf(stderr, _("Nothing specified, nothing added.\n"));
> -		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
> +		if (advice_add_nothing)
> +			advise( _("Maybe you wanted to say 'git add .'?\n"));

Same nit as above.

>  		return 0;
>  	}
>  
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index c325167b90..a649805369 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -326,7 +326,7 @@ test_expect_success 'git add --dry-run of an existing file output' "
>  cat >expect.err <<\EOF
>  The following paths are ignored by one of your .gitignore files:
>  ignored-file
> -Use -f if you really want to add them.
> +hint: Use -f if you really want to add them.
>  EOF
>  cat >expect.out <<\EOF
>  add 'track-this'
> -- 
> gitgitgadget

Finally, you'd better update Documentation/config/advice.txt too.

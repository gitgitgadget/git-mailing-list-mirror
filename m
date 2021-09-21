Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D665C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5463C61183
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhIUQxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhIUQxk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:53:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF55C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:52:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso2413024pjh.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=BKpxBtzXz6NN1dIq2uWTQ7BKx7AZAPvl0Mfa8yUKmQM=;
        b=Io5+rdAig1+GLY9YO7BHh4qHo68eyC84ARnCFlsLQ+c9Lkwb65SbxmYXYlUlH2RFiW
         PoPa2lRHYXBMXojS/WXOPKyfKhdDPu2IPNWlUs7Uwtsm0i7H8+GRCObLNK5NdtniKLGd
         0u9HGmNONgTy2hROuql+kSeF/sLdjyK5wUor0koiCrR17DjT/4CHL/nWKo/Zz7oFfpQV
         2zD8w7K//ST0t5JgiiP7IpBuRRWRwf6/aCFOSFMnQuG+7azF8ePMmh3+LI7iM3Fmh5v2
         WnQ0ahfDHVtUdTdy34SWzwSbAzs4JS8A3GQiyU+tk1HRRIA6x1r3XgdcvD7KHATDxRsW
         CNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=BKpxBtzXz6NN1dIq2uWTQ7BKx7AZAPvl0Mfa8yUKmQM=;
        b=JLUncHj9pI8zZQ7DNoPROEpFuKFomg0znC3Ov5VZUXCP3yQ42MuCsq7D8vO+gfT7kD
         WBaONMxqzjBfAXtYcGUGqEtX+R8LX3p87x33PYEzqlYkc7Wc1AyZASPb4JAuzfE8qmBU
         LLhVo6rdb8tE6T1WXgkhOWkSJDCDaePmPuzCnkd+1TJoIRCPo8CPR0/oHu4aGUN1oFCq
         PwURNO4wi27nPHz4lNc9UC+pNRhB+rK17cKA6HdoOn2dpjSnw4rdAudqkufXPCfOGJcZ
         O/j+ByXDaiiw6aMlXAdfNYrLu+LYtl2X/JQ/0aCREVUe2ppLeJAlVOwaFyrisHWOaozs
         d5PQ==
X-Gm-Message-State: AOAM531aAWAOp+NZXMenUWC+14BmEkq3PdqO69zrp89AoF7O22AmuNL0
        i/jhQpA/uNwAWap8tLHmnXYuIdLRFEE=
X-Google-Smtp-Source: ABdhPJynw30QeAzJproIIpEe6Lebax+gKoOhOh3VliqoZaTqhfMVCRxJy7OyxrS/gtXXc8rm0RP2lg==
X-Received: by 2002:a17:903:22c7:b0:13c:855a:3d74 with SMTP id y7-20020a17090322c700b0013c855a3d74mr28768428plg.74.1632243131282;
        Tue, 21 Sep 2021 09:52:11 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.152])
        by smtp.gmail.com with ESMTPSA id s9sm6935545pfw.143.2021.09.21.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:52:11 -0700 (PDT)
References: <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
 <20210918193116.310575-1-kaartic.sivaraam@gmail.com>
 <20210918193116.310575-2-kaartic.sivaraam@gmail.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v2 1/1] submodule--helper: fix incorrect newlines in an
 error message
Date:   Tue, 21 Sep 2021 22:17:51 +0530
In-reply-to: <20210918193116.310575-2-kaartic.sivaraam@gmail.com>
Message-ID: <m27df9lvm1.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> A refactoring[1] done as part of the recent conversion of
> 'git submodule add' to builtin, changed the error message
> shown when a Git directory already exists locally for a submodule
> name. Before the refactoring, the error used to appear like so:
>
>   --- START OF OUTPUT ---
>   $ git submodule add ../sub/ subm
>   A git directory for 'subm' is found locally with remote(s):
>     origin        /me/git-repos-for-test/sub
>   If you want to reuse this local git directory instead of cloning again from
>     /me/git-repos-for-test/sub
>   use the '--force' option. If the local git directory is not the correct repo
>   or you are unsure what this means choose another name with the '--name' option.
>   ---  END OF OUTPUT  ---
>
> After the refactoring the error started appearing like so:
>
>   --- START OF OUTPUT ---
>   $ git submodule add ../sub/ subm
>   A git directory for 'subm' is found locally with remote(s):  origin     /me/git-repos-for-test/sub
>   fatal: If you want to reuse this local git directory instead of cloning again from
>   /me/git-repos-for-test/sub
>   use the '--force' option. If the local git directory is not the correct repo
>   or if you are unsure what this means, choose another name with the '--name' option.
>
>   ---  END OF OUTPUT  ---
>
> As one could observe the remote information is printed along with the
> first line rather than on its own line. Also, there's an additional
> newline following output.
>
> Make the error message consistent with the error message that used to be
> printed before the refactoring.
>
> This also moves the 'fatal:' prefix that appears in the middle of the
> error message to the first line as it would more appropriate to have
> it in the first line. The output after the change would look like:
>
>   --- START OF OUTPUT ---
>   $ git submodule add ../sub/ subm
>   fatal: A git directory for 'subm' is found locally with remote(s):
>     origin        /me/git-repos-for-test/sub
>   If you want to reuse this local git directory instead of cloning again from
>     /me/git-repos-for-test/sub
>   use the '--force' option. If the local git directory is not the correct repo
>   or you are unsure what this means choose another name with the '--name' option.
>   ---  END OF OUTPUT  ---
>
> [1]: https://lore.kernel.org/git/20210710074801.19917-5-raykar.ath@gmail.com/#t
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  builtin/submodule--helper.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 414fcb63ea..236da214c6 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2775,7 +2775,7 @@ struct add_data {
>  };
>  #define ADD_DATA_INIT { .depth = -1 }
>
> -static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
> +static void show_fetch_remotes(struct strbuf *msg, const char *sm_name, const char *git_dir_path)

I like the change from using a strbuf instead of passing the output
stream and printing to it. But maybe we should rename this function, now
that it doesn't really 'show' anything? Probably something like
'append_fetch_remotes()'?

>  {
>  	struct child_process cp_remote = CHILD_PROCESS_INIT;
>  	struct strbuf sb_remote_out = STRBUF_INIT;
> @@ -2791,7 +2791,7 @@ static void show_fetch_remotes(FILE *output, const char *sm_name, const char *gi
>  		while ((next_line = strchr(line, '\n')) != NULL) {
>  			size_t len = next_line - line;
>  			if (strip_suffix_mem(line, &len, " (fetch)"))
> -				fprintf(output, "  %.*s\n", (int)len, line);
> +				strbuf_addf(msg, "  %.*s\n", (int)len, line);
>  			line = next_line + 1;
>  		}
>  	}
> @@ -2823,20 +2823,28 @@ static int add_submodule(const struct add_data *add_data)
>
>  		if (is_directory(submod_gitdir_path)) {
>  			if (!add_data->force) {
> -				fprintf(stderr, _("A git directory for '%s' is found "
> -						  "locally with remote(s):"),
> -					add_data->sm_name);
> -				show_fetch_remotes(stderr, add_data->sm_name,
> +				struct strbuf msg = STRBUF_INIT;
> +				char *die_msg;
> +
> +				strbuf_addf(&msg, _("A git directory for '%s' is found "
> +						    "locally with remote(s):\n"),
> +					    add_data->sm_name);
> +
> +				show_fetch_remotes(&msg, add_data->sm_name,
>  						   submod_gitdir_path);
>  				free(submod_gitdir_path);
> -				die(_("If you want to reuse this local git "
> -				      "directory instead of cloning again from\n"
> -				      "  %s\n"
> -				      "use the '--force' option. If the local git "
> -				      "directory is not the correct repo\n"
> -				      "or if you are unsure what this means, choose "
> -				      "another name with the '--name' option.\n"),
> -				    add_data->realrepo);
> +
> +				strbuf_addf(&msg, _("If you want to reuse this local git "
> +						    "directory instead of cloning again from\n"
> +						    "  %s\n"
> +						    "use the '--force' option. If the local git "
> +						    "directory is not the correct repo\n"
> +						    "or you are unsure what this means choose "
> +						    "another name with the '--name' option."),
> +					    add_data->realrepo);
> +
> +				die_msg = strbuf_detach(&msg, NULL);
> +				die("%s", die_msg);
>  			} else {
>  				printf(_("Reactivating local git directory for "
>  					 "submodule '%s'\n"), add_data->sm_name);

Other than that this patch is an improvement. Thanks for fixing this!

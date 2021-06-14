Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3111EC48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 19:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF93613CC
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhFNTy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 15:54:59 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36416 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbhFNTy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 15:54:59 -0400
Received: by mail-ed1-f46.google.com with SMTP id w21so47993093edv.3
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=Qog3rYUL+Z48LXLUUkleMaGHE+rTAki6YlvbLu/7rWA=;
        b=eViycHXCzbzZl0ax9vGnTzG4a0eQknhqOR0rmNPqn9VAn1yHzgW8a+AQ1LOWoWhS3/
         HsbNjaY0L0Zqd6afGDTkq5Mu0BDlDWlj69rBxShAFwZU1DRDQ6ac5sOhoL0kWzsJDmB7
         /NwACqLhjuaC3TiDsvNAQw/2Wk3HZzEUakNIMKUO+/F5ISdiyEdI/gR++59p684Mj1RT
         G32qgG4yBzCbLOIivO50iKir6vK81/qR9c8RSb7jz1Y54UQiCScLmx1svKBrybSFr+1x
         qhM46QZPsZ4UQhTGoLV9uORNqinUMxWYpL5rms5KUbCQXdMWTNzDshbo5HLnLwV/9vB7
         ihSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=Qog3rYUL+Z48LXLUUkleMaGHE+rTAki6YlvbLu/7rWA=;
        b=c0nYBYUjlvzVUblS8/+U8eGWfdMnzYP/0EmgKQiU/UD7FhKJ1DkT5N8TKf+lCVJ6si
         TI2wGmk3SXUkM0INFG3wjgeu+fP6tXFMLSCy1CQSdy7QqMKffYP/40sxvD97OXUAeQFv
         EDc80bmYsaZPMlkZkUQCIP7vNioSaUsTwI0Nba6pOE9WTItSZsf+loqBrVit2I5D7Fjr
         HQyCzdPI1D46D+6iFnDPnWbPvfGTL5w5ANjivwmBSvJi+/etNKEFugITJ4P7qZWCNFSU
         ZiI7bvLIAQKLbAeLPFfwdb3trNlCLgUc6B+Jqtq6U1G/WzyTU1Hx6RDjWnVCwI3fXMxV
         qsuA==
X-Gm-Message-State: AOAM533YchGRom/p3L5tl1kLPdSyU6GQbU6iBQbVk7UMKiK5O6knjHFi
        /yXXDuCrrVkphqr/Uq+JM+g=
X-Google-Smtp-Source: ABdhPJwvtqDBItfvbi7kQDgsQE7zallrDgepKz+GstS0oeRdMfcsSpS64/HAZAGeCXCaUsYzd3nZZQ==
X-Received: by 2002:a05:6402:4255:: with SMTP id g21mr3343276edb.103.1623700315110;
        Mon, 14 Jun 2021 12:51:55 -0700 (PDT)
Received: from cpm12071.fritz.box ([79.140.114.214])
        by smtp.gmail.com with ESMTPSA id m18sm8182243ejx.56.2021.06.14.12.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:51:54 -0700 (PDT)
References: <20210610083916.96243-1-raykar.ath@gmail.com>
 <20210614125157.99426-1-raykar.ath@gmail.com>
 <20210614125157.99426-4-raykar.ath@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v4 3/3] submodule--helper: introduce add-config subcommand
In-reply-to: <20210614125157.99426-4-raykar.ath@gmail.com>
Message-ID: <gohp6kh7i0xm08.fsf@cpm12071.fritz.box>
Date:   Mon, 14 Jun 2021 21:51:53 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Atharva Raykar <raykar.ath@gmail.com> writes:

> ---
>  builtin/submodule--helper.c | 119 ++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  28 +--------
>  2 files changed, 120 insertions(+), 27 deletions(-)
>

I do not have enough expertise to judge the entire content of this
patch. I would like, however, to propose a slight code change for the
sake of readability.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 6dffaeb6cb..c4b2aa6537 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2935,6 +2935,124 @@ static int add_clone(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static void configure_added_submodule(struct add_data *add_data)
> +{
> +	char *key, *submod_pathspec = NULL;
> +	struct child_process add_submod = CHILD_PROCESS_INIT;
> +	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
> +	int pathspec_key_exists, activate = 0;
> +
> +	key = xstrfmt("submodule.%s.url", add_data->sm_name);
> +	git_config_set_gently(key, add_data->realrepo);
> +	free(key);
> +
> +	add_submod.git_cmd = 1;
> +	strvec_pushl(&add_submod.args, "add",
> +		     "--no-warn-embedded-repo", NULL);
> +	if (add_data->force)
> +		strvec_push(&add_submod.args, "--force");
> +	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
> +
> +	if (run_command(&add_submod))
> +		die(_("Failed to add submodule '%s'"), add_data->sm_path);
> +
> +	key = xstrfmt("submodule.%s.path", add_data->sm_name);
> +	config_set_in_gitmodules_file_gently(key, add_data->sm_path);
> +	free(key);

This above three lines of code is very similar to the two operations that
follows (including the one inside the `if (add_data->branch)`
condition. So [ ... ]

> +	key = xstrfmt("submodule.%s.url", add_data->sm_name);
> +	config_set_in_gitmodules_file_gently(key, add_data->repo);
> +	free(key);
> +	if (add_data->branch) {
> +		key = xstrfmt("submodule.%s.branch", add_data->sm_path);
> +		config_set_in_gitmodules_file_gently(key, add_data->branch);
> +		free(key);
> +	}
> +

[ ... ] it might be worth to write a small wrapper that will perform: (1)
`xstrfmt()` on the specified config section, (2) set the configuration
in the file and (3) free()'ing the variable inside the wrapper. Thus,
most of these code will become one liners that is easier to read (given
the function is properly named :) ).

After abstracting the code on the wrapper, this code will become
something like:


    function_properly_named("submodule.%s.path", add_data->sm_name, add_data->sm_path);
    function_properly_named("submodule.%s.url", add_data->sm_name, add_data->repo);
    if (add_data->branch)
         function_properly_named("submodule.%s.branch", add_data->sm_path, add_data->branch);


Just as an example, here's a diff to demonstrate the argument:

-- >8 --
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 65f79fbd53..48ea909f51 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2934,6 +2934,14 @@ static int add_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+void add_config_in_submodules_file(const char *keyfmt, const char *submodule,
+			  const char *value)
+{
+	char *key = xstrfmt(keyfmt, submodule);
+	config_set_in_gitmodules_file_gently(key, value);
+	free(key);
+}
+
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key, *submod_pathspec = NULL;
@@ -2955,17 +2963,10 @@ static void configure_added_submodule(struct add_data *add_data)
 	if (run_command(&add_submod))
 		die(_("Failed to add submodule '%s'"), add_data->sm_path);
 
-	key = xstrfmt("submodule.%s.path", add_data->sm_name);
-	config_set_in_gitmodules_file_gently(key, add_data->sm_path);
-	free(key);
-	key = xstrfmt("submodule.%s.url", add_data->sm_name);
-	config_set_in_gitmodules_file_gently(key, add_data->repo);
-	free(key);
-	if (add_data->branch) {
-		key = xstrfmt("submodule.%s.branch", add_data->sm_path);
-		config_set_in_gitmodules_file_gently(key, add_data->branch);
-		free(key);
-	}
+	add_config_in_submodules_file("submodule.%s.path", add_data->sm_name, add_data->sm_path);
+	add_config_in_submodules_file("submodule.%s.url", add_data->sm_name, add_data->repo);
+	if (add_data->branch)
+		add_config_in_submodules_file("submodule.%s.branch", add_data->sm_path, add_data->branch);
 
 	add_gitmodules.git_cmd = 1;
 	strvec_pushl(&add_gitmodules.args,

-- >8 --

A proper name than "add_config_in_submodules_file" should be considered - I'm
not very good in naming things.

These change does (should) not change the behavior of code, even though
I believe it make the code simpler to read, I do not have strong
opinions about it. So, take this proposal as you wish. 

-- 
Thanks
Rafael

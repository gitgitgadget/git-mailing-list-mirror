Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E878C54E49
	for <git@archiver.kernel.org>; Sun, 10 May 2020 11:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF66420820
	for <git@archiver.kernel.org>; Sun, 10 May 2020 11:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY8fxe/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgEJLOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 07:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbgEJLOn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 07:14:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C8DC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 04:14:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y16so17299wrs.3
        for <git@vger.kernel.org>; Sun, 10 May 2020 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X0IlwevixH0jtPnfB9KHUIC0kGNnup/hSo9TWDd8bIU=;
        b=dY8fxe/vuYWYFB2zd853AJ+IVjVfSy9EX8lyyvvm1zvFXTumJU67lySJx3McnLST2Q
         RrD85VkLEHe/S19qyJRbXrGxc5k3xFUV4PNv92j++afC/ygao25iNY4GGeLhvMBa62Pz
         Jg+LOtf3sHE0pUiHU+cUyJgw+d5EkgU+A3qzIR638Bb5gvNOjwqQf6pz6gc/wryklpo3
         tzrJq4eDWN4iuzI+mjMPT7rP1bE/k9Awe9A8owZLdwvtg/exDFnsrX3hB5dqPDNMkt7I
         yF8dmGmwEh13MKa9y+z8Ysvug/oGzSSb0JV187UMQ/PR37YTfcE9rMgl2sv559g/87Gp
         SlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X0IlwevixH0jtPnfB9KHUIC0kGNnup/hSo9TWDd8bIU=;
        b=pvlNVuEQEIF9iaeuenWxdUvzfcASmbO4NA8/G44QKmn/rztjgndfTmbtmIfVqKyVTe
         qRyewKt7whLDgrZxTO78+hR+KajftnkBNMvZKOPfYRNJLWblbsHTCOH6SL9mdJ06GFkA
         g9Oeg/tzN6UzI0kBw6AqcbZjRIJ0AQ1QRwUrcs21I1ETZUGzFceXqgfsk6qGxnwHu545
         UMD8bt5hcZw8eaxvs1vMQX07dbKDW/QO3CP+dBJPkakBT+BLuZR8LCSyt2x5e2lCuy2I
         33f3rXPpdJ68weoGYUxXSqMW0DJ52NRq5IBEvd3wNIprY3LXPkSU1RSPrcVT/HoUydyI
         sMQA==
X-Gm-Message-State: AGi0PuYCLITXSxGb8RiYYTKsMz/tubQUUgPSe9mwOys5Ll4dvFg6MsSW
        AfFmTi/44brhMSHoDsiNiNYvU4aV
X-Google-Smtp-Source: APiQypIytzid0zYTMGGnyjfm+S/tQ9d8bRO5uXkypN0QOcS7Tk91Ybf8hoDeijL4EEeq+VQFDM2lPw==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr12478805wrc.424.1589109281507;
        Sun, 10 May 2020 04:14:41 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-328-227.w86-199.abo.wanadoo.fr. [86.199.215.227])
        by smtp.gmail.com with ESMTPSA id d126sm1897003wmd.32.2020.05.10.04.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 04:14:41 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] rebase -i: support --ignore-date
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200429102521.47995-1-phillip.wood123@gmail.com>
 <20200429102521.47995-5-phillip.wood123@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7d72953e-83d2-b60e-1a61-f40fde841957@gmail.com>
Date:   Sun, 10 May 2020 13:14:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200429102521.47995-5-phillip.wood123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 29/04/2020 à 12:25, Phillip Wood a écrit :
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> As part of the on-going effort to retire the apply rebase backend
> teach the merge backend how to handle --ignore-date. We take care to
> handle the combination of --ignore-date and
> --committer-date-is-author-date in the same way as the apply backend.
> 
> Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-rebase.txt   |  7 +++--
>  builtin/rebase.c               | 13 +++++---
>  sequencer.c                    | 49 +++++++++++++++++++++++++++--
>  sequencer.h                    |  1 +
>  t/t3436-rebase-more-options.sh | 57 ++++++++++++++++++++++++++++++++++
>  5 files changed, 117 insertions(+), 10 deletions(-)
> 
> -%<-
>
> diff --git a/sequencer.c b/sequencer.c
> index 8dff8b9b95..339dbf4a59 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -150,6 +150,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>   */
>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>  static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
> +static GIT_PATH_FUNC(rebase_path_ignore_date, "rebase-merge/ignore_date")
>  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>  static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>  static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
> @@ -889,6 +890,24 @@ static const char *author_date_from_env_array(const struct argv_array *env)
>  	BUG("GIT_AUTHOR_DATE missing from author script");
>  }
>  
> +/* Construct a free()able author string with current time as the author date */
> +static char *ignore_author_date(const char *author)
> +{
> +	int len = strlen(author);
> +	struct ident_split ident;
> +	struct strbuf new_author = STRBUF_INIT;
> +
> +	if (split_ident_line(&ident, author, len) < 0) {
> +		error(_("malformed ident line '%s'"), author);
> +		return NULL;
> +	}

Nit: add an empty line here?

> +	len = ident.mail_end - ident.name_begin + 1;
> +
> +	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
> +	datestamp(&new_author);
> +	return strbuf_detach(&new_author, NULL);
> +}
> +
>  static const char staged_changes_advice[] =
>  N_("you have staged changes in your working tree\n"
>  "If these changes are meant to be squashed into the previous commit, run:\n"
> @@ -957,7 +976,11 @@ static int run_git_commit(struct repository *r,
>  
>  	if (opts->committer_date_is_author_date)
>  		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
> +				 opts->ignore_date ?
> +				 "" :
>  				 author_date_from_env_array(&cmd.env_array));
> +	if (opts->ignore_date)
> +		argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
>  

Perhaps this could be done in read_env_script(), too, instead of fixing
up what this function did right after calling it, twice?  Something like
this:

---- snip ----
index 339dbf4a59..3a7a80bab7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -840,11 +840,12 @@ int read_author_script(const char *path, char
**name, char **email, char **date,
 }

 /*
- * Read a GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL AND GIT_AUTHOR_DATE from a
- * file with shell quoting into struct argv_array. Returns -1 on
- * error, 0 otherwise.
+ * Read a GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE from a
+ * file with shell quoting into struct argv_array, and set
+ * GIT_COMMITTER_DATE if needed. Returns -1 on error, 0 otherwise.
  */
-static int read_env_script(struct argv_array *env)
+static int read_env_script(struct replay_opts *opts,
+                          struct argv_array *env)
 {
        char *name, *email, *date;

@@ -854,7 +855,17 @@ static int read_env_script(struct argv_array *env)

        argv_array_pushf(env, "GIT_AUTHOR_NAME=%s", name);
        argv_array_pushf(env, "GIT_AUTHOR_EMAIL=%s", email);
-       argv_array_pushf(env, "GIT_AUTHOR_DATE=%s", date);
+
+       if (opts->ignore_date) {
+               argv_array_push(env, "GIT_AUTHOR_DATE=");
+               argv_array_push(env, "GIT_COMMITTER_DATE=");
+       } else {
+               argv_array_pushf(env, "GIT_AUTHOR_DATE=%s", date);
+
+               if (opts->committer_date_is_author_date)
+                       argv_array_pushf(env, "GIT_COMMITTER_DATE=%s",
date);
+       }
+
        free(name);
        free(email);
        free(date);
---- snap ----

>  	argv_array_push(&cmd.args, "commit");
>  
> @@ -1386,7 +1409,8 @@ static int try_to_commit(struct repository *r,
>  		strbuf_addf(&date, "@%.*s %.*s",
>  			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
>  			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
> -		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
> +		res = setenv("GIT_COMMITTER_DATE",
> +			     opts->ignore_date ? "" : date.buf, 1);
>  		strbuf_release(&date);
>  
>  		if (res)
> @@ -1452,6 +1476,15 @@ static int try_to_commit(struct repository *r,
>  
>  	reset_ident_date();
>  
> +	if (opts->ignore_date) {
> +		author = ignore_author_date(author);
> +		if (!author) {
> +			res = -1;
> +			goto out;
> +		}
> +		free(author_to_free);
> +		author_to_free = (char *)author;
> +	}

Nit: add an empty line here?

Cheers,
Alban


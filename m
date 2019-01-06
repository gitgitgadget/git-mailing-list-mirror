Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB805211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 22:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfAFWrj (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 17:47:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39511 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfAFWrj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 17:47:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so41425517wra.6
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 14:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jU3AxeaOjeEXgWk5Cju/aGodYmyYZYIRDLnzDvelqQY=;
        b=S3xJ12bh7MrflePT4r0BnoKNLPth8iyCb8OSqdIg5WkpQ/1lcz25WKU721zHUUu3DQ
         VD1v2u+7JpWON2eQecpyN2YORON4lP3WSNNgAIciToqyaZ7be1Vcio07PYcBYJg90gRF
         1iAhMCBF6zG3gsxTnacubH6BTzpAhIFQZZwbdcBHbTqWoTzdzkQO50SHbXFn+XJSyMpE
         SzoQrRjZ8PYzM/8ch+X4S2rFIrogzTLEGLlisQImpMZDwizPY17Ntc9PpAGX/oo8lwDq
         ri8B8A+hh+dzL7cCleL3foKcVDk/KHWxTaC+HzaMvv5l8mFC+/TmdCq3R2VmfFsib9D7
         otXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jU3AxeaOjeEXgWk5Cju/aGodYmyYZYIRDLnzDvelqQY=;
        b=CokfMNhcv+4yYRockhSRKGoc0MD51SmAzzgzDNNb7xDj8OjRY5gRbXUogMQ3hQw2y1
         b4Sd3dH3U70yY6UpYQgR1pznRsB/Lq1hsZrISh2c6wpQTzjoi0ET/MNw2iRMNZ1tM6pE
         CDaQB9hpFUtD9U2OdNQqda/TMQPdeqpe3I8cgGJisuGvcc4R/Jcl2vmMedHpj0ngASY9
         GciUbWlzCMsWvpLzmWEiew0TcBo97LIY4/tQCy1BsuimJbh4JnSk+/sAsPdgMTnYIGxO
         e+0RgO+I5XtaEcDh0CwKbdeUOzNMeshJR68r2D1jJ+j1SdOCJAWqH11cIBB/Jypzcrdk
         vGfQ==
X-Gm-Message-State: AJcUukeomySNWJcOvRW+CPqe+AAO3Kww0BTBhTN4Sc58yZaTBklv3sOL
        e5HDkr/KzeTQRw6qebcM4P4=
X-Google-Smtp-Source: ALg8bN4yqjbTrii7UyKnmScZg3NUyLVCPxqK4SQnMiT9cfe05CL9+TNzhL/wNGmBq6WqppcAvjsX5Q==
X-Received: by 2002:adf:c108:: with SMTP id r8mr52274948wre.233.1546814857205;
        Sun, 06 Jan 2019 14:47:37 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id p6sm64735236wrx.50.2019.01.06.14.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 14:47:36 -0800 (PST)
Date:   Sun, 6 Jan 2019 22:47:35 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v12 21/26] stash: optimize `get_untracked_files()` and
 `check_changes()`
Message-ID: <20190106224735.GI25639@hank.intra.tgummerer.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
 <17f45e4bb48bdf9588d87c7b134afd703dbd69e6.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f45e4bb48bdf9588d87c7b134afd703dbd69e6.1545331726.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20, Paul-Sebastian Ungureanu wrote:
> This commits introduces a optimization by avoiding calling the
> same functions again. For example, `git stash push -u`
> would call at some points the following functions:
> 
>  * `check_changes()` (inside `do_push_stash()`)
>  * `do_create_stash()`, which calls: `check_changes()` and
> `get_untracked_files()`
> 
> Note that `check_changes()` also calls `get_untracked_files()`.
> So, `check_changes()` is called 2 times and `get_untracked_files()`
> 3 times.
> 
> The old function `check_changes()` now consists of two functions:
> `get_untracked_files()` and `check_changes_tracked_files()`.
> 
> These are the call chains for `push` and `create`:
> 
>  * `push_stash()` -> `do_push_stash()` -> `do_create_stash()`
> 
>  * `create_stash()` -> `do_create_stash()`
> 
> To prevent calling the same functions over and over again,
> `check_changes()` inside `do_create_stash()` is now placed
> in the caller functions (`create_stash()` and `do_push_stash()`).
> This way `check_changes()` and `get_untracked files()` are called
> only one time.
> 
> https://public-inbox.org/git/20180818223329.GJ11326@hank.intra.tgummerer.com/

I missed this the other time, but having this link in the commit
message is unnecessary, and it may go stale (though in this case it
includes the Message-ID, so it is still useful as long as some archive
exists.  The commit message explains well enough what this change is
doing, even without the link to the review.

Sorry I missed these things in the earlier rounds somehow.

> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash--helper.c | 53 +++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 19ead63c46..4b63352927 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -884,18 +884,18 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
>  }
>  
>  /*
> - * The return value of `check_changes()` can be:
> + * The return value of `check_changes_tracked_files()` can be:
>   *
>   * < 0 if there was an error
>   * = 0 if there are no changes.
>   * > 0 if there are changes.
>   */
> -static int check_changes(struct pathspec ps, int include_untracked)
> +

Unnecessary blank line after the comment here.

> +static int check_changes_tracked_files(struct pathspec ps)
>  {
>  	int result;
>  	struct rev_info rev;
>  	struct object_id dummy;
> -	struct strbuf out = STRBUF_INIT;
>  
>  	/* No initial commit. */
>  	if (get_oid("HEAD", &dummy))
> @@ -923,14 +923,26 @@ static int check_changes(struct pathspec ps, int include_untracked)
>  	if (diff_result_code(&rev.diffopt, result))
>  		return 1;
>  
> +	return 0;
> +}
> +
> +/*
> + * The function will fill `untracked_files` with the names of untracked files
> + * It will return 1 if there were any changes and 0 if there were not.
> + */
> +

Unnecessary blank line.

> +static int check_changes(struct pathspec ps, int include_untracked,
> +			 struct strbuf *untracked_files)
> +{
> +	int ret = 0;
> +	if (check_changes_tracked_files(ps))
> +		ret = 1;
> +
>  	if (include_untracked && get_untracked_files(ps, include_untracked,
> -						     &out)) {
> -		strbuf_release(&out);
> -		return 1;
> -	}
> +						     untracked_files))
> +		ret = 1;
>  
> -	strbuf_release(&out);
> -	return 0;
> +	return ret;
>  }
>  
>  static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
> @@ -1141,7 +1153,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
>  		head_commit = lookup_commit(the_repository, &info->b_commit);
>  	}
>  
> -	if (!check_changes(ps, include_untracked)) {
> +	if (!check_changes(ps, include_untracked, &untracked_files)) {
>  		ret = 1;
>  		goto done;
>  	}
> @@ -1166,8 +1178,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
>  		goto done;
>  	}
>  
> -	if (include_untracked && get_untracked_files(ps, include_untracked,
> -						     &untracked_files)) {
> +	if (include_untracked) {
>  		if (save_untracked_files(info, &msg, untracked_files)) {
>  			if (!quiet)
>  				fprintf_ln(stderr, _("Cannot save "
> @@ -1252,20 +1263,15 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  			     0);
>  
>  	memset(&ps, 0, sizeof(ps));
> -	strbuf_addstr(&stash_msg_buf, stash_msg);
> -	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
> -			      NULL, 0);
> +	if (!check_changes_tracked_files(ps))
> +		return 0;
>  
> -	if (!ret)
> +	strbuf_addstr(&stash_msg_buf, stash_msg);
> +	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))

It's a bit odd to have do_create_stash moved inside the if here, even
though it was introduced in this patch series.  It makes the patch a
bit more noisy and harder to see what was changed here.

>  		printf_ln("%s", oid_to_hex(&info.w_commit));
>  
>  	strbuf_release(&stash_msg_buf);
> -
> -	/*
> -	 * ret can be 1 if there were no changes. In this case, we should
> -	 * not error out.
> -	 */
> -	return ret < 0;
> +	return ret;
>  }
>  
>  static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
> @@ -1275,6 +1281,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
>  	struct stash_info info;
>  	struct strbuf patch = STRBUF_INIT;
>  	struct strbuf stash_msg_buf = STRBUF_INIT;
> +	struct strbuf untracked_files = STRBUF_INIT;

Does this strbuf also need to be released at the end of the function?

>  
>  	if (patch_mode && keep_index == -1)
>  		keep_index = 1;
> @@ -1309,7 +1316,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
>  		goto done;
>  	}
>  
> -	if (!check_changes(ps, include_untracked)) {
> +	if (!check_changes(ps, include_untracked, &untracked_files)) {
>  		if (!quiet)
>  			printf_ln(_("No local changes to save"));
>  		goto done;
> -- 
> 2.20.1.441.g764a526393
> 

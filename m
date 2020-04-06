Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C15C2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ED92487E
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFKep/4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgDFPIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:08:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35990 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgDFPIB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 11:08:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id d202so16275489wmd.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8d/AYYvZ3FndBdE2CzrM33kI53iggDSfCyP+iHhvJPQ=;
        b=pFKep/4KqzIoO9bewruQGUrnksr0kqPOZoJFITvF1fL+MCJetlv/kW5dia5OCnbsML
         SO6Zv3aOhpAFC9XK9H6Yvc29BqXpEljiMtX7qtcWF/Pp9n6YMMzvvmgQecW6hA1chP/M
         dpgpEJwN2ECKrHhp259D1E+tbUMJr+ppQGmqn5scBQdDP1Lt8LEUM2a/GPRx9HP0UA6Y
         0yAzQTMyE1gDws8T1i/FhmWa4hk072ZHcWB9W3zaGFvZjgUju1jvoOto/wGxAX5YT20k
         insU3cfphB6xWy/nTqHhvrYRSx5VnnDGAW0GFXjj2X2QDU249IGc8MnQBDQADIzRq31j
         YjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8d/AYYvZ3FndBdE2CzrM33kI53iggDSfCyP+iHhvJPQ=;
        b=Cet40jbRxO3tBtnpaz73/WvGFBMBO3Hm8cflp+Mv1V/91x9b+pg+ffLJCqXhu4oUEL
         Nm6wk7/hk28H1NFDlMyRXuQfLRmE5ZXSU+SOoYX2eC38sETs7rfFqbEeyB7YGoI5VacR
         BFPZ7e0SlsKwB4vPyR27NMy5gzu7eUgZdF4Sr+ERl1nH2twxxDaZeGSIrgMsad0THkUQ
         O+kAvAXg5+vA3SY5gbRh+Byt692p0I8JReEpfP+qpfA2pwjOdGocwFbwDe4ykf3KE+t/
         JFhNgioTWm/b61L7lF0P7ou/Gazzub1eBpxRdPyEKuIDHVfgSo5lIU0M67joMhdh3mLP
         3zwQ==
X-Gm-Message-State: AGi0PuYVVSYkJDKxIzI4exDSJbc03I5L+Rkja3eWWTJqFpd+ixceIjCq
        4X4S+iQ7aWLdq1fKZmexrcI=
X-Google-Smtp-Source: APiQypJsNudpvVWRxt+Qkg0Zyeeo4SA3gvx0qHw9WdBqQ/9qSf1IeXgo2ZSi2InP24UUojgn9/O+iA==
X-Received: by 2002:a05:600c:2c04:: with SMTP id q4mr134682wmg.7.1586185679855;
        Mon, 06 Apr 2020 08:07:59 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id f4sm9422524wrp.80.2020.04.06.08.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:07:59 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 10/23] sequencer: make apply_rebase() accept a path
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1584782450.git.liu.denton@gmail.com>
 <cover.1585962672.git.liu.denton@gmail.com>
 <e0b8e409afbf8d90b4fc6406a67a1a1e930e022f.1585962673.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <09c74578-9d25-b4d9-8808-4a6a9f92e918@gmail.com>
Date:   Mon, 6 Apr 2020 16:07:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e0b8e409afbf8d90b4fc6406a67a1a1e930e022f.1585962673.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 04/04/2020 02:11, Denton Liu wrote:
> In order to make apply_rebase()

I think you mean apply_autostash() (in the subject as well)

Best Wishes

Phillip

> more generic for future extraction, make
> it accept a `path` argument so that the location from where to read the
> reference to the autostash commit can be customized. Remove the `opts`
> argument since it was unused before anyway.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   sequencer.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index d1d59867ae..ae9efe5825 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3649,13 +3649,13 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
>   	return -1;
>   }
>   
> -static int apply_autostash(struct replay_opts *opts)
> +static int apply_autostash(const char *path)
>   {
>   	struct strbuf stash_sha1 = STRBUF_INIT;
>   	struct child_process child = CHILD_PROCESS_INIT;
>   	int ret = 0;
>   
> -	if (!read_oneliner(&stash_sha1, rebase_path_autostash(),
> +	if (!read_oneliner(&stash_sha1, path,
>   			   READ_ONELINER_SKIP_IF_EMPTY)) {
>   		strbuf_release(&stash_sha1);
>   		return 0;
> @@ -3748,7 +3748,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>   		return error(_("%s: not a valid OID"), orig_head);
>   
>   	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
> -		apply_autostash(opts);
> +		apply_autostash(rebase_path_autostash());
>   		sequencer_remove_state(opts);
>   		return error(_("could not detach HEAD"));
>   	}
> @@ -4061,7 +4061,7 @@ static int pick_commits(struct repository *r,
>   				run_command(&hook);
>   			}
>   		}
> -		apply_autostash(opts);
> +		apply_autostash(rebase_path_autostash());
>   
>   		if (!opts->quiet) {
>   			if (!opts->verbose)
> @@ -5070,7 +5070,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		todo_list_add_exec_commands(todo_list, commands);
>   
>   	if (count_commands(todo_list) == 0) {
> -		apply_autostash(opts);
> +		apply_autostash(rebase_path_autostash());
>   		sequencer_remove_state(opts);
>   
>   		return error(_("nothing to do"));
> @@ -5081,12 +5081,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   	if (res == -1)
>   		return -1;
>   	else if (res == -2) {
> -		apply_autostash(opts);
> +		apply_autostash(rebase_path_autostash());
>   		sequencer_remove_state(opts);
>   
>   		return -1;
>   	} else if (res == -3) {
> -		apply_autostash(opts);
> +		apply_autostash(rebase_path_autostash());
>   		sequencer_remove_state(opts);
>   		todo_list_release(&new_todo);
>   
> 

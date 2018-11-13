Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB0E1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 09:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbeKMToE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 14:44:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53267 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbeKMToE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 14:44:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 306C510FE0E;
        Tue, 13 Nov 2018 04:46:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NlX5GRx1B+1r1FeY/aMAfyR2Jzc=; b=Qn8loU
        NpFNbGvOyBzSugl8nM+MFKNbM9y/xJghMIs7hxTTDZsjsk5QBWG7YHzmacWhVWzH
        VAqF8TWRTYbXaWGzuNVozLgO07wtOC6g4nudAfTD+iX4ZJBax3zi+bRRBCxBx0/M
        rztEA5oMbsimPK8zEzqE80yEEIxJoaK+7KpmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OCB5tANzMiyR7WFBY6UqJtP/AK6cIK6E
        cgg3TCVmNfza6GR8bGAaSEe2jeElPHdMvqQsK20Lz4IrzsLrjz7zAPc+uLEnwgF2
        mBY1rDFzGVTqqm92p68GT3+487kYJmz9kRIm1bVxLXgZj5zzJPjn3AHpGJE8Ele3
        72Kct9iWQq4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29A5410FE0C;
        Tue, 13 Nov 2018 04:46:42 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96E3510FE0B;
        Tue, 13 Nov 2018 04:46:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: Re: [PATCH v3] remote: add --save-to-push option to git remote set-url
References: <xmqqin1754c5.fsf@gitster-ct.c.googlers.com>
        <8fded8b84b593497177de740f80b3499c4269758.1541740174.git.liu.denton@gmail.com>
Date:   Tue, 13 Nov 2018 18:46:40 +0900
In-Reply-To: <8fded8b84b593497177de740f80b3499c4269758.1541740174.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 9 Nov 2018 00:20:02 -0500")
Message-ID: <xmqqy39xux6n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06117104-E729-11E8-A0BA-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This adds the --save-to-push option to `git remote set-url` such that
> when executed, we move the remote.*.url to remote.*.pushurl and set
> remote.*.url to the given url argument.
>
> For example, if we have the following config:
>
> 	[remote "origin"]
> 		url = git@github.com:git/git.git
>
> `git remote set-url --save-to-push origin https://github.com/git/git.git`
> would change the config to the following:
>
> 	[remote "origin"]
> 		url = https://github.com/git/git.git
> 		pushurl = git@github.com:git/git.git
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> On Fri, Nov 09, 2018 at 12:15:22PM +0900, Junio C Hamano wrote:
>> This sounds more like "saving to push" (i.e. what you are saving is
>> the existing "url" and the "push" is a shorthand for "pushURL",
>> which is the location the old value of "url" is aved to), not "save
>> (the) push(URL)".  So if adding this option makes sense, I would say
>> "--save-to-push" (or even "--save-to-pushURL") may be a more
>> appropriate name for it.
>> 
>
> My original intention was for it to mean "save push behavior" but I
> agree with you that it's unclear so I'm changing it to --save-to-push.
>
>> Ambigous in what way?  You asked the current URL to be saved as a
>> pushURL, so existing pushURL destinations should not come into play,
>> I would think.  If there are more than one URL (not pushURL), on the
>> other hand, I think you have a bigger problem (where would "git fetch"
>> fetch from, and how would these multiple URLs are prevented from
>> trashing refs/remotes/$remote/* with each other's refs?), so
>> stopping the operation before "set-url" makes the problem worse is
>> probably a good idea, but I think that is true with or without this
>> new option.
>> 
>
>> I _think_ in the future (if this option turns out to be widely used)
>> people may ask for this condition to be loosened somewhat, but it is
>> relatively easy to start restrictive and then to loosen later, so I
>> think this is OK for now.
>> 
>
> I agree, there's no reason why we shouldn't allow appending to the push
> URLs if one already exists so I removed that removed that restriction.
> ---
>  Documentation/git-remote.txt |  5 +++++
>  builtin/remote.c             | 26 +++++++++++++++++++++-----
>  t/t5505-remote.sh            | 11 +++++++++++
>  3 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 0cad37fb81..8f9d700252 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -19,6 +19,7 @@ SYNOPSIS
>  'git remote set-url' [--push] <name> <newurl> [<oldurl>]
>  'git remote set-url --add' [--push] <name> <newurl>
>  'git remote set-url --delete' [--push] <name> <url>
> +'git remote set-url --save-to-push' <name> <url>
>  'git remote' [-v | --verbose] 'show' [-n] <name>...
>  'git remote prune' [-n | --dry-run] <name>...
>  'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
> @@ -155,6 +156,10 @@ With `--delete`, instead of changing existing URLs, all URLs matching
>  regex <url> are deleted for remote <name>.  Trying to delete all
>  non-push URLs is an error.
>  +
> +With `--save-to-push`, the current URL is saved into the push URL before
> +setting the URL to <url>. Note that this command will not work if more than one
> +URL is defined because the behavior would be ambiguous.
> ++
>  Note that the push URL and the fetch URL, even though they can
>  be set differently, must still refer to the same place.  What you
>  pushed to the push URL should be what you would see if you
> diff --git a/builtin/remote.c b/builtin/remote.c
> index f7edf7f2cb..3249c3face 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -24,8 +24,9 @@ static const char * const builtin_remote_usage[] = {
>  	N_("git remote set-branches [--add] <name> <branch>..."),
>  	N_("git remote get-url [--push] [--all] <name>"),
>  	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
> -	N_("git remote set-url --add <name> <newurl>"),
> -	N_("git remote set-url --delete <name> <url>"),
> +	N_("git remote set-url --add [--push] <name> <newurl>"),
> +	N_("git remote set-url --delete [--push] <name> <url>"),
> +	N_("git remote set-url --save-to-push <name> <url>"),
>  	NULL
>  };
>  
> @@ -77,8 +78,9 @@ static const char * const builtin_remote_geturl_usage[] = {
>  
>  static const char * const builtin_remote_seturl_usage[] = {
>  	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
> -	N_("git remote set-url --add <name> <newurl>"),
> -	N_("git remote set-url --delete <name> <url>"),
> +	N_("git remote set-url --add [--push] <name> <newurl>"),
> +	N_("git remote set-url --delete [--push] <name> <url>"),
> +	N_("git remote set-url --save-to-push <name> <url>"),
>  	NULL
>  };
>  
> @@ -1519,7 +1521,7 @@ static int get_url(int argc, const char **argv)
>  
>  static int set_url(int argc, const char **argv)
>  {
> -	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
> +	int i, push_mode = 0, save_to_push = 0, add_mode = 0, delete_mode = 0;
>  	int matches = 0, negative_matches = 0;
>  	const char *remotename = NULL;
>  	const char *newurl = NULL;
> @@ -1532,6 +1534,8 @@ static int set_url(int argc, const char **argv)
>  	struct option options[] = {
>  		OPT_BOOL('\0', "push", &push_mode,
>  			 N_("manipulate push URLs")),
> +		OPT_BOOL('\0', "save-to-push", &save_to_push,
> +			 N_("change fetching URL behavior")),
>  		OPT_BOOL('\0', "add", &add_mode,
>  			 N_("add URL")),
>  		OPT_BOOL('\0', "delete", &delete_mode,
> @@ -1543,6 +1547,8 @@ static int set_url(int argc, const char **argv)
>  
>  	if (add_mode && delete_mode)
>  		die(_("--add --delete doesn't make sense"));
> +	if (save_to_push && (push_mode || add_mode || delete_mode))
> +		die(_("--save-to-push cannot be used with other options"));
>  
>  	if (argc < 3 || argc > 4 || ((add_mode || delete_mode) && argc != 3))
>  		usage_with_options(builtin_remote_seturl_usage, options);
> @@ -1564,6 +1570,16 @@ static int set_url(int argc, const char **argv)
>  		urlset = remote->pushurl;
>  		urlset_nr = remote->pushurl_nr;
>  	} else {
> +		if (save_to_push) {
> +			if (remote->url_nr != 1)
> +				die(_("--save-to-push can only be used when only one url is defined"), remotename);

Unused parameter "remotename" is fed to die().  I'll drop this.

> +
> +			strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
> +			git_config_set_multivar(name_buf.buf,
> +			      remote->url[0], "^$", 0);
> +			strbuf_reset(&name_buf);
> +		}
> +
>  		strbuf_addf(&name_buf, "remote.%s.url", remotename);
>  		urlset = remote->url;
>  		urlset_nr = remote->url_nr;
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index d2a2cdd453..434c1f828a 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -1194,6 +1194,17 @@ test_expect_success 'remote set-url --delete baz' '
>  	cmp expect actual
>  '
>  
> +test_expect_success 'remote set-url --save-to-push bbb' '
> +	git remote set-url --save-to-push someremote bbb &&
> +	echo bbb >expect &&
> +	echo "YYY" >>expect &&
> +	echo ccc >>expect &&
> +	git config --get-all remote.someremote.url >actual &&
> +	echo "YYY" >>actual &&
> +	git config --get-all remote.someremote.pushurl >>actual &&
> +	cmp expect actual
> +'
> +
>  test_expect_success 'extra args: setup' '
>  	# add a dummy origin so that this does not trigger failure
>  	git remote add origin .

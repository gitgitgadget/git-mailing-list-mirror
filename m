Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09298C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 01:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69D361186
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 01:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhHGBhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 21:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhHGBhR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 21:37:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D397C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 18:37:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hw6so18099387ejc.10
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 18:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wOB7br1rtvlxuQM5Npz1ABbzMDpt/ycqLs8c0epd0gE=;
        b=hy0VPFpwkmsSAQ065GVbfMqpp+pfjEWooDf/vlbMWypfToSwozjJB93sTlD34XfzfW
         8pBkLOqxvaLZzgqojAhQkW6zSQIHyv+lsMPUGmulseF6dyhhTyPSmTE3ghK8n5sHohKi
         U8TP6fdGMPLiSF5qVXBOQX03q6AktjrBU6F2tMROeMPRJKZRSyPQWIU9nMHzCTHX+YC5
         AdApjkTY3YZNp2FaOOFvT5FaSZ0uye2Rdxb4pLeTT290b2Hac9D2kPaDJj8vdMXYiXZD
         1zNJjn4TtcOxcAMWPQgBytCxyHEaz7Iv+xrZamW+HwSTjXwpatFxrzmZyAv9ZX014sT7
         xiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wOB7br1rtvlxuQM5Npz1ABbzMDpt/ycqLs8c0epd0gE=;
        b=J3qxfruHIm3tBZWSPN1C2ZKrmMAVw410+hJs7Hu8cI5wkladuxXYPbkCbdY/WLPgoa
         uZgU53HzxXfRnNZWC3/67WyCUzaJcBRJ+liFwH5QWCeiOiDs3xqGpVO6EX4YSX6p34zN
         EaPEa8aTF4bavE6RsPEoVBR+umQJSZilSRcr/w+mDCicfAcoUalR5eAUyqX06ya6CK2d
         4+aWE132EoXerg3tWONzbugr0Iui8uaOog6pS98VCl9g3tfmEh8Wld655XM1CeDeSLiP
         punqt4Cc53SQB7eORn0kNdfPYTm517WM1nHb+cVxRqWVsY4FD7EorAotuULOhQw5glxZ
         k5zQ==
X-Gm-Message-State: AOAM533aGytUcED2kAWkAdkzBN5HlSYNnEP33wO4D3sLDtnaA8Tcbtgh
        dsbC12vXB4QDblk9AgsyO08=
X-Google-Smtp-Source: ABdhPJwh0SEvtePDqsb5aIQfhT6SVClxzqI4k+L1ipU2jb06Hl41VM7zP2iLk50igbdeV27GrBxRWQ==
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr12581911ejc.523.1628300218876;
        Fri, 06 Aug 2021 18:36:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b15sm3344214ejv.15.2021.08.06.18.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 18:36:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport: no warning if no server wait-for-done
Date:   Sat, 07 Aug 2021 03:31:01 +0200
References: <20210806214612.1501980-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210806214612.1501980-1-jonathantanmy@google.com>
Message-ID: <87eeb6yr0m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 06 2021, Jonathan Tan wrote:

> When the push.negotiate configuration variable was implemented in
> 477673d6f3 ("send-pack: support push negotiation", 2021-05-05), Git was
> taught to print warning messages whenever that variable was set to true
> but push negotiation didn't happen. However, the lack of push
> negotiation is more similar to things like the usage of protocol v2 - in
> which the new feature is desired for performance, but if the feature
> is not there, the user does not intend to take any action - than to
> things like the usage of --filter - in which the new feature is desired
> for a certain outcome, and if the outcome does not happen, there is a
> high chance that the user would need to do something else (in this case,
> for example, reclone with "--depth" if the user needs the disk space).
>
> Therefore, when pushing with push.negotiate set to true, do not warn if
> wait-for-done is not supported for any reason (e.g. if the server is
> using an older version of Git or if protocol v2 is deactivated on the
> server). This is done by using an internal-use-only parameter to "git
> fetch".

Tangentally related (the alternative was to start a thread on some
2018-era patch of yours): Is it intentional that when you supply a
gibberish OID or a nonexisting one as an explicit negotiation tip we
don't even warn about it?

Looking at the history of fetch-pack.c I suspect not. It goes back to
ec06283844a (fetch-pack: introduce negotiator API, 2018-06-14), i.e. the
"o && o->type == OBJ_COMMIT" check, now "if (c)" (as in could we look up
a commit) on "master". That in turn seems to go back as far as
9534f40bc42 (Be careful when dereferencing tags., 2005-11-02).

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fetch.c       |  8 +++++++-
>  send-pack.c           | 11 +++--------
>  t/t5516-fetch-push.sh |  3 +--
>  transport.c           |  6 ++++--
>  transport.h           |  6 ++++++
>  5 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 25740c13df..940d650aba 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -84,6 +84,7 @@ static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
>  static int fetch_write_commit_graph = -1;
>  static int stdin_refspecs = 0;
>  static int negotiate_only;
> +static int negotiate_only_failure_ok;
>  
>  static int git_fetch_config(const char *k, const char *v, void *cb)
>  {
> @@ -208,6 +209,8 @@ static struct option builtin_fetch_options[] = {
>  			N_("report that we have only objects reachable from this object")),
>  	OPT_BOOL(0, "negotiate-only", &negotiate_only,
>  		 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
> +	OPT_BOOL(0, "negotiate-only-failure-ok", &negotiate_only_failure_ok,
> +		 N_("for internal use only: if --negotiate-only fails, do not print a warning message")),
>  	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
>  	OPT_BOOL(0, "auto-maintenance", &enable_auto_gc,
>  		 N_("run 'maintenance --auto' after fetching")),
> @@ -2059,8 +2062,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		gtransport = prepare_transport(remote, 1);
>  		if (gtransport->smart_options) {
>  			gtransport->smart_options->acked_commits = &acked_commits;
> +			gtransport->smart_options->negotiate_only_failure_ok =
> +				negotiate_only_failure_ok;
>  		} else {
> -			warning(_("Protocol does not support --negotiate-only, exiting."));
> +			if (!negotiate_only_failure_ok)
> +				warning(_("Protocol does not support --negotiate-only, exiting."));
>  			return 1;

But we still want to "return 1" here and not proceed with the fetch?, ah
yes, because we run this via send-pack.c below...

>  		}
>  		if (server_options.nr)
> diff --git a/send-pack.c b/send-pack.c
> index 5a79e0e711..020fd0b265 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -424,7 +424,8 @@ static void get_commons_through_negotiation(const char *url,
>  	child.git_cmd = 1;
>  	child.no_stdin = 1;
>  	child.out = -1;
> -	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
> +	strvec_pushl(&child.args, "fetch", "--negotiate-only",
> +		     "--negotiate-only-failure-ok", NULL);
>  	for (ref = remote_refs; ref; ref = ref->next)
>  		strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
>  	strvec_push(&child.args, url);
> @@ -447,13 +448,7 @@ static void get_commons_through_negotiation(const char *url,
>  		oid_array_append(commons, &oid);
>  	} while (1);
>  
> -	if (finish_command(&child)) {
> -		/*
> -		 * The information that push negotiation provides is useful but
> -		 * not mandatory.
> -		 */
> -		warning(_("push negotiation failed; proceeding anyway with push"));
> -	}
> +	finish_command(&child);
>  }
>  
>  int send_pack(struct send_pack_args *args,
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 0916f76302..60b377edf2 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -222,8 +222,7 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
>  	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
>  	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
>  		git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
> -	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
> -	test_i18ngrep "push negotiation failed" err
> +	grep_wrote 5 event # 2 commits, 2 trees, 1 blob
>  '
>  
>  test_expect_success 'push without wildcard' '
> diff --git a/transport.c b/transport.c
> index 17e9629710..913fc0f8e4 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -397,10 +397,12 @@ static int fetch_refs_via_pack(struct transport *transport,
>  
>  	if (data->options.acked_commits) {
>  		if (data->version < protocol_v2) {
> -			warning(_("--negotiate-only requires protocol v2"));
> +			if (!data->options.negotiate_only_failure_ok)
> +				warning(_("--negotiate-only requires protocol v2"));
>  			ret = -1;
>  		} else if (!server_supports_feature("fetch", "wait-for-done", 0)) {
> -			warning(_("server does not support wait-for-done"));
> +			if (!data->options.negotiate_only_failure_ok)
> +				warning(_("server does not support wait-for-done"));
>  			ret = -1;
>  		} else {
>  			negotiate_using_fetch(data->options.negotiation_tips,
> diff --git a/transport.h b/transport.h
> index 1cbab11373..98c90b46df 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -53,6 +53,12 @@ struct git_transport_options {
>  	 * common commits to this oidset instead of fetching any packfiles.
>  	 */
>  	struct oidset *acked_commits;
> +
> +	/*
> +	 * If the server does not support wait-for-done, do not print any
> +	 * warning messages.
> +	 */
> +	unsigned negotiate_only_failure_ok : 1;
>  };
>  
>  enum transport_family {

I find myself wondering if a new option for this, or if --negotiate-only
shouldn't just pay attention to the existing --quiet and --verbose
options, depending. We already pass that down to this level through the
transport struct you're changing.

So since we're running a one-off special command here why not just pass
--quiet and check args.quiet in fetch_refs_via_pack() before emitting
the warning()? Ditto for fetch itself...

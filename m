Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984AAC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A251613C0
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhD0J6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhD0J6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:58:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53DC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:57:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ja3so12770894ejc.9
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pXCHF3ge/0ASV5WMiG5b2z3DR7HnBbTMQVvktfGCNSE=;
        b=nFGILYqP8ntZZ6ebj2AwGjoGtGbPqqsnjzxdCOJD1ZSsX2C9suZGEwEeFwLUMr358j
         yOMsbYqslqBD29yP0qxRct7BudSY1rwEsCI7aNG5auqyyRuaVJDsWVcw5EyqBM2GB8Zi
         AXqJUUTqHZHD1cG2y6lZqfuYu/ZQmZWF2oCpY3ozZtoPv4dYEZgdE71FG/hQ2+nnrBBY
         f5KEYxqXHOjngBGBZ6iKZa+ZTdl8hDx4vO91gQH0PYGknL0RsUYnLwPQI5dDiF0GvDQB
         p57bxOTjvkHsK772vjN39xMLj3hpARIaVhvJeLRI3mIlXVyVvvTUgC7kvDw4OL5aS4wY
         QdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pXCHF3ge/0ASV5WMiG5b2z3DR7HnBbTMQVvktfGCNSE=;
        b=FtyeceMgdT6Lohijlh1byASCoCTo6TzCCGJkMKNWlqVllN3G9dn4ko68R4ywxgzLUr
         93EDQnpYAO+uEQRJayHL15BDOIHS4bx6aXDSIXq/MKK2pOgreGb3P2Vh/J7dXo3zDTHF
         xNAEOxLEKrLHvKXopyVaK0gJZeuzZiqK73soq4MirFQOZicgKU5b5uXEdSTZtqSevxF0
         /Cz52YSBV4JjzlCiwUyHFG68M4/Oay+gij9R95aqv0PRkfvENzm9d95yJhWoo+B7henu
         hpwWUgXMn/nBSl9Fs0XLEc8+pyyPtw8opyVPtyx01mAAwr4rvM+dC5uTxdJdFBPD4TVd
         PHIw==
X-Gm-Message-State: AOAM5327uggBg27n/bJzJwCMlc96FM2dBa7BIIZukRdzPEk6O05jxe8d
        jViV0gnyfxV9BMfW23GvjCzOL+SQvlw=
X-Google-Smtp-Source: ABdhPJwp9kSVng2+AoigsL9GJv036sxa/H79m7BCSu4lwNtH52cjdf2Fb86+LpbKfxe3GBRnvn3E1w==
X-Received: by 2002:a17:906:a1c5:: with SMTP id bx5mr23556556ejb.166.1619517454849;
        Tue, 27 Apr 2021 02:57:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g11sm1967962edw.37.2021.04.27.02.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 02:57:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/23] fsmonitor: introduce `core.useBuiltinFSMonitor`
 to call the daemon via IPC
Date:   Tue, 27 Apr 2021 11:20:56 +0200
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <7082528d8f7c1afa33e1146e3d274e044735f6a1.1617291666.git.gitgitgadget@gmail.com>
 <f77457d0-925d-2ea1-4ad4-b3315532b37f@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <f77457d0-925d-2ea1-4ad4-b3315532b37f@gmail.com>
Message-ID: <87mttkyrqq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 26 2021, Derrick Stolee wrote:

> On 4/1/21 11:40 AM, Johannes Schindelin via GitGitGadget wrote:> @@ -2515,6 +2515,11 @@ int git_config_get_max_percent_split_change(void)
>>  
>>  int repo_config_get_fsmonitor(struct repository *r)
>>  {
>> +	if (r->settings.use_builtin_fsmonitor > 0) {
>
> Don't forget to run prepare_repo_settings(r) first.
>
>> +		core_fsmonitor = "(built-in daemon)";
>> +		return 1;
>> +	}
>> +
>
> I found this odd, assigning a string to core_fsmonitor that
> would definitely cause a problem trying to execute it as a
> hook. I wondered the need for it at all, but found that
> there are several places in the FS Monitor subsystem that use
> core_fsmonitor as if it was a boolean, indicating whether or
> not the feature is enabled at all.
>
> A cleaner way to handle this would be to hide the data behind
> a helper method, say "fsmonitor_enabled()" that could then
> check a value on the repository (or index) and store the hook
> value as a separate value that is only used by the hook-based
> implementation.
>
> It's probably a good idea to do that cleanup now, before we
> find on accident that we missed a gap and start trying to run
> this bogus string as a hook invocation.
>> -static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
>> +static int query_fsmonitor(int version, struct index_state *istate, struct strbuf *query_result)
>>  {
>> +	struct repository *r = istate->repo ? istate->repo : the_repository;
>> +	const char *last_update = istate->fsmonitor_last_update;
>>  	struct child_process cp = CHILD_PROCESS_INIT;
>>  	int result;
>>  
>>  	if (!core_fsmonitor)
>>  		return -1;
>
> Here is an example of it being used as a boolean.
>
>> +	if (r->settings.use_builtin_fsmonitor > 0) {
>> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>> +		return fsmonitor_ipc__send_query(last_update, query_result);
>> +#else
>> +		/* Fake a trivial response. */
>> +		warning(_("fsmonitor--daemon unavailable; falling back"));
>> +		strbuf_add(query_result, "/", 2);
>> +		return 0;
>> +#endif
>
> This seems like a case where the helper fsmonitor_ipc__is_supported()
> could be used instead of compile-time macros.
>
> (I think this is especially true when we consider the future of the
> feature on Linux and the possibility of the same compiled code needing
> to check run-time properties of the platform for compatibility.)
>
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -58,6 +58,9 @@ void prepare_repo_settings(struct repository *r)
>>  		r->settings.core_multi_pack_index = value;
>>  	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
>>  
>> +	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && value)
>> +		r->settings.use_builtin_fsmonitor = 1;
>> +
>
> Follows the patterns of repo settings. Good.

It follows the pattern, but as an aside the pattern seems bit odd. I see
it dates back to your 7211b9e7534 (repo-settings: consolidate some
config settings, 2019-08-13).

I.e. we memset() the whole thing to -1, then for most things do something like:

    if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
        r->settings.gc_write_commit_graph = value;
    UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);

But could do:

    if (repo_config_get_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph))
        r->settings.gc_write_commit_graph = 1;

No? I.e. the repo_config_get_bool() function already returns non-zero if
we don't find it in the config.

I see the UPDATE_DEFAULT_BOOL() macro has also drifted from "set thing
default boolean" to "set any default value".

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AA2C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 11:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiGSLyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 07:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGSLyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 07:54:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B4402F3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 04:54:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so19232376edc.4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=l/MXxI2QhwdJAOXpb0UpRRvzo1/caCP1zzxowlmcF2s=;
        b=UGg4VaArty/UdLWa567NkrtJEinx7l2xV3kYLIA3zfpj4+T0qfm26+fQ5W4CtH68yo
         em0ENIdQtq00XUYnlmiiMArOAZPYmaArM/TUdtw8dBNwc3uQijVoSDYTialDpTJnPUvC
         5bzDlBTjjJt3bfe+/scJV4TcMuQb0CTNIoutidSheh3vBb838oxhFWmGI3Ep9C/IUK0T
         o3lJBi25sRQoAFb+Y3bYQpgJkF+MdQC3vQt2XrqJ3+/4n3IhU6Or0hPjE99NOlxltTPW
         A22gJzasZNbI1cp6MbQjSYyOU6gCA/Z/IVtI6h7vBzp8FjWet/7ZSTDCmf942cXCYsNH
         /CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=l/MXxI2QhwdJAOXpb0UpRRvzo1/caCP1zzxowlmcF2s=;
        b=m+Y/dxmbRKj7EOD1kzR3GQPiHeyhILZT5cNoFFlZ7BmGnF7G5QZGAVhLXG/1h7lJ7u
         T2jXb6Lj511y/hCYRlduDPvn+q6FJ4sveKQmzgi7PtBhl7GnVAC89RxL3sXefMroPZXE
         pPGGKzukYrUYj6WFZQyW8+d3ij1wlLz/DRSGfV5ci/y0F5K+1LNF37DBul1rsH6cXPtl
         B6r07rSN6P/0Qr4ZZDPbUPueJSOPWPqDSb3I0X+G4L1IioMO9tpM6x8stp88+20dvGZ8
         Hf0/mlmwdj6mG7l+5arh8zHvYd3Q2KScOLSw9QjD058Oi6+5Vmnf6mvofP0jS66oBnXk
         7Afw==
X-Gm-Message-State: AJIora9iM/mPvWsBTpD18oJZqRIKp+BTtnKDjs8hS9uD6p5K9EtiTPt+
        v9Ygn9aks1uSoN73NtopxbdEAYJy+J6Myw==
X-Google-Smtp-Source: AGRyM1uC0oKDYQ3j7NNGTvFEaz2ON6V6QRVVS7CRnZfE7c21HtXSEJ2bSTdHadT7MMKAmORW6oFxyQ==
X-Received: by 2002:a05:6402:3689:b0:43a:7c1c:8960 with SMTP id ej9-20020a056402368900b0043a7c1c8960mr42726492edb.79.1658231676849;
        Tue, 19 Jul 2022 04:54:36 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m21-20020aa7d355000000b0043a7de4e526sm10352296edr.44.2022.07.19.04.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:54:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDlo8-003d60-Ft;
        Tue, 19 Jul 2022 13:54:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "tenglong.tl" <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 0/7] trace2: dump scope when print "interesting" config
Date:   Tue, 19 Jul 2022 13:42:37 +0200
References: <220718.86edyiw82r.gmgdl@evledraar.gmail.com>
 <20220719112612.46679-1-tenglong.tl@tenglongtldeMacBook-Pro.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220719112612.46679-1-tenglong.tl@tenglongtldeMacBook-Pro.local>
Message-ID: <220719.86tu7duxl3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 19 2022, tenglong.tl wrote:

>> Yeah likewise, it even applies directly on master. But I can live with
>> it :)
>
> Sorry, may I ask what's the recommanded way to deal this, alway use
> tag or master on update?

We generally submit patches on a single "topic", what a "topic" is is
often fuzzy, and sometimes a topic that's mostly trying to do X will fix
or change some unrelated Y "while at it".

But patch or patches at the end of a series don't depend on anything
that comes before them, and could be "cherry-pick"'d directly on top of
"master" that's generally a sign that you should be submitting two sets
of patches, not one.

Per
https://lore.kernel.org/git/2016ef2e342c2ec6517afa8ec3e57035021fb965.1650547400.git.dyroneteng@gmail.com/
the "let's log config" is just something you happened to run into on
this topic, but it might have just as well been some other command.

So I think it's better to split it up into its own topic.

>> One minor nit is that something like this (which needs to be fleshened
>> up) should be fixed up into 7/7 (and maybe we want to keep the "..."?):
>>
>> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
>> index 49bb1ca1924..ce544982a37 100644
>> --- a/Documentation/technical/api-trace2.txt
>> +++ b/Documentation/technical/api-trace2.txt
>> @@ -716,7 +716,7 @@ The "exec_id" field is a command-unique id and is only useful if the
>>  ------------
>>  {
>>  	"event":"def_param",
>> -	...
>> +	"scope": ...
>>  	"param":"core.abbrev",
>>  	"value":"7"
>>  }
>
> I do a little check, the json format in this scenario is like :
>
> {
>   "event": "def_param",
>   "sid": "20220719T075535.279369Z-H1b0a19dc-P000093db",
>   "thread": "main",
>   "time": "2022-07-19T07:55:35.280720Z",
>   "file": "git.c",
>   "line": 461,
>   "scope": "global",
>   "param": "color.ui",
>   "value": "always"
> }
>
> So, I think this is ok maybe:
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index bb13ca3db8..d66da52686 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -717,6 +717,7 @@ The "exec_id" field is a command-unique id and is only useful if the
>  {
>         "event":"def_param",
>         ...
> +       "scope":...
>         "param":"core.abbrev",
>         "value":"7"

Yes, that sound good, although I'd make that "scope" line be:

	"scope": "global" | "worktree" | <add more things to the list here>

Or just say:

	"scope": <a string that 'git config --show-scope' would return>,

Which covers all the possibilities, without hardcoding them there.

>  }
>
>> And that the addition to api-trace2.txt seems to partially be something
>> that should just link to Documentation/config/trace2.txt, i.e. it's
>> generally documenting an existing facility.
>
> Do you mean the modification about `trace2.configParams` and you suggest
> to make a link to Documentation/config/trace2.txt(actually as git-config[1])
> in /Documentation/technical/api-trace2.txt?

I mean that part of what you're adding is about this new "scope"
feature, but another part just seems to be explaining how the
trace2.configParams works in general.

For the "works in general" let's either link to git-config(1), or if
that explanation is lacking improve it & link to it.

>> I think it would be great in any case to have that 7/7 split into what
>> we do now & docs for that, and then the minor addition of "scope".
>
> Let me try to understand this, it's better to split [7/7] into two commits.
>
> First commit is to add docs in /Documentation/technical/api-trace2.txt to let
> reader to find the print-config ability, by the way link the doc about the
> GIT_TRACE2_CONFIG_PARAM and trace2.configparami in git-config[1].
>
> Like:
>
> commit 2db47572d4462e3788a92fd355b97df13b9bcc39
> Author: Teng Long <dyroneteng@gmail.com>
> Date:   Tue Jul 19 17:30:35 2022 +0800
>
>     api-trace2.txt: add docs to print config
>
>     It's supported to print "interesting" config value to tr2 log by
>     setting the "GIT_TRACE2_CONFIG_PARAMS" environment variable and
>     the "trace2.configparam" config, let's add the related docs.
>
>     Signed-off-by: Teng Long <dyroneteng@gmail.com>
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index bb13ca3db8..4e411f3306 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -1207,6 +1207,45 @@ at offset 508.
>  This example also shows that thread names are assigned in a racy manner
>  as each thread starts and allocates TLS storage.
>
> +Print Configs::
> +
> +         Dump "interesting" config values to trace2 log.
> ++
> +The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
> +`trace2.configparams` can be used to output config values which you care
> +about(see linkgit:git-config[1). For example, assume that we want to
> +config different `color.ui` values in multiple scopes, such as:
> ++
> +----------------
> +$ git config --system color.ui never
> +$ git config --global color.ui always
> +$ git config --local color.ui auto
> +$ git config --list --show-scope | grep 'color.ui'
> +system  color.ui=never
> +global  color.ui=always
> +local   color.ui=auto
> +----------------
> ++
> +Then, mark the config `color.ui` as "interesting" config with
> +`GIT_TRACE2_CONFIG_PARAMS`:
> ++
> +----------------
> +$ export GIT_TRACE2_PERF_BRIEF=1
> +$ export GIT_TRACE2_PERF=~/log.perf
> +$ export GIT_TRACE2_CONFIG_PARAMS=color.ui
> +$ git version
> +...
> +$ cat ~/log.perf
> +d0 | main                     | version      |     |           |           |              | ...
> +d0 | main                     | start        |     |  0.000260 |           |              | /opt/git/master/bin/git version
> +d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
> +d0 | main                     | cmd_name     |     |           |           |              | version (version)
> +d0 | main                     | def_param    |     |           |           |              | color.ui:never
> +d0 | main                     | def_param    |     |           |           |              | color.ui:always
> +d0 | main                     | def_param    |     |           |           |              | color.ui:auto
> +d0 | main                     | exit         |     |  0.000470 |           |              | code:0
> +d0 | main                     | atexit       |     |  0.000477 |           |              | code:0
> +----------------
>  == Future Work

Yes, something like that, although it's a bit odd to discuss "scope"
here and not have the trace show it yet, but that's fixed below.:

> Second is actually what we do in [7/7], modify to support print scope names
> and update the docs which based on what we just add in the first commit
>
> Like:
>
>
> commit 615ab4864fce6b8042778aa78799ac2656785710 (HEAD -> tl/bitmap-append-trace2-outputs)
> Author: Teng Long <dyroneteng@gmail.com>
> Date:   Thu Jul 7 21:48:32 2022 +0800
>
>     tr2: dump names if config exist in multiple scopes
>
>     When we specify GIT_TRACE2_CONFIG_PARAMS or trace2.configparams,
>     trace2 will prints "interesting" config values to log. Sometimes,
>     when a config set in multiple scope files, the following output
>     looks like (the irrelevant fields are omitted here as "..."):
>
>     ...| def_param    |  ...  | core.multipackindex:false
>     ...| def_param    |  ...  | core.multipackindex:false
>     ...| def_param    |  ...  | core.multipackindex:false
>
>     As the log shows, even each config in different scope is dumped, but
>     we don't know which scope it comes from. Therefore, it's better to
>     add the scope names as well to make them be more recognizable. For
>     example, when execute:
>
>         $ GIT_TRACE2_PERF=1 \
>         > GIT_TRACE2_CONFIG_PARAMS=core.multipackIndex \
>         > git rev-list --test-bitmap HEAD"
>
>     The following is the ouput (the irrelevant fields are omitted here
>     as "..."):
>
>     Format normal:
>     ... git.c:461 ... def_param scope:system core.multipackindex=false
>     ... git.c:461 ... def_param scope:global core.multipackindex=false
>     ... git.c:461 ... def_param scope:local core.multipackindex=false
>
>     Format perf:
>
>     ... | def_param    | ... | scope:system | core.multipackindex:false
>     ... | def_param    | ... | scope:global | core.multipackindex:false
>     ... | def_param    | ... | scope:local  | core.multipackindex:false
>
>     Format event:
>
>     {"event":"def_param", ... ,"scope":"system","param":"core.multipackindex","value":"false"}
>     {"event":"def_param", ... ,"scope":"global","param":"core.multipackindex","value":"false"}
>     {"event":"def_param", ... ,"scope":"local","param":"core.multipackindex","value":"false"}
>
>     Signed-off-by: Teng Long <dyroneteng@gmail.com>
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 4e411f3306..50f1e0c259 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -717,6 +717,7 @@ The "exec_id" field is a command-unique id and is only useful if the
>  {
>         "event":"def_param",
>         ...
> +       "scope":...
>         "param":"core.abbrev",
>         "value":"7"
>  }
> @@ -1240,9 +1241,9 @@ d0 | main                     | version      |     |           |           |
>  d0 | main                     | start        |     |  0.000260 |           |              | /opt/git/master/bin/git version
>  d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
>  d0 | main                     | cmd_name     |     |           |           |              | version (version)
> -d0 | main                     | def_param    |     |           |           |              | color.ui:never
> -d0 | main                     | def_param    |     |           |           |              | color.ui:always
> -d0 | main                     | def_param    |     |           |           |              | color.ui:auto
> +d0 | main                     | def_param    |     |           |           | scope:system | color.ui:never
> +d0 | main                     | def_param    |     |           |           | scope:global | color.ui:always
> +d0 | main                     | def_param    |     |           |           | scope:local  | color.ui:auto
>  d0 | main                     | exit         |     |  0.000470 |           |              | code:0
>  d0 | main                     | atexit       |     |  0.000477 |           |              | code:0
>  ----------------
> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index c5c8cfbbaa..37a3163be1 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
> @@ -479,9 +479,12 @@ static void fn_param_fl(const char *file, int line, const char *param,
>  {
>         const char *event_name = "def_param";
>         struct json_writer jw = JSON_WRITER_INIT;
> +       enum config_scope scope = current_config_scope();
> +       const char *scope_name = config_scope_name(scope);
>
>         jw_object_begin(&jw, 0);
>         event_fmt_prepare(event_name, file, line, NULL, &jw);
> +       jw_object_string(&jw, "scope", scope_name);
>         jw_object_string(&jw, "param", param);
>         jw_object_string(&jw, "value", value);
>         jw_end(&jw);
> diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
> index c42fbade7f..69f8033077 100644
> --- a/trace2/tr2_tgt_normal.c
> +++ b/trace2/tr2_tgt_normal.c
> @@ -298,8 +298,11 @@ static void fn_param_fl(const char *file, int line, const char *param,
>                         const char *value)
>  {
>         struct strbuf buf_payload = STRBUF_INIT;
> +       enum config_scope scope = current_config_scope();
> +       const char *scope_name = config_scope_name(scope);
>
> -       strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
> +       strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
> +                   value);
>         normal_io_write_fl(file, line, &buf_payload);
>         strbuf_release(&buf_payload);
>  }
> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
> index a1eff8bea3..8cb792488c 100644
> --- a/trace2/tr2_tgt_perf.c
> +++ b/trace2/tr2_tgt_perf.c
> @@ -441,12 +441,17 @@ static void fn_param_fl(const char *file, int line, const char *param,
>  {
>         const char *event_name = "def_param";
>         struct strbuf buf_payload = STRBUF_INIT;
> +       struct strbuf scope_payload = STRBUF_INIT;
> +       enum config_scope scope = current_config_scope();
> +       const char *scope_name = config_scope_name(scope);
>
>         strbuf_addf(&buf_payload, "%s:%s", param, value);
> +       strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
>
> -       perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
> -                        &buf_payload);
> +       perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,
> +                        scope_payload.buf, &buf_payload);
>         strbuf_release(&buf_payload);
> +       strbuf_release(&scope_payload);
>  }
>
>  static void fn_repo_fl(const char *file, int line,
>
> Am I understand accurately?
> Thanks.

Yes, exactly! That makes it much clearer what the functional change was
about, i.e. we can see what parts of the trace are now different (the
scope is added to the trace).


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4FFC28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350084AbiHSSI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350090AbiHSSId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:08:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEF895E6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:57:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso4444968wmh.5
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=pg4F/o15NmonrxmNEp1J2ifgT42CTIKmEGm0pvwpJHc=;
        b=mmhehpvpXF/sXqqVZRllYiWyr4BeKJV3Uq736gjujorCaJbYpLybVZwaaxI/6s8SQu
         WHZKSAGtCdKudLKseDdsRH6fEbmuoW8R64Q3s5c8LCfqrCq8ETnLDwff6E4Ig0MWe9dt
         1uxML0+yAI2TUU5DJvRi3RQMUQnQQQcydfLm1xrpAUhijkUTvOcXv+whxwWIKDTE1cg2
         ew53aqPzVtwvQlKt3CxT50+mEYoIAg9aIFm3d+jCS5QPZw2S6BY9ofn8Fc8oSMuv3+kc
         2FayqNqdIiBwgSYLviAgQ72z3ETXyis+cBG2RQ9trKa9Pu9bFiJ4+HlBbu+GjSuLF39l
         1gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=pg4F/o15NmonrxmNEp1J2ifgT42CTIKmEGm0pvwpJHc=;
        b=o5imTUN/3NMeGhI3ZrHUKy9WUb71hLYSZIQvOYfDxSSIApqKgghqChsGfmUd6Mj/EV
         c3uFwoBCEFzoaQ7ZKww20zvQx7VO1NpMVQCzScKNDXhGtmmlguMvZD+SWlzxcl9ITe/B
         vwLkBsoyK3FaN6dIICirvV+UZo3UNDhpCForcq9RI7sjavbirOIheg2f5as66EFxDGof
         Eg6V5z3qhjokVOv+0OVx9Hy+CumD4TuroMv5bYy+mxf7Nqnej3+pj2G0G8kfk3pYhNwJ
         4khzujmi/AtAbpyWFPwebrShIxnOOdGk3nqEq18BQcnblBWPJdvS9rPTm48Ok1UbJSU0
         4mNg==
X-Gm-Message-State: ACgBeo1IkRTsn8QAQTPsl/AzMyRBnRMS/9MNn2ZlvlktFkFw7h03XYjV
        CZpggfgopcNc7ARfW9+uaK8=
X-Google-Smtp-Source: AA6agR6Om89O08G4KB4zL04+RfVek573aKGD1CFlWo/PfysOlBOSrsa8eTFI8ej+Qd26OBVOt7nGXw==
X-Received: by 2002:a05:600c:4e52:b0:3a6:d89:4d1b with SMTP id e18-20020a05600c4e5200b003a60d894d1bmr5613467wmq.150.1660931826563;
        Fri, 19 Aug 2022 10:57:06 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d4fcd000000b0022533c4fa48sm3253956wrw.55.2022.08.19.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:57:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP6Ey-000pqc-32;
        Fri, 19 Aug 2022 19:57:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/20] builtin/commit-graph.c: let parse-options
 parse subcommands
Date:   Fri, 19 Aug 2022 19:56:30 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-12-szeder.dev@gmail.com>
 <220819.8635ds6run.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220819.8635ds6run.gmgdl@evledraar.gmail.com>
Message-ID: <220819.86y1vk5d73.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:
>
>> 'git commit-graph' parses its subcommands with an if-else if
>> statement.  parse-options has just learned to parse subcommands, so
>> let's use that facility instead, with the benefits of shorter code,
>> handling missing or unknown subcommands, and listing subcommands for
>> Bash completion.
>>
>> Note that the functions implementing each subcommand only accept the
>> 'argc' and '**argv' parameters, so add a (unused) '*prefix' parameter
>> to make them match the type expected by parse-options, and thus avoid
>> casting function pointers.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>  builtin/commit-graph.c  | 30 +++++++++++++-----------------
>>  t/t5318-commit-graph.sh |  4 ++--
>>  2 files changed, 15 insertions(+), 19 deletions(-)
>>
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index 51c4040ea6..1eb5492cbd 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -58,7 +58,7 @@ static struct option *add_common_options(struct option=
 *to)
>>  	return parse_options_concat(common_opts, to);
>>  }
>>=20=20
>> -static int graph_verify(int argc, const char **argv)
>> +static int graph_verify(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct commit_graph *graph =3D NULL;
>>  	struct object_directory *odb =3D NULL;
>> @@ -190,7 +190,7 @@ static int git_commit_graph_write_config(const char =
*var, const char *value,
>>  	return 0;
>>  }
>>=20=20
>> -static int graph_write(int argc, const char **argv)
>> +static int graph_write(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct string_list pack_indexes =3D STRING_LIST_INIT_DUP;
>>  	struct strbuf buf =3D STRBUF_INIT;
>> @@ -307,26 +307,22 @@ static int graph_write(int argc, const char **argv)
>>=20=20
>>  int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>>  {
>> -	struct option *builtin_commit_graph_options =3D common_opts;
>> +	parse_opt_subcommand_fn *fn =3D NULL;
>> +	struct option builtin_commit_graph_options[] =3D {
>> +		OPT_SUBCOMMAND("verify", &fn, graph_verify),
>> +		OPT_SUBCOMMAND("write", &fn, graph_write),
>> +		OPT_END(),
>> +	};
>> +	struct option *options =3D parse_options_concat(builtin_commit_graph_o=
ptions, common_opts);
>
> This looks like it'll leak if...
>
>>=20=20
>>  	git_config(git_default_config, NULL);
>> -	argc =3D parse_options(argc, argv, prefix,
>> -			     builtin_commit_graph_options,
>> -			     builtin_commit_graph_usage,
>> -			     PARSE_OPT_STOP_AT_NON_OPTION);
>> -	if (!argc)
>> -		goto usage;
>
> We take this goto..

Sorry, I'm being an idiot and misreading this, the "goto" isn't here
anymore, du'h!

>> +	argc =3D parse_options(argc, argv, prefix, options,
>> +			     builtin_commit_graph_usage, 0);
>> +	FREE_AND_NULL(options);
>
> Why FREE_AND_NULL() over free()?

But this question still stands :)

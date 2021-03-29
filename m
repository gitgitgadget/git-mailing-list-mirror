Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2441DC433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB5461981
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC2QMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhC2QM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:12:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3617FC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:12:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l4so20313989ejc.10
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0j/I7cFpbGZQGcUTDk1HvO7apgyeUHNS8yTlqyaiQLQ=;
        b=hKWL6u/SnyE9m3IN/pjb2wlayaZxcz8N/CNF3v1wJ9ADbmNzaUIv8tRaQY99QBNjG+
         Aic47/LTrKuRKWNrMrfZY/QZ+5cocchVUWqFDL+Y/05x5Fk46KLMlYUOnED1cJUkUlB+
         Cy7Fk/6dIuTFBQaIoKmyUlySn26BjA2oqWxzDY8y1WuFrX1ljJECZRArHourWoArbIN7
         C0dgJdVSxfBal9zaiI8O3+a0aSnosXrq0DEvj9SkA95JYnhlsSUUOV6rabT3tcrwOxMv
         d2GavZutTcuDyfYuDXdK7lWAz8GU5wlOXWa8M/UVBtx2EMaZBRwB4TG7RTpkYtOMEvfO
         n7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0j/I7cFpbGZQGcUTDk1HvO7apgyeUHNS8yTlqyaiQLQ=;
        b=N7JrP6K7DZQvcjwa2ZsmkqvDbTOnt8195f4JiUxzQYu/MMdHR7adA84vq7oWnqr3Gh
         jHzL+zSMGyDRWOMpnaywpnLwxT/n813F0ybfDLhXNcWRmqB7K4uJ3Ix1lhGIRAytEU1z
         S6hSsDfxOLdRQCsNyu1yH8Xg0qR2UBMbxFJ9ONnMfpD0UC0C9r/ZhnwheQXr6hEVAGih
         pwouhqDKdaGa1/Z1m8wApAlaZdaK4N2SblxKTFNxcpgjmBUkInQgjLEfkvpcOMpqCU4y
         twEraVyKTC9G8lE24BtGhQ3w5MWCpUZuT2q362AZ96pM2SZv+pjLf/JpvSQdX2JWslHj
         0oeg==
X-Gm-Message-State: AOAM5302ArQyfnTFx7uyaBtdr7weL32bvpINmXjHwN+cltnJ5YGvdVkF
        3OVT9xd+VGsA9L9LE1MNzvU=
X-Google-Smtp-Source: ABdhPJwMVMflILThybAnoJyfOHh3RrSPH7sfBgaDyRrMHDLsAPEXY4HAGlVVjS5ROWTNo8rykVl1mg==
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr29139913ejt.410.1617034342725;
        Mon, 29 Mar 2021 09:12:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x4sm9071199edd.58.2021.03.29.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:12:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] rebase: don't override --no-reschedule-failed-exec
 with config
References: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com>
 <cover.1616411973.git.avarab@gmail.com>
 <e00300d58d4de4a6b440446a0054d34ad5a092f3.1616411973.git.avarab@gmail.com>
 <fc7e3d13-8761-6d79-0fc9-734d6942a8e6@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <fc7e3d13-8761-6d79-0fc9-734d6942a8e6@gmail.com>
Date:   Mon, 29 Mar 2021 18:12:21 +0200
Message-ID: <87lfa6lz16.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 29 2021, Phillip Wood wrote:

> Hi =C3=86var
>
> On 22/03/2021 11:48, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix a bug in how --no-reschedule-failed-exec interacts with
>> rebase.rescheduleFailedExec=3Dtrue being set in the config. Before this
>> change the --no-reschedule-failed-exec config option would be
>> overridden by the config.
>> This bug happened because of the particulars of how "rebase" works
>> v.s. most other git commands when it comes to parsing options and
>> config:
>> When we read the config and parse the CLI options we correctly
>> prefer
>> the --no-reschedule-failed-exec option over
>> rebase.rescheduleFailedExec=3Dtrue in the config. So far so good.
>> However the --reschedule-failed-exec option doesn't take effect when
>> the rebase starts (we'd just create a
>> ".git/rebase-merge/reschedule-failed-exec" file if it was true). It
>> only takes effect when the exec command fails, and the user wants to
>> run "rebase --continue".
>
> The exec command is rescheduled in the todo file as soon as it fails,
> we do not wait for the user to run 'rebase --continue' to reschedule
> it. However if it still fails after restarting or a later exec fails
> we have the problem you describe.

Right, as noted in [1] I grokked those internals eventually, but the
commit message is written from the viewpoint of a hypothetical user...

B.t.w. if you've had a chance to read [1] over it would be interesting
to get some thoughts on that rambling. So far I only managed to upset
Johannes :)

1. http://lore.kernel.org/git/cover.1616411973.git.avarab@gmail.com

>> At that point we'll have forgotten that we asked for
>> --no-reschedule-failed-exec at the start, and will happily re-read the
>> config.
>> We'll then see that rebase.rescheduleFailedExec=3Dtrue is set. At that
>> point we have no record of having set --no-reschedule-failed-exec
>> earlier. So the config will effectively override the user having
>> explicitly disabled the option on the command-line.
>> Even more confusingly: Since rebase accepts different options based
>> on
>> its state there wasn't even a way to get around this with "rebase
>> --continue --no-reschedule-failed-exec" (but you could of course set
>> the config with "rebase -c ...").
>> I think the least bad way out of this is to declare that for such
>> options and config whatever we decide at the beginning of the rebase
>> goes. So we'll now always create either a "reschedule-failed-exec" or
>> a "no-reschedule-failed-exec file at the start, not just the former if
>> we decided we wanted the feature.
>
> Thanks for working on this and for the detailed commit message. I'm
> not entirely convinced we want yet another state file in
> .git/rebase-merge. We could we start writing the setting to the file
> rather than having different files for whether the option is on or
> off. If we use the contents of the file it could be -1 for 'use
> config', 0 'off', 1 'on'. The downside is that starting 'rebase
> --no-reschedule-failed-exec' with a new version of git and then
>  continuing with an old version would do the wrong thing.

Yes I suppose, but it seems much simpler indeed to just represent this
sort of tri-state as a ENOENT/no-FOO/FOO neither exists + file pair with
how the current code is set up, especially because (as you note) we'd
need to phase-in any writing of the content across multiple versions or
something, least in-progress rebases across versions subtly behave
weirdly.

Well, in this case it's not such a big deal, but I'd rather not
establish the pattern for something that *does* matter.

> Best Wishes
>
> Phillip
>
>> With this new worldview you can no longer change the setting once a
>> rebase has started except by manually removing the state files
>> discussed above. I think making it work like that is the the least
>> confusing thing we can do.
>> In the future we might want to learn to change the setting in the
>> middle by combining "--edit-todo" with
>> "--[no-]reschedule-failed-exec", we currently don't support combining
>> those options, or any other way to change the state in the middle of
>> the rebase short of manually editing the files in
>> ".git/rebase-merge/*".
>> The bug being fixed here originally came about because of a
>> combination of the behavior of the code added in d421afa0c66 (rebase:
>> introduce --reschedule-failed-exec, 2018-12-10) and the addition of
>> the config variable in 969de3ff0e0 (rebase: add a config option to
>> default to --reschedule-failed-exec, 2018-12-10).
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   Documentation/git-rebase.txt |  8 ++++++++
>>   sequencer.c                  |  5 +++++
>>   t/t3418-rebase-continue.sh   | 25 +++++++++++++++++++++++++
>>   3 files changed, 38 insertions(+)
>> diff --git a/Documentation/git-rebase.txt
>> b/Documentation/git-rebase.txt
>> index a0487b5cc58..b48e6225769 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -622,6 +622,14 @@ See also INCOMPATIBLE OPTIONS below.
>>   --no-reschedule-failed-exec::
>>   	Automatically reschedule `exec` commands that failed. This only makes
>>   	sense in interactive mode (or when an `--exec` option was provided).
>> ++
>> +Even though this option applies once a rebase is started, it's set for
>> +the whole rebase at the start based on either the
>> +`rebase.rescheduleFailedExec` configuration (see linkgit:git-config[1]
>> +or "CONFIGURATION" below) or whether this option is
>> +provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
>> +start would be overridden by the presence of
>> +`rebase.rescheduleFailedExec=3Dtrue` configuration.
>>     INCOMPATIBLE OPTIONS
>>   --------------------
>> diff --git a/sequencer.c b/sequencer.c
>> index 848204d3dc3..59735fdff62 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -164,6 +164,7 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-m=
erge/strategy")
>>   static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy=
_opts")
>>   static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merg=
e/allow_rerere_autoupdate")
>>   static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge=
/reschedule-failed-exec")
>> +static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-mer=
ge/no-reschedule-failed-exec")
>>   static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge=
/drop_redundant_commits")
>>   static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge=
/keep_redundant_commits")
>>   @@ -2672,6 +2673,8 @@ static int read_populate_opts(struct
>> replay_opts *opts)
>>     		if (file_exists(rebase_path_reschedule_failed_exec()))
>>   			opts->reschedule_failed_exec =3D 1;
>> +		else if (file_exists(rebase_path_no_reschedule_failed_exec()))
>> +			opts->reschedule_failed_exec =3D 0;
>>     		if (file_exists(rebase_path_drop_redundant_commits()))
>>   			opts->drop_redundant_commits =3D 1;
>> @@ -2772,6 +2775,8 @@ int write_basic_state(struct replay_opts *opts, co=
nst char *head_name,
>>   		write_file(rebase_path_ignore_date(), "%s", "");
>>   	if (opts->reschedule_failed_exec)
>>   		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>> +	else
>> +		write_file(rebase_path_no_reschedule_failed_exec(), "%s", "");
>>     	return 0;
>>   }
>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>> index ea14ef496cb..9553d969646 100755
>> --- a/t/t3418-rebase-continue.sh
>> +++ b/t/t3418-rebase-continue.sh
>> @@ -291,4 +291,29 @@ test_expect_success 'rebase.rescheduleFailedExec on=
ly affects `rebase -i`' '
>>   	git rebase HEAD^
>>   '
>>   +test_expect_success 'rebase.rescheduleFailedExec=3Dtrue &
>> --no-reschedule-failed-exec' '
>> +	test_when_finished "git rebase --abort" &&
>> +	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
>> +	test_config rebase.rescheduleFailedExec true &&
>> +	test_must_fail git rebase -x false --no-reschedule-failed-exec HEAD~2 =
&&
>> +	test_must_fail git rebase --continue 2>err &&
>> +	! grep "has been rescheduled" err
>> +'
>> +
>> +test_expect_success 'new rebase.rescheduleFailedExec=3Dtrue setting in =
an ongoing rebase is ignored' '
>> +	test_when_finished "git rebase --abort" &&
>> +	test_must_fail git rebase -x false HEAD~2 &&
>> +	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
>> +	test_config rebase.rescheduleFailedExec true &&
>> +	test_must_fail git rebase --continue 2>err &&
>> +	! grep "has been rescheduled" err
>> +'
>> +
>> +test_expect_success 'there is no --no-reschedule-failed-exec in an ongo=
ing rebase' '
>> +	test_when_finished "git rebase --abort" &&
>> +	test_must_fail git rebase -x false HEAD~2 &&
>> +	test_expect_code 129 git rebase --continue --no-reschedule-failed-exec=
 &&
>> +	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
>> +'
>> +
>>   test_done
>>=20


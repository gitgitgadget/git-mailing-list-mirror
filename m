Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C591C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 14:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbiGNOn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiGNOnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 10:43:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB505924C
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 07:43:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r18so2684215edb.9
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VE7cq3UPN+3AfnZ3n27xwxKEJ+944A6USZhwnVRtyyc=;
        b=iyzPoiDmBzoO5YhJNEL3d56560S6oZ4mdObzoEtf2+UjAw06rfAOPuj0ogKCfmWybw
         vkJR6yPBxKSxHOUNv6+KSDF0Nse6yzRSzfNsCfo71cedQB1/XlPP5ZJlTRrBGJSTFkDw
         7Ov43tBNmWG4b30aCP74Vf3Ib/Y76+Rp6QUJupv4S9cScEWS7P1hwUc6d9n60Mb37ptw
         Yjpt137tNOh97uCXNqPaImvt3FINRr5P5Mfpx5YAh02tNiCrwa+0RMGz6bl/1R5uty+D
         yXcKtwMXnP7P5tg3psFKwt6go15U03VOaDANrwELcYeqMbnF34/29M5p67FHH8VV9bt5
         H3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VE7cq3UPN+3AfnZ3n27xwxKEJ+944A6USZhwnVRtyyc=;
        b=GDzhEcesTF2eyGIr4lnyKpY5ECt//HlnPA8VORm8ZVZflhKHripXWWoF38FYx3BuZv
         JtgejVC59PPFkvUuGMHIGGvpNBxh/+gYoCeWrqROIFyitVKCAK8nmxGCaeRwvCvgFnGX
         Ddk99pVMb9Q4L+q5v4/BMcTz7GbDkaGHWS72F4OFOEQ+LvCGP/ItaKSP6ZjHNmjDlijw
         z2s3LNY/2TYz7ii19GyXZO//ySdBasrawTAFIzU2cw1nDUpY5eXHHM57Xr1BNLzxBJ/p
         +mXL4UyMVtIkKuWDlp8AY3vZSH0VDR69Hhp6iC3PxSXiXJv8HzfhxczeFh8vmNAEIZhH
         C6CQ==
X-Gm-Message-State: AJIora8dJ5m6sC4NawaFTYVMs0xawxo1ovrAjJY+apuo94XK7G3vIFpd
        gT0rrNfcp2oy4WdhvpMCQHA=
X-Google-Smtp-Source: AGRyM1sohdgXbyaL+6frQdedGhuGJXMpb9Nj9c9/nunu4YkBOpvbwmFWHgEmCJhjAipzctDe6woRxw==
X-Received: by 2002:a05:6402:c44:b0:431:52cc:f933 with SMTP id cs4-20020a0564020c4400b0043152ccf933mr12847728edb.41.1657809802255;
        Thu, 14 Jul 2022 07:43:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ek9-20020a056402370900b0042de3d661d2sm1147345edb.1.2022.07.14.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:43:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oC03j-002KkD-BM;
        Thu, 14 Jul 2022 16:43:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 05/11] submodule--helper: free() leaking
 {run,capture}_command() argument
Date:   Thu, 14 Jul 2022 16:43:01 +0200
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <patch-05.11-76eab92c8b6-20220713T131601Z-avarab@gmail.com>
 <kl6l5yk05psl.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6l5yk05psl.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220714.86r12n21rs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Free the "dir" member of "struct child_process" that various functions
>> in submodule-helper.c allocate allocates with xstrdup().
>>
>> Since the "dir" argument is "const char *" let's keep a
>> "char *to_free" variable around for this rather than casting when we
>> call free().
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 41 +++++++++++++++++++++++++++----------
>>  1 file changed, 30 insertions(+), 11 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index a8e439e59b8..2099c5774b2 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2198,27 +2198,36 @@ static int is_tip_reachable(const char *path, st=
ruct object_id *oid)
>>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>>  	struct strbuf rev =3D STRBUF_INIT;
>>  	char *hex =3D oid_to_hex(oid);
>> +	char *to_free;
>> +	int ret;
>>=20=20
>>  	cp.git_cmd =3D 1;
>> -	cp.dir =3D xstrdup(path);
>> +	cp.dir =3D to_free =3D xstrdup(path);
>>  	cp.no_stderr =3D 1;
>>  	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", N=
ULL);
>>=20=20
>>  	prepare_submodule_repo_env(&cp.env);
>>=20=20
>> -	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
>> -		return 0;
>> +	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len) {
>> +		ret =3D 0;
>> +		goto cleanup;
>> +	}
>>=20=20
>> -	return 1;
>> +	ret =3D 1;
>> +cleanup:
>> +	free(to_free);
>> +	return ret;
>>  }
>>=20=20
>>  static int fetch_in_submodule(const char *module_path, int depth, int q=
uiet, struct object_id *oid)
>>  {
>>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>> +	char *to_free;
>> +	int ret;
>>=20=20
>>  	prepare_submodule_repo_env(&cp.env);
>>  	cp.git_cmd =3D 1;
>> -	cp.dir =3D xstrdup(module_path);
>> +	cp.dir =3D to_free =3D xstrdup(module_path);
>>=20=20
>>  	strvec_push(&cp.args, "fetch");
>>  	if (quiet)
>> @@ -2232,7 +2241,9 @@ static int fetch_in_submodule(const char *module_p=
ath, int depth, int quiet, str
>>  		free(remote);
>>  	}
>>=20=20
>> -	return run_command(&cp);
>> +	ret =3D run_command(&cp);
>> +	free(to_free);
>> +	return ret;
>>  }
>>=20=20
>>  static int run_update_command(struct update_data *ud, int subforce)
>> @@ -2240,6 +2251,8 @@ static int run_update_command(struct update_data *=
ud, int subforce)
>>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>>  	char *oid =3D oid_to_hex(&ud->oid);
>>  	int must_die_on_failure =3D 0;
>> +	char *to_free;
>> +	int ret;
>>=20=20
>>  	switch (ud->update_strategy.type) {
>>  	case SM_UPDATE_CHECKOUT:
>> @@ -2273,7 +2286,7 @@ static int run_update_command(struct update_data *=
ud, int subforce)
>>  	}
>>  	strvec_push(&cp.args, oid);
>>=20=20
>> -	cp.dir =3D xstrdup(ud->sm_path);
>> +	cp.dir =3D to_free =3D xstrdup(ud->sm_path);
>>  	prepare_submodule_repo_env(&cp.env);
>>  	if (run_command(&cp)) {
>>  		switch (ud->update_strategy.type) {
>> @@ -2301,11 +2314,14 @@ static int run_update_command(struct update_data=
 *ud, int subforce)
>>  			exit(128);
>>=20=20
>>  		/* the command failed, but update must continue */
>> -		return 1;
>> +		ret =3D 1;
>> +		goto cleanup;
>>  	}
>>=20=20
>> -	if (ud->quiet)
>> -		return 0;
>> +	if (ud->quiet) {
>> +		ret =3D 0;
>> +		goto cleanup;
>> +	}
>>=20=20
>>  	switch (ud->update_strategy.type) {
>>  	case SM_UPDATE_CHECKOUT:
>> @@ -2329,7 +2345,10 @@ static int run_update_command(struct update_data =
*ud, int subforce)
>>  		    submodule_strategy_to_string(&ud->update_strategy));
>>  	}
>>=20=20
>> -	return 0;
>> +	ret =3D 0;
>> +cleanup:
>> +	free(to_free);
>> +	return ret;
>>  }
>>=20=20
>>  static int run_update_procedure(struct update_data *ud)
>
> I assume I'm missing something, but couldn't we achieve the same result
> by just removing the xstrdup() calls? i.e. we only leak .dir (which we
> don't clear because it's const), so couldn't we just assign to it
> without xstrdup() and not have to worry about free()-ing it?
>
> I didn't see a correctness reason for us to xstrdup(), and indeed, t7406
> passes with the change I just described (which I believe covers all of
> the sites here). In fact, we already have one site that does exactly
> this in the recursive part of update_submodule():
>
> 	if (update_data->recursive) {
> 		struct child_process cp =3D CHILD_PROCESS_INIT;
> 		struct update_data next =3D *update_data;
> 		int res;
>
> 		next.prefix =3D NULL;
> 		oidcpy(&next.oid, null_oid());
> 		oidcpy(&next.suboid, null_oid());
>
> 		cp.dir =3D update_data->sm_path;
>
> Tangentially related question (primarily for my own learning): in all of
> these hunks, the string being xstrdup()-ed is update_data.sm_path, which
> is only ever set in update_submodules():
>
> 		update_data->sm_path =3D ucd.sub->path;
>
> where ucd.sub->path is a "const char *". So we never have to worry about
> free()-ing update_data.sm_path, right? (Your patch doesn't attempt to
> free() it, which sounds correct.)

Yes, do'h! That's a much better fix, and only 3 lines of getting rid of
the xstrdup(). I'll re-roll with that.

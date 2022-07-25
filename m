Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6E5C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiGYUnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbiGYUnR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:43:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496F022BDF
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:43:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i13so6355994edj.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=F6H4BT2gzJTRTf7cLTNENRP4GB2EViiVy87NFrqg9zc=;
        b=o4ntkn0ynG8NcQRew2N222YeV1xUKQFCcpOrk8MHZUcevomfOwkFVnXrVfozXaDlAT
         20GkC6gjkLEy7AdGoiLLvGy0gL3Gm7HjoVXL504vTKS77mMSVeKJzVdDgn0n4Wh6IAU3
         qawRC/hROXer0kaZEbeyhncxDi2e53gNHZX+CnNcaGXf6gmDnHOdQVyMPg+acvSPKpVc
         pvAo95D3E4WcE5G0vWs7BAUINMcCkjfTrUza/c3ncy551/AimFhW8Hb3fStGc2b0Vpxt
         7Zr03JrrcMbTmYHgewViLyai0XaTC3DBqWo65ELbZmZb4MehDruMLAtwvKx8fhYkJCST
         L9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=F6H4BT2gzJTRTf7cLTNENRP4GB2EViiVy87NFrqg9zc=;
        b=giRDNe4ArEPqDkiu+z8Qpwo9KtgA6JfJgw44rlaOz+qku1H3bVsEeIeEfR1qF+ALul
         dMcH9Wfv/cj5q/P1WY5w++U3KFHMsFuRJ1kQXfWrXsYyAJ4xw9I/s6fqeSO0DkR0TmNE
         dNRCTqqWEkz/G1Hj6VKEy1Kq63yNp/Tgl2+IMov3Br5gDbR61Vnv581fefbdPuA4Wh9F
         yRaGoRlss47wSHBbbzEij95VpvAiaOw4sAjhPeYnV0A4wS9X2Sa/HjPpJNRaYV12Ch03
         qUW611h3eC0YdiYx0p1O7E/MgM5IdrS5GuEogDKzsSuobgGFSpW0cl2/d9wimEs7UH8t
         nvmA==
X-Gm-Message-State: AJIora/T18mcuvHMPiHqRZKyrZ5O/GVlKg/oeRKXzo0FfVHztLiXTmiB
        KFZUV+f+fnzUVmQCdqD85Ys=
X-Google-Smtp-Source: AGRyM1s1tKAi2jx9WxmqWXOZ5rl8dbkOtTnaUg3ksqqjr97g3kVQXn/vGaAsqaFESnT5RUTv5qDMbw==
X-Received: by 2002:aa7:dcd6:0:b0:43b:b754:c6fc with SMTP id w22-20020aa7dcd6000000b0043bb754c6fcmr14738274edu.284.1658781793463;
        Mon, 25 Jul 2022 13:43:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7de8f000000b0043be16f5f4csm4235204edv.52.2022.07.25.13.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:43:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oG4v1-005uP7-8R;
        Mon, 25 Jul 2022 22:43:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: SANITIZE=address failure on master (was: [PATCH v8 3/5] config:
 learn `git_protected_config()`)
Date:   Mon, 25 Jul 2022 22:41:30 +0200
References: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
 <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
 <30ac73716cbc234a1f176d2d417bf0e2b0b335cf.1657834081.git.gitgitgadget@gmail.com>
 <220725.861qu9oxl4.gmgdl@evledraar.gmail.com>
 <kl6l35ept0e1.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6l35ept0e1.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220725.86o7xcords.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Jul 14 2022, Glen Choo via GitGitGadget wrote:
>>
>>> +/* Read values into protected_config. */
>>> +static void read_protected_config(void)
>>> +{
>>> +	char *xdg_config =3D NULL, *user_config =3D NULL, *system_config =3D =
NULL;
>>> +
>>> +	git_configset_init(&protected_config);
>>> +
>>> +	system_config =3D git_system_config();
>>> +	git_global_config(&user_config, &xdg_config);
>>> +
>>> +	git_configset_add_file(&protected_config, system_config);
>>> +	git_configset_add_file(&protected_config, xdg_config);
>>> +	git_configset_add_file(&protected_config, user_config);
>>> +	git_configset_add_parameters(&protected_config);
>>> +
>>> +	free(system_config);
>>> +	free(xdg_config);
>>> +	free(user_config);
>>> +}
>>
>> Noticed after it landed on master: This change fails with:
>>
>> 	make SANITIZE=3Daddress test T=3Dt0410*.sh
>>
>> Running that manually shows that we fail like this:
>>=20=09
>> 	$ cat trash\ directory.t0410-partial-clone/httpd/error.log | grep -o AH=
0.*
>> 	AH00163: Apache/2.4.54 (Debian) configured -- resuming normal operations
>> 	AH00094: Command line: '/usr/sbin/apache2 -d /home/avar/g/git/t/trash d=
irectory.t0410-partial-clone/httpd -f /home/avar/g/git/t/lib-httpd/apache.c=
onf -c Listen 127.0.0.1:10410'
>> 	AH01215: AddressSanitizer:DEADLYSIGNAL: /home/avar/g/git/git-http-backe=
nd
>> 	AH01215: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D: /home/avar/g/=
git/git-http-backend
>> 	AH01215: =3D=3D27820=3D=3DERROR: AddressSanitizer: SEGV on unknown addr=
ess 0x000000000000 (pc 0x7f7af5dc0d66 bp 0x7fff11964450 sp 0x7fff11963be8 T=
0): /home/avar/g/git/git-http-backend
>> 	AH01215: =3D=3D27820=3D=3DThe signal is caused by a READ memory access.=
: /home/avar/g/git/git-http-backend
>> 	AH01215: =3D=3D27820=3D=3DHint: address points to the zero page.: /home=
/avar/g/git/git-http-backend
>> 	AH01215:     #0 0x7f7af5dc0d66 in __sanitizer::internal_strlen(char con=
st*) ../../../../src/libsanitizer/sanitizer_common/sanitizer_libc.cpp:167: =
/home/avar/g/git/git-http-backend
>> 	AH01215:     #1 0x7f7af5d512f2 in __interceptor_fopen64 ../../../../src=
/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:6220: /hom=
e/avar/g/git/git-http-backend
>> 	AH01215:     #2 0x562a65e37cc8 in git_fopen compat/fopen.c:22: /home/av=
ar/g/git/git-http-backend
>> 	AH01215:     #3 0x562a65df3879 in fopen_or_warn wrapper.c:431: /home/av=
ar/g/git/git-http-backend
>> 	AH01215:     #4 0x562a65a12476 in git_config_from_file_with_options con=
fig.c:1982: /home/avar/g/git/git-http-backend
>> 	AH01215:     #5 0x562a65a124f4 in git_config_from_file config.c:1993: /=
home/avar/g/git/git-http-backend
>> 	AH01215:     #6 0x562a65a15288 in git_configset_add_file config.c:2389:=
 /home/avar/g/git/git-http-backend
>> 	AH01215:     #7 0x562a65a16a37 in read_protected_config config.c:2649: =
/home/avar/g/git/git-http-backend
>> 	AH01215:     #8 0x562a65a16b5c in git_protected_config config.c:2661: /=
home/avar/g/git/git-http-backend
>> 	AH01215:     #9 0x562a65dd9f9a in get_upload_pack_config upload-pack.c:=
1342: /home/avar/g/git/git-http-backend
>> 	AH01215:     #10 0x562a65ddc1cb in upload_pack_v2 upload-pack.c:1706: /=
home/avar/g/git/git-http-backend
>> 	AH01215:     #11 0x562a65d2eb8a in process_request serve.c:308: /home/a=
var/g/git/git-http-backend
>> 	AH01215:     #12 0x562a65d2ec18 in protocol_v2_serve_loop serve.c:323: =
/home/avar/g/git/git-http-backend
>> 	AH01215:     #13 0x562a6593c5ae in cmd_upload_pack builtin/upload-pack.=
c:55: /home/avar/g/git/git-http-backend
>> 	AH01215:     #14 0x562a656cf8ff in run_builtin git.c:466: /home/avar/g/=
git/git-http-backend
>> 	AH01215:     #15 0x562a656d02ab in handle_builtin git.c:720: /home/avar=
/g/git/git-http-backend
>> 	AH01215:     #16 0x562a656d09d5 in run_argv git.c:787: /home/avar/g/git=
/git-http-backend
>> 	AH01215:     #17 0x562a656d174f in cmd_main git.c:920: /home/avar/g/git=
/git-http-backend
>> 	AH01215:     #18 0x562a6594b0b9 in main common-main.c:56: /home/avar/g/=
git/git-http-backend
>> 	AH01215:     #19 0x7f7af5a5681c in __libc_start_main ../csu/libc-start.=
c:332: /home/avar/g/git/git-http-backend
>> 	AH01215:     #20 0x562a656cb209 in _start (git+0x1d1209): /home/avar/g/=
git/git-http-backend
>> 	AH01215: : /home/avar/g/git/git-http-backend
>> 	AH01215: AddressSanitizer can not provide additional info.: /home/avar/=
g/git/git-http-backend
>> 	AH01215: SUMMARY: AddressSanitizer: SEGV
>> ../../../../src/libsanitizer/sanitizer_common/sanitizer_libc.cpp:167
>> in __sanitizer::internal_strlen(char const*):
>> /home/avar/g/git/git-http-backend
>> 	AH01215: =3D=3D27820=3D=3DABORTING: /home/avar/g/git/git-http-backend
>> 	AH01215: error: upload-pack died of signal 6: /home/avar/g/git/git-http=
-backend
>>
>> (We really should have a SANITIZE=3Daddress in CI, but it takes a while.=
..)
>
> Thanks. I narrowed the failure down to the hunk above, specifically this
> line:
>
>   git_configset_add_file(&protected_config, xdg_config);
>
> Since xdg_config can be NULL, this results in the failing call
> fopen_or_warn(NULL, "r").
>
> This logic was lifted  from do_git_config_sequence(), which checks that
> each of the paths are not NULL. So a fix might be something like:
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>
>   diff --git a/config.c b/config.c
>   index 015bec360f..208a3dd7a7 100644
>   --- a/config.c
>   +++ b/config.c
>   @@ -2645,9 +2645,13 @@ static void read_protected_config(void)
>     system_config =3D git_system_config();
>     git_global_config(&user_config, &xdg_config);
>
>   -	git_configset_add_file(&protected_config, system_config);
>   -	git_configset_add_file(&protected_config, xdg_config);
>   -	git_configset_add_file(&protected_config, user_config);
>   +
>   +	if (system_config)
>   +		git_configset_add_file(&protected_config, system_config);
>   +	if (xdg_config)
>   +		git_configset_add_file(&protected_config, xdg_config);
>   +	if (user_config)
>   +		git_configset_add_file(&protected_config, user_config);
>     git_configset_add_parameters(&protected_config);
>
>     free(system_config);
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>
> I'm not sure if system_config can ever be NULL, but (xdg|user)_config is
> NULL when $HOME is unset, and xdg_config is also unset if
> $GIT_CONFIG_GLOBAL is set.

Not having looked into it much at all: Doesn't this then introduce
another logic error where git_protected_config() is now buggy, i.e. it's
a "lazy load" method where we'll expect to read_protected_config()
first.

The assumption with that seems to have been that it's invariant within a
single process, is that still the case, or can e.g. HOME be set during
our runtime when we rely on these functions?

(I don't know)

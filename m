Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D870C6FA8E
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 16:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiIZQ7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiIZQ7V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 12:59:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4965600A
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:58:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sd10so15109653ejc.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=3w2vdd5wdJ3GOdx+/xvt/KM/ZtdHOXG3kULNGNqNQFU=;
        b=BUWxB9KKoFVaEdE2/m/sHuQjvaJdHAtk+w4rC/fs6gBE/36KaYoPaIMz23IhKlWRXa
         Fk1BfFQvAyndOx4LvQpULvnwQNdtERVtHqCTO5UC/fOu5SAiRiw/tWe/1l/EOnYaI+u9
         bnjwk2xvRASJcDusteBcVobXh0QoenoyQ62Lwcdm45OOmkHLdml7BJOOcLCOItUJSMmd
         DfqkGPfoh8NoQ42ryPt0A30IIwbxLncX4B5Md8PSan9A8mDx8rgDCZe8C/Gks63AR95+
         Qi45toGT1bEAIYbQ0+yAr1+CiiMQwMpce/8Vrwwmk9UPgA88uTkgpJiWVIThl0kNnC+n
         pp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=3w2vdd5wdJ3GOdx+/xvt/KM/ZtdHOXG3kULNGNqNQFU=;
        b=PmiKLn0FhRJ+M39aKbs++7i+R+08Db7F7eNAnKtvO22DDAiNg0/Ohv7O4ag0YeM9zc
         KLEVmBvMvmmym10r5JHRzQXx21DKnqXBUm7CALFyfmUg8oXMGLPuBhxECsLGk+KY3MEN
         /nOUBVpuBU8ZCkIApQ+Sbu4sd1Cr5GYMuuE5Gwr0t2Zmk0PE6KcDgiHHfJ8e5NEwrrWt
         gzl8ea55bKcPMsbpQMW8I2HTFat1qKcz+YJc94YCuk+ckmazEfk/fe/cYtbZd5AgRoFz
         Tfw7IvpggGdMuh69QZ63pdZ7rO4e/7ro785xCj/ZO9Wv0uDNEVzCaETUljD/9hLATjtF
         jR5w==
X-Gm-Message-State: ACrzQf1mLedRLSXClVu6Dc6Tw3XCxLiXOKxMZhZHGDBEVNVNoCxyNpsQ
        yhNC7PkkyWeGrNeDKvwMRPerbsasGds=
X-Google-Smtp-Source: AMsMyM6C6zV3+JBJ4zxHqybeOPPr29PsT3nU3i4Fs86KHO8P+yAOytcQLH4rqb11Q49IY09VhdEZvw==
X-Received: by 2002:a17:907:3f99:b0:782:4605:530e with SMTP id hr25-20020a1709073f9900b007824605530emr19408400ejc.108.1664207915041;
        Mon, 26 Sep 2022 08:58:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b13-20020a170906708d00b00734bfab4d59sm8642830ejk.170.2022.09.26.08.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:58:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocqV6-000BR2-2b;
        Mon, 26 Sep 2022 17:58:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com
Subject: Re: [PATCH v2 1/2] maintenance: add 'unregister --force'
Date:   Mon, 26 Sep 2022 17:39:50 +0200
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
 <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
 <69c74f52eefd906c38494759a02e137e4d7c01d8.1663853837.git.gitgitgadget@gmail.com>
 <20220923130832.GA1761@szeder.dev>
 <fc6739c3-2f7c-5dab-e4a2-8243deafde50@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <fc6739c3-2f7c-5dab-e4a2-8243deafde50@github.com>
Message-ID: <220926.86mtamyvo7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 26 2022, Derrick Stolee wrote:

> On 9/23/2022 9:08 AM, SZEDER G=C3=A1bor wrote:
>> On Thu, Sep 22, 2022 at 01:37:16PM +0000, Derrick Stolee via GitGitGadge=
t wrote:
>>>  static int maintenance_unregister(int argc, const char **argv, const c=
har *prefix)
>>>  {
>>> +	int force =3D 0;
>>>  	struct option options[] =3D {
>>> +		OPT_BOOL(0, "force", &force,
>>> +			 N_("return success even if repository was not registered")),
>>=20
>> This could be shortened a bit by using OPT__FORCE() instead of
>> OPT_BOOL().  OTOH, please make it a bit longer, and declare the option
>> with the PARSE_OPT_NOCOMPLETE flag to hide it from completion:
>
> Looks like I can do both like this:
>
> 		OPT__FORCE(&force,
> 			   N_("return success even if repository was not registered"),
> 			   PARSE_OPT_NOCOMPLETE),

I don't think PARSE_OPT_NOCOMPLETE is appropriate here. Yes we use it
for most of --force, but in some non-destructive cases (e.g. "add") we
don't.

This seems to be such a case, we'll destroy no data or do anything
irrecoverable. It's really just a
--do-not-be-so-anal-about-your-exit-code option.

I'm guessing that you wanted to be able to error check this more
strictly in some cases. For "git remote" I post-hoc filled in this
use-case by exiting with a code of 2 on missing remotes on e.g. "git
remote remove", see: 9144ba4cf52 (remote: add meaningful exit code on
missing/existing, 2020-10-27).

In this case we would return exit code 5 for this in most case before,
as we wouldn't be able to find the key, wouldn't we? I.e. the return
value from "git config". Seems so:
=09
	$ GIT_TRACE=3D1 git maintenance unregister; echo $?
	17:48:59.984529 exec-cmd.c:90           trace: resolved executable path fr=
om procfs: /home/avar/local/bin/git
	17:48:59.984566 exec-cmd.c:237          trace: resolved executable dir: /h=
ome/avar/local/bin
	17:48:59.986795 git.c:509               trace: built-in: git maintenance u=
nregister
	17:48:59.986817 run-command.c:654       trace: run_command: git config --g=
lobal --unset --fixed-value maintenance.repo /home/avar/g/git
	17:48:59.987532 exec-cmd.c:90           trace: resolved executable path fr=
om procfs: /home/avar/local/bin/git
	17:48:59.987561 exec-cmd.c:237          trace: resolved executable dir: /h=
ome/avar/local/bin
	17:48:59.988733 git.c:509               trace: built-in: git config --glob=
al --unset --fixed-value maintenance.repo /home/avar/g/git
	5

Maybe we want to just define an exit code here too? I think doing so is
a better interface, the user can then pipe the STDERR to /dev/null
themselves (or equivalent).

Aside from anything else, I think this would be much clearer if it were
split up so that:

 * We first test what we do now without --force, which is clearly
   untested and undocumented (you are adding tests for it here
   while-at-it)

 * This commit, which adds a --force.

Also:

> @@ -1538,11 +1545,23 @@ static int maintenance_unregister(int argc, const=
 char **argv, const char *prefi
>  		usage_with_options(builtin_maintenance_unregister_usage,
>  				   options);
>=20=20
> -	config_unset.git_cmd =3D 1;
> -	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
> -		     "--fixed-value", "maintenance.repo", maintpath, NULL);
> +	for_each_string_list_item(item, list) {
> +		if (!strcmp(maintpath, item->string)) {
> +			found =3D 1;
> +			break;
> +		}
> +	}

This code now has a race condition it didn't before. Before we just did
a "git config --unset" which would have locked the config file, so if we
didn't have a key we'd return 5.

> +	if (found) {

But here we looked for the key *earlier*, so in that window we could
have raced and had the key again, so ....

> +		config_unset.git_cmd =3D 1;
> +		strvec_pushl(&config_unset.args, "config", "--global", "--unset",
> +			     "--fixed-value", key, maintpath, NULL);
> +
> +		rc =3D run_command(&config_unset);
> +	} else if (!force) {

...found would not be true, and if you you didn't have --force...

> +		die(_("repository '%s' is not registered"), maintpath);
> +	}
>=20=20
> -	rc =3D run_command(&config_unset);

...this removal would cause us to still have the key in the end, no? I.e.:

 1. We check if the key is there
 2. Another process LOCKS config
 3. Another process SETS the key
 4. Another process UNLOCKS config
 5. We act with the assumption that the key isn't set

Maybe it's not racy, or it doesn't matter.

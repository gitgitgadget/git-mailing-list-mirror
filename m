Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4134C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 08:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC06860F6F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 08:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhHDIfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbhHDIfa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 04:35:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0DAC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 01:35:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t3so2213825plg.9
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=KOscSyzFxoCz08DfS93Q4CizAhkeNJEgyxd5RL6Hy50=;
        b=Q058Auk9Y0mTh6/+UFomkzmWUetbDipDORc2AY0dqBefen7MGxZuTZx9hbqo8tY5Dj
         RpdPuBkEFgUNh4u7clBeG9v2aIWl12/WsknVPqYP2944lqJR5a3t5c5aojQaEX5p3iEe
         y37MxIQsF76UGCkhWYfTGZjMmYlACzRXqEDh9NQXRujjHC9+G0NRiMtV3MzDXS4EMB13
         hD4jILzygU3guK1ytlrh4OACVNixzbboNkB67pW9jgz/UIgRctT0SUl87OpiYQtWyBJD
         3CVg4mz6EMNfx1KinxGffLBZ0vRIIiY+XTYX0HEHU6yBCch6dqMjeSnlBWacEg3HJ3wk
         DJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=KOscSyzFxoCz08DfS93Q4CizAhkeNJEgyxd5RL6Hy50=;
        b=Ly9eHQwrGTE3zf/uD7NNkckDDCrCwXP9FQAeTwNI/cAu1lv3b3LqOGTzVZqIS/Q3fJ
         +ANV7yJgfYaQcx0IhLu7x6kxb4KhQCogOJOeGsb8JPgeEgq+1rMR9ejDRo3nNgeUXwgx
         zQ9R7BQRyDjiz7Ie2qWTafRby/uj2x9e8EPrnSQPaSaO8/aR0twpwByv45HEC5NWvJw7
         HnOI8sfMtg4w9CCfbE0914cBP/q+i6FpKTCm+rAsNp9/QJBtOmMO2ikg1PJohliYrnnV
         PQVOk/Au0mNsKOuAZgXiYDvUat1BjKf8kuc5hXaAimNpEd3m3uMxdPryiXc12Xbc7aTc
         sGqg==
X-Gm-Message-State: AOAM531xz5Yd3PTKpso1wCdChquSzrwd7aZ/toY3mSFObXJHARoznIK6
        51Ca2cOaFTlvCZPNIgB2G4s=
X-Google-Smtp-Source: ABdhPJz7clFnrDGCh5HFQQH67Zk6Lj8qB+PdgB2gZsHedewv7Tgf6vf3+WPyOypnrU+okhe8dIFwJQ==
X-Received: by 2002:aa7:9ac4:0:b029:3c4:3e72:95fa with SMTP id x4-20020aa79ac40000b02903c43e7295famr5823751pfp.59.1628066117996;
        Wed, 04 Aug 2021 01:35:17 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id f6sm1800679pfe.10.2021.08.04.01.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 01:35:17 -0700 (PDT)
References: <20210722134012.99457-1-raykar.ath@gmail.com>
 <87r1fps63r.fsf@evledraar.gmail.com>
 <9532C3EF-257E-4898-8C75-C49EA4B66A99@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [GSoC] [PATCH] submodule--helper: run update procedures from C
In-reply-to: <9532C3EF-257E-4898-8C75-C49EA4B66A99@gmail.com>
Message-ID: <m2wnp1a9q7.fsf@gmail.com>
Date:   Wed, 04 Aug 2021 14:05:12 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Atharva Raykar <raykar.ath@gmail.com> writes:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>>> static void update_submodule(struct update_clone_data *ucd)
>>> {
>>> 	fprintf(stdout, "dummy %s %d\t%s\n",
>>> @@ -2379,6 +2552,79 @@ static int update_clone(int argc, const char **a=
rgv, const char *prefix)
>>> 	return update_submodules(&suc);
>>> }
>>>
>>> +static int run_update_procedure(int argc, const char **argv, const cha=
r *prefix)
>>> +{
>>> +	int force =3D 0, quiet =3D 0, nofetch =3D 0, just_cloned =3D 0;
>>> +	char *prefixed_path, *update =3D NULL;
>>> +	char *sha1 =3D NULL, *subsha1 =3D NULL;
>>> +	struct update_data update_data =3D UPDATE_DATA_INIT;
>>> +
>>> +	struct option options[] =3D {
>>> +		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge=
")),
>>> +		OPT__FORCE(&force, N_("force checkout updates"), 0),
>>> +		OPT_BOOL('N', "no-fetch", &nofetch,
>>> +			 N_("don't fetch new objects from the remote site")),
>>> +		OPT_BOOL(0, "just-cloned", &just_cloned,
>>> +			 N_("overrides update mode in case the repository is a fresh clone"=
)),
>>> +		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fe=
tch")),
>>> +		OPT_STRING(0, "prefix", &prefix,
>>> +			   N_("path"),
>>> +			   N_("path into the working tree")),
>>> +		OPT_STRING(0, "update", &update,
>>> +			   N_("string"),
>>> +			   N_("rebase, merge, checkout or none")),
>>> +		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_(=
"path"),
>>> +			   N_("path into the working tree, across nested "
>>> +			      "submodule boundaries")),
>>> +		OPT_STRING(0, "sha1", &sha1, N_("string"),
>>> +			   N_("SHA1 expected by superproject")),
>>> +		OPT_STRING(0, "subsha1", &subsha1, N_("string"),
>>> +			   N_("SHA1 of submodule's HEAD")),
>>> +		OPT_END()
>>> +	};
>>> +
>>> +	const char *const usage[] =3D {
>>> +		N_("git submodule--helper run-update-procedure [<options>] <path>"),
>>> +		NULL
>>> +	};
>>> +
>>> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>>> +
>>> +	if (argc !=3D 1)
>>> +		usage_with_options(usage, options);
>>> +	update_data.force =3D !!force;
>>> +	update_data.quiet =3D !!quiet;
>>> +	update_data.nofetch =3D !!nofetch;
>>> +	update_data.just_cloned =3D !!just_cloned;
>>
>> For all of these just pass the reference to the update_data variable
>> directly in the OPT_*(). No need to set an "int force", only to copy it
>> over to update_data.force. Let's just use the latter only.
>
> Hmm, I'm trying to remember why the single bit values are treated this way
> in this whole file...
>
> ...there seems to be no good reason for it. The API docs for parse options
> state that OPT_BOOL() is guaranteed to return either zero or one, so that
> double negation does look unnecessary.

I forgot to mention why I did not address this change in my v3 patch.
The reason why we are handling boolean values this way is because they
are declared as bitfields in the 'update_data' struct. Since we cannot
take the address of bitfields, we have to use a different variable to
store when using 'parse_options()'.

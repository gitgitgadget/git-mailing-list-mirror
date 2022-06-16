Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB1BC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 17:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiFPRvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiFPRvF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 13:51:05 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A714BFCF
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 10:51:04 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id jg5-20020a17090326c500b0016a020648bcso133447plb.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=dB1hSN51v9Laheg1jKZvsdDf2B4x0lk09/iMHeJR+UU=;
        b=C62tHaKGpB1mamTB6OgRuF91NrRFdPhFibyexEuTbLumwtLOaR9Cs4bnUuuhLWjaDd
         PHUCzxXOl8H3M+Yh8TXJI2rb0VG+UmMwageGRF67hBK9MB/F7op5kEHRIbVVBgc7HGL0
         xgvVeyOsUL+c9YnX52N9EER1UPyuSsfDRZSCg9BVPSqOp6QJ3p8ow9bWEnvY4aTlZY0s
         kq5dOuYU4/3+Dbzh8t9wRa7IREXuJaDPfGO2miz4vtBTWKFWn/bJ/ajt7gy7TXrAZouF
         J0ftjLFOCT6UMej+AdON9tcyer+qPpCrNFD14nkeceU7CYc5mzin+zMk5HEULYPGvEqb
         H45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=dB1hSN51v9Laheg1jKZvsdDf2B4x0lk09/iMHeJR+UU=;
        b=ZqrzBuB5S5AcLEmT5n1PTl9R96PkyCrZFhRVXWMYWne8GB40es2kQ4TQnFIYiCfUg4
         RJbc8/+BkHKQPgq3BQrGkFF8Euag0ub2W4QaFUVlzhJG+1Ph6V3jcumkK/9ymEnr42L9
         1wzpGVn/nTBMSRJsGLH6Y47Qv0cvC7N1OqMQuAbuOVx7Q5hGTP1UICQJZMpR9/poHp8Z
         GJY7BfkoazOUUnPJ4yDpN3FWX/aVn2hFVO8/m8E6V50oDBGeDf2mqkrbcqElwBFBBF0a
         c1ZXV2JkhecxpsNxtmhrFrbw70O/l3TwQdVkQZGmoGSFZopr7fPbWpoIZ6l90SJaMQTW
         9dBw==
X-Gm-Message-State: AJIora+UayTTUO+ef1L5K4UXHLU+D3O80wPWsd28BWkxwgvPDre5WuiM
        TDzEUMmyjilfZYsfOGacpN0FFL7RTBFWTg==
X-Google-Smtp-Source: AGRyM1tpdwZ5T0bmXDS8ttlqgqO6vwQ7tn0vTNTvDAowZ3zV9MUhTQhQCxMEv9neS0f/WGARUEv2jbFUeyiB2g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d504:b0:167:756a:f992 with SMTP
 id b4-20020a170902d50400b00167756af992mr6118310plg.160.1655401863903; Thu, 16
 Jun 2022 10:51:03 -0700 (PDT)
Date:   Thu, 16 Jun 2022 10:51:02 -0700
In-Reply-To: <xmqq35g5xmmv.fsf@gitster.g>
Message-Id: <kl6lsfo44hvd.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
 <877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com>
 <xmqq35g5xmmv.fsf@gitster.g>
Subject: Re: [PATCH 03/11] submodule--helper: avoid memory leak in `update_submodule()`
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Reported by Coverity.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  builtin/submodule--helper.c | 2 ++
>>  1 file changed, 2 insertions(+)
>
>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 5c77dfcffee..d7b8004b933 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2512,6 +2512,8 @@ static int update_submodule(struct update_data *up=
date_data)
>> =20
>>  		next.recursive_prefix =3D get_submodule_displaypath(prefixed_path,
>>  								  update_data->prefix);
>> +		free(prefixed_path);
>> +
>
> This function has two very similar code block that computes
> prefixed_path depending on the same condition, and one frees the
> variable correctly while the other one (i.e. this one) forgets to do
> so, which is irritating to see.

Good eye, I hadn't noticed this.

In this case, we're computing the same thing twice in the function -
first unconditionally, then conditionally. So we can actually just reuse
the first result by doing something like

		next.recursive_prefix =3D xstrfmt("%s/", update_data->displaypath);

(note that we need to append a "/" at the end)

> Perhaps the whole "we have update_data structure, in which
> recursive_prefix, sm_path and prefix members in it; please set the
> displaypath member based on these values" should become a helper
> function, e.g.
>
> 	static const char *displaypath_from_update_data(struct update_data *u)
> 	{
> 		char *pp, *ret;
>
> 		if (u->recursive_prefix)
> 			pp =3D xstrfmt("%s%s", u->recursive_prefix, u->sm_path);
> 		else
> 			pp =3D xstrdup(u->sm_path);
>
> 		ret =3D get_submodule_displaypath(pp, u->prefix);
> 		free(pp);
> 		return ret;
> 	}
>
> to avoid duplicated computation.

Even better, I recently noticed that .recursive_prefix can probably just
be replaced with "--super-prefix", and that will let us dispatch to
get_submodule_displaypath() without this extra dance here.

I'll flesh that out into a series and send it soon.

> But the whole thing may become moot, as there seems to be a move to
> get rid of submodule--helper.c altogether?
>
>
> I'll refrain from touching this patch and instead redirect it to
> Glen; perhaps removal of submodule--helper.c involves moving the
> code here to another file or something, in which case it is far
> easier if I outsource that to somebody who is actually working on
> the file ;-)

cc-ed =C3=86var, who knows even more than I do :)

git-submodule.sh is definitely going away soon \o/ but I don't think we
have plans to get rid of submodule--helper.c just yet, so I think we
should probably still keep this patch.

>
> Thanks.
>
>>  		next.prefix =3D NULL;
>>  		oidcpy(&next.oid, null_oid());
>>  		oidcpy(&next.suboid, null_oid());

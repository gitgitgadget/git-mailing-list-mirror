Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161D6C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiGMSFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 14:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMSFV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 14:05:21 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050D328E34
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 11:05:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r23-20020a17090a941700b001f04239bebdso3864784pjo.2
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=PgE7qnQYZn0WIy7HQoHMj/B3sArgnd8hexI+n9bMuko=;
        b=TB0VD6Eqetuf1BqCAbpTnmowBwy1AMkQBAam57A+ss1dzXrDu190j1pulQPulEmv6J
         XCHCFC3k3XgvqLn0x/i6ZQPtS+Ijp39fNtsNfQlRforyOMSscBdEHYFvqXvQzw7bF5Ys
         NZJQpdNKV9yMtwi+IBCtuqt82+SlfO1zPDcteUzdNuZ6B2dTNWoVhB9VtwdWDMX5TC+l
         6Fal0OQqBZWZDNo40IuGdcji3t3CITaNLNcrEMi9UQ9Eac3roBO0K1HLt2z23OwNrZuM
         zt/bgtoOc6atply3kLMvoHvEH5IFyfR+tOJI91bHeUw8Ms2mu2LO63eSAOe8lWtLPUnN
         /wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=PgE7qnQYZn0WIy7HQoHMj/B3sArgnd8hexI+n9bMuko=;
        b=iPASUWj7prUYImw5YdR5M4OLE+3wb+Ylatxkc9b+E0Gg82FF7xLF1lvz3AHyBJ1G/T
         55ShCRB7li7xkANapYom8T3kUPK537zt98w6VhxFpfbkU+qZqBLg6VuFRAWOORF+irHs
         ZKJbL7AqXHLPDZT8UUQhRUUJ27p2rGMwFTUACW5+ju2fjmsUKzcuP7j13dYT/gSEP+pD
         DI7m+f4zcp9i2yK9FCivVYvY5r5lAeD5BCpek+NY0zJGLR+CbbeeB9y+sCpU3dU1P0QW
         r6WjLCuUqcx5Z97BxUZHwGJf0L6GdKJ2KmtDkiNwdFmODEPX7puQ/tYrOCq3k1QJp1PF
         v7sw==
X-Gm-Message-State: AJIora/9j3YqaGziQpiVAoBvVxAzu5gr9rtHttqIfOH3OlQoVnqxRdtS
        jPgivVfkXRUcucaZ235Xl2zj8HHlrHqIsw==
X-Google-Smtp-Source: AGRyM1vgDARXCT49kNPa9epSyafb3PvPDa+2CXDDfnZ/SviW/TJokWmDbsJ7AyRBWRF/RWjq4VuIBNRc1+fOtg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3e8e:b0:1f0:1ac:5908 with SMTP id
 rj14-20020a17090b3e8e00b001f001ac5908mr4983812pjb.175.1657735519473; Wed, 13
 Jul 2022 11:05:19 -0700 (PDT)
Date:   Wed, 13 Jul 2022 11:05:17 -0700
In-Reply-To: <kl6lmtdc6hhp.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lilo06g82.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <patch-03.11-e5ec6945409-20220713T131601Z-avarab@gmail.com> <kl6lmtdc6hhp.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 03/11] submodule--helper: fix "module_clone_data" memory leaks
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 73717be957c..23ab9c7e349 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1511,6 +1511,7 @@ static int module_deinit(int argc, const char **ar=
gv, const char *prefix)
>>  struct module_clone_data {
>>  	const char *prefix;
>>  	const char *path;
>> +	char *path_free;
>>  	const char *name;
>>  	const char *url;
>>  	const char *depth;
>> @@ -1527,6 +1528,11 @@ struct module_clone_data {
>>  	.single_branch =3D -1, \
>>  }
>> =20
>> +static void module_clone_data_release(struct module_clone_data *cd)
>> +{
>> +	free(cd->path_free);
>> +}
>> +
>>  struct submodule_alternate_setup {
>>  	const char *submodule_name;
>>  	enum SUBMODULE_ALTERNATE_ERROR_MODE {
>> @@ -1651,9 +1657,9 @@ static int clone_submodule(struct module_clone_dat=
a *clone_data)
>> =20
>>  	if (!is_absolute_path(clone_data->path)) {
>>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
>> -		clone_data->path =3D strbuf_detach(&sb, NULL);
>> +		clone_data->path =3D clone_data->path_free =3D strbuf_detach(&sb, NUL=
L);
>>  	} else {
>> -		clone_data->path =3D xstrdup(clone_data->path);
>> +		clone_data->path =3D clone_data->path_free =3D xstrdup(clone_data->pa=
th);
>>  	}
>
> Hm, having .path_free doesn't seem necessary. If I'm reading the code
> correctly,
>
> - in module_clone() we set clone_data.path from argv
> - then we unconditionally call clone_submodule(), which does all of the
>   hard work
> - in clone_submodule(), we always hit this conditional, which means that
>   past this point, clone_data.path is always free()-able.
>
> which suggests that we don't need clone_data.path_free at all. I suspect
> that just this
>
>    static void module_clone_data_release(struct module_clone_data *cd)
>    {
>    	free(cd->path);
>    }
>
> is enough to plug the leak (though admittedly, I haven't properly tested
> the leak because it's been a PITA to set up locally).
>
> That's a pretty hacky suggestion though, since we're still using the
> same member to hold free()-able and non-free()-able memory....

Ah, here's a wacky idea (whose feasibility I haven't thought about at
all) that would make things a lot cleaner. If we had something like
OPT_STRING_DUP, that xstrdup()-s the value from argv when we parse it,
then we could drop the "const" from clone_data.path and just free() it.

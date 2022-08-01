Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E5C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 15:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiHAPH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 11:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAPH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 11:07:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099B222AF
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 08:07:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i13so14107571edj.11
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=wnDa6j6U6Ft2pw7RzBTNVrcLjD1nDgKZ4W9PlnxWS8g=;
        b=ORH0M1hk8K7IPDu/iFGjAqC21BMidRMwlYR/cg4ycP/o0xxnvc/SU0jYozq6sduBcj
         1Yp72JzS5RzZuDVMkeTB2/ca5bulF7VvxmTw4mTQmTaEJQvw1MwAjsmbFsChKfvuonYT
         W3hIghyz0Zdgasi/4sQc6h0I8BeP+ukP8QPkTMKvhTnoaMoarsTz4D2XF/mK8SA7y1sm
         tz4cXS8n0j/kz8J+nN0oIl268i8Rft+PFukK7Wo2xfvTbPfD8vnOmEmEI3g+FSW6HZSZ
         xp2jjdNwa/RVAaJmhIVjVQ7Pv7PMHBpIczBIojXT4UPdhiMzTpCtX+q2JaJK+g7kPSeY
         V2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=wnDa6j6U6Ft2pw7RzBTNVrcLjD1nDgKZ4W9PlnxWS8g=;
        b=0P9STKrLLCw422HwnvYa2ISV0XoK5SjVO48HNuVwQiVNmtejdq52TX2laQNVxEWjLT
         aOnuyXLqiJtPVsT94F8G2UHNnwslQVbR+XFeOTncBpCF6XUpIGK3zMRlGflG7C82ghTU
         M0AVDHbfv3L+7d3PiFzOwZl4RbahPAGtV1lujAyXbIyBQYe7EdFgJaQCX3Qd8oVpTVK9
         PwJ0OIeu7KCo1HwEVR/sKvb6G7Jv4u/18eZbFmy87MTIYQCQIO79IIuKlBKMeAtWVuC9
         hkKQno1yjPD1v+pcb6Iw+nLQrMTYvhSG+zG8hE1Nrhti1kRDtBvikVRbziFnXgHKXpb6
         eTfQ==
X-Gm-Message-State: AJIora/qoDmZ0Ay1DoMrN+A5J35xifhZfWvgbIQd3fsqjWLiXIznMt2U
        ojnbfbktqHif4jcs5gGIx7Q=
X-Google-Smtp-Source: AGRyM1txWFi/xIsDGE8xJzEUk6SYdy0ef0u+VPuiMNSp2E9oQkZ0XdMQPB5YGqoSU8j9Y/JjdmYSkQ==
X-Received: by 2002:a05:6402:5244:b0:43a:77b8:6bdf with SMTP id t4-20020a056402524400b0043a77b86bdfmr15961079edd.153.1659366474100;
        Mon, 01 Aug 2022 08:07:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b0072af0b036f3sm4673857ejc.41.2022.08.01.08.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 08:07:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oIX1M-008yRe-2J;
        Mon, 01 Aug 2022 17:07:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 14/20] submodule--helper: pass a "const struct
 module_clone_data" to clone_submodule()
Date:   Mon, 01 Aug 2022 17:05:49 +0200
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <patch-14.20-b364f3200d8-20220728T161116Z-avarab@gmail.com>
 <kl6lmtcrr2ov.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lmtcrr2ov.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220801.86v8rcgfxz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 29 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Add "const" to the "struct module_clone_data" that we pass to
>> clone_submodule(), which makes the ownership clear, and stops us from
>> clobbering the "clone_data->path".
>>
>> We still need to add to the "reference" member, which is a "struct
>> string_list". Let's do this by having clone_submodule() create its
>> own, and copy the contents over, allowing us to pass it as a
>> separate parameter.
>
> I can't help but think that this would be easier to review as part of
> the leaks series since:
>
> - Outside of leaks, I don't think we really care about ownership (though
>   please please correct me if I'm off base).
>
> - The ownership of "reference" is still quite messy (downstream code
>   might append to it, but its members are sometimes free()-able and
>   sometimes not), so it's hard to visualize what we're getting out of
>   this change without seeing the corresponding leak fix.

I'll amend the commit message. I'll leave this in this series, as
starting to split "is this really just for the leak fix?" out of this
will generally lead to the slippery slope of bundling most of this up
again.

I think the addition of "const" helps things along independently of
that.

>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 6cedcc5b239..e235acce985 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1569,18 +1567,20 @@ static char *clone_submodule_sm_gitdir(const cha=
r *name)
>>  	return sm_gitdir;
>>  }
>>=20=20
>> -static int clone_submodule(struct module_clone_data *clone_data)
>> +static int clone_submodule(const struct module_clone_data *clone_data,
>> +			   struct string_list *reference)
>>  {
>>  	char *p;
>>  	char *sm_gitdir =3D clone_submodule_sm_gitdir(clone_data->name);
>>  	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>> +	const char *clone_data_path;
>>=20=20
>>  	if (!is_absolute_path(clone_data->path))
>> -		clone_data->path =3D xstrfmt("%s/%s", get_git_work_tree(),
>> -					   clone_data->path);
>> +		clone_data_path =3D xstrfmt("%s/%s", get_git_work_tree(),
>> +					  clone_data->path);
>
> - (this is pretty minor) It feels weird to see that we're intentionally
>   leaking clone_data_path at its inception. We aren't introducing any
>   new leaks, but moving this to the leaks series makes it clearer that
>   we eventually do the right thing.

Here we're just preserving the status quo, memory leaks aren't really
tied to variable scope (except as a reporting convenience in some
tools). We're leaking in the same way before & after this. I think it's
better to fix the leak in the follow-up series to separate the concerns
here.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93BAC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjAJFkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjAJFk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:40:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835E13F44F
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:40:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o15so7940763wmr.4
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MAwg3IGR6/9CMo+0/Wrh3zXVF+F0ISvqnkYgr2kuaWk=;
        b=cvJTvfGGM5p2126VdXIGS7RaFJCIBCFciZb1hhvU0lneDQyeyi9ru+yr0XMQn72jP4
         gdDcM41E546lmH30XP7Hvgm36phN4povlbbj3V5kFTHrF4UGazaTNBH1ctHj/AX8FXun
         K8mTv1iT/MkWP1knwH9EHWWHCLz1bVFQLXu9oGuQsADEViDMgk+kaR1enZY7dLPtDFwj
         jntcmPYEvtfrKjPZpU7b/Q4zBkR2YOHR5aj3EuvwKccz+GefqLh9tww+XLOCTNS6x876
         lk58i2V5a01z9beyPGDkXFZbqV4S8qrUfJ2te9dTYu1DY3I+j/TiE/7rRjC8bZauLKHo
         owtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAwg3IGR6/9CMo+0/Wrh3zXVF+F0ISvqnkYgr2kuaWk=;
        b=bOXw0s91jsNLzvytTEKDoZhcQUELz1LfS/eDNKkjV9RO/NOsvAuefk4s6cMwZSoqGm
         0oi4RpG0dpPblSfcf6NquI6vJVEJonYZ1jmMxUpdfdrjWHLI682kUPAsudWMvfWTNNZR
         Qavvc1v8AaZMLPb1rhbxUDl9yysMuqT9EyCK4OPRphy8NgNqoBfG3J2e2HOvkOwM8jcq
         Vfy2QBhOzFdA0o+a64YKrGWU9m18XptKkgy1Wvx4EtHzsdKOkN5MOqloSS2z/061saXA
         LZkN5OBJR6vnoZbiPQfukKJ8SuQv4dQLk3dpnnqJnkhN2dG8UKq7lH4ORQMsRpa2D3b3
         f/LA==
X-Gm-Message-State: AFqh2ko9QGl5SwDQN/zlsLRO861l/LXTokhPn1nek7h7Ncf48UmlDU+i
        +vrHLgarabHZIA+fQhkBjzU=
X-Google-Smtp-Source: AMrXdXu8ImuNI28YcO/wYdt8pdmgyTOlONBBNDjDBFyt58kycjz1hVj+bGlEkjFdnlxoqcwlUZweZw==
X-Received: by 2002:a05:600c:35d4:b0:3d2:2d2a:d581 with SMTP id r20-20020a05600c35d400b003d22d2ad581mr47374392wmq.30.1673329225903;
        Mon, 09 Jan 2023 21:40:25 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b003d9ea176d54sm11252975wmq.27.2023.01.09.21.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:40:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pF7N2-000Gzx-1U;
        Tue, 10 Jan 2023 06:40:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 15/20] connected.c: free(new_pack) in check_connected()
Date:   Tue, 10 Jan 2023 06:39:38 +0100
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
 <patch-v2-15.20-d5210017cab-20221230T020341Z-avarab@gmail.com>
 <755d84d5-62f1-4f4e-ff31-4604c0dca0a9@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <755d84d5-62f1-4f4e-ff31-4604c0dca0a9@web.de>
Message-ID: <230110.86wn5vymk7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 30 2022, Ren=C3=A9 Scharfe wrote:

> Am 30.12.22 um 03:18 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Fix a memory leak that's been with us since this code was introduced
>> in c6807a40dcd (clone: open a shortcut for connectivity check,
>> 2013-05-26). We'd never free() the "new_pack" that we'd potentially
>> allocate.
>
> That's obviously not true because the patch removes free() calls for
> it, so at least some execution paths were already cleaning it up.
>
> Taking a closer look, though: Is there a leaking execution path
> without this patch at all?
>
>    $ git grep -n return connected.c
>    connected.c:41:		return err;
>    connected.c:89:		return 0;
>    connected.c:127:		return error(_("Could not run 'git rev-list'"));
>    connected.c:161:	return finish_command(&rev_list) || err;
>
> So there are four returns before.
>
>> Since it's initialized to "NULL" it's safe to call free()
>> here unconditionally.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  connected.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/connected.c b/connected.c
>> index b90fd61790c..e4d404e10b2 100644
>> --- a/connected.c
>> +++ b/connected.c
>> @@ -38,7 +38,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>>  	if (!oid) {
>>  		if (opt->err_fd)
>>  			close(opt->err_fd);
>> -		return err;
>> +		goto cleanup;
>
> Where are we?
>
>    $ git grep -n new_pack.=3D connected.c
>    connected.c:29:	struct packed_git *new_pack =3D NULL;
>    connected.c:53:		new_pack =3D add_packed_git(idx_file.buf, idx_file.le=
n, 1);
>
> After new_pack is initialized to NULL, but before it is set to
> point to some actual pack object.  So no free() is needed here.
>
>>  	}
>>
>>  	if (transport && transport->smart_options &&
>> @@ -85,8 +85,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>>  promisor_pack_found:
>>  			;
>>  		} while ((oid =3D fn(cb_data)) !=3D NULL);
>> -		free(new_pack);
>> -		return 0;
>> +		goto cleanup;
>
> free() removed, no leak before.
>
>>  	}
>>
>>  no_promisor_pack_found:
>> @@ -123,8 +122,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>>  		rev_list.no_stderr =3D opt->quiet;
>>
>>  	if (start_command(&rev_list)) {
>> -		free(new_pack);
>> -		return error(_("Could not run 'git rev-list'"));
>> +		err =3D error(_("Could not run 'git rev-list'"));
>> +		goto cleanup;
>
> Same here.
>
>>  	}
>>
>>  	sigchain_push(SIGPIPE, SIG_IGN);
>> @@ -157,6 +156,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>>  		err =3D error_errno(_("failed to close rev-list's stdin"));
>>
>>  	sigchain_pop(SIGPIPE);
>> +	err =3D finish_command(&rev_list) || err;
>> +cleanup:
>>  	free(new_pack);
>> -	return finish_command(&rev_list) || err;
>> +	return err;
>
> free() kept, no leak before.
>
> And that's all four returns.
>
> So there is no leak to begin with here, or am I missing something?

The commit message was just out of date, this was just the
post-refactoring for the already landed dd4143e7bf4 (connected.c: free
the "struct packed_git", 2022-11-08), but I forgot to update it.

I'll just drop this patch, as this series is meant to be leak fixes, not
such post-refactorings, sorry.

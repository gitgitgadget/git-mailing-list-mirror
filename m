Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6238C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 16:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB8B6124C
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 16:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhJEQBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbhJEQBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 12:01:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46717C061764
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 09:00:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g8so728609edt.7
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yzHn/F4wgfwxFtpFL65J742/ywwpUw0AERPbAiYsakc=;
        b=RDJ26V4TQS12/9RVWZTLqfNSWnhCzWtUjrITj00XHqdSjIEafyDB9CVsoYF3qsR+jx
         Kc06N8CRNhWBJiUiu8x/A+jah09G5Gb1lTH7r9YtDp9XGmblU7ykYyR5Fa7Opx3Ab05X
         wVnfarwc7X2ewKDMjIG8NMm/RB5SwhAczblTleNcbriqKm77wTWIwRst0V89bkX5CGLp
         6Sd/lQff2Ooxjze1ObYJW7Mjs8LodmcaGb1iniqH26Hh8zlAHBVqrRwl2bT2IXf+hweZ
         g3tFU/egTz1+I0BmVsj0zMnC48LSwwXqld53tJwhKizO9uXXomLRDuex3+wJ/xc8jYTO
         TViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yzHn/F4wgfwxFtpFL65J742/ywwpUw0AERPbAiYsakc=;
        b=rgU0gw9eVs7MYc/EV+olJUY2tvjIG4xnQjxckfA0TNMFVNIOtHvC3GOBwUUcuoGxQW
         N4w3lD7PEvERIVMX9Yyh7d1tJ9JEQuperdgtsvWmYqUuCy3EnPbTCrcUDqnUUP2caswk
         BVwEjmZgUGTwotCPxW0WrsaWx/z/PaGJsNZ2IMsS6QCazpKGOQ6RsLpSG/BG1rOE0paT
         LX+zdyrdZtKaH4BJ8k1AOEvbjc3+FQUVwT1pT18kTWIFVuMS93rxKzgKVIAd0921PwPB
         B0UkzgvaCZBe+4wZwTwbqRU+naKu+PwQ1a87BxPMCdYacb9z8Fc/geJ4cewbbFDjJfFT
         PD9g==
X-Gm-Message-State: AOAM532Gf8eCqgODNj4qPuMP8dL8AXoyArs6vqM7nXGLk/Rfshu5k0F2
        clpymSRTll9GRkQXsq2leEs=
X-Google-Smtp-Source: ABdhPJyEDSo20IG1hQkVuNJYmUvpP9Inxy8TvbyeEP51vsIwyEH8na9OcPvwQTJvmhzHs0dGZjKCwg==
X-Received: by 2002:a05:6402:19ba:: with SMTP id o26mr27151090edz.1.1633449599755;
        Tue, 05 Oct 2021 08:59:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 5sm7856162ejy.53.2021.10.05.08.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:59:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] object.[ch]: mark object type names for translation
Date:   Tue, 05 Oct 2021 17:52:36 +0200
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
 <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
 <5d47caad-7f0b-f6ce-b055-dc21d58892cc@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <5d47caad-7f0b-f6ce-b055-dc21d58892cc@gmail.com>
Message-ID: <874k9vlawx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 05 2021, Bagas Sanjaya wrote:

> On 04/10/21 21.27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>   static const char *object_type_strings[] =3D {
>>   	NULL,		/* OBJ_NONE =3D 0 */
>> -	"commit",	/* OBJ_COMMIT =3D 1 */
>> -	"tree",		/* OBJ_TREE =3D 2 */
>> -	"blob",		/* OBJ_BLOB =3D 3 */
>> -	"tag",		/* OBJ_TAG =3D 4 */
>> +	/*
>> +	 * TRANSLATORS: "commit", "tree", "blob" and "tag" are the
>> +	 * name of Git's object types. These names are interpolated
>> +	 * stand-alone when doing so is unambiguous for translation
>> +	 * and doesn't require extra context. E.g. as part of an
>> +	 * already-translated string that needs to have a type name
>> +	 * quoted verbatim, or the short description of a command-line
>> +	 * option expecting a given type.
>> +	 */
>> +	N_("commit"),	/* OBJ_COMMIT =3D 1 */
>> +	N_("tree"),	/* OBJ_TREE =3D 2 */
>> +	N_("blob"),	/* OBJ_BLOB =3D 3 */
>> +	N_("tag"),	/* OBJ_TAG =3D 4 */
>>   };
>>=20=20=20
>
> Are these object type names safe for translating? (e.g. can they be
> translatable without affecting private API string, which aren't=20
> translatable)?

Yes, the N_() macro is always a noop. It's just there so the i18n
tooling knows to pick up these strings and drop them into
po/git.pot. See po/README.md for details.

It does change the behavior of any code that later does
_(type_name(type)), as the string will then (potentially) be found in
the *.mo files, but as shown in 2/2 that needs to be added to each
callsite manually. So we're not going to translate "ls-tree" output or
whatever just because it has "tree" etc. in it.

>> +/*
>> + * TRANSLATORS: This is the short type name of an object that's not
>> + * one of Git's known object types, as opposed to "commit", "tree",
>> + * "blob" and "tag" above.
>> + *
>> + * A user is unlikely to ever encounter these, but they can be
>> + * manually created with "git hash-object --literally".
>> + */
>> +const char *unknown_type =3D N_("unknown type");
>> +
>>   const char *type_name(unsigned int type)
>
> Did you mean that "unknown type" is generic shorthand?

Yes, we could get the actual type name here, but it's a bit of a pain,
and as noted in 2/2 this code doesn't work anyway (which pre-dates this
series).

But I'll see if I'll remember to loop around to fixing it after my
fsck/object library fixes related to this land, but for now just marking
this for translation makes senes I think.

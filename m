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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA9DC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC0D61972
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhC1PrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhC1Pql (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 11:46:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B9C061756
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:46:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ap14so2541020ejc.0
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tqWaJ+D+vhExOqWdq2IVh/Hm2Vq4U9ojwzqKJN6cam8=;
        b=DfmisebguXT8kbAU2TMObINWXsL6BMaOjS76jsE4ZYI/tPNzUeO6J689UDQHp6cMjf
         QjZLYGx8g4Io+TGrA6MudcMXiwNKMxWDRVFj4+bU5Yms+GNo1Hr3c+jqfZRpt/P/PRZo
         MzNZ+z9wRUj8dGDN+nHScoIJkUsMGUOl2oIU9lC2kZwE1nAD8uhT5NbRXi1N3B0QFGa0
         YfTgGhaA9n4iq/NBwRabApj4Cb+ZMj5s1hHTaIzAJtGZ3tJUm8A6Gy5AX7jev7fgClCb
         rtk/gCPe3AZz+Fadmmbxeya9coB3OCku84CxJ/g+C0rCtq7tgjirpIyvmXJmMuA2CGbN
         hTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=tqWaJ+D+vhExOqWdq2IVh/Hm2Vq4U9ojwzqKJN6cam8=;
        b=KWF4ee/Ulrd3aRTLrfL+vNNq6idMYFlLjVjVN9sJ4i15ldDlfuH2Xr8Gt13DaYO+lz
         zOdgI3+i/U5Rjk73aQ5QRRi52/icrenS9PPSZfETaG6IF88tqqqlGbZb4kRfzozIJzkL
         jm47xHBJYSHpKP/ORCm2DzFkBSvaztPLU2a6kDmej5m6fmslgvuKgUk3FCzmChzgcMT+
         oObh00LwcICHkFUCIrneEmipKrxHQfINjlCq9eRO8ykFesytsk/1+UXVf/SXtCZlITSp
         aL2kvND+diIX/rTC1I+ZZ4blLtzPgznz/jQVo0s8abnGXUZw/nonL0AX/wUSyPjhJfuR
         s8+w==
X-Gm-Message-State: AOAM533TGUB5QGAweIWHCV0TCQxx8Iypm/WOPGKOb3tuNKm08l3ybc6F
        55JN++3+UvqzQHJ1SOFCpg4x81Ogkc2imA==
X-Google-Smtp-Source: ABdhPJx2KF2xYHu4dk5Vxz7rh/3PpauVlW2KqHpMgODYw7Nqgn0f8quJFEoAFqLT/vd1vOXZgkhMNA==
X-Received: by 2002:a17:907:20c7:: with SMTP id qq7mr24012835ejb.528.1616946400237;
        Sun, 28 Mar 2021 08:46:40 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r4sm6779845ejd.125.2021.03.28.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 08:46:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/10] object.c: stop supporting len == -1 in
 type_from_string_gently()
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <patch-01.11-e51c860a65d-20210328T021238Z-avarab@gmail.com>
 <xmqqy2e7on7d.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqy2e7on7d.fsf@gitster.g>
Date:   Sun, 28 Mar 2021 17:46:39 +0200
Message-ID: <87zgynmgbk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 28 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the type_from_string() macro into a function and drop the
>> support for passing len < 0.
>>
>> Support for len < 0 was added in fe8e3b71805 (Refactor
>> type_from_string() to allow continuing after detecting an error,
>> 2014-09-10), but no callers use that form. Let's drop it to simplify
>> this, and in preparation for simplifying these even further.
>
> Given the recent fallout of oversimplifying we've seen in other
> topic, this line of thinking makes me nauseated, but let's see how
> well this works this time around.

Do you mean related to tree-walk.[ch]? But yeah, this step doesn't
striclly need to be taken, but seemed worth it given that there's just
10 or so callers (none of which used this).

> At least, replacing an already queued topic with v2 would not
> increase the number of topics that are supposedly in-flight but not
> quite moving due to lack of reviews and responses, unlike bunch of
> totally new patches ;-)

I'm not sure what to do to improve things in that area.

I'm obviously for increasing the net velocity of my patches making it to
master, but if it's held up my number of reviews a submission of Y won't
necessarily make X worse, since people who've got an interest in Y will
be different than those with an interest in X.

But some of it's definitely on my end, e.g. re-rolls sometimes taking me
longer than I'd prefer. It's a different activity to dissect outstanding
reviews & re-roll than writing code, and sometimes I'm interested in one
over the other...

>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  object.c | 10 +++++++---
>>  object.h |  2 +-
>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/object.c b/object.c
>> index 78343781ae7..65446172172 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -39,9 +39,6 @@ int type_from_string_gently(const char *str, ssize_t l=
en, int gentle)
>>  {
>>  	int i;
>>=20=20
>> -	if (len < 0)
>> -		len =3D strlen(str);
>> -
>>  	for (i =3D 1; i < ARRAY_SIZE(object_type_strings); i++)
>>  		if (!strncmp(str, object_type_strings[i], len) &&
>>  		    object_type_strings[i][len] =3D=3D '\0')
>> @@ -53,6 +50,13 @@ int type_from_string_gently(const char *str, ssize_t =
len, int gentle)
>>  	die(_("invalid object type \"%s\""), str);
>>  }
>>=20=20
>> +int type_from_string(const char *str)
>> +{
>> +	size_t len =3D strlen(str);
>> +	int ret =3D type_from_string_gently(str, len, 0);
>> +	return ret;
>> +}
>> +
>>  /*
>>   * Return a numerical hash value between 0 and n-1 for the object with
>>   * the specified sha1.  n must be a power of 2.  Please note that the
>> diff --git a/object.h b/object.h
>> index 59daadce214..3ab3eb193d3 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -94,7 +94,7 @@ struct object {
>>=20=20
>>  const char *type_name(unsigned int type);
>>  int type_from_string_gently(const char *str, ssize_t, int gentle);
>> -#define type_from_string(str) type_from_string_gently(str, -1, 0)
>> +int type_from_string(const char *str);
>>=20=20
>>  /*
>>   * Return the current number of buckets in the object hashmap.


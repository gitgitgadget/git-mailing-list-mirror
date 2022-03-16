Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988ABC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 17:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbiCPRCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiCPRCW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 13:02:22 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A15468F
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:01:04 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so1819665oti.5
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=l0tzHTzkAlR/HWGTBk0JOk5uUgt3V0WHLZyJ4JEOerk=;
        b=obcKnT28BYL+gqEfB/j74seA/yRtUnf08MZPmP8djXOrZ9UeG2sKfgoCul6ZHYxSWq
         VOSZVs6W4U96LDd/86R23CCT6jYBJGGrcczzTihHGUTrcjkJi8oS6/K/ESbOGg5Y9Gmm
         GnfXOT3rPUQIMLoL90NRRAbkJRFFCrw0flvV4Uo5bahVj132WZuqp4iKtcOI7tY73ewU
         uvWGNNATy2Y/YP3xKXBvMKfshZOmNAO5yIGlBD3TGR7d641LdDFVFpqlcTEKPzFlVVGY
         FIfh4knNyl3XFgQMowVz12zgam34mxN3MScJSI2k3F0drEj+IszmFW/MShp7ElwJVsdV
         dCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=l0tzHTzkAlR/HWGTBk0JOk5uUgt3V0WHLZyJ4JEOerk=;
        b=LAXc29FjC/JgjgQZ87MTo+rmI6CGg2hUE4RghDZZLMsxZDZDv7zdL+s/c49ujDvQ3W
         Egz2LrlJ03WdhlvIYFqq4wAJW78fwKingWpufKlGvQVH2oVdGo+6X/3jOgOXiAJODEvV
         vG8WNlViQ/o8vEbNs+TZ5bs0TBvdPcEjIIxI9zMrcysbnWC2ceuDRY170Cw7QTzrM95I
         moSnptAF/aCc/GFOnu3Xxi/IHDAaPa3CJI4vXmhnP6ZyGQ5x34QibflQepGT0Rz5Xf6H
         EG8XP1C0agtHNZDmdZqhOdemU1vUjCK7uaXZ17R7gxB/y/eR/VdmmV6pa3ZHrT7KrcTg
         fIew==
X-Gm-Message-State: AOAM53041LuKnjATU0koO8cje4wQiXyDKkZtIt3SkhNndubEabA3E32i
        GClN+RPed81lb0bPBOcJn9w=
X-Google-Smtp-Source: ABdhPJyiHSbkR+3nT+Mg/Fr+CqV2SeWyd7dhsHc6B5Y3RrD9Fh5M8JKnXshvlCOkpF9p85vSYsgbFg==
X-Received: by 2002:a05:6830:2649:b0:5c9:778c:3292 with SMTP id f9-20020a056830264900b005c9778c3292mr324466otu.215.1647450063433;
        Wed, 16 Mar 2022 10:01:03 -0700 (PDT)
Received: from smtpclient.apple ([144.5.226.18])
        by smtp.gmail.com with ESMTPSA id l1-20020a056830268100b005c93e625b9dsm1221784otu.46.2022.03.16.10.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 10:01:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Drew Stolee <dstolee@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/6] object-name: make get_oid quietly return an error
Date:   Wed, 16 Mar 2022 11:01:00 -0600
Message-Id: <67325D49-FE1F-4C70-B4F8-80665C20BF3E@gmail.com>
References: <xmqqo825n8eh.fsf@gitster.g>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
In-Reply-To: <xmqqo825n8eh.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (19D52)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey guys - I=E2=80=99d been ignoring this thread as spam but just opened it a=
nd see you meant to include Derrick Stolee. I=E2=80=99m Drew Stolee, likely r=
elated but who knows how. dstolee@gmail.com is not the developer you=E2=80=99=
re looking for.=20

Best,
Drew

Sent from my iPhone

> On Mar 16, 2022, at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> =EF=BB=BF"brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
>> A reasonable person looking at the signature and usage of get_oid and
>> friends might conclude that in the event of an error, it always returns
>> -1.  However, this is not the case.  Instead, get_oid_basic dies if we
>> go too far back into the history of a reflog (or, when quiet, simply
>> exits).
>>=20
>> This is not especially useful, since in many cases, we might want to
>> handle this error differently.  Let's add a flag here to make it just
>> return -1 like elsewhere in these code paths.
>>=20
>> Note that we cannot make this behavior the default, since we have many
>> other codepaths that rely on the existing behavior, including in tests.
>>=20
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>> cache.h       | 21 +++++++++++----------
>> object-name.c |  6 +++++-
>> 2 files changed, 16 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/cache.h b/cache.h
>> index 825ec17198..416a9d9983 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1366,16 +1366,17 @@ struct object_context {
>>    char *path;
>> };
>>=20
>> -#define GET_OID_QUIETLY           01
>> -#define GET_OID_COMMIT            02
>> -#define GET_OID_COMMITTISH        04
>> -#define GET_OID_TREE             010
>> -#define GET_OID_TREEISH          020
>> -#define GET_OID_BLOB             040
>> -#define GET_OID_FOLLOW_SYMLINKS 0100
>> -#define GET_OID_RECORD_PATH     0200
>> -#define GET_OID_ONLY_TO_DIE    04000
>> -#define GET_OID_REQUIRE_PATH  010000
>> +#define GET_OID_QUIETLY            01
>> +#define GET_OID_COMMIT             02
>> +#define GET_OID_COMMITTISH         04
>> +#define GET_OID_TREE              010
>> +#define GET_OID_TREEISH           020
>> +#define GET_OID_BLOB              040
>> +#define GET_OID_FOLLOW_SYMLINKS  0100
>> +#define GET_OID_RECORD_PATH      0200
>> +#define GET_OID_ONLY_TO_DIE     04000
>> +#define GET_OID_REQUIRE_PATH   010000
>> +#define GET_OID_RETURN_FAILURE 020000
>=20
> I do not think we want this change.  The next time somebody adds an
> overly long symbol, we reformat all the lines, making it hard to
> spot that the change is only adding a single new symbol?
>=20
> I think we'd rather go the other way not to tempt people into
> right-aligning these constants, either by rewriting them into
>=20
>    #define GET_OID_QUIETLY<TAB>(1U << 1)
>    #define GET_OID_COMMIT<TAB>(1U << 2)
>    #define GET_OID_COMMITTISH<TAB>(1U << 3)
>    ...
>   =20
> in a separate preliminary patch without adding a new symbol, or
> adding the new symbol unaligned and without touching existing lines.
>=20
>> diff --git a/object-name.c b/object-name.c
>> index 92862eeb1a..daa3ef77ef 100644
>> --- a/object-name.c
>> +++ b/object-name.c
>> @@ -911,13 +911,17 @@ static int get_oid_basic(struct repository *r, cons=
t char *str, int len,
>>                        len, str,
>>                        show_date(co_time, co_tz, DATE_MODE(RFC2822)));
>>                }
>> -            } else {
>> +            } else if (!(flags & GET_OID_RETURN_FAILURE)) {
>>                if (flags & GET_OID_QUIETLY) {
>>                    exit(128);
>>                }
>>                die(_("log for '%.*s' only has %d entries"),
>>                    len, str, co_cnt);
>>            }
>> +            if (flags & GET_OID_RETURN_FAILURE) {
>> +                free(real_ref);
>> +                return -1;
>> +            }
>>        }
>=20
> So, without the new bit, we used to die loudly or quietly.  The new
> bit allows us to return an error to the caller without dying
> ourselves.
>=20
> You can call the bit _RETURN_ERROR and not to worry about the
> right-alignment above ;-), but better yet, how about calling it
> _GENTLY, which is how we call such a variant of behaviour?
>=20

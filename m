Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698BEC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 22:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiFCWc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiFCWcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 18:32:25 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAA31EEEB
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 15:32:24 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 92-20020a17090a09e500b001d917022847so4761232pjo.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 15:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=lsDmzNUakmfcNrhateJ32dILS6dJcwq0O6cw4yfFuaI=;
        b=pTMWy/RidBZw0hdk/M5TloRGuzEkPuNBdu13wInQCzI6sw41e7XzjOo2J4zZ/SXyNu
         f0Yr3TFsD0ISfp+qNqcBkYg3VJpIpe+vREiN08KfBKKFFHr4XJCyFFSyY6WBdIfrK+4b
         ++OdIxhcyoExyphkMVXIjy8WzoKP1q6u6of0BWhmrs6pf/iKAfGrJ1CqFEGzPBHpdMiw
         uaGtzbOpL2ey5kait1f1p8cSemeaL+RpNXoBnsPNwRDn3XAG8u2ehZjvgkK1y8OKS437
         yJeVjeR8oodYjMq3b3q2/04MmL+hbooqMLLxmqR9ozZRXnkUc9cAXXdFNVNiCm58FZlT
         FN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=lsDmzNUakmfcNrhateJ32dILS6dJcwq0O6cw4yfFuaI=;
        b=WpMecCENJPAWbJz9I8BdJAqjZRjguC6F2l5sVYJyRHFQvloI8Yefju6sRh57I/j2IV
         dIMJEPcj+vs09euv65gCYU7CbBcFZEpqLPBw9Qig/8cxP2LBK0Mdq//sD5rxm+BRs55C
         lhyy61iwQF+7S9kt3DZjum7sPk4p8diaVWsDgn/yTQedzqGDthSxbhHF84V9TaK7rqZj
         qTa9aPdY/JwwbX6H2OUjZVrshLdHlflxDuWr+s9HbcNl8SkiK2hVJAJx+PZlVCF4jjG3
         deshs0hvpOWvREB/R+nn9pa4kQihC/M/CcE4Iw7TdBNdfH1lTe9th6XI9zZqH+aQ7oDx
         5YRA==
X-Gm-Message-State: AOAM53185Ha6pBMPqzGZIypZUQHLrHbhFEXboEPGF4p4QBHcVx4gyx4B
        od8+vBSJAyA3SAgkePDSwwEGmFpPIk61cg==
X-Google-Smtp-Source: ABdhPJy51udHu8F7/jpRmtEXpEDZJ2/WpoA5brzMNP9VWSxw7mCr755qWTXOC9P+AU30LNwDNGwmkRtOUojSvg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:179a:b0:51b:cd4c:3e83 with SMTP
 id s26-20020a056a00179a00b0051bcd4c3e83mr9631176pfg.10.1654295543593; Fri, 03
 Jun 2022 15:32:23 -0700 (PDT)
Date:   Fri, 03 Jun 2022 15:32:14 -0700
In-Reply-To: <0c296c0e-bbd4-57a6-1cab-3b98c3bc8927@web.de>
Message-Id: <kl6l35gle5u9.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-01.15-b3a678d934a-20220603T183608Z-avarab@gmail.com> <0c296c0e-bbd4-57a6-1cab-3b98c3bc8927@web.de>
Subject: Re: [RFC PATCH 01/15] remote.c: don't dereference NULL in freeing loop
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        "=?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason" 
        <avarab@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  remote.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/remote.c b/remote.c
>> index 930fdc9c2f6..61240562df1 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -144,14 +144,10 @@ static void remote_clear(struct remote *remote)
>>  	free((char *)remote->name);
>>  	free((char *)remote->foreign_vcs);
>>
>> -	for (i =3D 0; i < remote->url_nr; i++) {
>> +	for (i =3D 0; i < remote->url_nr; i++)
>>  		free((char *)remote->url[i]);
>> -	}
>> -	FREE_AND_NULL(remote->pushurl);
>
> So you remove the redundant release of the pushurl array, but the url
> array, which should be freed here after its elements are released, still
> leaks.  The duplicate FREE_AND_NULL perhaps resulted from a copy&paste
> error.

This seems like the most likely explanation (even I don't recall how I
ended up introducing this bug..). I probably meant to change pushurl ->
url, but forgot somehow.

>> -
>> -	for (i =3D 0; i < remote->pushurl_nr; i++) {
>> +	for (i =3D 0; i < remote->pushurl_nr; i++)
>>  		free((char *)remote->pushurl[i]);
>> -	}
>>  	FREE_AND_NULL(remote->pushurl);
>
> Why set pushurl to NULL after release?  This results in an invalid state
> unless pushurl_nr und pushurl_alloc are reset to zero.  Same goes for
> the url array above -- either a simple free(3) call suffices or url_nr
> and url_alloc need to be cleared as well.

True, thanks for catching that. We'd probably never notice it because we
never reuse the clear-ed `struct remote` (since we only ever call this
when we clean up `struct repository`), but it's better to do the 'right
thing'.

I didn't consider that when I chose to use FREE_AND_NULL() instead of
free(), and there wasn't any particular reason why I chose one over the
other.

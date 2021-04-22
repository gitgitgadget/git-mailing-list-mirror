Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0F9C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 06:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984BC61450
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 06:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhDVGKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 02:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhDVGKh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 02:10:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEF1C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 23:10:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w23so51183436ejb.9
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 23:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=sj32O456b6qJTwrjdaC5yee03gsudSOTnLKApxEUFao=;
        b=nQfBlxiB18kmH5+RBhLpOhzPgY209ciXs8TNNahanraAEOD4eYlW8fvpN8Wr6Lu7TC
         1lpRjyTwesJGgWggRQvCvzdn7ZqsNAg/Rw8Xwtmlzw5UIMHJAcSvaBY+7cqD3x2Kxetl
         KsqmqTJeZ6R8uNiX7VZVOjrqXE4mHBnB2DJXBe7JZsXWKk0UOcZuAPLyvsjI7FkLLXlM
         NDXfGYeUyug4HkM5b1bY0J8ccnLTF8ioczfRsapsbzPYh3XpMYFEs1Ky4ijc10WaQkz3
         uv0S8X/xS3YWKYDasx5F75SmYIwzNSc8zA3Uu1aguzlipJY4jJAI8SSpDOeCUb+GQrYQ
         FAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=sj32O456b6qJTwrjdaC5yee03gsudSOTnLKApxEUFao=;
        b=mt5NQenyNybiU6sscvC5Y92adsFAFFVzGZE5KnlUw2I8Xv+ImG/KJXEoyNDV+GdZJD
         qhVeXsLCLlRWUBksTA1JzgBi1Hcwv1KO3bHl7qp5Q8FwRDEhwR0dBVRBDfaaMcHCzRhu
         SHFAxYdn8+zJPDwFrleOqMFcRHA+njOWq1M3/Csv13ot+zUfYW7fEpQYf13Ekqqs85wE
         e/mnTHzvbaMjbdCRH3coe8KzqX3gF+gCkeY7cRLLPGoTfybfSskKlfuV4ki4YJYxGhr8
         hcsEkpscchotKqy31joh5fWUKI8Ghl219AFwKWT3vILjjlPrXQhLl3z3AxwdzDpulePs
         xbwQ==
X-Gm-Message-State: AOAM530UWSZxlgoLdxPBjb3kZYABpW7xTwFXUf+CUeTqFG8ufZGEUI5x
        vx4dBTWJaiaPospy/8KXaks=
X-Google-Smtp-Source: ABdhPJxrNKP/ejWMvMcLrnA6BD/uomZPAb5adJXWhlY68e8srNPALRYxZu0v9eojLOR5QYUx1l8Ifg==
X-Received: by 2002:a17:906:3e54:: with SMTP id t20mr1601531eji.53.1619071802090;
        Wed, 21 Apr 2021 23:10:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id he35sm1109349ejc.2.2021.04.21.23.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 23:10:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, me@ttaylorr.com, newren@gmail.com
Subject: Re: [PATCH v2 2/8] object.c: add a utility function for "expected
 type X, got Y"
References: <patch-2.8-1b472fcd85-20210420T133218Z-avarab@gmail.com>
 <20210421220300.1022458-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210421220300.1022458-1-jonathantanmy@google.com>
Date:   Thu, 22 Apr 2021 08:10:00 +0200
Message-ID: <877dku3l53.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 22 2021, Jonathan Tan wrote:

>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 7618303f7b..b952106203 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -2999,6 +2999,7 @@ static int read_oid_strbuf(struct merge_options *opt,
>>  	if (!buf)
>>  		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
>>  	if (type != OBJ_BLOB) {
>> +		const char* msg = oid_is_type_or_die_msg(oid, OBJ_BLOB, &type);
>>  		free(buf);
>>  		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
>>  	}
>
> Stray extra line.
>
>> +void oid_is_type_or_die(const struct object_id *oid,
>> +			enum object_type want,
>> +			enum object_type *type)
>> +{
>
> Thanks - this looks like a good simplification.
>
> Why is type a pointer? Maybe it's to better distinguish the values at
> the call site (one pointer, one not), but this solution is confusing
> too.

Yeah I came up with it because of that, so you wouldn't confuse the
OBJ_COMMIT with (presumably) a variable with the same.

But in some other cases I end up having to do:

    enum object_type type = OBJ_COMMIT;

And then pass that &type in, do you think it's worth it? Maybe I should
just change it...

>> +int oid_is_type_or_error(const struct object_id *oid,
>> +			 enum object_type want,
>> +			 enum object_type *type)
>> +{
>
> Same comment.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BF0C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 23:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiCHXKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 18:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCHXKd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 18:10:33 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2016E57B
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 15:09:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qx21so1107698ejb.13
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 15:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S532f1XvMkmneXRi8ZNFmCC5UuSCwPgolQ+TI9YM2kc=;
        b=qXIC3iFTg81+T+A+sMOKo3Fy93Bbk33sT3IvpNWwwKxwTMDIf/oIxvlF29JeKE0tQE
         4/S8ThMz3cnqPllMxGNlaknrk0/uCRPj12/AuD04uTEsXXbJUUsAjR4jVUCIpPy+uNvf
         JOCCVVJ5xxkj8Dl9X1hNi/17LM/PYFh64Zkwuc/fawj0fr7OfanOyssGRcq/tmqo4KR+
         AtLbhRDRAZB9vmLdRPs6BifsZWwWIVdIt5TMrGqlFT1w+F6MX121KGGmXnF8mMm2xPsl
         AkJwZKup909207rENAtU7jygkJcO0ypkbKkdQ9huDK7JidngD/3ytjbmAp6kWUXB5iDr
         lkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S532f1XvMkmneXRi8ZNFmCC5UuSCwPgolQ+TI9YM2kc=;
        b=0LviWYcHazlL7wZ5YfVjHt3V1LjOgYS5AdGLKptm0z0avmXritYrQ/OPdcJ7xB1cp8
         en6h/Ba8BFvgFz5nCIl5y7//tWe3gsynuZYbrQ34AEdK0iYpLO9/FGkXYCKUZDUdHjKF
         BveQxIjKy7XFR27ZSP7EgWP/AJRGoQdjgZsPR4w1DJvUbTkjUVgn4YDMNCSoUeznxw83
         HHrg5FyfEz+vr83O9r4NbSkeU6TxcFIkPfzg3QlBq7Y1jalxZEbyOXDKY/PojaX2u1Jm
         2pwGpZlF1HWZpIuUSzRJ146UJHegvSbrHVtr7l9UNjyNPbxFezittEUK8juzyENcM7pM
         MbTg==
X-Gm-Message-State: AOAM531kRYz5EOK0UoguL/Fk5lpYDbkxdX8gjsl3Lo8q8BeWDFxiqxbZ
        xA5aWYoTY9y/I3Fhi8x34x0=
X-Google-Smtp-Source: ABdhPJxXShbzHrvUYV9akyLUFGJ58R4vOk8PtGNMwMpBjSeDdM4TQrAcTP9ScfLVv5c09BF9r5cU/A==
X-Received: by 2002:a17:906:a38e:b0:6da:a1f9:f9ee with SMTP id k14-20020a170906a38e00b006daa1f9f9eemr14509512ejz.27.1646780972204;
        Tue, 08 Mar 2022 15:09:32 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id gs39-20020a1709072d2700b006d3ed4f51c6sm58067ejc.0.2022.03.08.15.09.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 15:09:31 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] cat-file: skip expanding default format
Date:   Tue, 08 Mar 2022 18:09:29 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <5A50CFA8-AD78-4774-9340-DF18C493FEC9@gmail.com>
In-Reply-To: <YifZBEAEqUvFwiEV@nand.local>
References: <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
 <pull.1221.v3.git.git.1646777327043.gitgitgadget@gmail.com>
 <YifZBEAEqUvFwiEV@nand.local>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On 8 Mar 2022, at 17:30, Taylor Blau wrote:

> On Tue, Mar 08, 2022 at 10:08:46PM +0000, John Cai via GitGitGadget wro=
te:
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 7b3f42950ec..e2edba70b41 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -351,6 +351,13 @@ static void print_object_or_die(struct batch_opti=
ons *opt, struct expand_data *d
>>  	}
>>  }
>>
>> +static int print_default_format(char *buf, int len, struct expand_dat=
a *data)
>> +{
>> +	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->o=
id),
>> +			 type_name(data->type),
>> +			 (uintmax_t)*data->info.sizep);
>> +}
>
> Two small nits here. It looks like the indentation on the second and
> third lines is off a little bit, since we'd typically expect those to b=
e
> indented to the same margin as the first argument to xsnprintf().

Thanks for bringing this up. I did have a question about indentation in t=
his
case. for the second line, I did try to indent it to align with buf. I at=
tempted
to do the same with the third line, but it's the ( that lines up with buf=
 so
optically it looks a little off.

>
> The other is that you're reading data->info.sizep by dereferencing it,
> but we know that it points to data->size. So I think there it makes
> sense to just read the value directly out of data->size, though note
> that you'll still need the cast to uintmax_t since you're formatting it=

> with PRIuMAX.

good point, I'll adjust this in the next version.

>
>> +
>>  /*
>>   * If "pack" is non-NULL, then "offset" is the byte offset within the=
 pack from
>>   * which the object may be accessed (though note that we may also rel=
y on
>> @@ -381,10 +388,16 @@ static void batch_object_write(const char *obj_n=
ame,
>>  		}
>>  	}
>>
>> -	strbuf_reset(scratch);
>> -	strbuf_expand(scratch, opt->format, expand_format, data);
>> -	strbuf_addch(scratch, '\n');
>> -	batch_write(opt, scratch->buf, scratch->len);
>> +	if (!opt->format) {
>> +		char buf[1024];
>> +		int len =3D print_default_format(buf, 1024, data);
>> +		batch_write(opt, buf, len);
>
> Just curious (and apologies if this was discussed earlier and I missed
> it), but: is there a reason that we have to use a scratch buffer here
> that is separate from the strbuf we already have allocated?
>
> That would avoid a large-ish stack variable, but it means that the two
> paths are a little more similar, and can share the batch_write call
> outside of the if/else statement.

This was holdover code from before. Looks like the scratch buffer gets pa=
ssed
in. Do you mean we don't need to allocate char buf[1024] and instead we c=
an just
use scratch and pass it into print_default_format?

>
> The rest of the changes in this file all look good to me.
>
>> diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
>> new file mode 100755
>> index 00000000000..e463623f5a3
>> --- /dev/null
>> +++ b/t/perf/p1006-cat-file.sh
>> @@ -0,0 +1,16 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'Basic sort performance tests'
>
> Is this description a hold-over from p0071? If so, it may be worth
> updating here.
>
>> +test_expect_success 'setup' '
>> +	git rev-list --all >rla
>> +'
>> +
>> +test_perf 'cat-file --batch-check' '
>> +	git cat-file --batch-check <rla
>> +'
>
> We could probably get away with dropping the setup test and using
> `--batch-all-objects` here. Note that right now you're only printing
> commit objects, so there would be a slight behavior change from the way=

> the patch is currently written, but it should demonstrate the same
> performance improvement.

This sounds good to me!

>
> Thanks,
> Taylor

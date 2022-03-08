Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DF5C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 01:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiCIBGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiCIBGi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 20:06:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D123DB498
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 16:45:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bt26so998051lfb.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 16:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6web8yRn6CulDwn+/eZBhn15y/zQBqpGdMqJ3M36tHY=;
        b=X5BYwtXt6Ck+o1qul9G7t5y1uvdvzCRFVU+qGrZ9GUsoLV36DzjzhAeE6l5IFEOIgr
         y7RPnUw4vkkKk+WZ6O2R1K/vzcpDF0IeKvju1uqrn8Ev9qE0JypBdd1psh988mX89+io
         Q40OT95tqDSPN24fKuGFLbnwiZI1h5zCYhkl24ub1QJXYkTdxJBcWgb5FhUlKi2rxF8n
         SgFeNQ+c1QbLQiicrMcTdjgUVYGxonJISnNU1NKLWe2TVDS9QAmP7o2mTkvFlFyqJ4oj
         00bdZTvXAowizaaMWRdQ6kMdwkOPeEiyaT2q3XOp/96i0folii39eXB8KYCoN2IMGRdS
         RYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6web8yRn6CulDwn+/eZBhn15y/zQBqpGdMqJ3M36tHY=;
        b=NhicSIXF+Q5D+OspCj2uRMYQ1WoHZyz1lZK5IthNo+z/zqRsOwXMYrvD+6HQF4boHY
         j/VP3+QR5xbZTwE48+EE6+wcETKXsLoza56wmbu0tTTKo4aM5izMvohzGhN5VB+IVZi8
         Z3Ryed1vU4oLkJHuVrEJRljW0dANJny6lNnG0pUDM03beas4welZzzacLHp5BJXOFZYD
         eg+gSsIVGovENlSyCwH6Cc19C4G5YcAzl8xBTVYz4/xNTw1cYpF1MtPBqZpN/2PHvIaa
         mgrX5RyRCqwYvVQiJc0qzCtP+ONRm7nC+wRH9gPOmZPVG/s+yiX/fai9k6UnUIARRDpc
         ewPg==
X-Gm-Message-State: AOAM532267AgNrhUC/EVK5coC0EinVeWAM8DzmdiwvNUeJ1WjyiEnPAm
        DnyIMiUSxwB9YYXq8tHPCSpSOobzyPE=
X-Google-Smtp-Source: ABdhPJyIiZEE9lHRYcqJ1UixltDhGQI7/GeSv1c9/Hv9sNtn5OqzyHwQ+r90P75tklo+hfM9TTnXyA==
X-Received: by 2002:a05:6402:280b:b0:416:7a43:b30e with SMTP id h11-20020a056402280b00b004167a43b30emr3746657ede.371.1646782452783;
        Tue, 08 Mar 2022 15:34:12 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id hg11-20020a1709072ccb00b006cee4fb36c7sm70612ejc.64.2022.03.08.15.34.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 15:34:12 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] cat-file: skip expanding default format
Date:   Tue, 08 Mar 2022 18:34:10 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <81B6E80C-CB84-45E6-8D26-4E32E1AAC0DE@gmail.com>
In-Reply-To: <5A50CFA8-AD78-4774-9340-DF18C493FEC9@gmail.com>
References: <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
 <pull.1221.v3.git.git.1646777327043.gitgitgadget@gmail.com>
 <YifZBEAEqUvFwiEV@nand.local>
 <5A50CFA8-AD78-4774-9340-DF18C493FEC9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8 Mar 2022, at 18:09, John Cai wrote:

> Hi Taylor,
>
> On 8 Mar 2022, at 17:30, Taylor Blau wrote:
>
>> On Tue, Mar 08, 2022 at 10:08:46PM +0000, John Cai via GitGitGadget wr=
ote:
>>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>>> index 7b3f42950ec..e2edba70b41 100644
>>> --- a/builtin/cat-file.c
>>> +++ b/builtin/cat-file.c
>>> @@ -351,6 +351,13 @@ static void print_object_or_die(struct batch_opt=
ions *opt, struct expand_data *d
>>>  	}
>>>  }
>>>
>>> +static int print_default_format(char *buf, int len, struct expand_da=
ta *data)
>>> +{
>>> +	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->=
oid),
>>> +			 type_name(data->type),
>>> +			 (uintmax_t)*data->info.sizep);
>>> +}
>>
>> Two small nits here. It looks like the indentation on the second and
>> third lines is off a little bit, since we'd typically expect those to =
be
>> indented to the same margin as the first argument to xsnprintf().
>
> Thanks for bringing this up. I did have a question about indentation in=
 this
> case. for the second line, I did try to indent it to align with buf. I =
attempted
> to do the same with the third line, but it's the ( that lines up with b=
uf so
> optically it looks a little off.
>
>>
>> The other is that you're reading data->info.sizep by dereferencing it,=

>> but we know that it points to data->size. So I think there it makes
>> sense to just read the value directly out of data->size, though note
>> that you'll still need the cast to uintmax_t since you're formatting i=
t
>> with PRIuMAX.
>
> good point, I'll adjust this in the next version.
>
>>
>>> +
>>>  /*
>>>   * If "pack" is non-NULL, then "offset" is the byte offset within th=
e pack from
>>>   * which the object may be accessed (though note that we may also re=
ly on
>>> @@ -381,10 +388,16 @@ static void batch_object_write(const char *obj_=
name,
>>>  		}
>>>  	}
>>>
>>> -	strbuf_reset(scratch);
>>> -	strbuf_expand(scratch, opt->format, expand_format, data);
>>> -	strbuf_addch(scratch, '\n');
>>> -	batch_write(opt, scratch->buf, scratch->len);
>>> +	if (!opt->format) {
>>> +		char buf[1024];
>>> +		int len =3D print_default_format(buf, 1024, data);
>>> +		batch_write(opt, buf, len);
>>
>> Just curious (and apologies if this was discussed earlier and I missed=

>> it), but: is there a reason that we have to use a scratch buffer here
>> that is separate from the strbuf we already have allocated?
>>
>> That would avoid a large-ish stack variable, but it means that the two=

>> paths are a little more similar, and can share the batch_write call
>> outside of the if/else statement.
>
> This was holdover code from before. Looks like the scratch buffer gets =
passed
> in. Do you mean we don't need to allocate char buf[1024] and instead we=
 can just
> use scratch and pass it into print_default_format?

something like this?

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e2edba70b418..2336bcc80850 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -351,11 +351,11 @@ static void print_object_or_die(struct batch_option=
s *opt, struct expand_data *d
        }
 }

-static int print_default_format(char *buf, int len, struct expand_data *=
data)
+static void print_default_format(struct strbuf *scratch, struct expand_d=
ata *data)
 {
-       return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data=
->oid),
-                        type_name(data->type),
-                        (uintmax_t)*data->info.sizep);
+       strbuf_addf(scratch, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid)=
,
+                   type_name(data->type),
+                   (uintmax_t)data->size);
 }

 /*
@@ -388,17 +388,17 @@ static void batch_object_write(const char *obj_name=
,
                }
        }

+       strbuf_reset(scratch);
+
        if (!opt->format) {
-               char buf[1024];
-               int len =3D print_default_format(buf, 1024, data);
-               batch_write(opt, buf, len);
+               print_default_format(scratch, data);
        } else {
-               strbuf_reset(scratch);
                strbuf_expand(scratch, opt->format, expand_format, data);=

                strbuf_addch(scratch, '\n');
-               batch_write(opt, scratch->buf, scratch->len);
        }

+       batch_write(opt, scratch->buf, scratch->len);
+
        if (opt->print_contents) {
                print_object_or_die(opt, data);
                batch_write(opt, "\n", 1);
>
>>
>> The rest of the changes in this file all look good to me.
>>
>>> diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
>>> new file mode 100755
>>> index 00000000000..e463623f5a3
>>> --- /dev/null
>>> +++ b/t/perf/p1006-cat-file.sh
>>> @@ -0,0 +1,16 @@
>>> +#!/bin/sh
>>> +
>>> +test_description=3D'Basic sort performance tests'
>>
>> Is this description a hold-over from p0071? If so, it may be worth
>> updating here.
>>
>>> +test_expect_success 'setup' '
>>> +	git rev-list --all >rla
>>> +'
>>> +
>>> +test_perf 'cat-file --batch-check' '
>>> +	git cat-file --batch-check <rla
>>> +'
>>
>> We could probably get away with dropping the setup test and using
>> `--batch-all-objects` here. Note that right now you're only printing
>> commit objects, so there would be a slight behavior change from the wa=
y
>> the patch is currently written, but it should demonstrate the same
>> performance improvement.
>
> This sounds good to me!
>
>>
>> Thanks,
>> Taylor

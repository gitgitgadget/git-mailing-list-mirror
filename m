Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB281C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347014AbiCHTCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbiCHTCV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 14:02:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C23650E3E
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 11:01:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s10so20136edd.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 11:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrlP0gRR0JMrYyjyxUDVVNajbbmOmyj2ACuNrXbtU0k=;
        b=Qhzv7muc929dvZVjXJ4avmU7VOC2LC/H33ZTYs4w85T3X+KWMm/R4ji/sEKj19yBs6
         vH91K+2s8+eS4tYWoqeyVA4Z5tnehpVy+qSUh1UCkCo8VSo7lbKx2/dmWMypAgA5a+QL
         Z8zhtdIPSDfJ2AKZVDbVdcDk42Psms/h11aYI+F5opimhJJuQHXxgtHiy0L2F1GwaTGg
         WmwOC+Clol6qaGaB1QEp2ERwhdq9lUpr+5zlVMg1+hdNSd6HOv1EcjDX8yx9hRvops/D
         uT0l3PvJlmup1TwBqyDwDHpSamifc4GvyvdlGb7bZxU46Tlp/Zt7HtBI7AvLCBetVebJ
         eONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrlP0gRR0JMrYyjyxUDVVNajbbmOmyj2ACuNrXbtU0k=;
        b=AolnML5sy3D4ZCTRxqg7t6DdkLhggz8p3+s3oVEJBmNA+Tjbmxvi5GsZ//aqm2JUs0
         KLcPUdVxQ6i0kzbQKfD/TkyEmVvLwHc1hG/h3bfmceIuXD9E/qRHHDUXE0l+L2xJmzTD
         KrwD7b/2Qeygkh2JE5OIq0t6azB15gX9mFd307E8eehpo7UGHxMG2pGeCiZE7h5wHJ3Q
         z9zX0RKJfMVJ43balCwf2uE1aFbY20bZnRPGLkEnMusfFS3K3tGwjiNvXILtpNbo8BRo
         xQI3ewiywWJ8WsH67qdIdbJynhUGVTLqo9U2Rbb0UGa2iv+krKj0esD6zTA7I9S6IXLy
         zapA==
X-Gm-Message-State: AOAM5323I2bVAP/luSyIZqgYmOOafEbVMxz3pk6tDyRD7hO2RkR/6rXT
        Hpb79T6ZUV4qXmxAyL+GbqA=
X-Google-Smtp-Source: ABdhPJzdVXWcitQL58ObJAcOMG3jl/kHDwuVdVW019z60UccVSsP265jEMJ1MJoIGPtEVULGL6XSZA==
X-Received: by 2002:aa7:c687:0:b0:415:eb43:8ff5 with SMTP id n7-20020aa7c687000000b00415eb438ff5mr17716702edq.74.1646766082896;
        Tue, 08 Mar 2022 11:01:22 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id si13-20020a170906cecd00b006cded0c5ee2sm6319441ejb.61.2022.03.08.11.01.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:01:22 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] cat-file: skip expanding default format
Date:   Tue, 08 Mar 2022 14:01:19 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <0D4FEF37-1652-4172-A266-9FF98DA2EE9C@gmail.com>
In-Reply-To: <xmqqmti0nzx7.fsf@gitster.g>
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
 <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
 <xmqqmti0nzx7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 8 Mar 2022, at 11:59, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 7b3f42950ec..ab9a49e13a4 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -351,6 +351,14 @@ static void print_object_or_die(struct batch_opti=
ons *opt, struct expand_data *d
>>  	}
>>  }
>>
>> +static int print_default_format(char *buf, int len, struct expand_dat=
a *data)
>> +{
>> +	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->o=
id),
>> +		 data->info.type_name->buf,
>> +		 (uintmax_t)*data->info.sizep);
>> +
>> +}
>
> OK.  We want size and type if we were to show the default output out
> of the object-info API.
>
>>  /*
>>   * If "pack" is non-NULL, then "offset" is the byte offset within the=
 pack from
>>   * which the object may be accessed (though note that we may also rel=
y on
>> @@ -363,6 +371,11 @@ static void batch_object_write(const char *obj_na=
me,
>>  			       struct packed_git *pack,
>>  			       off_t offset)
>>  {
>> +	struct strbuf type_name =3D STRBUF_INIT;
>> +
>> +	if (!opt->format)
>> +		data->info.type_name =3D &type_name;
>
> And at this point, !opt->format means we would use the default
> format, so we cannot leave .type_name member NULL.  That is OK
> but puzzling.  Why didn't we need this before?
>
> If the caller is batch_objects(), there is the "mark_query" call to
> strbuf_expand() to learn which field in data->info are needed, so
> it seems that this new code should NOT be necessary.
>
>     Side note.  I briefly wondered if this expand is something you
>     would want to optimize when the default format is used, but this
>     is just "probe just once to ensure various members of data->info
>     are populated, to prepare for showing hundreds of objects in the
>     batch request", so it probably is not worth it.
>
> I am guessing that this is for callers that do not come via
> batch_objects() where the "mark_query" strbuf_expand() is not made?
> If so,
>
>  * why is it sufficient to fill .type_name and not .sizep for the
>    default format (i.e. when opt->format is NULL)?
>
>  * why is it OK not to do anything for non-default format?  If no
>    "mark_query" call has been made, we wouldn't be preparing the
>    .type_name field even if the user-supplied format calls for
>    %(objecttype), would we?
>
> Looking at the call graph:
>
>  - batch_object_write() is called by
>    - batch_one_object()
>    - batch_object_cb()
>    - batch_unordered_object()
>
>  - batch_one_object() is called only by batch_objects()
>  - batch_object_cb() is used only by batch_objects()
>
>  - batch_unordered_object() is called by
>    - batch_unordered_loose()
>    - batch_unordered_packed()
>    and these two are called only by batch_objects()
>
> And the "mark_query" strbuf_expand() to probe which members in
> expand_data are are necessary is done very early, before any of the
> calls batch_objects() makes that reach batch_object_write().
>
> OK, so my initial guess that the new "we need .type_name member to
> point at a strbuf" is because there are some code that bypasses the
> "mark_query" strbuf_expand() in batch_objects() is totally wrong.
> Everybody uses the "mark_query" thing.  Then why do we need to ask
> type_name?
>
> Going back to the new special case print_default_format() gives us
> the answer to the question.  It expects that data->info already
> knows the stringified typename in the type_name member.  The
> original slow code path in expand_atom() uses this, instead:
>
> 	} else if (is_atom("objecttype", atom, len)) {
> 		if (data->mark_query)
> 			data->info.typep =3D &data->type;
> 		else
> 			strbuf_addstr(sb, type_name(data->type));

Thanks for going through this analysis! so looks like I am relying on
oid_object_info_extended() which calls do_oid_object_info_extended(), whi=
ch calls
type_name(co->type) if oi->type_name is not NULL.

This is a bit roundabout, so I like what you suggest below of just callin=
g
type_name() in print_default_format() directly.

>
> Which makes me wonder:
>
>  * Is calling type_name(data->type) for many objects a lot less
>    efficient than asking the stringified type_name from the
>    object-info layer?
I'm not sure, but I imagine that if the # of calls to type_name remain th=
e same,
eg: once per object that it wouldn't really matter much where in the stac=
k it
happens. Also, I took a look at type_name() in object.c and it's just a l=
ookup
in a constant array so that should be pretty fast.

>    If that is the case, would you gain
>    performance for all cases if you did this instead
>
> 	} else if (is_atom("objecttype", atom, len)) {
> -		if (data->mark_query)
> -			data->info.typep =3D &data->type;
> -		else
> -			strbuf_addstr(sb, type_name(data->type));
> +		if (data->mark_query) {
> +			data->info.typep =3D &data->type;
> +			data->info.type_name =3D &data->type_name;
> +		} else {
> +			strbuf_addstr(sb, data->type_name);
> +		}
>
>    in expand_atom()?

I don't quite follow here. Would we add a member type_name to
expand_data? Also where would the call to type_name() be to get the strin=
gified
type_name?

Also I'm thinking this approach may not work well with the default format=

optimization as we would be skipping the strbuf_expand() call altogether =
when
default format is used.

>
> 	Side note: I am keeping data->info.typep because a lot of
> 	existing code switches on data->type, which is an enum.
>
>    We may have to keep the strbuf_release() at the end of this
>    function this patch added, to release data->info.type_name, if we
>    go that route, but we wouldn't be dealing with an on-stack
>    type_name in this function.
>
>  * If it does not make any difference between calling type_name() on
>    our side in expand_atom() or asking object-info API to do so,
>    then would it make more sense to lose the local type_name strbuf
>    and print type_name(data->type) in print_default_format() instead?

I think this is the most intuitive solution.

>
> Other than that, this looks good to me.
>
> Thanks.

thanks!
John

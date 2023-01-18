Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6570EC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 23:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjARXSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjARXSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 18:18:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE40F62D05
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:18:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vw16so1211707ejc.12
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y4lo1nOdBB0Ub6JBquVjtz2s0uYxgBUfeIg4A6DHII8=;
        b=V6bs1jmQJF/6Ew/34SlcITfEX0TIdl9CaS+5YnPd1thuOWCBeGpQIJfbtoptk6/Xp8
         /t3C4H93L7rcDoa/FEOMZ2xp3On6nP3rxTVExIvUD9A8Z9F2R2NQpjUI1NNxxB9/CH4C
         x1r/64lmDuguTkiMOf7k+BfsuAX4qSaI3InP8KU7BdKir4dB0+KXr3Y1WXTOPKbZogqB
         GO+IFX9zjtDWLj72jijM9BcPiQXhWtOoI0/FkzB3ZD7KZjOIN7aMvbLCysdZ/5gJTmdN
         E1dfJFSuT02sYtsYOXLw0Jl76UjZOUhuwNIdb+GBUe/YCRjy1obzPQkFKazRAfQ+3xUU
         nDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4lo1nOdBB0Ub6JBquVjtz2s0uYxgBUfeIg4A6DHII8=;
        b=qWegosLX+aEZZ95Lxh5PCAeVt1ItdpWcC81HiEIFl8xSYrZLoeH5zhb7m9ZWZwXQzU
         Tqaql1exXcivRLHLdx4TruACtGXXd+ftaPpE2As/Kk1+/1n7kRmAgsmGyERrVp5WCmPB
         JlFpG6puKTQ0fs757hDKJjGMAiVWOLxqMaHNw/iMMG2FiTeB5VFPugoCzEVxL6e6Uwh5
         Dh6cte22Nhk6zess7szm/QDl0nlJsRoccjewfxSs9QPQRb/TsFP5DH9TcjQ1I8ijD0ys
         xhhRPcEx4+0gUPobN4SCUqMN8uodCETOHIgPF1fTwRotmQ5vASN5+aNIB/lU1ihVqTlG
         NHpg==
X-Gm-Message-State: AFqh2krsGTkfZcEl25NtBEGSRok2+7xDQvFRvVIk7QHiEQ1WcFuJ/5o5
        pQy8slo7ICo/Wf4txxwmOo/wRXsl3UKojQ==
X-Google-Smtp-Source: AMrXdXtqUvUqml5ZYpccQsnp0SxKuBaPzayrB/URoAw1Phpqz/RZnEuj2lPgnq/GHKDHP68ZkOp5jw==
X-Received: by 2002:a17:906:7e1a:b0:86d:30ca:ec27 with SMTP id e26-20020a1709067e1a00b0086d30caec27mr7995232ejr.13.1674083895090;
        Wed, 18 Jan 2023 15:18:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q27-20020a1709066b1b00b0087329ff593fsm2762676ejr.144.2023.01.18.15.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:18:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pIHh7-003CVw-39;
        Thu, 19 Jan 2023 00:18:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v6 10/12] http: replace unsafe size_t multiplication
 with st_mult
Date:   Thu, 19 Jan 2023 00:16:41 +0100
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <cc9a220ed1f12aef2f4df940e71adc1fad917a6b.1674012618.git.gitgitgadget@gmail.com>
        <230118.863588xeat.gmgdl@evledraar.gmail.com>
        <aa8abc8d-284b-b87e-f594-27ee40cc4bec@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <aa8abc8d-284b-b87e-f594-27ee40cc4bec@github.com>
Message-ID: <230119.864jsnwhxm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:
>>=20
>>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>>
>>> Replace direct multiplication of two size_t parameters in curl response
>>> stream handling callback functions with `st_mult` to guard against
>>> overflows.
>>>
>>> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
>>> ---
>>>  http.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/http.c b/http.c
>>> index 8a5ba3f4776..a2a80318bb2 100644
>>> --- a/http.c
>>> +++ b/http.c
>>> @@ -146,7 +146,7 @@ static int http_schannel_use_ssl_cainfo;
>>>=20=20
>>>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buf=
fer_)
>>>  {
>>> -	size_t size =3D eltsize * nmemb;
>>> +	size_t size =3D st_mult(eltsize, nmemb);
>>>  	struct buffer *buffer =3D buffer_;
>>>=20=20
>>>  	if (size > buffer->buf.len - buffer->posn)
>>> @@ -176,7 +176,7 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void =
*clientp)
>>>=20=20
>>>  size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *bu=
ffer_)
>>>  {
>>> -	size_t size =3D eltsize * nmemb;
>>> +	size_t size =3D st_mult(eltsize, nmemb);
>>>  	struct strbuf *buffer =3D buffer_;
>>>=20=20
>>>  	strbuf_add(buffer, ptr, size);
>>=20
>> This is a really worthwhile fix, but shouldn't this be split into its
>> own stand-alone patch? It applies on "master", and seems like something
>> that's a good idea outside of this "test-http-server" topic.
>
> While it's this change *can* stand alone, please keep in mind that
> suggestions like this (recommending a series be split and resubmitted) can
> be highly disruptive to the in-flight topic and the original contributor.
>
> Monitoring and iterating on multiple series at once is time-consuming for
> the contributor and reviewers, and often (although not in this case) it
> creates a dependency of one series on another, which comes with a cost to
> the maintainer's time. Not to say those recommendations should never be m=
ade
> (e.g. in a clearly too-long series early in its review cycle, or when
> certain patches lead to excessive context switching while reviewing), just
> that they should be made more carefully, with consideration for the time =
of
> other contributors.
>
> So, with that in mind, I don't think this patch is critical enough to
> separate into an independent submission, and (subjectively) it does not
> disrupt the flow of this series.

Yes, I take your general point, it's not always the right thing,
sometimes a while-at-it cleanup is better than a split-out etc.

In this case the split-out seemed like it wouldn't create a dependency
between topics, as the rest of the series didn't rely on the overflow
sanity check being added, it's just a good idea to do it in general.


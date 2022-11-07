Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7969AC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 22:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiKGWeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 17:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiKGWeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 17:34:06 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FCF6321
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 14:34:05 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f7so19852249edc.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 14:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZi0l2hcJ8IIZ8rm0rdNq8vy0VbhhvG66Z2K4EHcolE=;
        b=USmttxeMaTDy7MPFFRW83vEjzL8s5CBLcTlMcfmsJFXE4ZMtGlBUs+NdfkYslVh2ST
         xua5tYyyKTaOmwkT2TBdIfpBkV9IdQ2lcEnZs6rygcElLj6AaxtJKpYVw/rvbW3NC3QX
         aT/yAJWxyDFSWE3Y6GZRM9EW65yFP1dD5+9PW5ZPCbkhHGOZVcEyHSlrmB1ZXdqPpwz8
         Gchi1Rcknyn50jqnvSpCdO3s56NwcZFKaJKMjoPHewIcCi+0mdEoGQ5+RByxs8PkqxLH
         +9kCVH5LnJa1R+arV0AqiKSsKN78eZ5Y5tDl8G3yCORWfI4OUCIKj8OcnoXQ5IOkUpfC
         jYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZi0l2hcJ8IIZ8rm0rdNq8vy0VbhhvG66Z2K4EHcolE=;
        b=rlDxoLOvGpMs3c6XUrKk9NbRxv8wq0HGXQiAwvOAYF/IznX3ADBSG/rPPK05GqT5GO
         uR3d2SvXa8/rVzzZCCl5d8ND3bYaCNCAMWBXfQdt6JKfugTNKiOWkK+0NpSxe61m9+GZ
         Gf1O3PYk6Gk7Fbu8sBdiWH9nrRswTOHZQ77G9Z5uW8GxPa0h9oXd8qngHywTxZh3u7nV
         MtE4r41xOZFH0e8eH2s56KEROBK2A//cQ6omdXLQMMp9KbpZBjLZ6iIJ9qroa+/PcfbB
         3dC5tdEsXzYq6O5ye0tJIfk3dIXVpyPOCzUwR6llPUUjiVXL2tiaeBBAlmI7MQtULtac
         fJ2Q==
X-Gm-Message-State: ACrzQf1gAmNMenYCKqP2xPjzPTB6+QM7cq9t7YeApAG//+Bqeen6nl2V
        Y/St1s3d11BqrvPMsX154jQ=
X-Google-Smtp-Source: AMsMyM4/69dWTYGZzNk8fzOkp3EGfH70aAqLx6XJx9gfUKJLSHFzqKrOOwX4bzWxPZrk9Efx+NPLXA==
X-Received: by 2002:a05:6402:430a:b0:462:2e05:30b5 with SMTP id m10-20020a056402430a00b004622e0530b5mr51777768edc.246.1667860443858;
        Mon, 07 Nov 2022 14:34:03 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b0078ba492db81sm3938466ejc.9.2022.11.07.14.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 14:34:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osAgr-000Mu4-2E;
        Mon, 07 Nov 2022 23:34:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 2/3] notes.c: fixed tip when target and append note
 are both empty
Date:   Mon, 07 Nov 2022 23:33:33 +0100
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <5dbe014a09cca6ffa01dc9f61d0ddc095d31d518.1667828335.git.dyroneteng@gmail.com>
 <221107.86cz9yx1wh.gmgdl@evledraar.gmail.com>
 <Y2l9yfOhiT7r2+H6@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2l9yfOhiT7r2+H6@nand.local>
Message-ID: <221107.86bkpitmw6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Taylor Blau wrote:

> On Mon, Nov 07, 2022 at 03:40:03PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > @@ -567,9 +567,15 @@ static int append_edit(int argc, const char **arg=
v, const char *prefix)
>> >  	struct notes_tree *t;
>> >  	struct object_id object, new_note;
>> >  	const struct object_id *note;
>> > -	char *logmsg;
>> > +	char *logmsg =3D NULL;
>> >  	const char * const *usage;
>> > -	struct note_data d =3D { 0, 0, NULL, STRBUF_INIT };
>> > +	struct note_data d =3D {
>> > +		.given =3D 0,
>> > +		.use_editor =3D 0,
>> > +		.edit_path =3D NULL,
>>
>> Most of this is an unrelated "use designated init" cleanup, which is
>> good, but let's do that in a different commit if we need it. And then
>> you can drop all of these...
>>
>> > +		.buf =3D STRBUF_INIT
>>
>> ...and only need to keep this one.
>
> I don't mind seeing the cleanup here, but I don't see why we need to
> keep that portion of the hunk at all for this series.
>
> IOW, your "...and only need to keep this one" does not make sense to me.

I was still on my initial read-through, and was assuming that it was a
prep change for the 3/3 adding a new field, before I saw the 3/3...

> Changing "char *logmsg" to be initialized to NULL is important, though,
> since we now only set it conditionally still free it unconditionally. So
> that should be kept.

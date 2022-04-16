Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21E9C433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiDPCFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiDPCFG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:05:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F182198EE4
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 18:54:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b19so12335911wrh.11
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 18:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tKtA4dXStra8qc1gyo32CaQhsUpKEd3G74oYT0uMGok=;
        b=J1FAsgSgw3U01n9kH1BmcGaOXF/s0kjWiJ0LCOK/eAtOCC02c6+20mB9xegJOxKgxQ
         4tZUJxZgSd3fLKXHvh8XJjLGRjaXOkx3diaUo4oLGwMBCcAgDdlXISKwxOMU6FVBGQpi
         ugt2+67/Bw4dTxRZI1fReTMUeqRzQB7iIBxQGID9rz8JGLaVbCr1eZ11/dUnKQo6RPVJ
         XQGVTUXUBryLakGwcepb9ibu496y4KqlnlKpQDs9J5335nH+YNGrQH3ejfFLxxkpACFv
         zhtgd/bZ59n7jBUIWUhWNJnGiKWnk9h4lZa5sv6Fd28wbRT0vuOI1L36JTW2LGy/Sswv
         96VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tKtA4dXStra8qc1gyo32CaQhsUpKEd3G74oYT0uMGok=;
        b=BmtofmKQ/cKdBd0G7CcTUdCs8v04ejxAnCzzokk3X+p02LRxZ+otB1aFQkdyLVy4Ae
         7uszNPW9ZmDZMc6Rh5MBN/kSK9MOxEt7cReu05JrhiKzJwrsC57Yx8XuEREfLtcOKRbT
         PgnA3hhBUcW7zSJesjlMXaR5XR9buYNbdahc3pZlkv33WqXnEI3+RK49Q3BKn4K9wqHp
         4OwxXOjLkg+XaIJ7/ze5WtOvSIgp1bfIXEatLOgZ/RM0EZyrVs+yUNI04WAPQb5lqWbz
         y7K6DfuguXwX65igQaXuJVgzeRZp4OB/pb19Q3ps5mR3ZUXF0lnO5Wwj88Nwjk1b/0ax
         CvUg==
X-Gm-Message-State: AOAM533vSllpfJhujaXvZgVKZcjsynUXe1Ee48msOdSWQEH6CYYOxaf8
        tfSjP+5BNVVOIAmPVOMM895a7o5nMx8atQ==
X-Google-Smtp-Source: ABdhPJxUh7wQat/COLnzM9kwKNkYR9CbmYYQMtygJcf0/PITdUzKQvEAZRISbpNb14ux3R+FdipzJQ==
X-Received: by 2002:a05:6402:492:b0:404:c4bf:8b7e with SMTP id k18-20020a056402049200b00404c4bf8b7emr1678797edv.318.1650072283502;
        Fri, 15 Apr 2022 18:24:43 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709064a0100b006e89334f5dfsm2157101eju.136.2022.04.15.18.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:24:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfXB4-005xmR-IZ;
        Sat, 16 Apr 2022 03:24:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        phillip.wood@talktalk.net
Subject: Re: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12
 warning in http.c
Date:   Sat, 16 Apr 2022 03:20:17 +0200
References: <20220415123922.30926-1-carenas@gmail.com>
 <20220415231342.35980-1-carenas@gmail.com>
 <20220415231342.35980-3-carenas@gmail.com> <xmqqh76taplg.fsf@gitster.g>
 <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com>
 <xmqqwnfp98ix.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqwnfp98ix.fsf@gitster.g>
Message-ID: <220416.86lew5akh1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Junio C Hamano wrote:

> Carlo Arenas <carenas@gmail.com> writes:
>
>> this would be IMHO a better fix than the one currently queued in
>> ab/http-gcc-12-workaround and indeed squashes the warning with the gcc
>> 12 version that is likely to be released with Fedora 36,=20
>
> That is an excellent news, as ...
>
>> but notice
>> that it was proposed before[1] and apparently didn't work with the
>> version of the compiler that =C3=86var was using at that time, as
>> documented in the commit message.
>
> ... I was the one who suggested it, and I remember that it didn't
> work for =C3=86var back then.  If the problem with the version =C3=86var =
had
> is no longer there, that does sound like a good thing.  We can take
> the patch you posted and then post release we can apply the "clear
> the .finished member as we are done with the slot" fix, which is a
> good hygiene regardless of any compiler warning issue.

I don't know what version of GCC 12 Carlo is using, but I'm using it
built from its main branch this week, and it warns on that "if
(slot->finished =3D=3D &finished)" suggestion.

I don't understand what you think you're gaining from:

	if (slot->finished =3D=3D &finished)
		slot->finished =3D NULL;

That you don't get from:

	slot->finished =3D NULL;

I.e. the assignment earlier in the function is unconditional, why
wouldn't the clearing of the data correspond to that assignment and
clear it unconditionally?

If it's imagined that we have parallel assignments of the "finished"
member wouldn't that check/assignment be racy?

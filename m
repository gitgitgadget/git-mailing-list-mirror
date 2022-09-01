Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E446ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 14:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiIAO6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiIAO6V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 10:58:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962475CE3
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 07:58:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c59so16724578edf.10
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=JwuDbuz6+SJl8mcZglhHqa6kTBEjxU9R0YWmrUX43uE=;
        b=bAEkZucZuA4HVHN7yv8PzsAy1k2tKO46kHqKw4WFFwcpB8QhmQ4s3sIBPKI2ROemxq
         WF9S2HThAXHWjQhOR2wLFmrL7NtB9iLvwYBQ/0KiD5BcatSyX7xPG5WjHJXlDeLzmC7h
         0ybHMPrbf9n8CQRzfjIpzynImX208DSgxo35tu23G2pc2J2ify+eP9zw1/oOtrLoIGAc
         VuLqc+0EACA1i1iBqOLa3mttj7QCvT6rvXTdm0nslXbooz5yNbeNmT7djTVjA1ofBzp4
         EzFbbuh3lGAflNWT7Z+yLBRdbs80N1Y2oW/++CwBr38eRlKYw08IkHiHEL4+JrlmRQuV
         6qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=JwuDbuz6+SJl8mcZglhHqa6kTBEjxU9R0YWmrUX43uE=;
        b=AeMS4HNfClg2LUBCKv9nbDPq1AduwIvkLGoedTUuYKOIA3wrvM/3muMY2jnfWrsjm/
         q30GiEl3fBQfVrArJH5tFVcOTtVJ1Jy8AP+ezN1tMzHRwg1abmn18Q068bZsaiiZqoP6
         IH4gMprwe9WlOJEO+oaea1u9UXKN4iiGhrzfFLkVhJvNZgBm78D/rGQVCWGKpeOMrwTN
         AdEtglBAV5th4baP8nYlx54BIFKwLEsWmHUfZ+ljRY9JjZSw3IkkLMu8I6tSOG5gWie/
         bGkxSBUO25W4e0jTaOxUb7oEXQyFgOrrx55P61Sv4QFi3gRQg+8Kd5f6bGyqYjU3qMBH
         ljAg==
X-Gm-Message-State: ACgBeo1EOpy2Hw56f+ezNM9Y4OMqIi1dCTovXFAdJQrz3HShMBUdC5zI
        tdylgt9fG7pSnzv+HZsRQG8=
X-Google-Smtp-Source: AA6agR60liARWZvjyY8zkNs14VzUP4mQeSmQkeSMCRjtiD9W7Z6ijh50jpB78TDlpOdBJZaEOg0Hfg==
X-Received: by 2002:aa7:d4d8:0:b0:447:a745:4b18 with SMTP id t24-20020aa7d4d8000000b00447a7454b18mr30396818edr.174.1662044298966;
        Thu, 01 Sep 2022 07:58:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906300300b0073100dfa7b0sm8566646ejz.8.2022.09.01.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:58:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTle5-000EX5-1B;
        Thu, 01 Sep 2022 16:58:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3?= =?utf-8?Q?n?= 
        <carenas@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] Makefile: use $(OBJECTS) instead of $(C_OBJ)
Date:   Thu, 01 Sep 2022 16:52:05 +0200
References: <patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com>
 <cover-v3-0.2-00000000000-20220831T090744Z-avarab@gmail.com>
 <patch-v3-2.2-cb3bc8b5029-20220831T090744Z-avarab@gmail.com>
 <xmqqmtbkdr5n.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqmtbkdr5n.fsf@gitster.g>
Message-ID: <220901.867d2njg52.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 31 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> In the preceding commit $(C_OBJ) added in c373991375a (Makefile: list
>> generated object files in OBJECTS, 2010-01-26) became synonymous with
>> $(OBJECTS). Let's avoid the indirection and use the $(OBJECTS)
>> variable directly instead.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Makefile | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> This is a declaration that we would never ever build .o files out of
> sources other than .c files.  While it does make sense to have it
> outside the scope of [PATCH 1/2], I am not sure if it even belongs
> to the same series.

I think it does. Before this the C_OBJ would be:

	C_OBJ :=3D $(filter-out $(ASM_OBJ),$(OBJECTS))

but after 1/2 it's the same as $(OBJECTS). An earlier iteration of this
did this cleanup "while we're at it" (which I do think makes sense as an
atomic change), but I got the feedback that the cleanup wasn't strictly
necessary.

But as 1/2 has removed the ability to build those $(ASM_OBJ), as we had
only one of those, I don't think keeping this particular bit of
indirection makes sense.

Of course it doesn't really matter at all, the real change is the
removal of $(ASM_OBJ).

If we do start building *.o files out of *.S files (or other non-*.c)
again we'll need new rules anyway. I think we should just add any such
variables back then, and not keep this small bit of dead husk around.

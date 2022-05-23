Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28116C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 09:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiEWJax (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiEWJaw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 05:30:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF84990B
        for <git@vger.kernel.org>; Mon, 23 May 2022 02:30:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s3so18274023edr.9
        for <git@vger.kernel.org>; Mon, 23 May 2022 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=G8cGgXCV62xgMn6vd1zJBL9vPW/LqIzfr2L80mGguts=;
        b=ZSmqHZmS9fpBbEZtOxxjo0ZhGvVEHoN2FOIaFcmoQ01qAyfLljgz8atlNn4GnLj8cB
         B29VkY6RTZ9lir5hZ56ljVbrqeKS0S/TJAY2Z7YehALpAdHWwQKIiOjomyunkwi4SfTs
         QyInR9sLk7slq12gwC2Hpnz9bXWAqFT5eifhD/AIqEFz9KtIc8FtFV2J0VL/IONdjRw5
         f4DMQfSN4I0JcNcewMB5AeSZHZzWDMhZvBob+c1bd1VUeJGsnI1q09FmkSeuJV9P5W8L
         cYPhcbhevxNZuF4g1/60MbSoIIc+k7Pr3SJoxAOR1NL0suTymgGA/EOzyN+Jb2iOQjFq
         UG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=G8cGgXCV62xgMn6vd1zJBL9vPW/LqIzfr2L80mGguts=;
        b=bwIUOse3A9j+eDaCBjuzujfphrR5tTVjhuwUWB5kVYOIo54qbdWjATdBD4kIcR0I7k
         yUwgNfgrYBc1RljV5Ll5rjAEE3TCxSLaFQAolmiTB92lUhWxUH3Fgn/rHX9jx1sA4KJs
         7DcCBOu+Keu5UytrnOYp3kAoAAOh4jLnSwLBGsHtf6K7+YOicb4RaUKDwfkz/pgssNZ4
         SHrkjPoRC1SCq6pcvocycAnCBKQgGBPNvoQszKOSljxb4Zkl6D77KXYj5f5+mePOYzW8
         /qdbGoriJEjuUMUQs5zBiwYzdpT0JcccSEZ8DGPq61ZHFy0q5KZHvhf1rvuhGzzQMsQM
         u3Kg==
X-Gm-Message-State: AOAM531OCd+HPeyVO+W2YrwbhZCusnX8lk1eHuoWzyB/NwYoBww+UF06
        eEglv6IMxbvfPATmCs7URauiBGXvFuY=
X-Google-Smtp-Source: ABdhPJyfdh65YN0htQXwDCJo8Hi4FjmW7EdLMB1uSTvyeRqQT0ddXmx5/evqKkvgCGppHwvlUvSagA==
X-Received: by 2002:a05:6402:51d0:b0:42b:b34:1cae with SMTP id r16-20020a05640251d000b0042b0b341caemr18735610edd.335.1653298249024;
        Mon, 23 May 2022 02:30:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709064a0900b006fed85c1a8fsm1308410eju.202.2022.05.23.02.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 02:30:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nt4OB-002rHz-3c;
        Mon, 23 May 2022 11:30:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 6/9] po/git.pot: don't check in result of "make pot"
Date:   Mon, 23 May 2022 11:28:59 +0200
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-7-worldhello.net@gmail.com>
 <220523.86r14kzp2t.gmgdl@evledraar.gmail.com>
 <CANYiYbG6qLvBDHUkQ+6JRL22obLA14nrdcgpqB77TN4Bxqmybg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CANYiYbG6qLvBDHUkQ+6JRL22obLA14nrdcgpqB77TN4Bxqmybg@mail.gmail.com>
Message-ID: <220523.86a6b8zjdo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Jiang Xin wrote:

> On Mon, May 23, 2022 at 3:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Mon, May 23 2022, Jiang Xin wrote:
>>
>> >  .PHONY: pot
>> >  pot: po/git.pot
>> > @@ -3319,6 +3319,7 @@ dist-doc: git$X
>> >
>> >  distclean: clean
>> >       $(RM) configure
>> > +     $(RM) po/git.pot
>>
>> I think I noted "why not add this to clean?" in an earlier round, but
>> didn't think it through.
>>
>> On second thought we should do that, but the reason is that "distclean"
>> should only clean things that you get if you do "make dist".
>>
>> I.e. we add "configure" to a generated tarball, but not po/git.pot, so
>> this should just be under regular "clean", not "distclean".
>
> Will remove "po/git.pot" under regular "clean" rule in next reroll. I
> copied it from your original patch without thinking carefully.

Yes, sorry about that. Just to be clear I didn't think this was an issue
you introduced. To be honest I thought it could be mine or yours, and
didn't dig to look into the history :)

I have no idea why I added it to distclean, and it doesn't make any
sense to me now, but oh well, as long as we fix it ... :)

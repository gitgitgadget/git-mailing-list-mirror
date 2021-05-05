Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B0BC433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895FE61159
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhEEMEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhEEMEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:04:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676FEC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:03:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j28so1687183edy.9
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gtRkPJnNDi4bJNHXnE7RULsFWmS0zeMJO9UMhP7Y4Bk=;
        b=OdJ8mYwqMSwYQByy18Bg2INOuE5ruQyLfbMCB0I8qudebXs2IuupKlo0v+w48ZSBDG
         IB2Rjmb9TkVfosCx6c79dNCuA7LhqggVfAvndpxhy0ZFpYeplDMyeuXLh5eYUMcB/7Rw
         y/0FXdeaPVM5MbQEQxHWpa65y9J/kTGcko2mfys7otFtXC621kjSHN8GtkyEr3OjQjSr
         NoioSguq4EVoUhWjVYao1LkLaOmx/9hz7lmxkkE0TmAFI/rlWmCn4iEUNfCM8/+kQJOj
         UPVIeOY3oFGMwxZkbnDiE0m/WL1H4lUV7s71BUaRq0EkCYgmVYDrGD1Mp+lGCdyaAc1O
         B14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gtRkPJnNDi4bJNHXnE7RULsFWmS0zeMJO9UMhP7Y4Bk=;
        b=W7FLDmrTUvwOCZXGSvtyNdVskVfHGyIPgF/36bJ7qM/TEpIwdtdWI3N3xT2x+T2GYp
         A4wyxC0KfVhg4d844WCYmiBduLuvLjDTFuSIeVBDOcMgTi8NQb3YHYIlf38/PC5dp2gt
         UmRpY0xH9n/iHLSXWOblqfDQaX+f0dQhe+Yseo4fKu7rY71utyAzFOzoCReA+ZQnexg9
         KnpPsFSdokWjVBB4/dg4E43RsTQ5J/WGMbVJwo7jMg+gTmRx0JGse2P9iaimIcXknWBe
         i38z4/H8xyBq7L6OksttumKok+yGTLzPct6Bzd3uGt3pIdG5ftC73SCplfmtY649wl+C
         +maw==
X-Gm-Message-State: AOAM531uIwqvibOpTO9cykoQqhi8NqntE595iYbEg/TOTz3gYiOKFFMT
        mfzvpDbWnz+j5GXBGJguRLg=
X-Google-Smtp-Source: ABdhPJyYPsEzmZ+/tWsTRpHERK0nw21CDaSIDkSUD5GOBc2OMIhFfSQFI9y3xcHXHa7ste/tjeuDVQ==
X-Received: by 2002:a05:6402:7c7:: with SMTP id u7mr18704022edy.2.1620216233125;
        Wed, 05 May 2021 05:03:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r18sm2796494ejd.106.2021.05.05.05.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:03:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
Date:   Wed, 05 May 2021 14:01:25 +0200
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <CAPig+cQks0_nL1J4YUbEUjmWYLKrhuHX-f8PkWM2zFE4gybWMw@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAPig+cQks0_nL1J4YUbEUjmWYLKrhuHX-f8PkWM2zFE4gybWMw@mail.gmail.com>
Message-ID: <871ralwfo8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 02 2021, Eric Sunshine wrote:

> On Sat, May 1, 2021 at 10:59 AM L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr>=
 wrote:
>> +       strvec_push(&child.args, "--now");
>> +       strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
>> +
>> +       if (start_command(&child))
>> +               die(_("failed to run systemctl"));
>> +       return finish_command(&child);
>> +}
>> +static int systemd_timer_write_unit_templates(const char *exec_path)
>> +{
>> +       unit =3D "[Unit]\n"
>> +              "Description=3DOptimize Git repositories data\n"
>> +              "\n"
>> +              "[Service]\n"
>> +              "Type=3Doneshot\n"
>> +              "ExecStart=3D\"%1$s/git\" --exec-path=3D\"%1$s\" for-each=
-repo --config=3Dmaintenance.repo maintenance run --schedule=3D%%i\n"
>
> I see that it's in POSIX, but do we use this `%n$s` directive
> elsewhere in the Git source code? If not, I'd be cautious of
> introducing it here. Maybe it's better to just use plain `%s` twice...

We use it in po/, so for sprintf() on systems that don't have
NO_GETTEXT=3DY we already test it in the wild.

But no, I don't think anything in the main source uses it, FWIW I have a
WIP series in my own fork that I've cooked for a while that uses this, I
haven't run into any issues with it in either GitHub's CI
(e.g. Windows), or on the systems I myself test on.

I think it would be a useful canary to just take a change like this, we
can always change it to the form you suggest if it doesn't work out.

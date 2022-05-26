Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A8C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 08:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbiEZIDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 04:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346579AbiEZIDE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 04:03:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C249703CF
        for <git@vger.kernel.org>; Thu, 26 May 2022 01:03:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id jx22so1437353ejb.12
        for <git@vger.kernel.org>; Thu, 26 May 2022 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gHzz00lw2VXEL4Fr2eV46MXNji7YPE0Qhk2ZKB37Ro0=;
        b=VmNeEIipYajO2wJsNM3zxelCdHgD2xRSXgerD4RqZDuWkHhTZdYEvYgt3QYlo1Fg6m
         DZ2haIoUgEvRxSTA65Qi1jg2jonj3qi1hm92Fj13wP4ADJQXcM5c8UErxg2uyb4Ale0B
         8NNCPX21DQgXJorfNvjD8LMTi94R9l0ZrvF/3WR+HRG8Hu9sK7kceBUrIG8MRfxlEWLt
         ubiXX53MZzAiCKLhScdxP1wwOnb+05upMDB82smf8uFZmg3zLHwLHEXmnI6ZkXAMCZem
         cFKXcZDwoL+U10gYySqe8IKIthp8wrTowqcpllTYSl1AVXypMw5+WgT8xbiyw3q5AWHA
         TQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gHzz00lw2VXEL4Fr2eV46MXNji7YPE0Qhk2ZKB37Ro0=;
        b=VLFfn1f4e8PC1v5J1sovVpcDhEI5NucV1z7HGB0Gm8k2Y3QPyv/Hfr7IrMzyDdzXlg
         DoPTbh6LjDigo4AZBbkV8mPwGcxhqwe17as+oC42x4+TtsNofNe/KG8h2vZgwsXuwYc0
         UMkNg+RciwcLZ2Wvs9k31hvtTwieLjIcVkNC7zvTNg32cLryAfIQA8QQAxm2KUqgPlFG
         YtjXeu9+DLUOD+7EALaeipWUWH8fbkrhGZ3pg65oSrivk57FGos1CddKvjjf8FSvFH0k
         /IJytyG3yRzORqwKLgGgoohddC4jUwKvXjEupgLV5YQMhBd9g2liNyd1P44vy0V5eWCo
         /thw==
X-Gm-Message-State: AOAM531mx/pQeHKIh098t9778DBj4QrScveXKbvxUA5JRDfsEK0v/qYO
        PLfcfNYIHL88/0J2gHA6IOEjdE3vn2Cq1Q==
X-Google-Smtp-Source: ABdhPJyV9KTaIH3kWlpxjWOcAm+hV5jNyjgXIFUORMbpzBnRC4UVMQsFz9esNDujxOT5mDs1xChFYw==
X-Received: by 2002:a17:907:6d82:b0:6fe:fd05:e21e with SMTP id sb2-20020a1709076d8200b006fefd05e21emr13242075ejc.432.1653552181465;
        Thu, 26 May 2022 01:03:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bi15-20020a170906a24f00b006febd5a0f5bsm286471ejb.59.2022.05.26.01.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 01:03:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nu8SS-0009fd-Bg;
        Thu, 26 May 2022 10:03:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with
 BUG()
Date:   Thu, 26 May 2022 09:59:20 +0200
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
 <xmqqpmk15o46.fsf@gitster.g> <xmqqh75d2aif.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqh75d2aif.fsf@gitster.g>
Message-ID: <220526.86fskw7mbv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 25 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +/* usage.c: if bug() is called we should have a BUG_if_bug() afterwards */
>>> +extern int bug_called_must_BUG;
>>
>> I am not sure about the name, ...
>
> I finally figured out why I found this name so disturbing.  This is
> written from the viewpoint of somebody who is trying to catch a
> programmer's error of calling bug() without calling BUG_if_bug();
> it is not named to help the users of API to understand it better.

I named it like that to indicate a "lesser bug", I think BUG_if_bug()
came later, because ...

> I wonder if it makes sense to make the call to BUG_if_bug() totally
> optional.  The rule becomes slightly different:
>
>  * You can call bug() zero or more times.  It issues a fatal error
>    message, and internally remembers the fact that we detected a
>    programming error that invalidates the execution of this program,
>    without immediately terminating the program.
>
>  * When you exit() from the program, the runtime consults that "did
>    we call bug()?" record and makes the program exit with known exit
>    code (we could arrange it to abort() just like BUG, but I'd
>    prefer controlled crash).
>
>  * But it is inconvenient to always keep going, after you may have
>    called one or more bug(), to the normal program completion.  So
>    there is a helper exit_if_called_bug(), which is an equivalent to
>    checking the "did we call bug()?" record and calling exit().
>
> By making BUG_if_bug() optional, we can lose a handful of lines from
> the test helper, because it makes it a non-issue to exit the program
> without calling it.

I don't think we should do it like that and keep it a BUG() not to call
BUG_if_bug() when we hit exit(), because e.g. in the case of
parse-options.c once we have the a bad "struct options" we don't want to
continue, as we might segfault, or have other bad behavior etc. So we'd
like to BUG() out as soon as possible.

That's how we use BUG() itself, i.e. we think the program execution is
bad and we immediately abort(), the new bug() makes a small concession
that we may be OK for a little while (e.g. while looping over the
options), but would like to BUG() out immediately after that.




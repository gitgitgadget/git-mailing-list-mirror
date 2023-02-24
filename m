Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5335BC7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 19:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBXTNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBXTNE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 14:13:04 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23071717A
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:13:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id fd25so62403pfb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uay4sEekbRXtEu475OInJih6WYuIR8x+6UUcLqfDPfc=;
        b=jqxpU2B0Ya3NoKERmwrVW71EYWIhhyVy2w6eEkr/8KPCiHCrW7qXoWYkNT7wXoTBtm
         BAV7kPehJdgKaGV6ilvtZgnKiBTL/Va7MK2KEaRdLn6QD+Dyg6E7NtZpAUGPXmMLF54G
         5VvQ7bpausOJxEfz8KRPhcBlCfFVRbCwPkmyWy3uPLtCgWxPfpYoFS5fTFWLrgClhIA5
         YdH8MOpK2tWPVRAh5RCFBc7GWjnLVRQPXzcQ8nwdUy6Tn9wxxwP8Yri17KdFUONsVTB8
         SFcIkhqgjmj5kU62l5bxslP1wUpIgFXzHnADAnMysjM7ktjuxlk9X18SirAjJyz5QbPB
         2k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uay4sEekbRXtEu475OInJih6WYuIR8x+6UUcLqfDPfc=;
        b=isjc852i3iMplW+Rdl/nJE8DBP6VfDDp+qUUm7vym6LqNItK5G1xDY5LzHnNmUINRm
         zILXTda+OIxTQusttzvYs1edr0Ys33nHhTFrWbtvn7IjHBChXJnPnITpddmUWi3LQglQ
         rffosIXB1+82FDo+W0PhrOYcZv3xx8BVaTsS11yfOfZM830+k/mqbHEJ1ZsuQNirgD9h
         rzX2zvqJdzRobHWYGRZaRUCSMIZ5AnRHJ5dYwXHfVnVuzvAOjgGNASGhgwOqQrVOLezh
         WWmXFe9Asb1i5pDerfD1jsnCk5+rk473prujv6QVCwa3g09MmXsd5uzqVdgLOzLcKFRe
         Je7g==
X-Gm-Message-State: AO0yUKWVo6OcvgvSvFZ49Pj1avfXWddmKzGTHoQaLc03PWfsUbC1nhTe
        29lRwAdTlfRcsd5H+AfKt8h4HlJ1x5U=
X-Google-Smtp-Source: AK7set8TnSAs1kVVSnu1XlAJu4qw1Cfts3Xq6jtse7zVimYrdwyilLIGzpe2dRx/f7Zrl6Crgw90RQ==
X-Received: by 2002:aa7:96ee:0:b0:5dc:6ddd:878f with SMTP id i14-20020aa796ee000000b005dc6ddd878fmr5712135pfq.2.1677265982161;
        Fri, 24 Feb 2023 11:13:02 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z17-20020aa785d1000000b005a8cb39ab85sm5313848pfn.48.2023.02.24.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 11:13:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
        <20230223053410.644503-2-alexhenrie24@gmail.com>
        <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
        <xmqqy1on0yla.fsf@gitster.g>
        <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
        <xmqqcz5z0wdb.fsf@gitster.g>
        <CAMMLpeSH1itopDuON=7ms_7Li7Qk+9dhzKjT5f7UE11posKK=g@mail.gmail.com>
        <xmqq8rgm29fw.fsf@gitster.g>
        <CAMMLpeTvyYgGNBQWtRBg3ZNuXeCMxiem-5LAdu0ex7XCuf0wAA@mail.gmail.com>
Date:   Fri, 24 Feb 2023 11:13:01 -0800
In-Reply-To: <CAMMLpeTvyYgGNBQWtRBg3ZNuXeCMxiem-5LAdu0ex7XCuf0wAA@mail.gmail.com>
        (Alex Henrie's message of "Fri, 24 Feb 2023 11:55:31 -0700")
Message-ID: <xmqqpm9yzxky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Phillip is concerned about people and scripts assuming that
> --rebase-merges is equivalent to --rebase-merges=no-rebase-cousins,
> see [1].

Isn't that already broken when you introduce rebase.merges
configuration?  People and scripts are already relying on the lack
of rebase-merges to flatten, and script writers will be surprised to
receive a "bug report" complaining that their script does not work
when the users set rebase.merges to anything but no.

> Tao and others are probably not going to like it if --rebase-merges
> without an argument undoes a rebase.merges=rebase-cousins
> configuration.

That is why I suggested to keep --rebase-merges= (with no value or
an empty string) only for those who came from the world where it
defaults to no-rebase-cousins and there was no rebase.merges
configuration.  If --rebase-merges= is given from the command line
without value *and* rebase.merges configuration is there (which is
Tao's concern?), the command line option can error out asking for an
explicit value to countermand whatever value is configured.

Wouldn't that work for folks from both camps?

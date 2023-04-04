Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB4C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 19:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjDDTb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbjDDTb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 15:31:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8830140E6
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 12:31:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso37230790pjb.3
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680636712;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u+YUnimTHNqsVP7F3dghDPdmr+RHhSOP18RibhhSu8=;
        b=P0SA8CYKyvL8Q0TRQ9El2yEbBx7T3paBdY7iEvLp+1f9C5AP9YUhWNh5RPCvOjVzpZ
         2Jn9G/vaXknKDJ37lrtH8T7HXNWs/Syi8Y3vt1pTm80K2s34qgwSRdSkEWAqs/0YXy75
         kZQATSCd+nKm/Gp4pqmpE80Onyds2cSsGFLcU/zFGDGyBPiW6/Oe93oRIGhWDnTrSRq9
         2lO8qmyoaaH+FVXIuS+nhXbjx+772OswBd3q6Pgvxrlr7zxtFEihe0kPeVMvlEolH7C1
         bdjlriax5kfz6mm8kaUy10CEB0LWseVihV7NINZtCPduKJAJP2FhoRAveu2UaslSyhcQ
         WA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680636712;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6u+YUnimTHNqsVP7F3dghDPdmr+RHhSOP18RibhhSu8=;
        b=1i5e9hlWH1s9mZB3IO9r/bruoaekurTlGrQ3gjBIo5D99GSXJF/4dgUGpWoNE7LK5O
         TAQmrShLTUXs8OPx6osusyo9pGbu35uparz11k1/jZCkn8/z0RxMr4KYNEKoSMrdn6Wc
         iWWQIzQKqnwDgWk5fRatcoQsKVARlETmipllWJefJLnfUS/1UUs8E7bNnlP4Gw4KWaqJ
         y83st0i2AqKAfQiTyoNCW3LJjXJdXdY766w/7d427VO8gWUDjUEo7oXeYFbdbufmMy3k
         fNxWPPi9b9d4Lr5EwFZ2zpA+Z8hPEXizMWULOPnWCewcD+u6nRn9NukWFu4FcdLC7HMq
         3fCg==
X-Gm-Message-State: AAQBX9dblyD2O0L1Vwp9kahl+awnx38QN3eKETmMJDji6I7ATIsTqPqA
        YhqZRRHXoanReX8V8/++Ine+ap7xFeg=
X-Google-Smtp-Source: AKy350btd5q4jt7/5/l0+bfz8VRalTaP/tRnSwu4zFULoE+u6flcSrAWNJc8KxHe7hKmdCnkPhiEaQ==
X-Received: by 2002:a05:6a20:619a:b0:e3:9d4e:b340 with SMTP id x26-20020a056a20619a00b000e39d4eb340mr3460394pzd.12.1680636711819;
        Tue, 04 Apr 2023 12:31:51 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b005e099d7c30bsm8971154pfi.205.2023.04.04.12.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:31:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Carlo Arenas <carenas@gmail.com>, demerphq@gmail.com,
        60690@debbugs.gnu.org, mega lith01 <megalith01@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Tukusej=E2=80=99s?= Sirs <tukusejssirs@protonmail.com>,
        pcre-dev@exim.org
Subject: Re: bug#60690: -P '\d' in GNU and git grep
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
        <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
        <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu>
Date:   Tue, 04 Apr 2023 12:31:51 -0700
In-Reply-To: <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu> (Paul Eggert's
        message of "Tue, 4 Apr 2023 11:25:59 -0700")
Message-ID: <xmqqttxvzbo8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Eggert <eggert@cs.ucla.edu> writes:

> This is an evolving area. Git master is fiddling with flags and
> options, and so is GNU grep master, and so is PCRE2, and there are
> bugs. If you're running bleeding-edge versions of this code you'll get
> different behavior than if you're running grep 3.8, pcregrep 8.45,
> Perl 5.36, and git 2.39.2 (which is what Fedora 37 has).
>
> What I'm fearing is that we may evolve into mutually incompatible
> interpretations of how Perl regular expressions deal with UTF-8
> text. That'd be a recipe for confusion down the road.

Nicely said.  My personal inclination is to let Perl folks decide
and follow them (even though I am skeptical about the wisdom of
letting '\d' match anything other than [0-9]), but even in Git
circle there would be different opinions, so I am glad that the
discussion is visible on the list to those who are intrested.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C52C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 09:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiBOJro (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:47:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiBOJrm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 04:47:42 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E693E6843
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 01:47:30 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 62-20020a17090a09c400b001b80b0742b0so12756794pjo.8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 01:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aFIxwiSboHFIfNBkmop3xD+q9Hwn4whQ2PksUeH+GHk=;
        b=Sc0me/db9JHz81MPiy1oaGmwbekitHtV5yKPndPYufykplSnT/P5W9m0pFOPZjz/Yc
         UVl90M80tkDENNIwZ8C+nXa6YKso8i2Q5CTHOoQ+t7ap/tND1s0S9H2Q7o7AKc5qpCml
         lebth1bri/iiMld5WeLGlfQkg45J6oM/QmZQF8LJ/Wpsq1N+Gniqk1PGw6bwaBKpLFWm
         oFXwM1VfYGmJLb9voORwOdEua3SbHKRSZ3Ua/CyYBi0NENypfWEjNZv7KvFLXEjo13/Z
         AUhDZ8hX0PzrJcxRQ3MCpQIFKHKi+eCyz2KPyhxRyBbxzbPb55ll2Oc+wUCqKLfqKxdz
         cmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aFIxwiSboHFIfNBkmop3xD+q9Hwn4whQ2PksUeH+GHk=;
        b=XZIjCTb3vyUmf0a18igZtn0Sf+3dRk0sv2wkj2NJ4axvO8f7MONapUpFMCUa/1UmPY
         Mm3Cr2jkSOaB1gOlG4PPEyDsd21p7lXCGjgLf+M+U/QFhKhAvViwcR+HaDTrGyejnYrZ
         JDx4GeKV0pIhsxLEFaGc1XDQP52hGs63ufz4RnJT+7JUjFYjc5HgNPZF4TPYy7SzhtnO
         /Ptv4F5p2gX0NbhTIwoUz4dVPjF+ZXXM+qBUBvhMvM/LhJot6aHPBjrWwJwahNK+jP6W
         CoRaiyXJl3ZTcYz18D+O1oKMwm45H9vRYhhiJU0ojq+MnDrk9zhKnLG0lrzT5aZBV/44
         lXVg==
X-Gm-Message-State: AOAM531qdX6iKYtMqbAGmT1UHJUR639cKg4Tp06eUj6ZAoWdeGJVkMfl
        4ISm9kw4PMsH2wFD3yUHfOAodJbcP/Y6Iw==
X-Google-Smtp-Source: ABdhPJz488KmKeFuux07QlPD9vOTPsRRIo76fjs4BKGj0pFPQTt0pBLe87aMte+cZCZtVs9CVwmA3wSYyUGFQg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1514:: with SMTP id
 q20mr3521560pfu.82.1644918449625; Tue, 15 Feb 2022 01:47:29 -0800 (PST)
Date:   Tue, 15 Feb 2022 17:47:27 +0800
In-Reply-To: <kl6la6et76bb.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lwnhw5umo.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
 <xmqqv8xj71mt.fsf@gitster.g> <xmqqr18770pc.fsf@gitster.g> <kl6la6et76bb.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I can merge this to seen minus the above two topics and get it
>> compile, but it also seems to have some interaction with 961b130d
>> (branch: add --recurse-submodules option for branch creation,
>> 2022-01-28) and makes the t3207, tests added by that other topic,
>> fail X-<.
>
> Oof, that's embarrassing of me, let me take a look at that. There's a
> nontrivial chance that the "branch --recurse-submodules" tests caught an
> actual regression.

Looks like this is the case - t3207 caught a regression in how "git
submodule update" sets the refspec of nested submodules.

Looks like our concerns about the test suite are well-founded..

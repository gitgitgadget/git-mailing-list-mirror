Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59808C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF922246BA
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uN9vgPd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgKRS1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRS1x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:27:53 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B672C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:27:52 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id y17so4108378ejh.11
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=655V0GcFNpoeYmdp1HsT0l9zb3kX1Sycpl69V3fpdrg=;
        b=uN9vgPd2WV8punZijNK/11kTmv48WatQP+OYH1nzuvWE9R5SDwHPkdzL/dHUZHwxbt
         xs1tVPRRSs+fQpTmw+IeM2fV50h3COL6S4sZxyXCtxgz03awRHhBc2V6ddv0janyuNs9
         qt5BJYpHnvfhiMXc+gnFzDcqkKxmrD+Gubt3SSxVl8/QgA5vLPHBUYO4dh534Btnup03
         uZcvZOc0MDGJR8ZpEt0SAckYouh1vJ7W3D8Yh+cyu03gI11cNh2ROjDShYCWW3YM6zpb
         VLnSYJnkZi2wXyMc9O2UcvlyOks0PIzhVmN3auTu2oR+voTM2A+Uv8LnUEivAS9tWGAW
         XJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=655V0GcFNpoeYmdp1HsT0l9zb3kX1Sycpl69V3fpdrg=;
        b=hEUEwjfi97unjMEd+FpT/a4rYdgUcHABR5wWihPOzFZNNZrlkWBEoXKjL3DzToD/RV
         DnIB3SOvQ5tWmFKjb7wPmPz7gZLFYyuqoLo9mhhUXNqDgKXVtR19S3b3jf+lBpZJMxa1
         NHQYqDFPD4slj9PtK772QMkcUXwn4bi8Qop8Bwir8R1dYoM/UbaWZln29425UfoZIReZ
         Zl5SJ7D+EH5enjbH2kGRP39sZVSBS222XaqNAKqrlzGVEHuiSIyV6x9KkiTNGUODqiJ0
         bfXEivtX9ZntKrIPLlsOlP0cPLHinmIHO8VYFo2m4dp6tU49tdLIgsWeH2LZnO3iJpjQ
         RF+Q==
X-Gm-Message-State: AOAM532zIIkklJB6jM2fvBPQAiW8OZ55NIiJSIE8dHGzdAyr8+ctQ1Gp
        W0jTVHnrDKKeKIsEaJGFgFI=
X-Google-Smtp-Source: ABdhPJxkjXRXnBUM75CI69n3KgwaWqup5gzOpXEDe6dFOgl+/37gBMawjiGCcAdrh3IMX8US+H34fg==
X-Received: by 2002:a17:906:4712:: with SMTP id y18mr24325222ejq.51.1605724070875;
        Wed, 18 Nov 2020 10:27:50 -0800 (PST)
Received: from evledraar (ip18-11-210-87.adsl2.static.versatel.nl. [87.210.11.18])
        by smtp.gmail.com with ESMTPSA id bg4sm13446011ejb.24.2020.11.18.10.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 10:27:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH v3] help.c: configurable suggestions
References: <xmqqima237qt.fsf@gitster.c.googlers.com> <C76K6Q09ATLR.1OI5KW390LKFX@taiga>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <C76K6Q09ATLR.1OI5KW390LKFX@taiga>
Date:   Wed, 18 Nov 2020 19:27:49 +0100
Message-ID: <877dqir04a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 18 2020, Drew DeVault wrote:

> On Wed Nov 18, 2020 at 12:16 PM EST, Junio C Hamano wrote:
>> It is unclear from this description alone why this is needed. The
>> seller of this change needs to emphasize how this is better than
>> setting the variable to "0" (do not autocorrect). My guess is that
>> some users do not even need the suggestion of correct spelling when
>> they made a typo?
>
> This is one reason. Another is that spell checking can be
> computationally expensive, and take an annoyingly long time on low-end
> devices.

As an aside it would be interesting if you're in a position to test it
whether it's the suggestion code itself that's so expensive, or e.g. the
stat()-ing on "git xyz" looking for "git-xyz" in $PATH. I if it's
FS-limited that there's easy optimization opportunities there.

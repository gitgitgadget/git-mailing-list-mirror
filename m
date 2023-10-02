Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEBDE784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 01:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjJBBbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 21:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjJBBbi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 21:31:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51545C4
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 18:31:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77acb04309dso576288939f.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 18:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696210295; x=1696815095; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3m4J2qHHLn+dZizbp1hXDjxKyJMA4MpmLlae/+N31+g=;
        b=OoOM02Xh7TC7iL2eDXW9y8uxFklTbJkgin6r1Ym6irUhL87ul/phjiCK2K8YY/tikp
         JkK7OtLvW+5JwElJLLFvAQcDoHg3Nf2dIV6c2ik4tK+PzyCMHfz2Cmy6dyMTfz+fbOcJ
         cqo8gDE36d0P2bSGnA/RiM6iU+7eyp9A0rEb6A5MQ9ZbZZKRk+mGAdDPsAFNEwTt8soO
         gCX5uUcios1ZjLcciIg9pBNaTQlEqGNBK/DsdQBi+iOJySuHnW0Y6Z3BV5d26gZRZhtN
         ZfHvurgPBXKCHNAP9rnJrzkORoJ9isLaOiGEzWg5T8TATALgWaT1PzE8PiazuSaRuwT4
         HPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696210295; x=1696815095;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m4J2qHHLn+dZizbp1hXDjxKyJMA4MpmLlae/+N31+g=;
        b=UQbBCxPQU6Vfo1NLOif5SnKzNsSM0WmD88XgsJGgUpp++nQAhy1YcFHwlCAseD1W2y
         ORNfJXW+mdvQk7F7zrgqMu19n+OXFwOo5DtGxh4pkRKGosyT0MHTYJVrqvuYMlMPxBTR
         jV2JuM0GLafWJECxJ2qXnkS8inksOZ/2bB0Op9a58vrsYXXaH2aCRWqppz3HUYGPWaEf
         +m1WWcOCPvC2UdJP3H62Z4lkfKaKXNiz2kcXrxAD2NvjH9nNoUf+mlJBY7bx1CFqFVfU
         6j1aYiQGeYLSE1zPRidcLvJ9m0N7RLLBdlthWmoQp328lfD0D3/2lHRq5f3vRWasYaOe
         jCvA==
X-Gm-Message-State: AOJu0YwSNdeH7kECCp893CSjmg956poGwue7Ww8Ws1qhlQdPI0CbMUPc
        xiv+jMaO/BdiJRPQqbD6WInS1jUezl792Q==
X-Google-Smtp-Source: AGHT+IE7pwwY8wlY/U+2ip5chgUDG4otfF6Uwa+qV0918SoOgxo49vcUh7/WAlflqmDzBa15lSah0w==
X-Received: by 2002:a5d:8a14:0:b0:792:884b:209b with SMTP id w20-20020a5d8a14000000b00792884b209bmr11719189iod.9.1696210295520;
        Sun, 01 Oct 2023 18:31:35 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id eh24-20020a056638299800b0041d73d0a412sm6747117jab.19.2023.10.01.18.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 18:31:34 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
        <20230927195537.1682-21-ebiederm@gmail.com>
        <xmqqfs2zl2iy.fsf@gitster.g>
Date:   Sun, 01 Oct 2023 20:31:32 -0500
In-Reply-To: <xmqqfs2zl2iy.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        27 Sep 2023 14:39:01 -0700")
Message-ID: <8734ytbyiz.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>
>> Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
>
> "Implement" -> "implement" (many other patches share the same
> problem, none of which I fixed while queueing).

Why shouldn't sentences begin with a capital letter?

I agree it isn't a very extensive sentence just two words but it is a
complete thought, and thus is a sentence.

There is great value in uniformity in a project so I will make the
change, but it seems very weird to me.

Eric

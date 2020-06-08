Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C3C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 12:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36CD2072F
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 12:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtoI/rj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgFHMkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgFHMkO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 08:40:14 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2964C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 05:40:12 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id s13so13460433otd.7
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TzBGVqMaRlWZMpqwJKf77wx0kZYHpHslKwqMy13kPE8=;
        b=GtoI/rj8JUThK3smoAwkgjetMA2zmpd9eWdVAKwUmOlAC8ONpIdBz8Rz09GeX6VS0t
         OFvHrsYKbnxmuUaw5NKEujoHmybKKRuG32KrgjXli+19Nohwa+mG96YUmdbWvClTmMwV
         gSFpIIRpBhnmd+8ePDDqCMKww6pNljLMJ5ZratlSTCk4/bXLaf8cT0GgDtSaYKR8U0e3
         OeMPdPGqcb+3aE/ucQkP/NzGlUnyIsUtbInh/42l2O+GWC+yA9qfpti3R9SYS/+QkIfg
         IAOnAd2kS1NiEPG8QpmWjM/XDE76cM+WXCOA9wNk7HBKX+MBAIEJ3+yBqn3fDhum81VL
         5XYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TzBGVqMaRlWZMpqwJKf77wx0kZYHpHslKwqMy13kPE8=;
        b=YWw5aNPXT4XvPft3+bKboApixF0TOcvu9jhnw/lbvnWhewUQvONO03sw56GKa89Yxn
         Oy1oe9dPG5r+6HtjqibmNWuPiliUgGlhp4l/cJsVjyhWyZQl8xDsOBtCY+x2QpTwtuI/
         Fm4Kbr/G398OW7g1fctpHuMQck4+flEK//VpRbYqeNiPzZEaW7hFduxwtGe9Cpk4AaSc
         ScOiDR4Dh566lousEwykHmeYAr98amgCbSTPwZBGrSO+u+Hm3yl+mMWokuIdWVmsxf5M
         llMTIplPdYrTr7TWwp45BYwbcLKqwylswx4cOlDcjEo9RGpOlzB3Xn3yZ0Dk53AQx13s
         IDKw==
X-Gm-Message-State: AOAM532zKQZccYjF9+RDx/8xPBdHDE+jQu1vCjPTJX7Rbsg5gOGi8zBr
        hFASwCF7kpYdlo2Vv1a+TPnVNwpP9XI=
X-Google-Smtp-Source: ABdhPJwLm5mRAT13IFoAacWmqIrLv8u//bldXpGaLX5lOiS7Ee35rZO/+icGs5WsVjn0QWnNqGjynA==
X-Received: by 2002:a9d:3f06:: with SMTP id m6mr3655807otc.65.1591620010792;
        Mon, 08 Jun 2020 05:40:10 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n187sm2460139oig.0.2020.06.08.05.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 05:40:10 -0700 (PDT)
Subject: Re: not sure if this is appropriate -- GH/Github question
To:     bruce <badouglas@gmail.com>, git@vger.kernel.org
References: <CAP16ngr=cTTUzSb8=beKu5wtaDCXL2tECUSUg8t+1HS12O972A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0f59fdf8-25df-e4d8-c0a1-75e3b77d15f3@gmail.com>
Date:   Mon, 8 Jun 2020 08:40:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CAP16ngr=cTTUzSb8=beKu5wtaDCXL2tECUSUg8t+1HS12O972A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2020 4:36 PM, bruce wrote:
> Testing the "create fork" process using the "GH" Github cli.

You are correct, this is not the appropriate place. GitHub and
Git are two different things. The most concise description I've
seen is the following from StackOverflow [1]:

> Git is a revision control system, a tool to manage your
> source code history.
> 
> GitHub is a hosting service for Git repositories.
> 
> So they are not the same thing: Git is the tool, GitHub is
> a service for projects that use Git.

(Note: I edited "the service" with "a service".)

[1] https://stackoverflow.com/a/13321586/127088

Please create an issue at https://github.com/cli/cli instead
for issues related to the GH client.

Thanks,
-Stolee

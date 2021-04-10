Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1277FC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25BF6115B
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhDJBND (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJBND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 21:13:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF5C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 18:12:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so3111488wmg.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 18:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=j3kjC6x1C83sF7Xv0VGs4LzqRRzwNvtczN87PsHeYtk=;
        b=V2TAZHrDecZfvHWVZ2rUHv3f/SDbTSF9R7s2B4YrvkttK9Y2rEKTNtX8dhkpuA/r3o
         K4xmOqd5tdQLqJE0KXzh68T7G+yEKMzH8QruQOwT7pdmirUJhrN+m0movdDtm2ovI5Gw
         wnp2cAMb/jZRmo346TPbqwNHSqtfb3iTyVkaukFrgR1ObMXKKCHWbeRAAqWFVVKAAELk
         4EA8rLjpchok6joeQoXbW+AcFrl4AUVJF87lJMR6/TfZUcHanofEINeIWSeyTMAC5z9L
         NqYLjQZ3ezgceAYOiepBy6KBVLv5OEfYreUO+18zizcf/VMbOyUhvPBh1G/yZpbPr94j
         e1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=j3kjC6x1C83sF7Xv0VGs4LzqRRzwNvtczN87PsHeYtk=;
        b=Qba29LPPlONxCf677xu0H56U8uU/i2wIKpa0GxcDhS77ZnOPsvvo6Q43MRf+ZzqJBF
         fZqW6mv/qx+ykBjLd6OkhNckVD+h5OPUQWE9pNihhUgZdrBhbGM33IO+FVFjj3ii7Q25
         KY4zuHnkIQ8rJa5LT3YjGaLadBfNXsU1k4bdUfImfmfy9kBiluU7mGptv1QbOVAGCABn
         A9FrJp/vXmDQKESRPupz2lOSpHJ1eNLpcybbbO6aWlDrY99TIkmExSQILplymf2yXyWv
         XH/cwVpkZNucZkEegCzH7Ww/q17Wd/0SQHgCRz5gkudgkGPCB3UTDrOq5/Yjkn50wNGQ
         ldpA==
X-Gm-Message-State: AOAM5320N4cyNiPB0DLNbsqJVZleetJfZemz6lUUBq/M4VBRG50ENsHJ
        Zv+LS4fXt1cbc3pTqSbdWrDceKnBnDuNpQ==
X-Google-Smtp-Source: ABdhPJwILUO3RsQp4Ph3/gK3Qr+sf0jp9INLNAL+lhZ400E8oWegScvmLTK0Mp7m7WzL21SzF77FKQ==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr16080645wmq.141.1618017166341;
        Fri, 09 Apr 2021 18:12:46 -0700 (PDT)
Received: from Inspiron (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id s8sm6689415wrn.97.2021.04.09.18.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:12:45 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [RFC PATCH v1 01/13] doc: typeset command-line options in
 monospace
In-Reply-To: <8a44cb3d-d1ce-a3dc-82da-69a65d5baac2@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
 <20210409040301.3260358-2-firminmartin24@gmail.com>
 <8a44cb3d-d1ce-a3dc-82da-69a65d5baac2@gmail.com>
Date:   Sat, 10 Apr 2021 03:12:44 +0200
Message-ID: <87r1jjgcxf.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 09/04/21 11.02, Firmin Martin wrote:
>>   help.browser, web.browser and browser.<tool>.path
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   
>>   The `help.browser`, `web.browser` and `browser.<tool>.path` will also
>>   be checked if the 'web' format is chosen (either by command-line
>> -option or configuration variable). See '-w|--web' in the OPTIONS
>> +option or configuration variable). See `-w`|`--web` in the OPTIONS
>
> Why not `-w | --web`?

Good question.

There are multiple justifications:
- The "|" is a meta-character not included in the option name.
- If you run
      grep -Pn "'.*\|.*?'" *.txt
  under the Documentation/ directory, you will notice that we have
  already done something like this, but in italic:
  - In git-rerere.txt's Synopsis: `git rerere` ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|'gc']
  - In gitremote-helpers.txt: 'option dry-run' {'true'|'false'}:
- That is exactly what "man man" or some other man pages do (e.g. "man
  tar"). Of course, some man pages do not follow this convention
  (e.g. "man 7z").
           
Best,

Firmin
                                                                 


>
> -- 
> An old man doll... just what I always wanted! - Clara

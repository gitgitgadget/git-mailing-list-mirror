Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF1C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjB0TkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 14:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjB0TkK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 14:40:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187327991
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:39:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id bh1so7900810plb.11
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ri8ni3TfpD8BOZ8fdHkWSp9/wt82bzgQ+wd5KKYWGs=;
        b=QIRj3nZGX2Lja9BZac28AnJHom3ha5kJwFo57+UrDieZvDJvlfZ13ga+0KmobEltIr
         XayWe00VHM7Weupklv/I2HZrZUinrnEni6qLJzkguAuDzm1Lmno1dopU7k8I8osOZ2x3
         pSO3Fz8i9qVErAUINUR8xP18yHPtPn8ZBwPshtzeeXvZmulhkWmqVKsEa5ImrLsyEsI7
         OThjzjJuDrj6Q6KeDukB5t5U58rD1SRoC9U/e3G38O+c3dalUMRBwPnsaku8zmaPU8Gs
         wdVPVs1hJyrV1BeSD0OFZnFUdEu7a9OHkwT96xW0VBbAeDz2ZwYn4CB2mEgCSB9Vr+mw
         rxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ri8ni3TfpD8BOZ8fdHkWSp9/wt82bzgQ+wd5KKYWGs=;
        b=QS6Nq4JRbu2qVDbZiorz7k6KpMx/9HBUqfTmLFQAu1VgwFKsC7d6RawfWckbV5OxAq
         VpryzIjlRzmp590AUrgFPU4xpoRsSrt+Cvg2eN4i/axgAiSvZGthwVcRUo3fiwGtNJYT
         t8P4hjuNFksOpRfjIPDnyTtrciGnEWClznyagf+U3OgqXr3aUbGydWm6OOzeAeZZ3Bvb
         D58TY79V158Z4vDGFbH2bDuGqS34KfpZ8jNKPf5QykAKYzH2GQXoVEYW8GP9eW+80GnI
         me+RhXpr/ZA3hMXw3wg2Hc6d9+P+euSmP+4tBdVmIHIKFzzs4S0cWz29H0wEDLeywQFf
         HjNw==
X-Gm-Message-State: AO0yUKX0IV/VCmMynVTKb4GjKX8Yid78jpDO+h6FrpVNWCGWn3Jy8OOG
        gNuaaRTgbBjQ3xuLC96a+f+P2TWDh6E=
X-Google-Smtp-Source: AK7set9mywOkVTjRQ0OMGyJdSLgcvslo8ozSUNkFELbxBCPrV+XVC5p4RNTRaTkLgm/8DLe7Uu5j+w==
X-Received: by 2002:a17:903:138d:b0:19a:d7d8:a080 with SMTP id jx13-20020a170903138d00b0019ad7d8a080mr60760plb.22.1677526785057;
        Mon, 27 Feb 2023 11:39:45 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709029a0900b001992e74d058sm4984360plp.7.2023.02.27.11.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:39:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/5] git-compat-util: add isblank() and isgraph()
References: <20230226115021.1681834-1-masahiroy@kernel.org>
        <20230226115021.1681834-2-masahiroy@kernel.org>
        <36cd059e-c676-2aa2-68d9-41a7b0db57f0@web.de>
Date:   Mon, 27 Feb 2023 11:39:44 -0800
In-Reply-To: <36cd059e-c676-2aa2-68d9-41a7b0db57f0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 26 Feb 2023 19:45:22 +0100")
Message-ID: <xmqqpm9usxrz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> In the previous submission, I just moved isblank() and isgraph() as
>> implemented in wildmatch.c. I knew they were not robust against the
>> pointer increment like isblank(*s++), but I thought it was the same
>> pattern as isprint(), which has the same issue. Unfortunately, it was
>> more controversial than I had expected...
>
> Not sure we need that story in the commit message,...

Usually we encourage people to write as if there were no "previous
iterations".  Describe how to reach the best end-result without any
detour, using the experience gained from failed attempts.

> ... but it gave me an idea:

;-)

> ...  So it's not so
> easy, however, ...
>
>> This version implements them as inline functions because we ran out
>> all bits in the sane_ctype[] table. This is the same pattern as
>> islower() and isupper().
>
> ... if you remove GIT_SPACE from the definition above you get a
> macro version of isgraph() that uses a single table lookup.
>
> If we're out of bits then isblank() is a good choice to implement
> without a table lookup, as this class only contains two characters
> and two comparisons should be quite fast.

Implementing sane_isblank() plus sane_isgraph() as static inlines is
already not too bad, but if one of them can be made into a simple
table look-up, that indeed is better ;-)

> Stepping back a bit: Is using the unlocalized is* macros in
> wildmatch() safe, i.e. do we get the same results as before
> regardless of locale?  Junio's remark in
> https://lore.kernel.org/git/xmqq3579crsd.fsf@gitster.g/ sounds
> convincing to me if we don't care about single-byte code pages
> and require plain ASCII or UTF-8.  I think it's a good idea to
> address that point in the commit message.

True.  To be honest, I wasn't thinking about non-UTF-8 single-byte
"code pages".  In the context of wildmatch, the strings we deal with
mostly interact with the paths on the filesystem.  If you interact
with your filesystem in latin-1 that may pose an issue, and even if
(or rather, especially if) we are to declare that it does not matter,
we should document it in the proposed log message.
>
> And adding tests to t/helper/test-ctype.c would be nice.

Very true.

>> +#define isblank(x) sane_isblank(x)
>> +#define isgraph(x) sane_isgraph(x)
>> @@ -1270,6 +1274,16 @@ static inline int sane_iscase(int x, int is_lower)
>>  		return (x & 0x20) == 0;
>>  }
>>
>> +static inline int sane_isblank(int c)
>> +{
>> +	return c == ' ' || c == '\t';
>> +}
>> +
>> +static inline int sane_isgraph(int c)
>> +{
>> +	return isprint(c) && !isspace(c);
>> +}

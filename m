Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B22C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 19:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjCOTOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjCOTOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 15:14:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CACB5D24B
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:14:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id iw3so4334220plb.6
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678907671;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/pcqiHewH7t1lcnjQC72BJbjXBz2VgT02FL43f5Gj0=;
        b=LuhapO5fk/AmoADCgvLLn53yA0r7IAADfiBimlM0cHI+a7/unjP+dF4btfW1HNrv51
         KleNIAWNeo5dq48BZIOx1r/CEs5GyzjyoToa/QpohR0k+LTsF+tXtT70c7euOBKLfBDy
         gKlsT4dCc14D/Yhhnom+MT/uZINSCfhd4BtSJgdwrmqUKtZrdK5IeiKiracbSw9AlqLY
         bi+DrpA8Exes79eENyTp3toqUrimLjvvQf95g7j8uHmqAPi1DC8cJ27TwXXKLn4cBjBt
         Uuc1WV3MyyTcbjtIX8bvw+K6M5oU4CFtDKLCng5J2HPCvRJTCO72pobgXuk0g8pV+Ih8
         zcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907671;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/pcqiHewH7t1lcnjQC72BJbjXBz2VgT02FL43f5Gj0=;
        b=tkZzvAhME4CHVI/8HNZMbBThaC3IIo/75JHM8MFiY60wsI5jkdzJuk6vy9oFxt7RPI
         H74zGYevVrgg5iEQBoLOzTnx0tXrhWQj5IuHso+65o2nLHsJoJnDRIja61dRuaJ7eFF+
         1xmM5uLDpinGBoiwFjAGMyyEDA1W8LG/BwDhRHCklYb9omiysQeLuYsJSVLHtgaJK5S6
         Ef+42BBSXlfUBzX1zeKfe50VyVG3WJ1uqLTQJMtKUxA1h02C564yJXSsDfsnH5g9qfVd
         gxPlLzQjutfxObPRflklAe0v2ZorKvhgZF035zxplVoxzmZV0W0brrr0PHfBHBenJ04G
         e4Og==
X-Gm-Message-State: AO0yUKWfbSXIvgL+rrUni0e/wqVwYqy5pIkyWZz0JUy2w6NPTVNXgETE
        fCeSCxkk/7z2Whizl6eYvYM=
X-Google-Smtp-Source: AK7set98OQOTcKRRQoe3e0UXUUa99W6fXF2MZC4wd1xng56URmeucVr0DRGTbt30DxvBm1G4msUHBg==
X-Received: by 2002:a17:903:230e:b0:1a0:4354:797b with SMTP id d14-20020a170903230e00b001a04354797bmr629138plh.21.1678907670973;
        Wed, 15 Mar 2023 12:14:30 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id n5-20020a17090a2bc500b00233bc4edb77sm1723237pje.25.2023.03.15.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:14:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 1/8] for-each-ref: add --stdin option
References: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
        <f9e80e233f1ca26f07f9db49261e54b7deaf83b8.1678902343.git.gitgitgadget@gmail.com>
        <ZBIJKrgI0+Qxd3pG@coredump.intra.peff.net>
Date:   Wed, 15 Mar 2023 12:14:30 -0700
In-Reply-To: <ZBIJKrgI0+Qxd3pG@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Mar 2023 14:06:34 -0400")
Message-ID: <xmqqttylomi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 15, 2023 at 05:45:36PM +0000, Derrick Stolee via GitGitGadget wrote:
>
>> @@ -75,7 +79,21 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>>  	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>>  	filter.ignore_case = icase;
>>  
>> -	filter.name_patterns = argv;
>> +	if (from_stdin) {
>> +		struct strbuf line = STRBUF_INIT;
>> +
>> +		if (argv[0])
>> +			die(_("unknown arguments supplied with --stdin"));
>> +
>> +		while (strbuf_getline(&line, stdin) != EOF)
>> +			strvec_push(&vec, line.buf);
>> +
>> +		/* vec.v is NULL-terminated, just like 'argv'. */
>> +		filter.name_patterns = vec.v;
>> +	} else {
>> +		filter.name_patterns = argv;
>> +	}
>
> Now that you aren't detaching the "line" strbuf in each iteration of the
> loop, it needs to eventually be cleaned up. strbuf_getline() will
> _reset() it, which is good, but at the end we'd need a strbuf_release()
> or it will leak.

Nicely spotted.

Thanks.

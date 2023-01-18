Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F4C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjARQaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjARQaL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:30:11 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930C458660
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:27:51 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k13so4819705plg.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gafD2/MASubReFWAql1+Ux/nCbeH18eE0TWXtW4ncn0=;
        b=fGlE8T8NEEcuDRViJF0s/UBhbBSgY+7YOD1FEDHKqKhUk6e3T+KXWYCok8kIBp8K8H
         DY73F+49TGKri4Qda2FwwaBCgSHS2vunuj1R23t5evv+R/h/eaqdkFUbL38r8smOYQ7a
         iv27LgDiM+HAQEGRHVTbd1T4txjQI13yT/6JJgy2NbYSt9b6XEbtX1YtjEePXdnAKGU1
         H/zMR/G+EV44T9/KaQPdXX47WxFu39joTx/I0gKZoQvWIw2uE/VLvSehlFJH33qlSTpq
         i2cv6asZDAULu+OlthtWc4jHT8xZX+uYiVyQazLQqddbXdTB+zcXuNoKlkxWT1yBYBDO
         KU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gafD2/MASubReFWAql1+Ux/nCbeH18eE0TWXtW4ncn0=;
        b=Z1TmDFbu0DFSVQD/z/r4jAXmsJFiDcs/69dBYhH4gGefr3AwLGWoE5zODKKOng6tBk
         ZcNzMrDfLHg5SDjcEeSXxuALxfDORAr+wTTshWmf2QYSYRVLKakLj8tj6Njn32mZtn/H
         wttVas94TW5hBjRsz1UK45r/c8BXb1QicTWG1x0Gu8d/oY/C1QJiluBUib+H0Gb7uahg
         CBYBUhSrwShRGs2lokJhveadAHzJDi2DxBsNGJYtwQjR6DIjj3zxEjKX/rtM97Q0ZtNd
         MVBvPtrXwAaUR9JpEGec7mzvD8T57qEWxa1XLA9MDvXSzK36Cf+mZIzjjBl87IcjZyUc
         uJxQ==
X-Gm-Message-State: AFqh2krPQaOPees4CdWdlCGdweeaM1EvY44KLMA2eBONFafd+hFYQFdW
        CZRVSO3EWT0TDTzLsknY2jM=
X-Google-Smtp-Source: AMrXdXsacqBvxfjvPrLH+aHCC2lkJ9H0ro+0YRxYvqWb+KXu52JiWhxP/ThYqvx0ykVUSPXrJQbxdw==
X-Received: by 2002:a17:90b:3695:b0:229:189c:c48e with SMTP id mj21-20020a17090b369500b00229189cc48emr8117026pjb.17.1674059271343;
        Wed, 18 Jan 2023 08:27:51 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r8-20020a17090a560800b00226156cf039sm1524604pjf.44.2023.01.18.08.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:27:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
References: <20230117013932.47570-1-michael.strawbridge@amd.com>
        <20230117013932.47570-3-michael.strawbridge@amd.com>
        <3a2d4559-fce2-80f3-bafd-5eb8ac1a7eff@amd.com>
        <xmqqbkmxbort.fsf@gitster.g>
        <71623e1d-805d-cdc7-d872-224821c1383c@amd.com>
Date:   Wed, 18 Jan 2023 08:27:50 -0800
In-Reply-To: <71623e1d-805d-cdc7-d872-224821c1383c@amd.com> (Luben Tuikov's
        message of "Wed, 18 Jan 2023 03:31:39 -0500")
Message-ID: <xmqqv8l34xkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luben Tuikov <luben.tuikov@amd.com> writes:

> On 2023-01-17 02:31, Junio C Hamano wrote:
>> Luben Tuikov <luben.tuikov@amd.com> writes:
>> 
>>>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>>>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>>>> +	if test -s "$2"
>>>> +	then
>>>> +		cat "$2" >actual
>>>> +		exit 1
>>>> +	fi
>>>> +	EOF
>> 
>> If "$2" is not given, or an empty "$2" is given, is that an error?
>> I am wondering if the lack of "else" clause (and the hook exits with
>> success when "$2" is an empty file) here is intentional.
>
> I think we'll always have a $2, since it is the SMTP envelope and headers.

We write our tests to verify _that_ assumption you have.  A future
developer mistakenly drops the code to append the file to the
command line that invokes the hook, and we want our test to catch
such a mistake.

Do we really feed envelope?  E.g. if the --envelope-sender=<who> is
used, does $2 have the "From:" from the header and "MAIL TO" from
the envelope separately?

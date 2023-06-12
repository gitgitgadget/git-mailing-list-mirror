Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6002CC7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjFLV13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbjFLV05 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:26:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044952958
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:26:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3a9eae57cso16330375ad.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686605166; x=1689197166;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46Y1f54ubQy+pMpDuGjF8sGoZthVvNZt5SoXgDuxssU=;
        b=k5+4Sn/hhHnbHGoLdT20y0ShwPV4dxMsHcmpCmkUvPpdjx/CfkB8VQZPZ7lc6Az0Jr
         DJu9BpIXWYul4kzvVqMeyjN8FoLnVCQb+c+OLTGvaHwaUtLfBWlAdwM69RttIRWRM3XC
         BFo1v7GJgqEnEHUvKBS+7HtzctbmZkaro2Nv8NuH+2bY+Xy/t7gLUEbLS1FSyH67iFt8
         L9rKOkZI8DoGjIoiglfiVuNmM4eEITVAnUzj+vcp+DiEdBQSrXVuG0FSitKLUkNo7grH
         j9u2DxRPiJEOUvw8XWkgF57oHtL0OiYB1skct26v7D917g0nXEZ1a/cC+RWS7zoSwS9Q
         xcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686605166; x=1689197166;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=46Y1f54ubQy+pMpDuGjF8sGoZthVvNZt5SoXgDuxssU=;
        b=lPTswFbeCnsFVxotsL8/fi8ID8GYQ8Ihv7UJfKrplt1w99k+WYXyY7e0z43MhyfZA0
         +niIFDgSxXIQdMSodjQq2cFHG00dviwvn1lh4/DrFkS+m6HDu2Plm5DKpqEwEif2cIm4
         VjoIUeZJiUmzPi/ubJc6WF44KcJP1VqfK08OyCMQWUtYL40P4KyhYEU55+I8OBqEYHyc
         jZLkDKAdwcA1cPeUtIRR3OQLvFEVzubZO+jybF5JXHFIsurGzZfvc6cDyGzTN9Jp5y7p
         3y1HYOBe5RbImPVHhEUOuigUEq49sqkvGAOvhd3g19ghDe4mu1rwFPwFakxU9w6RuMox
         7KOg==
X-Gm-Message-State: AC+VfDxVuH88KOHoDlrUlpMdEjodjUacL+qzBf6P4W6pJ1XgzfUlP/xc
        C16mIkfhu8RHC3y9TmTwqWMAG+Fm3t4=
X-Google-Smtp-Source: ACHHUZ7SSg7aRuYzSq9/jXtP0HcuX8+RvwCC9v+eZZ3JI48DT24woG+bGsJ1rXUixT//OAbNiyhKhQ==
X-Received: by 2002:a17:903:11d2:b0:1b0:3ab6:5140 with SMTP id q18-20020a17090311d200b001b03ab65140mr8783074plh.4.1686605166276;
        Mon, 12 Jun 2023 14:26:06 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001b3d756a6f4sm1899088plg.13.2023.06.12.14.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:26:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/4] gitformat-commit-graph: describe version 2 of BDAT
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1686251688.git.jonathantanmy@google.com>
        <d4b63945f6d52e68a4760393f787acde0fccc312.1686251688.git.jonathantanmy@google.com>
        <1d31a8a6-1e45-bc42-2485-ff39f3cea24b@ramsayjones.plus.com>
Date:   Mon, 12 Jun 2023 14:26:05 -0700
In-Reply-To: <1d31a8a6-1e45-bc42-2485-ff39f3cea24b@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 8 Jun 2023 20:52:57 +0100")
Message-ID: <xmqqh6rc8j9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>  	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
>> -	in Probabilistic Verification"
>> +	in Probabilistic Verification". Version 1 bloom filters have a bug that appears
>> +	when int is signed and the repository has path names that have characters >=
>
> s/int is signed/char is signed/ ?

Indeed.  Thanks for sharp eyes.  Will tweak while queuing.

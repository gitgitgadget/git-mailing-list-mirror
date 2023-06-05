Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D2EC7EE23
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 23:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjFEXyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 19:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFEXyT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 19:54:19 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6142BF3
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 16:54:18 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b28fc7a6dcso786129a34.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 16:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686009257; x=1688601257;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oatwxWgIl02xWMXPCotYRUR44HdLGST17s9a5mVhjZ8=;
        b=sEPdv7uBib8NpUTRasQQu/J03jiVlBsMLZaqzDAiHjAx3XiKE8aSW7MkfgAvLNnsUz
         tZyvcN6V8VqwJPNJVQ75sSkBUyVwtuqYNmHjJC3xNTnuFZjkZj7VWVvcO9Kkj4427DiT
         URTxUVgbxqUX2GkfDfjHh2aM5oR5gAdC+J++Jj1KaJHSQcw7Pu4whgsXetcfHVURc6rB
         8DMhou5TeYV96ZXcaHdoB98RTaMpgTBosASoDip/8ME3LgrLBb/1RkSCY0Dbg/XFX4Un
         lxPHMJ3tjAiPPRelCpveBVY+Au1sPT4MycFudv/cAqaZe0PewC+wKXmguc7o/Udj7vlz
         1f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686009257; x=1688601257;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oatwxWgIl02xWMXPCotYRUR44HdLGST17s9a5mVhjZ8=;
        b=hDXLOxghc0vbRsBw4Xp68i+OJBwNAUMagbBdMwHqWtD3UnONKA99CaACW45/KAofGF
         yRjJ5XyNkaS+MxRTdeLUhbVHrWTQCdA9CMcAAwXa8agxXr/VkUpKxrMXumI4cRs2NDFq
         alfH9qSYjbirl1JS0FEtcr9H3St8s1/EGcSnOGaaSKDdL0Ed3qYslihmki+1N5HTdvzc
         bxU7CR49Nr1Tv4H7trbCIDzJqDD0RrldQsGyajuSHu8W3ENMlnrxWCmw1G7UeCPg+m5G
         TIlBQxIhyR1hqsocTmDxVOCxSRmsMvafeMPeJotwRAlcBMZQLYkOTIh3h5OeBKeV6TN/
         Fhrg==
X-Gm-Message-State: AC+VfDyeRIcUZa2LOQwnlZ4mnWCDk2JM6RP86e+tp5035PwIrCLisvAI
        xastKbmaiJiJ4TFHy9KYGd8=
X-Google-Smtp-Source: ACHHUZ6NWQg+y5Ih7+e8+wcjLTdYdXcQIbCVqvfuYw3TYUyTb/uPw5p7lgpbnzQwm+JbHltY7WUr7g==
X-Received: by 2002:a05:6830:4b1:b0:6b2:8e2c:33b9 with SMTP id l17-20020a05683004b100b006b28e2c33b9mr253713otd.19.1686009257579;
        Mon, 05 Jun 2023 16:54:17 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id p10-20020aa7860a000000b006528d9080f6sm5726467pfn.9.2023.06.05.16.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:54:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 5/5] cat-file: Introduce new option to delimit output
 with NUL characters
References: <cover.1685710884.git.ps@pks.im>
        <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
        <9900512f-b0da-2e47-f1ab-ed51ec2c78ff@gmail.com>
Date:   Tue, 06 Jun 2023 08:54:16 +0900
In-Reply-To: <9900512f-b0da-2e47-f1ab-ed51ec2c78ff@gmail.com> (Phillip Wood's
        message of "Mon, 5 Jun 2023 16:47:14 +0100")
Message-ID: <xmqq35355utz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Instead, introduce a new option `-Z` that switches to NUL-delimited
>> input and output. The old `-z` option is marked as deprecated with a
>> hint that its output may become unparsable.
>
> The commit message explains the problem well, I agree adding a new
> option is the cleanest solution.
>
>...
>>   @@ -246,6 +246,12 @@ respectively print:
>>   -z::
>>   	Only meaningful with `--batch`, `--batch-check`, or
>>   	`--batch-command`; input is NUL-delimited instead of
>> +	newline-delimited. This option is deprecated in favor of
>> +	`-Z` as the output can otherwise be ambiguous.
>> +
>> +-Z::
>> +	Only meaningful with `--batch`, `--batch-check`, or
>> +	`--batch-command`; input and output is NUL-delimited instead of
>>   	newline-delimited.
>
> The documentation changes look good. I wonder if we should put the
> documentation for "-Z" above "-z" so users see the preferred option
> first.

Hmph, I expected "-z" and "-Z" to be orthogonal, the former
controlling how input records are delimited, the latter controlling
how output records are delimited, as it usually is a good idea to
keep things that could be orthogonal to be orthogonal to avoid
unnecessarily robbing users flexibility.  "-Z is a new way that is
preferred over -z" was something I did not expect, actually.

I am not outright rejecting such a deliberately limiting design, but
I'll have to think about it a bit.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E92C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjEQLUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjEQLUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:20:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9355426AA
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:20:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3093a6311dcso612300f8f.1
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684322405; x=1686914405;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A1dcgYvS60KJzrg6pfz1A2b1qPTOWBUyYDlQJpJqZgM=;
        b=he4j+Kwv9ehOP7zK3sHZGeotplJoNvgfVSXRJxntXccFpdS/mlNKmv2Nxw1ZOxJVDI
         HcnkQPMcjSAwsbrrlAQcFzN4y598PVza9R2PT8zw6m9HEucgxvYVTtTUSrs26KVG6pCm
         EFdEu1Dv9l14hNz8oMMZs7X6MQYm35aZrTeLiL6JIk7hGY/iUeDzB2lLTQA1ILQa1/1s
         OakhKMBWvqTndWBIn16Y7MWKcrjAh4R+gAUjktnQsfzIIPz9KwoNle3odjYkw6lUtV4y
         W4ZBpqEDCLW9XHWDOjYI5yj7curVNZMh79hqn4BSD8V6RnlPMPimGSAnAXVTIUzrUiUG
         +azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322405; x=1686914405;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1dcgYvS60KJzrg6pfz1A2b1qPTOWBUyYDlQJpJqZgM=;
        b=fHOs3JGsEbdkA801JvP1rxy6Fboamc/Tr41kW03xqY5mAajq9ddV3cZWZA7vKxWgbd
         po5AN/ZK5ZUAIGn9DxWk1lmBnqgd4Ucea5zwNEAsoZK+PVn45ydREarUPE/AVANrTMPb
         5uSWzSLE0jnCq4WwuwyLIaaMdR7g54VU1jzbM9Q1B4yWSJVm1ZxEO4sSV884CdEqh7gn
         PekOO27JtBOG9JIY788eoxkTfOXw8VdtWwHxhH16cz0ExYJblMZcwTfbPzSO18sYhaSf
         ta5ZsBgtodKBc//96e+92hpLxc4qfdPaKUOz995RHN/kyS3C4mlm6/Guem046XU5V1Iu
         kVQw==
X-Gm-Message-State: AC+VfDwHIy2osiHKvBWxS536QEN5xa32fLyAIDcNFDuYpCDHJjd1VNoU
        JOIFyQpiiTD7WPSIejToT0w=
X-Google-Smtp-Source: ACHHUZ7jjvfOhzf/5/Sq7K8uhUe5LdsOg5AeQcHvQcK4hRYSVyb/+2as0FE6ps7TIc4YBTLkeOMjnQ==
X-Received: by 2002:adf:df0b:0:b0:306:8f5b:1b49 with SMTP id y11-20020adfdf0b000000b003068f5b1b49mr433895wrl.47.1684322404794;
        Wed, 17 May 2023 04:20:04 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id i15-20020adfefcf000000b003064600cff9sm2550031wrp.38.2023.05.17.04.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 04:20:04 -0700 (PDT)
Message-ID: <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com>
Date:   Wed, 17 May 2023 12:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com> <ZGSlqAPwaLhgWm6v@ugly>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZGSlqAPwaLhgWm6v@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/05/2023 11:00, Oswald Buddenhagen wrote:
> On Wed, May 17, 2023 at 10:05:51AM +0100, Phillip Wood wrote:
>> On 28/04/2023 09:35, Oswald Buddenhagen wrote:
>>> +        } else if (skip_prefix(msg.subject, "Revert \"", 
>>> &orig_subject)) {
>>> +            if (skip_prefix(orig_subject, "Revert \"", 
>>> &orig_subject)) {
>>
>> I think it is probably worth adding
>>
>>     if (starts_with(orig_subject, "Revert \""))
>>         strbuf_addstr(&msgbuf, "Revert \"");
>>     else
>>
>> here to make sure that we don't end up with a subject starting "Revert 
>> \"Reapply \"Revert ...".
>>
> i can't follow you.
> 
> how is the concern not covered by the subsequent comment?

That comment says that reverting a commit with a subject line

	Revert "Revert some subject"

will result in the new commit having a subject

	Revert "Reapply some subject"

I'm saying that reverting a commit with a subject line

	Revert "Revert "Revert some subject""

should result in the new commit having the subject

	Revert "Revert "Revert "Revert some subject"""

(i.e. at that point we stop trying to be clever) rather than

	Revert "Reapply "Revert some subject""

which I think is what this patch produces.

Best Wishes

Phillip

>>> +                /*
>>> +                 * This prevents the generation of somewhat 
>>> unintuitive (even if
>>> +                 * not incorrect) 'Reapply "Revert "' titles from 
>>> legacy double
>>> +                 * reverts. Fixing up deeper recursions is left to 
>>> the user.
>>> +                 */
> 
> regards,
> ossi


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1FBC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA792083E
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbhAYV2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732634AbhAYVTj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 16:19:39 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E1C061574
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 13:18:59 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 36so14221711otp.2
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8u8RWwppm3YVsPYtQoPpgFrbpZR7YxE6sS9wbRW2euI=;
        b=tBX+AakTHEYe3JkuQLHOw5ktIZtKVeNuACmwDxz2/gmhK1KM6y9HAb6djApISBl+U0
         ZDYGP9mQTHzFeuuIKzztmFS29msPyL7+/6Q05/7jCXGejdgm4x9n4suqRYr4K2dkMb45
         DGaUWK0PG5gN3fl7mgHSHtYOuWV4TIOb9AT/dzu4Yk/OIdoIUXp6BAPVw4fGQ4tvWOzf
         3RB3Csi6hjBssD2jDcFFubmnd0h37ptnA+tue+0+DTjHKC1WfzAfJJOcWPAxSy+epWzJ
         gjQtQzB+aCW/OSWU46crIpjVEePI+gUYcqBabgyw8SUnPHSqYBXIR3tHeXGL8n2XOMRY
         6JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8u8RWwppm3YVsPYtQoPpgFrbpZR7YxE6sS9wbRW2euI=;
        b=BabMowVugZ1vNKi61bSYSA0dO/wo+9cseGkKBm0jVOM5ZGo79HA/jv1fqQP5yIBPUn
         aeZsFxcywn/pfFr9uElS5UsuvU2FIUjXsdxNm3GgBkLh6LeklYl3G5fGi9/YXSBJf/5+
         NIzvP41anRsQx764cLHdBYgEx7atiIlrzuhtjyWmX+eV2SI+MQCqq1Ioj1GzIfRguEYi
         M/BTLiSd9nu6sWWP8aYTf3J6TpzHp9dGG/OtKbTU+8ImlAzYD41lvRcWcf6fwV92EL7z
         NgtfdNWByc9rXHWIfwVSPmq8JU0UqhbRkYH1PxvJ1K7WF4SoiRzcAYSPFCTvwSHFcGl9
         WKYg==
X-Gm-Message-State: AOAM530JzIQZZs7ixAks+3HN2jaUXbGlNTY73EQwJhT+p83PhCB92DbN
        GOzegZE32wYYlU/+mAKPJpM=
X-Google-Smtp-Source: ABdhPJxmjy7vjDgdqt5yf3Jo1qNmbzVZRK34oK3qhgsyPxcCEJnLjq6L9D9g3TgBleDwrzVhAcpVUQ==
X-Received: by 2002:a05:6830:20d8:: with SMTP id z24mr1760929otq.126.1611609538371;
        Mon, 25 Jan 2021 13:18:58 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:518:5e71:3200:18f])
        by smtp.gmail.com with ESMTPSA id p25sm3771107oip.14.2021.01.25.13.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 13:18:57 -0800 (PST)
Subject: Re: [PATCH 00/27] [RFC] Sparse Index
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <xmqqh7n4ydyw.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ef05a917-e3ec-7099-bc44-e53e31d63a8e@gmail.com>
Date:   Mon, 25 Jan 2021 16:18:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqh7n4ydyw.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/25/21 3:10 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This RFC proposes an update to the index formats to allow "sparse directory
>> entries". These entries correspond to directories that are completely
>> excluded from the sparse checkout definition. We can detect that a directory
>> is excluded when using "cone mode" patterns.
> 
> Yay.
> 
>> Since having directory entries is a radical departure from the existing
>> index format, a new extension "extensions.sparseIndex" is added. Using a
>> sparse index should cause incompatible tools to fail because they do not
>> understand this extension.
> 
> Safety is good, but because the index is purely a local matter, we
> do not have to be so careful as updating the network protocols or
> pack/object formats.
> 
> I think the use of "extensions.*" mechanism to render the repository
> that uses the new feature unusable by older Git is safe enough, but
> it may be too draconian.  For example, when things go wrong, don't
> you want to "fetch"/"clone" from it into another repository to first
> save the objects and refs?  You do not need a version of the index
> file you understand in order to do that.
> 
> The index format has a mechanism to make older versions of Git bail
> when it encounters a file that uses newer feature that they do not
> understand.  Perhaps using it is sufficient instead?

There are interesting subtleties with the differences between index
formats 2, 3, and 4 that are worth keeping around. Perhaps the
extension could be a mechanism for allowing sparse directories in
those versions, but then a future "index version 5" includes sparse
directories without the extension.

I could spend time working on such an index v5 in parallel with
the updates to Git commands to make them sparse aware. The logic
from patches 1-14 in this series will be required before that could
begin.

Thanks,
-Stolee

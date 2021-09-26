Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9767CC433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE7C610A2
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 15:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhIZPQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 11:16:18 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:14480 "EHLO
        ext-mx-out002.mykolab.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231927AbhIZPQS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Sep 2021 11:16:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id CC3C512BE;
        Sun, 26 Sep 2021 17:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1632669278; x=1634483679; bh=0UvWckk+5heD47iiIDh
        OXywiKsdWhEv5wsR+W4AE1Uk=; b=Lr6x3cjjgrldf4JOYw1wnM4DboTAfOl9IIa
        CtIa/hQYYyJfU3m4be5hWGJ1n9J9attyQdWs+R28gsY/wCuZTMdUFgq1muRaoRy0
        VzvOfnXNjOizbHS5/Dg67sC2vtH/ED4SxOq7hhQ9QpTKXcCjeQTQwHJPckCL1UwK
        rjr4BfvjweU4VSydXB1Fm4OLpU/Ljesd2v6P4my4uAk2QiGpQx6AhB7EC3rQHYVW
        J5A5H/c1ZcFEGB6WB0S2tHqHMbJeoTGqUuWp/9LY8qXht2u4wOhKlAnltVZD5d5M
        oHy52t8Ti+6MEjohpT5auu0aieLIQQbgBZWA8fu0fsjerDBZHrmV37/0ZWZWoDsB
        /7gCvjQcuGlNzVZW2re9C8K/A6lr/mw6+aUOjJ3HVtJw/JoD6ltRHK2e8vb+apz/
        WLSQyjazSHCPIlGOCrnvvWTzhOq8y55ivEn2sFoYdhr54acL/8y/14KuoTbmBTpL
        a1rzD2I93qUdI/xSw5fpTtQRRFqibyMwfuYjjcXsdJWiEyOfy5D0M1Vcin/YVBa+
        l5hIY15A81mvvkSfaRH7b/ajnk6Te6fxZgrq/kfRaRfLeQHcj0J9wbKnPY5AL5Fa
        0hkz63UDAcgCcxdJLxKD+e2JYLhJCiqEGU9x7OnEoONN0e4cyUkff7x3bTSOjxB9
        TNtCdHMo=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from ext-mx-out002.mykolab.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cbfY-_DBVC2W; Sun, 26 Sep 2021 17:14:38 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 771F012A5;
        Sun, 26 Sep 2021 17:14:38 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 6CB911B54;
        Sun, 26 Sep 2021 17:14:37 +0200 (CEST)
Subject: Re: [PATCH] connect: also update offset for features without values
To:     Taylor Blau <me@ttaylorr.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <YUYLXKN8U9AMa5ke@nand.local>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <14ff5661-e06a-8348-7088-387fa7e3e094@ahunt.org>
Date:   Sun, 26 Sep 2021 17:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <YUYLXKN8U9AMa5ke@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/09/2021 17:53, Taylor Blau wrote:
>> parse_feature_value() does not update offset if the feature being
>> searched for does not specify a value. A loop that uses
>> parse_feature_value() to find a feature which was specified without a
>> value therefore might never exit (such loops will typically use
>> next_server_feature_value() as opposed to parse_feature_value() itself).
>> This usually isn't an issue: there's no point in using
>> next_server_feature_value() to search for repeated instances of the same
>> capability unless that capability typically specifies a value - but a
>> broken server could send a response that omits the value for a feature
>> even when we are expecting a value.
> 
> It may be worth adding a little detail here. parse_feature_value takes
> an offset, and uses it to seek past the point in features_list that
> we've already seen. But if we get a value-less feature, then offset is
> never updated, and we'll keep parsing the same thing over and over in a
> loop.
> 
> (I know that you know all of that, but I think it is worth spelling out
> a little more clearly in the patch message).

Good point - I've tried to improve this for V2 (I've mostly just copied 
your description verbatim).

> 
>> Therefore we add an offset update calculation for the no-value case,
>> which helps ensure that loops using next_server_feature_value() will
>> always terminate.
> 
>> next_server_feature_value(), and the offset calculation, were first
>> added in 2.28 in:
>>    2c6a403d96 (connect: add function to parse multiple v1 capability values, 2020-05-25)
> 
> This line wrapping is a little odd, but not a big deal.

I'll fix this for V2 - I think I tried too hard to make this look nice, 
but putting the reference inline does look better (and I've now realised 
this seems to be the usual way of doing things here).

ATB,

Andrzej

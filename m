Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48797C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 21:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIGVYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGVYT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 17:24:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ED6696FB
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 14:24:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k9so22599826wri.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=Cz0lb+RDK292sHe4DeXIXSg/fZPPtnHP35twcUO6PX4=;
        b=ZMmTWTcT6kCKJ2GjZbNej2IOq0KsjnUOr0dbWVdUVTHTQZCEoaSk5g0ICl4C0TOghc
         w9npaqd9iwAHuM366sAh36bYp+3VjNEJVy9rzEMBWrCEgH0Fipy6UCQStfDQNVqqsl/3
         cMY7SgImLK6jT6hXQwI/mDTCF82FqxBO8rpQE4CfFgaJMvlpF5nXjEf2jbXG0m/3SWmD
         9e5NGE4MKTcwDuRV6x667chW0oKpCRN8WrOkAWktHrwu2IQCc4S6xy1qOB+wgUT23cwO
         p7+VBuSYJDQQ0hGRKlYpkhE2/yreisu/jUsyebGhdAKYfQRAKoJxDviCOgJ+aA2sOIND
         ANfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Cz0lb+RDK292sHe4DeXIXSg/fZPPtnHP35twcUO6PX4=;
        b=RVW5WLxQ49AUsu3JXGfOwbNNrk+INK4LYQyFih9W7KNMICQiGmTjvkEWlKF6HcX8yi
         N5/npSzTh4Kf9QB20cMa++0NX2DQR3a3+VxO8BRidLUjoPMKrdlwKYq5EALxxb4mkH7a
         Inut29Ex7pXft6NQbwCbmXg3VIndMjDT6QalHIy/sdLI/evFxhRgMxay8ZzwoyB/8q22
         8eE1g/wkru3RoB1T6YMkSHqGQwfOlnZnFpyn7RmDPMAJmtq9lnIOG2+2V9c1aokKFrlZ
         a4eqy5Q+NsT0x0a52FKl4ZbmiZ+AKpuJfb+xpME64b+dasSrhnz7nrA7XlKmlnGTf4QB
         wdew==
X-Gm-Message-State: ACgBeo1Ql8AHuZKUErbfF15s3+MbIG5uw9e8kbVWekxYCSp4/J+ZpgU8
        coKvP+K3mftRdFNwzemlLglbFd7HpTI=
X-Google-Smtp-Source: AA6agR7EJtswgsfQBJG2FmOOH8825e0E+lRgncndPT5nEarTA0IA+BUKJKcJid5DlWC4OhX7lbSZsA==
X-Received: by 2002:adf:f911:0:b0:21e:c0f6:fd26 with SMTP id b17-20020adff911000000b0021ec0f6fd26mr3236910wrr.361.1662585851664;
        Wed, 07 Sep 2022 14:24:11 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id d9-20020adffbc9000000b002205cbc1c74sm18218049wrs.101.2022.09.07.14.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 14:24:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] branch: refactor "edit_description" code path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <d2624238-048c-ac5b-1d45-e08051202c79@gmail.com> <xmqq7d2fszhk.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <a5e5f94d-965b-3766-60c2-27183148e052@gmail.com>
Date:   Wed, 7 Sep 2022 23:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq7d2fszhk.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/7/22 10:25 PM, Junio C Hamano wrote:

Maybe the return 1 when edit_branch_description(), was a typo I was maintaining?

>> -		}
>> -		strbuf_release(&branch_ref);
>> +		} else
>> +			ret = edit_branch_description(branch_name);
>>  
>> -		if (edit_branch_description(branch_name))
>> -			return 1;
>> +		strbuf_release(&branch_ref);
>> +		return ret;

Thanks for you review.

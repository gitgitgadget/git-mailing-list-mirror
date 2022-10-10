Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153ACC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 06:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiJJGFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 02:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiJJGFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 02:05:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39025BCA9
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 23:05:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e18so6192120wmq.3
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 23:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpn3eZ5Ax39jK6oOxn38CTx4b8d0qZxnHDqPzKzYVQc=;
        b=FhXuoWE9sevr94tlDVgh3y2lbTTe/8lcLRUc5VQoHuso9zEsWCPmquRj8aPdC2bAB6
         BldYEd2g+NMehVwuu2IRJReLXEeVcVpzb/u6ZN9+rBIW0SSc86KRw9bKFjqjwoV5j6PF
         L0OamGwylHD+vi8m72OC3iXYSGThfZmgRAK5817IP5WmegbxN2f6QLSCVaMb7K5CY5rV
         u6DGRXUL5CTbglgnU452uK1iHIPNcsFRlDcvAQzIFsHPX2zDSRNLqHq+3oYdxUXoRbHa
         vlDXUabQBJ+wVJCtFCJV34nyzwzDY4+O2IQmQFCDdHIvWCWuzsA/htpeCxCG8TN89B8A
         7riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpn3eZ5Ax39jK6oOxn38CTx4b8d0qZxnHDqPzKzYVQc=;
        b=5RysXx+j5h1Yn6zmVjJvnd24AsCZUtR4YEsu0MdJUHjI/idrThKfRb3b74TfshsqV8
         xY4bJX66K8zXs6clDN3ojtUZTG6SCxDeY7JpgqOE4iqNFTbEjTAZnGoU9gi0I0tpdPs/
         rNPNuKS56LUcuKPL/H84cv5gkc9io2kukVVqQCBigSOLdbCNfMEBfjvX6BW9weFRqNM5
         zNvyH0U+ClSu0OibhS/DDy40xzPwWt2H3ze1L77qmzWN99KItjaS5tFjhJGJ27T7mXm1
         FcQHQbD5xK/4b79y8Zms6ORjG9ZH/V4Gy/k3Iz3tE7wlHcSxG4JMNnHIfc5l4mmhB/ND
         Iomg==
X-Gm-Message-State: ACrzQf2OsMZullEqE4iqs70gDB2LE4FFMpAmHSJz9SzadPGylwzDVxC8
        /7Bu12OEddeQhzGtb8f2omyTfPK8RCU=
X-Google-Smtp-Source: AMsMyM4ylHbOrAhZdqSo1FsboTf2BMCc2p1P3ZdolgozkuqDEHwnFf71aN5RHT2ITm9AMhSL9dDEoA==
X-Received: by 2002:a05:600c:3d90:b0:3c3:724b:56ff with SMTP id bi16-20020a05600c3d9000b003c3724b56ffmr9967124wmb.114.1665381927707;
        Sun, 09 Oct 2022 23:05:27 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003b4fdbb6319sm16578054wmq.21.2022.10.09.23.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 23:05:27 -0700 (PDT)
Subject: Re: [PATCH v5] branch: support for shortcuts like @{-1}, completed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com> <xmqqa6647qx2.fsf@gitster.g>
 <dacb1f40-2765-5978-1131-f78ba919e6e6@gmail.com> <xmqq4jwc5x7y.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <bf4a45cb-2f44-88bd-e12e-98ca31d5bbd4@gmail.com>
Date:   Mon, 10 Oct 2022 08:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq4jwc5x7y.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/10/22 2:38, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>> Mmm, I don't feel the same here, we already discussed about this. Maybe?:
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 17853225fa..307073cc47 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -817,7 +817,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>                 strbuf_release(&branch_ref);
>>                 strbuf_release(&buf);
>>  
>> -               return ret;
>> +               if (ret)
>> +                       return ret; /* some failure happened */
>>         } else if (copy) {
>>                 if (!argc)
>>                         die(_("branch name required"));
> 
> Before the above change, the body of the "else if" clause for the
> option was self contained.  With the above change, the reader has to
> follow to the end of the long top-level cascade to see the rest of
> the function does not do anything funny.
> 
> If we have a big common clean-up after each operation, then, falling
> through in the success case might be good, but that is not what I am
> seeing here.  So...
> 

I would like to see some kind of free(head) in a clean-up to not get
distracted with that.  Not a proper leak though and the leak checkers
does not refer to that as leak.  So not important.  We can go with the
unconditional return and let the dust settle.

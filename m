Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23513C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 13:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiBYNxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 08:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiBYNxm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 08:53:42 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C621C198D0C
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 05:53:10 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l25so7427929oic.13
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 05:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5yw5q0Cb0L5hBfTbzH6DPSeiaZpu/D0utk7ddC/qXPY=;
        b=VkI/qGJudthr6yNd9HaX8jWR29YO3gdF30EI8WVllWTOLEc73Imu+UgtXC6g1g5f/W
         X5qVHBLNwj3XcacdUiSJ1NFXboDba4OeDaHiX2wh7iUNW4VSiiUvpNCZacVbApDM/WTj
         pkshPV3MI0vpkErLBkZZbu8i2xNQBudVJCfj6Cni4xeAcpevFyNwBxFtMWfdEgIN2KMJ
         o40QqVD8i0hfzSXErU2d3A/SBJb1tFEDoAaY9079l0Z9sEvtTVYsH2GnlZTXuFPhiz40
         w93OtmK5ThZSPboHOrArVQuwBVB6EEPhGZuTt+ffEnkIeXacvzhUi7a1vktDwHTlPVVF
         cJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5yw5q0Cb0L5hBfTbzH6DPSeiaZpu/D0utk7ddC/qXPY=;
        b=yZ0wjX5l1CMLGu+Uw88qGaT5FvcCDfcOF+5OigwmgAMxYQ1EZiddxUd4AXta6UkP2w
         gwjfQYbeuT32PW7iStsLtC1c2yYTfzQ1FXUcutg99QH0pQQcbj1VwcBbqVLnV3G5i2YV
         lg0nHzoV4ePKZAaRenhTpImdgs0lyiAR4kmZsQTum34TGBAYgXDygzK6n2tJIobrjxqi
         bfWk9uyaFUJw4blgz1ww0h0T365SeOS2oD7wZfYgjKLTnRdATf/RTunxido9oFPfL/Y2
         Ca00pOJUvUVB0FrekIIKEGukw2hqEgv2Sj3O3CU7/o7AsAj+cTAkF+PM5cRZf5jq3KX1
         vi/w==
X-Gm-Message-State: AOAM532e7HsQQYgjRRcZsrsD4y77VgcmSjB5ou1ksNawaNzUY4vM3lxh
        R7vZmGoFFv3PdnBM/lWWDF46
X-Google-Smtp-Source: ABdhPJzRVxP2IkGI64KTcP55sDIZGss0MbCY4Ayy/13GPENElba2MaeXsy2E5azAExrBw8MjY1oTug==
X-Received: by 2002:a05:6808:1286:b0:2ce:6a75:b870 with SMTP id a6-20020a056808128600b002ce6a75b870mr1463629oiw.311.1645797189667;
        Fri, 25 Feb 2022 05:53:09 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r41-20020a056870582900b000d6cbaf589esm1287155oap.40.2022.02.25.05.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:53:09 -0800 (PST)
Message-ID: <3d303ba3-36ed-4bda-e499-8b7da0dc1413@github.com>
Date:   Fri, 25 Feb 2022 08:53:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 4/7] commit-graph: fix generation number v2 overflow
 values
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <de7ab2f39d90c6b33b21a5adf126ec2ef5ce27e6.1645735117.git.gitgitgadget@gmail.com>
 <xmqqbkyvki54.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqbkyvki54.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2022 5:35 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> -			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
>> +			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
> 
> Wow, that's embarrassing.
> 
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index 1afee1c2705..5e4b0216fa6 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -815,6 +815,19 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
>>  	)
>>  '
>>  
>> +# The remaining tests check timestamps that flow over
>> +# 32-bits. The graph_git_behavior checks can't take a
>> +# prereq, so just stop here if we are on a 32-bit machine.
>> +
>> +if ! test_have_prereq TIME_IS_64BIT
>> +then
>> +	test_done
>> +fi
>> +if ! test_have_prereq TIME_T_IS_64BIT
>> +then
>> +	test_done
>> +fi
> 
> The above is OK but is there a reason why we cannot do
> 
> 	if A || B
> 	then
> 		test_done
> 	fi
> 
> here (I am assuming not, but in case I am missing the reason why it
> has to be separate)?

Does not need to be separate. I just discovered the two different
prereqs for similar, but not exact, checks. I can swap this to an
or statement.
 
>> @@ -832,10 +845,10 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
>>  # The largest offset observed is 2 ^ 31, just large enough to overflow.
>>  #
>>  
>> -test_expect_success 'set up and verify repo with generation data overflow chunk' '
>> +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'set up and verify repo with generation data overflow chunk' '
>>  	objdir=".git/objects" &&
>>  	UNIX_EPOCH_ZERO="@0 +0000" &&
>> -	FUTURE_DATE="@2147483646 +0000" &&
>> +	FUTURE_DATE="@4000000000 +0000" &&
> 
> OK. 16#EE6B2800 too large to fit and will cause wrapping around with
> signed 32-bit integer.

Right. I wanted it to be right on that boundary of needing the 32nd
bit but not being over that on its own. I did check that without
the prereqs this code fails on 32-bit systems due to parsing the
time.

Thanks,
-Stolee

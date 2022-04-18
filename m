Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FDEC4332F
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 12:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiDRMkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 08:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbiDRMjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 08:39:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE277E30
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:31:19 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id hf18so9421606qtb.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=K95bSHwmj9zl/u6dPExSf8RalkjnCoXTaYeSC1wZmBk=;
        b=CB+92a6eD8kaBy0rlMj53gYLPxzstKut9tSJs6FTTCWXcdtOF9ot/uIjyXXyp7yZMM
         hlkI1fxgRYgB6Gpzg2AZ82u17bpQkoQ+h5FD5valN5HbeEcNcBTYh1Wru3+G0BdKs/om
         Z4riX5LIF2SDu9QpfYmhnXUfc5w6oeCB82sbVcqJ8by/1BVjnmPw4TmPUuPeXet1UxRq
         lx4dFCZ+b3vitCvdO5Mr+/Cp4LcZ1r3/VZJ9abJipMGD+cE9xoAhmywg3/tmGIA50v/O
         I4fixmop2uc/6eAB6yhsXJaudlLkIWAJwhOFy039gIh4XUg8VSzNYHhfwG3ZFgBNLiTT
         ayOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K95bSHwmj9zl/u6dPExSf8RalkjnCoXTaYeSC1wZmBk=;
        b=Ecw7NHzdyjQcL6bzP6r6ky3J2P6aJtZ9odkCFndTQ421Y90jxRiEIBFrWXZyjwjVSZ
         GTY36EO1kidAaAQT86LHt24KzKDWwyTKXvKmS0j/yvFSIpCpklhix1Ma8iGgzJ+53CKq
         nXhRmso086WUVnNu3L0IXh/CWrDwcFSELJdqjHas8Vg4uW7d/Eu0nydeLyddh83BtoEe
         odSqlH1hjsMNT9JehqC/i01c6EYjZgONPZ/h1hToDg8SfNyJqcDM+8umEzRPdEXYwPWb
         WpSBUnPdN9HH0RgTjAOoGJMRnHWQ2vUDYjCQu5L9LLEyBku2njsIjU3cRXvBY0Gxi5NH
         o0QQ==
X-Gm-Message-State: AOAM530XPBRjXIkPpOlRaFNX3ykRmJhPdEn3dcvs4nl9PMasuN8IKvPf
        aV+YgCo5DH2f8Y42wEV2eRM+
X-Google-Smtp-Source: ABdhPJwSxitpUX0BjlhxQ6ve513ZPHfZscMMsZAIXGatJuZlQPDqbBqdn6yXygyR9RANIs60clt9dQ==
X-Received: by 2002:ac8:7f11:0:b0:2f1:ffa8:e6c2 with SMTP id f17-20020ac87f11000000b002f1ffa8e6c2mr2647780qtk.364.1650285078975;
        Mon, 18 Apr 2022 05:31:18 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i7-20020ac85e47000000b002e22bad4717sm7644113qtx.1.2022.04.18.05.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 05:31:18 -0700 (PDT)
Message-ID: <4344a533-8450-1e05-3d4e-642eda330af2@github.com>
Date:   Mon, 18 Apr 2022 08:31:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/4] object-name: reject trees found in the index
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <f5da532767367844af7ecc477e1c8434a5454fd1.1649349442.git.gitgitgadget@gmail.com>
 <Ylhui1cBGDca4m19@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Ylhui1cBGDca4m19@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2022 2:57 PM, Josh Steadmon wrote:
> On 2022.04.07 16:37, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> This changes the behavior of 'git show :<sparse-dir>', but does not
>> bring it entirely into alignment with a full index case. It specifically
>> hits the wrong error message within diagnose_invalid_index_path(). That
>> error message will be corrected in a future change.

...

>> +	test_must_fail git -C sparse-index show :folder1/ 2>err &&
>> +	grep "is in the index, but not at stage 0" err
>>  '
> 
> It might be worth a note that we're demonstrating the current behavior
> here, but this is not the desired end-state. In other words, explicitly
> note that this is the "wrong error message" referred to in the commit
> message.

This is mentioned in the commit message. Since the line will be changed
in the next patch, I didn't think a test comment was worth it.

Thanks,
-Stolee

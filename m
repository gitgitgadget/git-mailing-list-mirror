Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2269FC433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 21:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018C061074
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 21:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbhIBVOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhIBVOH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 17:14:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C755C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 14:13:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me10so7480356ejb.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B9MkfbjwhsMHs+lbRVtWIXyTj2HcXFJ9BUWMx+5FuFI=;
        b=jbguiZF0tDOvqcbsYaKyfC1avObfEMg5h/I8CaqAkLcuPk+GjtcfQ/rJZYzmVo/hG+
         UbTOPHrlkTBRZeHwT3XEhLAP36Sq1wZLQfiVV+q0ZOBNmbSrHM/7/J7QvK9RwFg1avS1
         VevjJgX9H9TKZ27Yb1CGXW1yg2QBrK1Cp+FJAnr4fPDQjhiRRRXtUVhXA5KyWDmY6o2N
         TAiw60cHQGF7qgfxNTrAgtX2GTxEnElvf35yQpF3oac8nYVwFg6w92T8S+6GPiZIPEgN
         y4L37ExY3hSZSfz/rcVuHjVQuK6VjykSXhxg4/nM3yvXFiCrq6VKV1gcZx3kOQabEK0x
         y4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B9MkfbjwhsMHs+lbRVtWIXyTj2HcXFJ9BUWMx+5FuFI=;
        b=BbdA3iOz+NFzC7aIwDKaA+K712HknVgYiNVINjDgAPLIlkHJ1uf5QSTrPItdwyUIbC
         T3KX5FBz/iDKZJ0m2+QWtqxZ7br6sphcsRdjVZnNsvnwkxl/0dGE4iXLB4gsRddqzeW/
         zFlUOKw7VmyOvp34NP5IjvCAP36MAMbtDNAk4+Iv1DzJU3jIrSFQylraPdY2DbN/7Wnf
         AAw9pIyZ4apN1ebNI7ky/cbviCGEwoWCiXyP3WZa8+D3fmm7BaC5DTgd2mfCFIuwCDAf
         hDG1VeHg7hwTEoRNBdjx+CoTaM/8cS3ELkhQC8XNafpbfgOkgjn3P1nCq0cuDTfJs/l0
         Uq5g==
X-Gm-Message-State: AOAM532mRzZ5e9WkDYPLW5qjCM6SbXg3Wu7u/crjUQZmTNEVObFmwsBT
        vr9nTFQ5LtZigqMhyeuN2tw=
X-Google-Smtp-Source: ABdhPJx6Tjm43zRLRZ9AFcqfndnr3tUVi/C8leStK5Yzhby1hn2ycNQKR+Xj/D+D861eSB//x5hjjw==
X-Received: by 2002:a17:906:74d:: with SMTP id z13mr181121ejb.127.1630617186808;
        Thu, 02 Sep 2021 14:13:06 -0700 (PDT)
Received: from [10.21.18.15] ([212.102.57.209])
        by smtp.gmail.com with ESMTPSA id j22sm1739866ejt.11.2021.09.02.14.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 14:13:06 -0700 (PDT)
Subject: Re: [PATCH 3/9] git-sh-setup: remove unused git_pager() function
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
 <patch-3.9-73e540896fc-20210902T155758Z-avarab@gmail.com>
 <503e0203-90ce-ff81-4d6d-46088d6ca850@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <b110b970-c5e6-a15b-f92c-574c0781b358@gmail.com>
Date:   Thu, 2 Sep 2021 23:13:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <503e0203-90ce-ff81-4d6d-46088d6ca850@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2021 18:34, Philippe Blain wrote:
> Hi Ævar,
> 
> Le 2021-09-02 à 12:01, Ævar Arnfjörð Bjarmason a écrit :
>> Remove the git_editor() function last referenced by non-test code code

Also s/git_editor/git_pager/

>> in 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).
>>
> 
> s/code code/code/
> 
> Thanks,
> 
> Philippe.


Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A41C433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 03:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E6D221E5
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 03:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUd87eJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHHDqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 23:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgHHDqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 23:46:18 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87E6C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 20:46:17 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id s189so3883555iod.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 20:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0YzjCWVl4E32S7Moazzk/LehTRZn69wSGW4wQ4KRDvc=;
        b=PUd87eJgcndnCPC4lKQB1b3xbESFo9SQxbtabo3vSxVGmZPTKv0V0pf8pudYlmaV7F
         e5famRfwZEnNaa0P7GlYAcK564JGUIZ7nd3xMi1KWxi/NL6/Rl8VcaBoMhgMjulJ8TDK
         QYuN8k40dVRO2Ld/UNdcz0/1LDMC5nh9AqDHyPpQgkV81SxV9/LxNAOGb6FS6ArkBBwi
         D90rn+67tNbB+0OCyzL84ayKNXXDesCIRnjHn7H27EWdLWFcbevACZcRj0upqFVQe/bH
         TM4MnrmnSDItWqwHWkjD3ANB0q/K3xhyY3R1wkfVRpSNO5H2AuLJrRgOBePiVwETGLxn
         ya5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0YzjCWVl4E32S7Moazzk/LehTRZn69wSGW4wQ4KRDvc=;
        b=bnxOcrnx5V8bJE022pERA9njgeVrvMNkSnHqfk5HwZotKcI260MgSre6xqjGi5ulsZ
         ZjOP40Es5ic9AavVKSzGLOIBsuG+lKZ5WqQzFo9y1FFhTjUPyGZYFPAlKycYrd46fuWM
         rLgwx76/+zP7IMHtfBmYDeu9zdTHHrK1IEjbvcsFWZh4yCC977cI+aU5SeS4yoDxi7L+
         pgBrrirrBrEr4vtPMfrjXKGiuyFGm5AALWj3FkwmA1w71258mocv5sctGHih5qcqcOf5
         tGUmmJ6IUWyr3zUY8Mn3uQxjEc+mmDlyhJohH4JSLNwSZbJMP869hVfx5WZvBqMJFJ+s
         MmRw==
X-Gm-Message-State: AOAM531Yh/g+8Uljnplbpx7eLiv/9MM6MfRgAkmhSVfe0xuG/QYyrrRk
        jc8j6loZh+oXW0vcjr9Cnnsu5XHa
X-Google-Smtp-Source: ABdhPJyK/Lewa/kuPatonYS4Wivo3xLvu3T5NHdw6pWX0HXElQ07zFoV4bxCVx3P3/ogPb1zLWHezg==
X-Received: by 2002:a5e:db0d:: with SMTP id q13mr7331401iop.87.1596858376725;
        Fri, 07 Aug 2020 20:46:16 -0700 (PDT)
Received: from [192.168.1.2] ([96.78.87.197])
        by smtp.gmail.com with ESMTPSA id h9sm5185148ils.53.2020.08.07.20.46.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 20:46:16 -0700 (PDT)
To:     git@vger.kernel.org
From:   Jefferson Carpenter <jeffersoncarpenter2@gmail.com>
Subject: Re: Rename offensive terminology (master)
Message-ID: <fdff3cd6-7998-354b-8343-3c79089f9dc1@gmail.com>
Date:   Sat, 8 Aug 2020 03:46:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changing the default name would have an impact on teachability.  If 
you're assisting someone on learning Git, and you have to ask them to 
find out if their main branch is called "master" or "main", that adds 
complication to the learning process.  They'll wonder if they have to do 
this every time, etc.  I think it would harm the Git ecosystem for the 
default to be changed anywhere - including hosting companies.

-Jefferson

P.S. Sorry if that was already mentioned, this is a long thread!

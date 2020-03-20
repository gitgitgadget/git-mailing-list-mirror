Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05547C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE7A2072C
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 12:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA/cwFeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCTM2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:28:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41239 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgCTM2C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 08:28:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id s15so5745767otq.8
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IgLyHszisVYZu845XBoutmoF0gyHXWyUSIcVcgeI4WA=;
        b=UA/cwFeBIxx7EbZ9C3I7Kx+m6pCGs9Km2m3VbiAqtmSqdWGhUKOJXtGfUud/yTGNoo
         VAMvM2CB0zNZHPMtw/JB8FkwW+gMMD77vm17rbhiHriBpEXQUAi4lD05pJ8nwhUn3t7t
         7M/sl8VRWAmY1qLHgwHYU7Wv0gB+NoH3LwjYcksolFgANzoprTVC/mbzgl5p2yRPLTh0
         /Jcv+aHDhUtpjO3qM+p26F8LRTRC/4UwaFqCrMcouse1mbntiabZHXHTfF8KDtC2FuXj
         30Ybdy/mB5+OLLGHXyjcfoyCPj+OUrDhqv+Rdw4RSpQU5VnxoAz6gyqrRjwdypDVHb1q
         yvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IgLyHszisVYZu845XBoutmoF0gyHXWyUSIcVcgeI4WA=;
        b=Qs0pM5BCRj5n8JOd7RmdV9ILZ/0X0KhduLtqF4NdPM3gLj8YW2C9BfoZ0sqj+3Rnn+
         1v7D1eo9fK2x0Zry+WbOIwqjMVf1h5QP6le6jGrSVYpuzJK8NRnchmcvir+y21d7TCPI
         83VASEFxGve10J0wWxhObI3B0k3yG9jgDkSGsxln1EjEKpOhN6osodWcrQuAg1Fk6XSl
         mNaWtwKAI3XOJtTNxoSb2SH3Y+v4dxpDMExnVUPHMhjGXYNwRTxPJh2guvX5EiHLq76W
         /NzEjNk1ZvGxhyf/nzynFLRebpwN3vUZbqRZTJsFawNwCDSbfez98SSH0yczWKTcGfmz
         Kipw==
X-Gm-Message-State: ANhLgQ2MG/p2S4SMDOnY1I8KIGPj2NC0u0J2VNfQV/fSNrS5jG92JXZS
        zQcITNGZfSglox5b9CC3dVF922T7Kzo=
X-Google-Smtp-Source: ADFU+vsIn9978GyDrwYw2l9BS+ESeuwWMkGNDRaZbEMFYaKW2+bTYX05AOMqtuwBIobyIgSRKSRoPg==
X-Received: by 2002:a9d:1427:: with SMTP id h36mr6127504oth.219.1584707281690;
        Fri, 20 Mar 2020 05:28:01 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p65sm1887138oif.47.2020.03.20.05.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 05:28:00 -0700 (PDT)
Subject: Re: [PATCH 0/2] Slightly simplify partial clone user experience
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0b84c2db-6639-6985-ae4e-6ba3b74006df@gmail.com>
Date:   Fri, 20 Mar 2020 08:27:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <pull.586.git.1584638887.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2020 1:28 PM, Derrick Stolee via GitGitGadget wrote:
> REQUEST FOR HELP: If anyone out there is looking for an opportunity to
> contribute documentation, I feel there is a need to include a section in the 
> git clone documentation devoted to partial clone. Hopefully such a section
> would include answers to these questions:
> 
>  1. What is a partial clone?
>  2. Why would I want a partial clone?
>  3. How do I need to be careful when using a partial clone?
> 
> I don't have time to write such a document right now, which is why I'm
> asking for help if anyone is looking for a non-code way to contribute to the
> project.

I reached out on Twitter to see if anyone was interested, and I got a
response. I'm working with them to get started on the mailing list. I'll
send a proper introduction when I know which email address they plan to
use on the list.

Thanks,
-Stolee

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2A4CD37BC
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 14:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjIPOtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjIPOtT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 10:49:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E85718E
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 07:49:14 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65649c60858so2587516d6.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694875753; x=1695480553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2wNhsfF1HMYe9YIBNdLLPmzSRnj4FJJWczLZ4vIuTg=;
        b=lEo0dmK2Hi96k+7urJ1uSywEiWRfZiBkpzkrlEDZHMX0C72x9GtGLcL2/EcQVbbcGx
         oPhtOsJNxRvP9yBPNN9J9r1dbKEN4x2D6Eno4g1ZAvzN3xvgdxWmXwUWKE18mXXQa+oO
         QkuvPCCgN9UoKDAmfT6LScNJNTxPdpG2Vf4EB/QsequYS3tiRKdxkGRFwS5RzsxkArU0
         Xe+tXCt5gBE9kO2pgvH1AVfmERBn0TzNL1P7ywqvb4QpPIr3L1Ky3FMUGbwRmrSsCABC
         c0nnZToDsd+Qv8aIAUnoTpSS/1ubHzsPb18YtEnmb9+hyNVRhdJfcK4B433ZenieJ76p
         qGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694875753; x=1695480553;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2wNhsfF1HMYe9YIBNdLLPmzSRnj4FJJWczLZ4vIuTg=;
        b=n/fzlF1dSNq6qNRsx0Ymm+SILUiuQKNmFsggaYnMRHKVUKOYx9xEQsaecrkcZpbVfR
         pTaenqmXNDZJ/+jnLvL018rZ3nVZRb8EFJRmsGNcAbHJPjevkjT4APM40cRQTFZ4ax8M
         PCuHvjvUET/gALW3hqWyxPoojEfej/wBe171KcknaeIKbrFIt+tv9LkJc/RtSA5Kcwgn
         zHiPXMgc2YgWsOSOMXvT0YCl9AP3uDdRN7DWHoQE5mwpo4VMjtFQ5ADGfTJq8cGO2yfC
         T6y1pvGib2s0RdpfgaC4qVtMKKMaOFXW4dCWRhrD22Q62R0hdydsWvCDpKs9eqIIAywB
         grsQ==
X-Gm-Message-State: AOJu0Ywh9uvu3/X9r2bOo/5SV/Qk2HeY0W5FjWtgrT9QchyrlxiZSvqT
        vnxQGPqIT+/2PTYszn9tRhY=
X-Google-Smtp-Source: AGHT+IHfnzjOPW6yIe8qfKO7q3t/dYzsJzg9QjFtz15d0hUPNNwUP2+aBjaaGIW32fw9l9EGm/GzbA==
X-Received: by 2002:a0c:e149:0:b0:61f:ace6:e94e with SMTP id c9-20020a0ce149000000b0061face6e94emr4684089qvl.0.1694875753288;
        Sat, 16 Sep 2023 07:49:13 -0700 (PDT)
Received: from ?IPV6:2600:4040:266f:b900::387? ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id f16-20020a0cf3d0000000b0063d0159e1f6sm2008611qvm.109.2023.09.16.07.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 07:49:12 -0700 (PDT)
Message-ID: <2ce41212-41e7-fe5f-cc9f-bcfaa2641e59@gmail.com>
Date:   Sat, 16 Sep 2023 10:49:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: BUG: git-gui no longer executes hook scripts
Content-Language: en-US
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        me@yadavpratyush.com
References: <bd510f6d-6613-413b-6d64-c3d2fd01d8a9@gmail.com>
 <xmqqa5tngynh.fsf@gitster.g> <xmqq5y4bgxy1.fsf@gitster.g>
 <454d8b7b-96df-ec8f-2285-e022de66c66c@gmail.com> <xmqqil8ad8un.fsf@gitster.g>
 <ffd5e1dc-bad7-2b1d-3344-76ffeb2858f5@gmail.com>
In-Reply-To: <ffd5e1dc-bad7-2b1d-3344-76ffeb2858f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/16/23 08:56, Mark Levedahl wrote:
>
>
>
> So, there is hope c:\foo will split into c: foo, or c:\ foo, but 
> testing on Windows is needed. Really need Dscho or someone else from 
> g4w to help out here.
>
>
I did install git for windows into a bare VM, running tclsh.exe on that


puts [file split {c:\foo}]
c:/ foo

puts [llength [file split {c:\foo}]]
2

puts [file split {hooks\foo}]
hooks foo

puts [llength [file split {hooks\foo}]]
2

puts [file split {foo}]
foo

puts [llength [file split {foo}]]
1

So, file split seems to work as needed on Windows.


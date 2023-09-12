Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E6FEE3F09
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjILSat (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 14:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjILSas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 14:30:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D6189
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 11:30:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-403012f27e1so40142705e9.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694543442; x=1695148242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4E5IH8S+x7gPfG1Ufe+82CGpjxKlB4Jmqf/kNkKe2g=;
        b=bOjT8wqw3yAO30kzHm4QOhtP/9qjmcmRXdv5tRNcVhJAhZEbm3G+/n4ZkdiWIQUO+R
         RhjHceBV/6/QSDdbci6q1n9Ay1kf3ffDN1y3PbNiK0NR0A4HAhtOJDFVP03X/BtVofAL
         1/MnB/P1z8WzRrUeSGNlADEI/6N/j7jnwovLfr90no/sP+m7fJzduJmcBK4mFUgX4oVW
         aM71FWaPjHMorS+KaGGRlmtpH5wJSjqZY70rB4QydNc2eE4TuU5uNXZ3Zhi7HozjRGDf
         Ue2/fJQ0Qzfk9+AK+/oQ83RcSlVu1cn+bnSe1YeyB4cZUCDlX00zdKdQRu4x3by0QnCw
         ouvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694543442; x=1695148242;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4E5IH8S+x7gPfG1Ufe+82CGpjxKlB4Jmqf/kNkKe2g=;
        b=WtaMFPgkROoEloeRjaN0Lxb+vzXaLH7vvltmSRf7EwwC11qrXmn/a1UdQwCqbsBaJ4
         Gp05MVhXQcYmHijDPvK/COHVVIZvX+nkj5MVXc8dWZysVfQva/xiYLdjRSBDLkpQNXfS
         wjPlb2KJGSY+EvuWB3vV3OhhFhg4xaIpXed8ssLsRWRFAMaHvggTEo4QGP4h3s3UdgUG
         Nj5/hHeWmc74MdQUGj84p3NjsIk9m5ij7Oas+jaaJy4nGVSEnjwwVAuG7H1qfDWGwA30
         tc5YMbhznOX65mxPttPqedYBliP9xN75b1XIKMZZL3AjRcOesz1nozhb0lIw2J43Ctgo
         dLbg==
X-Gm-Message-State: AOJu0Yxhas3jDTBKsag4jBwnI2IM2coou/OjfQ/CgUshktooiKNYi8oi
        qf+zadIO5ecb2HgjE8XiAtNwQkqzrCnSsw==
X-Google-Smtp-Source: AGHT+IH6rgMw0pOgjgEXCXelB/E5xK+4+Ow7nEe0YCh4HbrZfUpRv96q8F5vJDoUENeHo3bhMFg+xA==
X-Received: by 2002:adf:ed86:0:b0:31c:887f:82f3 with SMTP id c6-20020adfed86000000b0031c887f82f3mr290399wro.40.1694543442239;
        Tue, 12 Sep 2023 11:30:42 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id g9-20020adff409000000b0031c79de4d8bsm13411578wro.106.2023.09.12.11.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 11:30:41 -0700 (PDT)
Message-ID: <12c956ea-330d-4441-937f-7885ab519e26@gmail.com>
Date:   Tue, 12 Sep 2023 19:30:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Sep 2023, #04; Tue, 12)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqpm2npbwy.fsf@gitster.g>
Reply-To: phillip.wood@dunelm.org.uk
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpm2npbwy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/2023 17:57, Junio C Hamano wrote:
> * pw/rebase-sigint (2023-09-07) 1 commit
>   - rebase -i: ignore signals when forking subprocesses
> 
>   If the commit log editor or other external programs (spawned via
>   "exec" insn in the todo list) receive internactive signal during
>   "git rebase -i", it caused not just the spawned program but the
>   "Git" process that spawned them, which is often not what the end
>   user intended.  "git" learned to ignore SIGINT and SIGQUIT while
>   waiting for these subprocesses.
> 
>   Will merge to 'next'?
>   source: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>

This needs a re-roll to stop it ignoring signals in the child c.f. 
<376d3ea0-a3eb-4b25-8bf2-ca40c4699e26@gmail.com>

Thanks

Phillip

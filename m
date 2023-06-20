Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A098EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjFTTzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjFTTy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:54:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525701716
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:54:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9b4bf99c2so18637945e9.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290896; x=1689882896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azRct1UkNozwIkGXsG/asfNygT1BcEzLhc7jCJTHAkc=;
        b=PtFwianWuPZwRifZzf9sHpkfUbtRN/OUt/U6FYNFNS1EqWbWMYJTcd/VHbU67XcjBi
         283tsTUdPzyaW8eWx2E8QaWPmfhp878+f26MOeJwAuSx0hooSUc5/ugfz1UmQimMG7WG
         0nY1fkMHSqTU3xFs6F3UwRyZaJGkS1+fpzywc2VNF1W2IrDmFSMTzJHzaVsvi9ao5VKH
         PR4VfrQsiNYabDf+uYXXOep4cMLPnt+KQWhtqeTDDWtRVrCpT7i6nQsf52xi5fjn6kn3
         lwSENQaq2PCaDEomccMLvoVFxz50NU1fOhyFrJryFrXIEnUANN+KqJ8I2cwttZLlPn6g
         xwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290896; x=1689882896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azRct1UkNozwIkGXsG/asfNygT1BcEzLhc7jCJTHAkc=;
        b=eLSpvCJCr7WV4jdwWmqWFGqzcIRpEB3EN3Aq5qljzT9yPtZrVKOBhFhdhjqM4jGJR5
         m2ml8KuL6DQ6MFHUDvwGCAyf045LJ41H00yoZXRwpwmHuwEhkpR5sak0ws5ZWNnRcuWy
         lcURjv1agRGTCHCTauQe8TDL6S69Fjfo1EnPCR4zzNYMpb9veWkVgVjhncMLl746FZhb
         5SlaQdBCLWmFjoWm7zzJu6G9JsB293bOI0SOTkNOA9Y/us82wGnoSkZALWEIr1x2ijTi
         vVWdg3D1bCX7soz5q9pvjJ93AMTsnEbB/Cnf8GyuGpfwageWCI8O7X9we3fCxgLfdAKf
         wmfg==
X-Gm-Message-State: AC+VfDwW0SsxoyY3/rUkDMzVmR+tebwVJJvc1wQppinAZd7y9PrSGn5a
        VKtBu2gW8v833p8eIocCPus=
X-Google-Smtp-Source: ACHHUZ4tz0OudFqwluBeoE2qV+W7f6XUNHvxJvkTqV7VVMRnQ5W8TopzVV8Ng7cyaZIJhNRGKTNk/g==
X-Received: by 2002:a7b:cb95:0:b0:3f9:bd29:96e2 with SMTP id m21-20020a7bcb95000000b003f9bd2996e2mr117807wmi.41.1687290895393;
        Tue, 20 Jun 2023 12:54:55 -0700 (PDT)
Received: from ?IPV6:2a00:a041:189c:9700:159b:4c7a:469:54ec? ([2a00:a041:189c:9700:159b:4c7a:469:54ec])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c290300b003f8140763c7sm3072320wmd.30.2023.06.20.12.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 12:54:55 -0700 (PDT)
Message-ID: <1540e884-08c7-922e-1fd9-65616268c1c9@gmail.com>
Date:   Tue, 20 Jun 2023 22:54:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] Introduced force flag to the git stash clear
 subcommand.
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
References: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
 <pull.1232.v3.git.1687219414844.gitgitgadget@gmail.com>
 <xmqqy1keodjj.fsf@gitster.g>
From:   Nadav Goldstein <nadav.goldstein96@gmail.com>
In-Reply-To: <xmqqy1keodjj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I am not sure how much value users would get by requiring "--force",
> though.  I know this was (partly) modeled after "git clean", but
> over there, when the required "--force" is not given, the user would
> give "--dry-run" (or "-n"), and the user will see what would be
> removed if the user gave "--force".  If missing "--force" made "git
> stash clear" show the stash entries that would be lost, then after
> seeing an error message, it would be easier for the user to decide
> if their next move should be to re-run the command with "--force",
> or there are some precious entries and the user is not ready to do
> "stash clear".
>
> But just refusing to run without giving any other information will
> just train the user to give "git stash clear --force" without
> thinking, because getting "because you did not give the required
> --force option, I am not doing anything" is only annoying without
> giving any useful information.


I see, but isn't the same argument apply for git clean? if not adding 
the force flag, the same message as I wrote appear in git clean (I 
copied it from there), and it will exit without any other information, 
hence given your argument, running git clean is also not very useful.


One can argue that git clean --dry-run == git stash list


I suggested in the beginning of this thread to ask the user if he is 
sure he want to proceed (default to no), and only if he wrote y/yes 
proceed with the action (and force will just do it, or requireforce=false).


The reason I suggested it is because when running git stash clear, it 
will remain in the user recent commands, and when the user will navigate 
through the commands history in the terminal, he might accidentally fire 
git stash clear, and this confirmation will be another safeguard against 
this mistake.


Maybe it will be useful for git clean as well for the same reasons.
Also when the user types git clean, I argue he wanted to clean or he did 
it by mistake, and In both scenarios I don't see why making git clean 
just fail will be useful.


So what do you think? Maybe we should present in both clean and clear a 
confirmation message? (only if requireforce=true)


What do you think?


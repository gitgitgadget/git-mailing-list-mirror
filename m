Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A9CECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiIAQyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIAQyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:54:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C0498D0C
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:54:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q3so14479631pjg.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=AWSDFvfaWqnCNOtt1aX2642Gl4w4UnpuA9vTiQxzocw=;
        b=VSODqjkujTjZTy7b6k0gPGall6T8bnj9GKeXOlZW2/X0Kp3f/ee32JAHiJhpl9TxHS
         H38wCQCiKnIt7dJK5UdkeMsHqM03ctDwdSjLoYCngidECtT0sd3artNDlupuSktYP8d9
         TXrehLeajgm87ht9gZJhfIB80k3hMKXrIy74LGuXnzGHTgUkFCL3qiB2dEXMZ1nmQFCs
         NQ9hKLWGVcwL4oGF3AeFSakPxVC43W/CeHsasCX04vtRCwaumxCKvr1GzR1Ag5qtxty/
         tM9WAJv8uIEym+GyiScxxlMahAjVlP5BmDNXUnOK/jyd0eJYHJJdYMptncYQMcm942iY
         Fhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=AWSDFvfaWqnCNOtt1aX2642Gl4w4UnpuA9vTiQxzocw=;
        b=rKN65JB+i/k/rZga4v7JY/WEgPZjbzkvAmxYs4ML20QQMB9pXxchX00ph3ZQ3rmQYm
         q0Y9yXJRpCPHA4srDuPF09Hj0D92MAHTsWN6bPXyRty48qoZUXnKbTui6efec32kPsjH
         nf97swpBzd3eBz0czMj1/30cxl6LRXqcTTxJB2BxwuzzJDFSnFGD+IcqPE3c19mUK3yY
         W00ChKWXDA5NdLJ5S+10R4G2auLUlBZzzvWROPQ0/0yX0N31ASXTIdYYY35UVglun66t
         fcAE4Jfd7gJtwizFbLerXUUPjpr+1mIQlIsEhQu4GfD+HdwI6quwwiKYMEfCH0DXMq1z
         N/pQ==
X-Gm-Message-State: ACgBeo0RW6BBKqo2SrI4RXKUiupKdtsFvEKdbCBAtNhYYpd8mRO8M/dI
        gB2nqh6kXGAZBuRn31majaY=
X-Google-Smtp-Source: AA6agR7ldm6DGpq9X+GoR+bDRB09GaryCD7+gOG1Mhbg0bLkTAAw3dNsuiBfXHtZDkzZ+/IjAQ2jsA==
X-Received: by 2002:a17:90b:1d02:b0:1fe:36a:6e01 with SMTP id on2-20020a17090b1d0200b001fe036a6e01mr85370pjb.102.1662051272588;
        Thu, 01 Sep 2022 09:54:32 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b001755e4278a6sm1983455plx.261.2022.09.01.09.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:54:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 0/3] built-in add -p: support diff-so-fancy better
References: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
        <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
        <ced55750-21bb-c264-ef2d-666aca77fa2b@gmail.com>
Date:   Thu, 01 Sep 2022 09:54:31 -0700
In-Reply-To: <ced55750-21bb-c264-ef2d-666aca77fa2b@gmail.com> (Phillip Wood's
        message of "Thu, 1 Sep 2022 17:04:15 +0100")
Message-ID: <xmqq35dbavco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Dscho
>
> On 01/09/2022 16:42, Johannes Schindelin via GitGitGadget wrote:
>> Philippe Blain reported in
>> https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
>> that there is a problem when running the built-in version of git add -p with
>> diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
>> The symptom is this:
>>      error: could not parse colored hunk header
>> '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'
>> This patch series addresses that and should fix
>> https://github.com/so-fancy/diff-so-fancy/issues/437
>> Changes since v4:
>>   * The second patch was further simplified, avoiding to print extra
>> ANSI
>>     sequences if the hunk header is shown verbatim.
>
> That was a quick re-roll! I'm very happy with this version

Yeah, looking good.

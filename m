Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242C6C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 18:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjDXSVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 14:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDXSVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 14:21:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C679B40C3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:21:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2470271d9f9so3436227a91.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682360494; x=1684952494;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zqi4Sniw1DOB8bFfqQmhRNqINM0CHWBa5r3gJ6j7pOM=;
        b=R7ncwyLiN/PNtFyOsvY7+whJi8XVDDmRIKUE30Q1+8UI7wyHpoQ8OeiZJ9oSKzzl2Z
         3kmY3T5swTdnfcJ0AZJnHuDFGr9jYkCp9/Th0uXO6+IIYz11mZrQ6CpfbBA2zRwrQGkI
         UAHnfpkeG3C5ZyWWKdHkjIHU2QDf4Q6VRHdaEUFiIAWhu/FP07R40jFJJFY2JfnY4Y+x
         cu0fzBd5M+t7RM9HchopX0IwVKHlYkP00m8+jq9XxPRVSPYW/iwPibpWNyE0EUpYxec2
         dRHidohjRTZ6fmgOQIA7JimzYpGC9mfSro+306/Ojew3+2B1DR2YRV4kP6lENxdhVmFt
         JhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682360494; x=1684952494;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zqi4Sniw1DOB8bFfqQmhRNqINM0CHWBa5r3gJ6j7pOM=;
        b=fbaI9GBz5TrJhDyncJCymt0BM8Oq9lJ7WeJf34dtOMnhu5DFvmj1IHQP0Zqb3sbqSi
         qBMcwwzXK440ZSSyNiwfxV238ZtHIuD4vSI/ez/OYsgGo/sbeIaq3q8uCzMI+h1WM1xc
         vPzklWnzR/ixmrbWMbQ4MfKj3v41LOJ9Hb0Umdy6UQP+HS+NrAdjzcQS6T4T4UpRSqT7
         I4F77EHrilnuqlBAYuYhJ0AKZVhmldyNKGcivSvPZEO3zKJzPJuht8FH2PGT2zKnYcsV
         Ccg8R9n6JDapSWPMFXdSrCLPjVba+69fKm5ftbBuaAOeEd+1hSnMBxcojiY9M9HDHoAR
         Vz8Q==
X-Gm-Message-State: AAQBX9eEd1VgIMpDNmA7uDKiDfNgCTLKr1Q8oYRiyFoIpzKrKbgwTzMV
        w0V10wacDw6rGn4gKdK8z3g=
X-Google-Smtp-Source: AKy350YJfiM1H2B15W79fzDGgkrwbe9EVwlM8e3s1yJC1sD7RSElv/O3QcLi0a2Se3UXZMyVgPHZlw==
X-Received: by 2002:a17:90b:3b83:b0:23a:177b:5bfa with SMTP id pc3-20020a17090b3b8300b0023a177b5bfamr14570905pjb.22.1682360494212;
        Mon, 24 Apr 2023 11:21:34 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id fs21-20020a17090af29500b002470e095920sm6842773pjb.40.2023.04.24.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:21:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: pb/complete-and-document-auto-merge-and-friends
References: <xmqqwn26w5cd.fsf@gitster.g>
        <CABPp-BGPbo8B6JXBOHTQs0LegpwHccbnnGe__ea05fkO_34YKA@mail.gmail.com>
Date:   Mon, 24 Apr 2023 11:21:33 -0700
In-Reply-To: <CABPp-BGPbo8B6JXBOHTQs0LegpwHccbnnGe__ea05fkO_34YKA@mail.gmail.com>
        (Elijah Newren's message of "Sat, 22 Apr 2023 08:00:00 -0700")
Message-ID: <xmqqleihdtua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Apr 20, 2023 at 3:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * pb/complete-and-document-auto-merge-and-friends (2023-04-14) 5 commits
> ...
> Perhaps we can at least wait for a fixup patch?

OK.  Thanks for stopping me.


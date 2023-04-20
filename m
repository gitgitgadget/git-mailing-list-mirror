Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6FCC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 17:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjDTRKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDTRKX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 13:10:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC0D2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:10:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a6bc48aec8so11056185ad.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682010622; x=1684602622;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9HE5DtZAWYDS6HF/E6UoNLC9OfrZLTAewm1TL16AI0=;
        b=qvXmmPvhhEaR+3Dn/Xz+vvHIQhTG0nHek7cu/Arx6AQ7X2e9sMkvoi8c0I35RkClBQ
         713HCqldRoSRgrbggVmXtH8YV4i7VhbbKXlhnN7LrqOnrj2jQyNkDXhKCD9FORcvCJZ6
         Pm5/Y0LzLmGjAb3Gdd/b5vlR4LPB8/TKsKcT8RQvXAMVI/lCPV+c3ZHAnnIx9ERE+zZf
         Z3Jv1FNrXD6QFbLxbOg0P8PCtFSnRXzgUKxH7gKZapCH7/uaklw43x+pQYN+2LWfvY2R
         b0HOVT/b1dGf/9iV4f9FUOni3cYCclA/0Dr0auMWblXMoxnhQVN73Kt8zN/5w+vdSqSP
         J2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682010622; x=1684602622;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9HE5DtZAWYDS6HF/E6UoNLC9OfrZLTAewm1TL16AI0=;
        b=eAu6SOahdjMmPo5ayGJ0DckzKh5GlDljCL7LacJK06/yXXKpY0W26c2IJVIRO2d9kt
         rIMDi4j4XErKKsFfUzoKXvmqzSqvJcmtZjx3XJQjty2mf7ggRYk1CNc4wBxoXUMar65a
         dfW9K3QbwH56smR47jsyhQryypBTbuK/XIejkwM60C/bBmY41e2htTgr6rE0i2Zm3n6S
         1CdqDbc9X/RrPWwKRlToPhAHO0T/1UKKB/F1cqO6SN21CR28NPEqvMur8EfIzHXj35fh
         jR+SCH+EFPQcYng27oBEfAzK08W7lQW9ty4c0cdz+UjtEI/2G9VUMqbUzRK/NUnmySuF
         tFHA==
X-Gm-Message-State: AAQBX9e04AQCGov984h8nlT9lqoWure053iBREJ0cr1IG53tiI8aHUT4
        HVne5Id1MOH0kyUC7QirZ7c=
X-Google-Smtp-Source: AKy350baWM2b9+7domAtqEQ4lsyfteaeS3PE7wG9A2nT1jDV4RF9vCEY2Kv4F3W39Y9tzwxiPH2N1g==
X-Received: by 2002:a17:903:2348:b0:1a6:413c:4a3e with SMTP id c8-20020a170903234800b001a6413c4a3emr2986626plh.5.1682010621972;
        Thu, 20 Apr 2023 10:10:21 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709027c0c00b001a52e3e3745sm1366878pll.296.2023.04.20.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:10:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: fix calling merge_finalize() with no
 intermediate merge
References: <pull.1518.git.1681974847078.gitgitgadget@gmail.com>
        <d5c93b5b-32b9-ec50-1661-06f73fa37f5f@github.com>
Date:   Thu, 20 Apr 2023 10:10:21 -0700
In-Reply-To: <d5c93b5b-32b9-ec50-1661-06f73fa37f5f@github.com> (Derrick
        Stolee's message of "Thu, 20 Apr 2023 09:10:47 -0400")
Message-ID: <xmqqa5z21nuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 4/20/2023 3:14 AM, Elijah Newren via GitGitGadget wrote:
>> From: Elijah Newren <newren@gmail.com>
>
>> While at it, ensure the FREE_AND_NULL() in the function does something
>> useful with the nulling aspect, namely sets result->priv to NULL rather
>> than a mere temporary.
>
> Good call. It also makes the code look better.

And more correct, if the NULLness of result->priv matters.

> Perhaps this would be better as
>
> 	if (result->priv) {
> 		clear_or_reinit_internal_opts(result->priv, 0);
> 		FREE_AND_NULL(result->priv);
> 	}
>
> to avoid an accidental addition of code to the end of this
> method that doesn't depend on result->priv?

It does sound like a good idea.

Thanks.

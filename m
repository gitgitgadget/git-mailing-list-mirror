Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A963BC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 19:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjC0Tks (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 15:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjC0Tkr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 15:40:47 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36782D4D
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 12:40:29 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-5b2f3e78d71so4151946d6.0
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679946029;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMniEnIjMoTJfXzkbk2V5XpD++MdLbOhKw+BaopQPxA=;
        b=Ssw649iTLQzRDAwM6hiSFAWoeAb4TJKtdQVNZXkO65JkyWKGUTcra6db/znDxegPch
         XsqX7T+8ZN0ooQxaLA9U+oja+ww4XWcdwcn8hYNkUJPR9dCxycLvi/JZA3Xq5OeklWbJ
         8P/AJi5rIPg0TwfZvmap4l3FalOMjy/TrRtSiAzhPPZHT9oVMdq/eyRaMoZLHfaKk9Np
         zyveMgwz4rgKFTW8RbNHOgx4ZuWW8pBKLzxcX4WGSEftU1rBNvHTHrnNThAa76knLv3+
         TSpOPZYPGNyMp/2f4HRwT5ouXfV23f13umptreZEhILLhszSo9oL7a4Ty6CEfzhEVxpT
         GR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946029;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMniEnIjMoTJfXzkbk2V5XpD++MdLbOhKw+BaopQPxA=;
        b=GyvKFTh0v+to19J9/wXz5a7Xy3lmCpCUvSKwnP0AkxjDBMbWFcbbOD0AWI/Dx+Wv7i
         1qxNBa4eJUCWDgxTyjsf4KdTrRaTDLQLANC44FQumLw01aU1W8zfUatji2Mx6mz5HLtA
         e/GBXEfcdK4V0A/PK/2eltvwG7PcZLyH8uVgIlSJunwC4tu5OPFG1QL7yitRwNcVk97P
         v+0D6AvJPX3YvZ5c5vcmt2Tvm0Vx91g7KVf01Wfap9W3/lI6sWGJ84tfPcuQXZWHW3wX
         JeH9ddiwiSTg7hNQo4HyoWVTtd5VvXAs6IwDN1eXije9AAhGfYqkB7LpwxoKGir/a9m1
         IyVQ==
X-Gm-Message-State: AAQBX9eVyz1/cvhcPADvO7FR8UnOzNG2uUzoexv5I1cT1d+AlcaznyZy
        QLrAJrcgNG/yvtpik9/b2H7Q7cT3/1o=
X-Google-Smtp-Source: AKy350aNo1CC8c74Jy47a0X6GgkorXPDooOkluBRb2XHJoJyhFUau8OTAuDkusrSR05Nt/NBXDyiZQ==
X-Received: by 2002:a05:6214:5084:b0:57d:747b:1f7 with SMTP id kk4-20020a056214508400b0057d747b01f7mr19116655qvb.1.1679946028723;
        Mon, 27 Mar 2023 12:40:28 -0700 (PDT)
Received: from [192.168.1.211] ([2600:4041:454d:2100:bd54:ae38:73b5:2870])
        by smtp.gmail.com with ESMTPSA id t29-20020a37ea1d000000b007441b675e81sm1167934qkj.22.2023.03.27.12.40.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:40:28 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] attr: teach "--attr-source=<tree>" global option to "git"
Date:   Mon, 27 Mar 2023 15:40:27 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <050BD3EA-8A9E-4A33-AD18-B8A132F6EF2C@gmail.com>
In-Reply-To: <xmqqcz4u9hew.fsf@gitster.g>
References: <pull.1470.git.git.1679109928556.gitgitgadget@gmail.com>
 <pull.1470.v2.git.git.1679936543320.gitgitgadget@gmail.com>
 <xmqqcz4u9hew.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 27 Mar 2023, at 14:29, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>     This version is the same as v1. Just changed the author to Junio as he
>>     contributed most of the code.
>
> Heh, I do not need an extra credit.  The most important missing
> piece I punted (i.e. the environment passing and receiving) was done
> by you that is a larger contribution anyway ;-)

Given that the main idea was yours and most of the code minus the test was as well, I
thought it made the most sense.

>
> I am kind-a surprised that we haven't queued the earlier one.  Is
> this ready to ship?

I believe so, though a review wouldn't hurt--especially on the environment
variable passing and receiving piece.

>
> Thanks.

thanks!
John

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDE0C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 16:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjAaQlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjAaQlK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 11:41:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF7E18AAA
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:41:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h9so7054348plf.9
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KgPCcfnecmbuRjKktnl6lhLZdQTByYPm6rVI9LPI48=;
        b=P9f/I5HkLpON2ZiUIR7WnQOdiYVz+/OsBt+HZqIgifkSRVHn+9hZT8QJLt+da+0mYx
         IVi2rB9iV/H91mMvwr3ZUUJiY6f6X+L57cuFlN0uK2UYDH6bHTFTHdXdbHDz8WLOqIh2
         MhnpbOTt3PXnjbA/TH8ZPrhuUpFLF17u0QYRoehCQAiUvRJroVMuXpHJ+ahUJKnRO36j
         aXxBe+0imBxxRK/tm5nEo+gwkvOHDYSqHhDkyZRhWDxoh5GGTMmpzVTKK2Dd5W5GbNXo
         wcXTjWnnEjVTbYlLjKd2uMboM3NFLr2hx+XI9zgN/0sAJ5PMGZgGl662RNVQMilsE5ZO
         hAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7KgPCcfnecmbuRjKktnl6lhLZdQTByYPm6rVI9LPI48=;
        b=DJwZoJTSdmrYXUcuJG4cruD1ZkhyE/H8Vh4VqXLBhOQmsCxWhnS7dUzz8c1i2QUUv5
         XVvgNRGZ9fCkeXEoDeccyoyLTekqFEBHlfQZ1heSivFWDvTmWA6i6x0n+dR7yxC6ojHp
         +ID/I5wotaJCdAu6gAOKv6P9LWwFYpT1BJvvXw663tybva4qf7cWl2HT0ZE2tnpeXd/W
         L9XGK7JPqSTSRvpNPGooxn5MPsV7V9chk+0NjJwtDwWw67LxH1KqlXd41JrPGOOV/YrR
         ubOI+T8hkQZESz5WhBURkoyHRa81EEHBS8ygcOiuXTwdUEyCFvCQs0l40rDUZfrNaIEt
         6GrQ==
X-Gm-Message-State: AO0yUKVHLTAv1frXwRGaACvFrBJj2At8aj1EW6oOOReQv/EEJjKzDv/B
        NBWcDWIvqhDonEGCILZPqLc=
X-Google-Smtp-Source: AK7set8J7oSu2V8K3/PFJCpVFxXhBmVVDNZVOcqDjem01FujWbM86ObwZdWzYCi5HDs3Y3XcgvBYNA==
X-Received: by 2002:a17:90a:1a0b:b0:22c:816f:cec0 with SMTP id 11-20020a17090a1a0b00b0022c816fcec0mr11526851pjk.21.1675183262553;
        Tue, 31 Jan 2023 08:41:02 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id b24-20020a17090acc1800b0022c52a0c202sm7112508pju.18.2023.01.31.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 08:41:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
        <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
        <xmqqk0156z55.fsf@gitster.g>
        <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
        <xmqq357r4zvk.fsf@gitster.g> <xmqqlelj3hvk.fsf@gitster.g>
        <xmqqk0131zxi.fsf@gitster.g>
        <d1c4cbad-bbb8-d610-5e27-970d96dd7a74@grsecurity.net>
Date:   Tue, 31 Jan 2023 08:41:01 -0800
In-Reply-To: <d1c4cbad-bbb8-d610-5e27-970d96dd7a74@grsecurity.net> (Mathias
        Krause's message of "Tue, 31 Jan 2023 08:48:54 +0100")
Message-ID: <xmqqtu06zmg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> Looks sensible, but maybe something like below would be even better?

When I say "in the meantime", I expect it not to be the final one.
This time, it was meant as a mere reminder to me while I wait for
the (hopefully final) reroll.

Thanks.

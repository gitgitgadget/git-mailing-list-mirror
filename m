Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB83C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCIRQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCIRP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:15:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD33F0FFC
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:13:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a2so2720007plm.4
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678382029;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EE2Zr/Krh/bjiws+ih0/HI/JXohpZDQHjDEDkWdV6jw=;
        b=g8gsEJHfc3RtFhU7itRR2X/JnV1XqSIOZIfypQZyjjCVeQJjVz+Pw/1ZcgY88aPAqG
         Jvl/nmHMq1CosZFRMGcfHenyqS8ORaF65FoRpssITycsQtA09NfMgrmKtCOtfCtG9etX
         DOGm7blINbONJlPzA3yfusOv1Ceqt6fs9uuSo27TcagNBCLGZrXh/XdctYDraWquUtY6
         P43h5ia2q4H/yg+RRCsbBjwHYzWLaWoQ/AFFkuihl1h4wi1i4eRQBphJE0j+/xTmVK3l
         4YN+J/poMWwXLCPZf12wEWptQgCg74MVQFMieD2/A/FGCwGbAvjm4ScRAuKqjD1/5cos
         ihWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382029;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EE2Zr/Krh/bjiws+ih0/HI/JXohpZDQHjDEDkWdV6jw=;
        b=qQca2Vbl61E8gUB49+xfIJ0agsS1ghsiaopdamV/7SK7XQ0J5pR/zRN/WQmVD+GEn8
         Zh3CdIcEsgIsYUdiWUU6srilSCF/e9q7sTKKWzDXPwAFo73pEyRS4h04qLADkJj9MeZp
         yhMvnIF6P4Z6k6DhtJlWHtBf8o+wmxJnZbWcjujGygV9AZQ7u5wDussS5tvoc1jrwp8r
         FJx7aNX+nerNmWsPJEkOSfqjNjN8UDTdEKZjvGL8F+oC6oyQT6kOxppSrRXM0d3HaAgs
         qFzIchHOaWLe4E4rgG69GNjsXwpm1rP8vdsrJGpEwIOYelrhwbVA6CLfOB9PcI3voGRF
         ZFPQ==
X-Gm-Message-State: AO0yUKV7kbGRvVw5SJDsGelosdvVjhhrMglauRUhjTdHxdJ3PE2kq+rW
        zcsAr8Q0lpZgMAcY/gnJSLk=
X-Google-Smtp-Source: AK7set9MLeksg6cDYdddi+b/UD/dUZa4Rn3RzlVgZHKucfv9/+hbq8QfbZi39t1XWmtgN1NoM0yueQ==
X-Received: by 2002:a05:6a20:4289:b0:c2:fb92:3029 with SMTP id o9-20020a056a20428900b000c2fb923029mr27638921pzj.33.1678382029101;
        Thu, 09 Mar 2023 09:13:49 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78189000000b0061a942c8b62sm8274192pfi.43.2023.03.09.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:13:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sudheer D <Sudheer.D@ibm.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git diff without intermediate commits
References: <MN2PR15MB3454AE2CE41E79F2B260DDD3E1B59@MN2PR15MB3454.namprd15.prod.outlook.com>
        <ZAl7JI3FZdUgrvkq@coredump.intra.peff.net>
Date:   Thu, 09 Mar 2023 09:13:48 -0800
In-Reply-To: <ZAl7JI3FZdUgrvkq@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Mar 2023 01:22:28 -0500")
Message-ID: <xmqqwn3pc0fn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You can try something like:
> ...
> which will work sometimes,

Yup, that is how I would do the comparison, if I cannot undo these
"pointless merges from the upstream".

> but I don't think it would be a good idea to
> build a feature around it.

Probably.

Thanks.

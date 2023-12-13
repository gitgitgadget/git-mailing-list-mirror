Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apollographql.com header.i=@apollographql.com header.b="tFqO8dyv"
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB6AAF
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 07:20:49 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4258026a9fdso43192411cf.0
        for <git@vger.kernel.org>; Wed, 13 Dec 2023 07:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apollographql.com; s=google; t=1702480849; x=1703085649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oW4Hsk+TV2+Mha8mMatSWWxB/0+cZZXwNW8Cwwrs/hM=;
        b=tFqO8dyvvxVog2g/4knhQxYCWlubZg5jY2CVZ1noJ7LS8OEDGMxFoMWb1ZcqIPSjDY
         oXZyroA9D4R/ORBayZuLyP4KBTc8UnQDBgvK4BmVhSmqUxPWuvmwc79xROw1xKsyQ6qO
         RVGyp+UwWByno5hIhm9ppZ5XU/VerYT9viVpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480849; x=1703085649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW4Hsk+TV2+Mha8mMatSWWxB/0+cZZXwNW8Cwwrs/hM=;
        b=YPRjlyO8S7rM5FRM0pKtf3AaoAqJDh+51V7HOVgg882plv3qPcPH86cNSvIiyHon3I
         OhpsKDfApSBKY54dBST/XQNR93uULb3urqoGTtsRqEtBL0GnzYOI/+TL6YlFlFvbCPRg
         6Ie9df7C2co/G8YH2RsOCfqPuGLjwhVvKV9A4gNnbYkJe32PCxnwuqlgDHjMzTlIaPAU
         MXs6eb9wNe35iD0a0Mbgnvazw/InSn/XXw0ZE3W5uJqMek6mIrNV0F9aTRp84S/6ku1H
         j98DKItlB1n56Lqn76ZjBL82kGSQkgI5pQWPACh9xm0H7Rdj47hE2Q4SEvl9BluOuTtC
         /9sw==
X-Gm-Message-State: AOJu0YxbmsOo4OUOeYg/Roz4+X4Xu1nJtiUZo2M8mV2smdKADzMz48XE
	PPKySVJ9gU+MaujZotJWFHoMcos7VVMzJCA0dZbBX66jKEluB8SlLgw=
X-Google-Smtp-Source: AGHT+IF17VTXLtbqqB5na+mcELve2dp9zUhEcx672sQcnY1xU5ZZH5JgN0bQh2U/rrTESM6qaiOj1bmdyHuiQNcdZ1g=
X-Received: by 2002:a05:622a:58a:b0:425:e419:42fa with SMTP id
 c10-20020a05622a058a00b00425e41942famr3276444qtb.75.1702480848897; Wed, 13
 Dec 2023 07:20:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
 <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com> <CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
 <CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
 <CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com> <xmqqzfyfoy2w.fsf@gitster.g>
In-Reply-To: <xmqqzfyfoy2w.fsf@gitster.g>
From: Zach FettersMoore <zach.fetters@apollographql.com>
Date: Wed, 13 Dec 2023 10:20:38 -0500
Message-ID: <CAEWN6q2XeDDLvSM-ik_-HVqpeyYZLWpPwoj2SUyB9L9NyMJPLw@mail.gmail.com>
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees present
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, 
	Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

>>> > $ git subtree split --prefix=apollo-ios-codegen --squash --rejoin
>>> > Merge made by the 'ort' strategy.
>>> > e274aed3ba6d0659fb4cc014587cf31c1e8df7f4
>>>
>>> Looking into this some it looks like it could be a bash config
>>> difference? My machine always runs it all the way through vs
>>> failing for recursion depth. Although that would also be an issue
>>> which is solved by this fix.
>>
>> I use Ubuntu where /bin/sh is dash so my current guess is that dash
>> might have a smaller recursion limit than bash.
>
> That sounds quite bad. Does it have to be recursive (iow, if we can
> rewrite the logic to be iterative instead, that would be a much better
> way to fix the issue)?

I don't think an iterative vs recursive approach fixes this
particular issue, the root of the issue this patch is fixing
is that lots of commits from the history of subtrees not
being acted upon are being processed when they don't need to
be. So the iterative approach would likely resolve the
recursion limit issue for some shells, but in my instance
I don't see a recursion limit error, it just takes an
extraordinary amount of time to run the split command
because of all the unnecessary processing which needs to be
avoided which this patch fixes.

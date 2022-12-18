Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8FDC4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 04:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiLRD6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 22:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLRD6N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 22:58:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7185DF31
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 19:58:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 124so4228176pfy.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 19:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdtPo19j+v4uDvm8NnkKua4uxxo5Wd3duzdMo+y2qAM=;
        b=UUO+5kOGmcRPHqTyN09DhzU2sXHpmzBjryELGd0LzgdHDmls5fhM3dD3bG8SpUghC4
         wC1BsZ8l1POdeLSEdlW4JAZ9DBrDPYaLAmmQC2uiayW20lWgg/v0OIVnXRQr3YYDfZXl
         qStNIgnYGY+sQnNlQiGCvu9ttnfmUuFZxEEoKEipRVomQO15YnY20is5zCPchEXf3kmr
         MZCvtDbp96PuvSwSeBJaVPmtvpRnRfRzdyvHjOUW7RiXNUtmeeEr8CiqgTWp6L9sKJXv
         xCYe0NTfsH++zugYOAwaCzjBN2BnM3HbOts3yYYaWZjogwFHuEuBZP5pxZ/dV9DPtYLp
         9O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hdtPo19j+v4uDvm8NnkKua4uxxo5Wd3duzdMo+y2qAM=;
        b=e8DekTfhGbgW1R8vP0sNQ1BZQKmEYyhBndaysvcBhhOrv3lsEKJ3l4nrbLXAsNALJj
         SUb2Z4rOxcGlDU3aCnfl/uuFzYsW4qjFJ4D1By9RDZX7P3y/8D1nL+T3yhiZwNTr42ij
         a3EEFJcfCxv7nhUlxBlCwtF8s4s1+Ce/xmZW7hUT+OZq4Xsn8qteyioQw3ek7Lu0OX2C
         zzBmyriiKT7L7l9FYqvRNKkq6P6u6zgqs3wnSh99E2MHGhvVSYmGroOHfNEvZFGfU+UH
         8aLEpYElWyXSd0xMASoUs6sy7scvtX1RjxzpRphbwOK2DotDfpfXhUhCQ+d91rsDJai7
         n+Ow==
X-Gm-Message-State: AFqh2kpftQ7HF3PlrWMAukMkmUgqhYjdVVP6zI1YCSdeYXw4f/kZBghG
        t3UdPnNkFcDxSSCgdi+ygaVmvMmeH8J5RQ==
X-Google-Smtp-Source: AMrXdXv3WqlUOBoJ9CC2x/RQXG8VrqIIbBqaCEbp7iMta2iLzN9dT+bVNLPJStKsfQ8YKaPUE+tUCg==
X-Received: by 2002:aa7:978e:0:b0:576:c70c:59a3 with SMTP id o14-20020aa7978e000000b00576c70c59a3mr4201997pfp.20.1671335890672;
        Sat, 17 Dec 2022 19:58:10 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79985000000b005623f96c24bsm3842101pfh.89.2022.12.17.19.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 19:58:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/2] mingw: remove msysGit/MSYS1 support
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
        <e6d3d280a4f9216aa6e9c3c83a38b0fb8ba3a8a1.1670274213.git.gitgitgadget@gmail.com>
        <xmqqsfhdxxyj.fsf@gitster.g>
Date:   Sun, 18 Dec 2022 12:58:09 +0900
In-Reply-To: <xmqqsfhdxxyj.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        18 Dec 2022 11:11:32 +0900")
Message-ID: <xmqq4jttxt0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Harshil-Jani <harshiljani2002@gmail.com>
>>
>> The msysGit (i.e. Git for Windows 1.x' SDK) is no longer used and the
>> last known user for MSys1 + MinGW has switched to MSys2.
>
> It is curious that we can speak with such a certainty of the lack of
> users of such a popular project.  References?

I see J6t mentioning about such a switch,

  https://lore.kernel.org/git/c9aec5b6-0a78-a580-3658-5189bd2075a6@kdbg.org/

but I do not know if it is sensible to claim that this was the last
known user switching away.  Perhaps

    Last time the code around here was modified, which eventually
    led to 49d279f8 (windows: include the Python bits when building
    Git for Windows, 2022-07-29), the change was carefully written
    to keep things unchanged for Msys1, as at least one user
    (Johannes Sixt) who did crucial work to support Git on Windows
    and we did not want to break Msys1 (yet).  In the discussion J6t
    confirmed that he no longer is on Msys1 (cf. [*1*]).

to replace the paragraph, with this at the end

    [References]
    *1* https://lore.kernel.org/git/c9aec5b6-0a78-a580-3658-5189bd2075a6@kdbg.org/)

explain the change (be sure to explain ../THIS_IS_MSYSGIT bit, too,
not just the $(uname_R) bit), and then throw in something like

    There may be users other than J6t who needs a working Msys1, but
    we can revert this patch if it becomes necessary (i.e. when they
    complain).

somewhere?

Thanks.

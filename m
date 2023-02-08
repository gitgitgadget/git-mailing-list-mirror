Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AD4C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 16:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjBHQxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 11:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBHQxd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 11:53:33 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE3213503
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 08:53:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n3so7565120pgr.9
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 08:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nssgO0Xv+dIVjX2NCZ4EXFYgiRuLpyAvJvbE4XTM+Y=;
        b=JVU9lhGfNXX5ecdZt2u9o8z8YHs2yTJQacnafKW3jK7/LinbEc1aWcBZUnL/6OC9TO
         tgFlQs2pK+cS2vtMlEb8/WAotQtiNmYs+ZHpkc9dBCZ9G8Yy8r9Zd4YGluXERaDqaF5u
         ObA8P5ltxW/lYoy0/YbqkYgAGeocGJhoHr1bFqoTAgoRy8NgTa+JKm+Luz4HcrNDiHAa
         Xiq+JRnxN3rUC0PKcgwQLflm3zygn18Uax5yzyZpd1ZY98gCIK0NAkUZFNFxAYSPyFX3
         62S+qdqXDKsfB452IoQ4zSBsnnRLpzJvR4LWzq02JGV6xNs99Wb30XMllZLfIdqYuN2B
         7jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nssgO0Xv+dIVjX2NCZ4EXFYgiRuLpyAvJvbE4XTM+Y=;
        b=WK5AwnBtvhaQomwpNmpn56z5SDTvNxLB4XQ55XCxbXYGzC8eRzlCx/kl4VIryZ4mVq
         Y54RWOKf4dkzjbbKGeNZPnj1SePkb0fSlLTQbq5WNsNtU8t4kMSl2ObtH6YxFY/cMMsJ
         UawygqMDw/1B0SKEPPHoRnAF9gj3S2F0yTVb/yP2fPYbFWe0UjoNuh4i3PB4a1gV6B4R
         3cod9+e8IqtTD7gK57S1dT0gvYycbwNr9dmCEvv2PhD4zJsX+Sbap6tpT6oij8AaCSWz
         Z2bFf/haTXjHL6M3nkxsccuty9B3+3QCs0rCjZzV4bxgg3vRb3174kH73bUDGSDY1jvU
         4l1w==
X-Gm-Message-State: AO0yUKU2eQHUwGE5oPjQDgnc0pHsyhxiMZsYCqDTbwotodmRRI3fb94r
        lT96VxXH88pgnkZmRoDGKI8=
X-Google-Smtp-Source: AK7set+Fv3+BiufvzmwadK4yva9FwoYHd+ctRd147XmwEI1MbHBpUEjVrExT0WDDF1KTLkkkJg857A==
X-Received: by 2002:aa7:962b:0:b0:5a8:4c85:f077 with SMTP id r11-20020aa7962b000000b005a84c85f077mr976540pfg.32.1675875212054;
        Wed, 08 Feb 2023 08:53:32 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b0058d99337381sm11860815pfo.172.2023.02.08.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:53:31 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ilya Kantor <iliakan@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <junio@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CMakeLists.txt from contrib/buildsystems fails to build on Mac
References: <BFC8139A-0A9A-4E84-BC0B-D6EE5F469F82@gmail.com>
        <230208.86sffgz7i1.gmgdl@evledraar.gmail.com>
        <a120ea47-722d-2bb0-9c49-294a850af6af@dunelm.org.uk>
Date:   Wed, 08 Feb 2023 08:53:31 -0800
In-Reply-To: <a120ea47-722d-2bb0-9c49-294a850af6af@dunelm.org.uk> (Phillip
        Wood's message of "Wed, 8 Feb 2023 14:31:58 +0000")
Message-ID: <xmqqlel8t7xw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 08/02/2023 11:57, Ævar Arnfjörð Bjarmason wrote:
>> Or rather, that GFW would be fixing it up, but then I don't see why it
>> should be in git.git, which as your message shows just leads to
>> confusion about why this component is in git.git's tree.
>
> I think Ilya's message shows we need to update the instructions in
> CMakeLists.txt to make it clear it is Windows only.

That matches the conclusion in the thread

  https://lore.kernel.org/git/1e701a54-0356-9f55-ab53-9d8bfdd93e55@dunelm.org.uk/

which was a subthread of the primary discussion we had on this
topic, which starts here:

  https://lore.kernel.org/git/544fff8a-7d56-57a1-00a3-d1a9302e227c@dunelm.org.uk/

I am fine with either marking CMakeLists as windows-only, or
removing it from my tree and have GfW folks add it back to their
tree.

Or keep it in my tree, make CI failures around it "soft" failures,
and mark it prominently as "work in progress" on platforms other
than Windows.  But this choice is only valid if we as the project
want to expend more effort on enhancing and extending cmake support.
I personally do not believe in having to maintain two parallel build
systems for non Windows and keep them in sync.

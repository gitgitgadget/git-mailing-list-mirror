Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F209FC6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 20:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjAMUWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 15:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjAMUWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 15:22:04 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF3778A73
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:22:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x4so12858412pfj.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLvqaMjkFl1KRAYTr9d7I1RGJBVlA9yZGFjUooaHz7g=;
        b=aAEbs9rVfK0yd7yqlGRsJU1oIwo47Slx/B72ZQNhadc6adVlJDudyAV2gsNasmzYMH
         XrqQ7FJuAg4nlqVBUXlvCF3v5cVNpYp17JwmQWjmsH+GVVE7KVwTeXEU/6DFKkduEy63
         tZ69jlbcpOD/V7br+hquqeExeeREHkibCsSx94ul4wnBFzUHWHRMkd+sQNLKz+Lx4RQx
         Pg5j7hbMMLQ9WVv0QDq48a/qpII+KpNo10oUh2iw+gydsb2Du2W17udB0M9DaWjRO1kd
         nioORk7JaQzTYiqflGxq9o7QGlggu/dyfhci0IvTBZpTiZGs2C0F7rj7tGL0yo2C41Fy
         7DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLvqaMjkFl1KRAYTr9d7I1RGJBVlA9yZGFjUooaHz7g=;
        b=g6tdv1ApZDBRO0/LiKxAdcHv+/jhwOsPOEWHupSja8AxVac0b/7WrY/Nmwx4+hXhFS
         DLJU/2G/l9xPP/kF/FZDJf/Nolae5CU18wBs1986dwmvQie7/pqDSQrkepqhJZp49d8+
         X6qWzPHcTSzcTZNJDvn1GqF+v0S/3ojojXOJhtXkTKxLKU1wkx/SwrtiRDiee7gMuBKU
         oODk3Er8kBCsjtUbmsUFO7RPMOQsGExI+vZFbC0FFxeq1V5YtF6jGC7TV2NpqFfBIeAM
         Pe3a2pjM9xF1GZmI5tSPye+0SHC3N8loyXKV24qbClkxbtIEhaiKYu4Q8bVL42lUxDC9
         WwfA==
X-Gm-Message-State: AFqh2kq1pv14rRVLD14iyzc8IsmZQXSmnWHTfCPUlXWeTanNwo5ExX7n
        eN8kp/Ceu2DB44Lp2t2RRbE=
X-Google-Smtp-Source: AMrXdXsoKp9N+i72jy4lxgMsUXJd5maqk/GYxk13J7jpav2nvtSrLk/vmV22BrNQp/tohYZCWLN0ZA==
X-Received: by 2002:aa7:8d41:0:b0:582:b7a7:de13 with SMTP id s1-20020aa78d41000000b00582b7a7de13mr38565993pfe.10.1673641322768;
        Fri, 13 Jan 2023 12:22:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm13128346pfl.146.2023.01.13.12.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:22:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
        <xmqq358fu4vr.fsf@gitster.g>
        <Y8A5X0kHE31kSH3z@coredump.intra.peff.net>
Date:   Fri, 13 Jan 2023 12:22:02 -0800
In-Reply-To: <Y8A5X0kHE31kSH3z@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 12 Jan 2023 11:46:23 -0500")
Message-ID: <xmqqilha18yd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I had somewhat the opposite thought. The "break" command is special in
> that it is not doing anything useful except returning control to the
> user. And hence producing a message is a useful add-on. So I expected
> the patch to just allow:
>
>   break this is a message the user will see
>
> without any "#" at all.

Ah, I am OK with that, too.

> That does close the door for further arguments, but I have trouble
> imagining what they would be.

Making almost everything that the tool does not pay attention to
(like the patch title of "pick") into comments, floated by Elijah in
the thread, does sound another reasonable direction to go.  If we
are not doing "pick 0f2d4b69 # the title of the commit", adding the
message without "#" to "break" might be a better way to go for
consistency.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3DEC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAEA611C0
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhGLVJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhGLVJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 17:09:26 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249D6C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 14:06:38 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso20277462oty.12
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=va1/2jhVQbXmAOMbpskuECgs4ZZgwMzh6p3GHVtCalY=;
        b=KuAyC7o7/Rl8Do4iuVHoPRktu6+NNqxBKvA6yks4DVJ/ntFgLVHErrNqv4EJ3nyLX8
         XDKwaXMzzNl9qHSMIW9So137i+MKb6/ZK5npQ5c55qHNYfkdJZN/2qBWPxnVnfmGYT/o
         Zt2AmCA/eJpo38L5HTsjUV3tHrjOVq1OrcnOz0R+4KS+UxRsZNXmaXFi81MAS4F6UXeq
         NYvBCjVJWD2KZ6AoFshxbg8OmG/3jFsKc2Xce1emzXjgxjxmEfVz3FxZAbBUlC+4I/yY
         q7831WZ5C8GD8+QYCozTp6uvsMjL7mikp2EqNTnBt2/jdz8T7VPOw8t1YMWDT4Q2r5Dj
         p0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=va1/2jhVQbXmAOMbpskuECgs4ZZgwMzh6p3GHVtCalY=;
        b=fnGrOgkkf+zc50pHIkjdV5wAiJ59ejdQn8N8W7JqySKG7oNec8/MWRdJPNgnS1lgBK
         lzhzY6Jb8o3xtK0bXhR8A49tJ+G8y/lJFDE8cknFmodg9c8WPfnwtOzBtXp4OsAdLxyY
         YYM0S01uCrH8T4/uHTv0GvUsC0MKev1b2gSX2StTLTklqZqt1oz4My9HXq6JDSYvMflb
         GN4K6ZCdHWq3+MONPNh50uqGqt3/eeGdJBBliDQWtDcSgIc+ycgBFbYCj4D3cSUyM6gd
         iz8b1B7vr+XQ0HBw2KnpNUZn/YOCIcP/wWlWw5C/VZGOYlERwaWuuq0U4ffg9PygQ5Ho
         Unvg==
X-Gm-Message-State: AOAM532hlijCe7quG5+sVSxHMB3EoRa2AHiOOhQrNVLcFr102b/f6WSw
        ez4/RjFIMWs4hL8RaWcGx7Q=
X-Google-Smtp-Source: ABdhPJyKgYaRUOH8Zqk5e4zCEWBRDIR0hXWgl1NyHjKQbeCYP7wQzAYH2ugHkFjC5Jk1/VCKbFwdiQ==
X-Received: by 2002:a05:6830:1bed:: with SMTP id k13mr706539otb.271.1626123997447;
        Mon, 12 Jul 2021 14:06:37 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id k67sm3402818oia.8.2021.07.12.14.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 14:06:36 -0700 (PDT)
Date:   Mon, 12 Jul 2021 16:06:34 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60ecaedae42a8_a68ed20825@natae.notmuch>
In-Reply-To: <CABPp-BGGi_b3PeFZ4-uErLS2vad-mX5gcuO+=nfgQreRMSCYZw@mail.gmail.com>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
 <xmqqpmvn5ukj.fsf@gitster.g>
 <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
 <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
 <CABPp-BGGi_b3PeFZ4-uErLS2vad-mX5gcuO+=nfgQreRMSCYZw@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> I think we should concentrate on making sure that we provide
> reasonable behavior when conflicting options/command-lines from the
> already provided set are specified.

The only way to do that in a way that a) does not significantly alter
existing semantics, b) can be clearly documented, and c) can be
implemented without a plethora of exceptions, is to create a new
configuration orthogonal to all the existing ones:

  pull.mode=fast-forward

-- 
Felipe Contreras

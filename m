Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC2AC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAA0206CD
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="OsQkXX9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGGGey (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgGGGex (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:34:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4AC061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:34:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so16339327plq.6
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=GA+Jr+WhDcdrKPx+JfeGhRzLRJmAohwa2epYqg+kbqw=;
        b=OsQkXX9Eh3aufdDQZp1WtBPM+xoWjZiMgkVTCDoScP3pS/w3Sj1Q2aWNWV5qIrKNzB
         PrFhuefSTLMcFBZON2wlC1E7eEno7H68GzGCSL9GEYtWLlKMBmndVpl5mYXQ0j6VubwJ
         cE8otao6pQW3WCpSvDVToYZXChdIhT9PuYZyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=GA+Jr+WhDcdrKPx+JfeGhRzLRJmAohwa2epYqg+kbqw=;
        b=R8vq+Pd8vY/QPCoSoptEHrktUEfEcdBF/9jJF7hZwThetVwpj0X7S9iz8wXqK/wX0S
         AhWTIiUhbn7iraD1AXBuUJEXI9zDaec3Nyr0MZcMAMLy15LFl4Lw+kEEdUAE8idD7LWA
         Mdjp4VE+onfmTKb1YqBz/wLUa+kPdf7W/4W3y4Q4BLW+jI0y2vpZyRzDJ8B+Kx4JBZDS
         8IzLy0HndHFrfcX2DH2PzGRz5NdlSF2ESJFB2rl3qQFE7fogbdmlOjdxm9sh+gxUxGE1
         5VWeCqme2Wa0Y++wwypbJwspklICKVrljdKzRQFf5GkKjibnl8LC97V0adXLr325nAxD
         jZBA==
X-Gm-Message-State: AOAM530JGqmma3B82lZ2Mzu+qEsmxdnamroh2NC676UAlwGoZ1JVSK52
        LqIx7F83CaRbBKV65RVKW0p+OgHmtu5i2XzPIvsVUujug5JJztjEcAvXbOYyMJQ+elrTeKpVhfn
        lOS2FCxrWCw9tzIbHpj8W/C0bhD5WArVU+exH8zlD8t5DFvpR+pmBuEsTfA==
X-Google-Smtp-Source: ABdhPJyPmf7NUlzx6KluBw6TMWF+PnIjIFvQxu0l3UFNcBp+zDuN4LCc80lVajTzUZBwOjpYql5nTg==
X-Received: by 2002:a17:90a:26ac:: with SMTP id m41mr2680171pje.169.1594103692819;
        Mon, 06 Jul 2020 23:34:52 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id d7sm20989790pfh.78.2020.07.06.23.34.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 23:34:52 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v8.git.git.1593825400699.gitgitgadget@gmail.com>  <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com> <xmqqzh8c8eda.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh8c8eda.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v9] Support auto-merge for meld to follow the vim-diff behavior
Date:   Tue, 7 Jul 2020 14:34:47 +0800
Message-ID: <31ab701d65428$b7ca6cd0$275f4670$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL0yMj140bttmss0MgcyFqN96deswLuUIqGAi/Ktd+mlciLkA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thank you for your comments, and I made the changes in [PATH v10].
For `git config --bool ...`, with a `=3D` appending to the =
rerere.enabled will get reverse result, here are the commands.
$ echo [rerere] enabled >> .git/config
$ git config --bool rerere.enabled
true
$ echo [rerere] enabled =3D >> .git/config
$ git config --bool rerere.enabled
false

So in [PATH v10], it still try get the string value first, then =
detecting the ""(empty)/true/false/auto.=20
That will cover most cases with one `git config...` calling for =
useAutoMerge is not configured or is configured properly.
Otherwise, it will try call `git config --bool ...` for checking more =
boolean configuration values.

Please review the [PATH v10], thank you.
https://lore.kernel.org/git/pull.781.v10.git.git.1594102679750.gitgitgadg=
et@gmail.com/

Regards
Lin


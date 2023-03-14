Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F17C6FD1F
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 20:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCNUoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 16:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCNUoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 16:44:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC99758
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 13:44:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso1955097pjf.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678826653;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giwgLMZKm+53qPCPsWM26fKB4z8yQM9dvUx7HLeEKUM=;
        b=d2Bar+XVhp7r7rkScJxz89ulIODEB11jMBOPH9px5XaeW+tU3gB5yeFj9h/lZwUdxq
         y3tPFti3Zfbc3z0NhTBOK0xYPDBC4Hav01X2T+FsjkWRyPkeFBC2yiF2TJ3lDCYhMm+U
         SecUflaJ25p8js/MFaeL/J/UNP/2dAExe+NwmZ8Wl5Gz2rnNMIiT98CQnxOKZBmMiG3c
         cGr22RPq+OmWax2/J6jrhsdlXxJ9WPN2rw9lxIfXKElyBF5XShHebpycPb13xNhtDlzk
         +qyMBUIvRq5ZPzPIOwEgkSzDOhm3pyyns47M4g26vKvIGKQ3oMRR32swYkdUjg46SVNh
         0nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826653;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=giwgLMZKm+53qPCPsWM26fKB4z8yQM9dvUx7HLeEKUM=;
        b=XZhohvJ1L7/XfxVXJIXIVtmddhmSb+PRDkEThkJCjI3IPbvmVfz2CMf2sRmRx+YE7i
         ImZ4TbibH5KRucySrlhgYvmtiOAh1Lo/xVJ3qkqT8Sihc1907CKkg086y+0J7vIsySZY
         tyrSSiYrKLHSDX0MjjxPDW1d4A6+xAaGdkoA2yk5lji0aBqoo2Dlw7XU8F8PI/zl1nUM
         R92ZxYUhoT+mTW72s8H/GaAPDpKeogrcZmVxrrNa6dT51XZ4QVvF1krPGo6O9KzJxp7P
         M38TMvfqS2ZSvSnEh2IDa3w6+VYGFoiOCrJMwH3ZqcP8Ha/pknf9qCc5aGYA7Dtg3j9+
         pBlg==
X-Gm-Message-State: AO0yUKWt6z9gwxaQvQqEB4Z3TFCQ/rhn90ztsu9UKNyNPk2E3C2TyvPY
        0YdEajDeb/sCQhnwLPOI8Nc=
X-Google-Smtp-Source: AK7set8OLmw/PD16GqFp+pOTTQWt/QjCqEU7jMtpVZWUrWjnYqLRUZbMDerTQNMrHQ81z5z8qCbVwg==
X-Received: by 2002:a17:90b:3b90:b0:233:d12f:f43a with SMTP id pc16-20020a17090b3b9000b00233d12ff43amr41352688pjb.1.1678826652764;
        Tue, 14 Mar 2023 13:44:12 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id li3-20020a170903294300b0019e88d9bed3sm2168583plb.210.2023.03.14.13.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:44:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] diff: support bare repositories when reading
 gitattributes for diff algorithm
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
        <ddd7cbb6-4f4d-ba0e-857e-5981779326d0@gmail.com>
        <20230314191833.qmiisyvsu2ppu4sh@pop-os>
Date:   Tue, 14 Mar 2023 13:44:11 -0700
In-Reply-To: <20230314191833.qmiisyvsu2ppu4sh@pop-os> (John Cai's message of
        "Tue, 14 Mar 2023 15:18:33 -0400")
Message-ID: <xmqqttynoyg4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

> I wasn't aware of those config options. Indeed that's a good option! My only
> concern with that is that there is already some precedence for passing a
> <tree-ish> as a source for attributes in [1], so I thought adding a command line
> option would be somewhat consistent.
>
> But I can also see the benefit of using a config value since there is also
> precedence because of mailmap.file and mailmap.blob. Not sure what others think,
> but this may be the less invasive way to go.

I actually hate these one-off variables, and I wish we didn't do
mailmap.file or mailmap.blob at all.  Instead we could have taught
the machinery to read from $GIT_DIR/info/mailmap just like the
exclude and the attribute machinery already knows to read excludea
and attributes files in the directory.

As your "per filetype (determined by the attribute) diff algorithm
in a bare repository" feature already depends on being able to use
config (as the look-up is "attributes determines the diff filetype
name, and then diff.<filetype>.algo is looked up in the config") to
configure, it does not sound too bad to add the attribute info in
the $GIT_DIR/info/attributes file in your bare repository (and you'd
set the algorithm in $GIT_DIR/config file there), and it would just
work without any new "read from HEAD" feature, I would presume?

Thanks.

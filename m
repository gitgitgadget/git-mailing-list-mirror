Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654CDC05027
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 16:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCNQy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 12:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCNQy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 12:54:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C3A3A9A
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 09:54:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v21so7133093ple.9
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678812866;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soJzwyUco171uvcryW+4Q3VYRVMhi0NUdE0ZKNqgOz0=;
        b=nmactm+VWgSlY8SDSxNcIT/gvy7YICSt3iuHMTlrlonlOXerfb1awp5juYAZXJ1Sb6
         Z+eI8b87bsMHYzEhRxSWQZ8bwGgm3O8HmW72TDcHDWBzUkjvajGWzKJ3+ELnDjK3g85K
         UtMlxVDr51EbPpILZPmP+Yk6MenlhXrAMbzTA55bjSyzqcY5pAnDiJKrkR4FzD5Z3Yzj
         VabVII6EPOzb6uhlJxGS+fm/rGjSpfPPd0/Z9p3UdQD9ISCfdJsnI5wfIr88dM975UYN
         lKBeQJ7dog0YfSVZoxSEXISHq0IioEb/3+cumNw04o8NTxN7X+koBVjahfU9oXfy3Cwg
         803A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678812866;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=soJzwyUco171uvcryW+4Q3VYRVMhi0NUdE0ZKNqgOz0=;
        b=RqO5xzu/btdNTDq6sOORDLR3tlAL3tZS0D4vxVS4olYppudAP4KRzPouM7SbQc1PTV
         qeNpNmspidiN5lDd2laMlZDZYLfvcxJ+dk4kQxzG8CirxYcEy4Blw1nZhT8e0eH4wTlm
         ay0COKU9E3u4O3OMMsLLJFFTLL6uvbQ+E84F9uqRy+5rfGFBALd1l6mTv75xW2UtKeKc
         CJgTGheBLfDn9kfaZZs4GvbTuGJk03m3p+RMYlSAF2IDXRLvZi0J91/5UpbRffJdRubo
         Xxso3k5btMcVLZDtSRXfPwr5CUFRhvBoETVaGz2B3+ewnDmUXm4Q0iFlQ4pj623L2Ot7
         ynbg==
X-Gm-Message-State: AO0yUKVQpHmajgBmyTPGryVZJo98TDTGhiYM7c9PEM8j2U/vz21ROUdh
        WMaVT32PbMdYOXNvIDAz+0k=
X-Google-Smtp-Source: AK7set8q52mLoY+RcvVEsHBEutuQF2KyPnmga0Lk+GRog9BE5DShCx441VDxDirFvPJDEPsP2Fh7hw==
X-Received: by 2002:a17:90a:34c:b0:23a:baf:ffec with SMTP id 12-20020a17090a034c00b0023a0bafffecmr39609281pjf.22.1678812866010;
        Tue, 14 Mar 2023 09:54:26 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a490100b00233ccd04a15sm1942310pjh.24.2023.03.14.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:54:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] diff: use HEAD for attributes when using bare
 repository
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
        <0fc704cf1c0724473a61086098d44c3a82938b03.1678758818.git.gitgitgadget@gmail.com>
Date:   Tue, 14 Mar 2023 09:54:24 -0700
In-Reply-To: <0fc704cf1c0724473a61086098d44c3a82938b03.1678758818.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 14 Mar 2023 01:53:37
        +0000")
Message-ID: <xmqqttynqnnj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> (a4cf900e diff: teach diff to read algorithm from diff driver,
> 2022-02-20) does not support bare repositories.

Wrong placement of opening parenthesis, i.e. "a4cf900e (diff: teach
diff to read algorithm from diff driver, 2023-02-20)".  The date is
also wrong.  Use "git show -s --format=reference a4cf900e".  Insert
its output directly to your editor instead of transcribing manually.

I do not think the commit is to blame in the first place for two
reasons.

 * Even in a bare repository, the attributes defined in the
   $GIT_DIR/info/attributes file are in effect, and the new feature
   added by a4cf900e should work just fine with it.

 * By definition, there is no working tree in a bare repository, and
   it always has been naturally expected we won't read attributes
   from working tree files.  This is in no way limited to the diff
   driver feature recently added.

So the above does not look like a good first sentence to explain
this change.

> Since running diff
> on bare repositories is often done on Git servers, it would be useful to
> allow bare repositories to also take advantage of setting the algorithm
> via the diff driver.

Since referring to in-tree attributes is often useful with any
command, not limited to "diff", I wonder if it is feasible to add
support for the --attr-source=<tree> option globally, instead of
implementing such an option piecemeal.  If your "git diff" in a bare
repository starts honoring attributes recorded in HEAD, don't your
users expect your "git log" and "git show" to also honor them?

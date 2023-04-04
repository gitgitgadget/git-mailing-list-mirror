Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74252C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 15:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjDDPm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjDDPm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 11:42:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA504EE2
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 08:42:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o2so31687615plg.4
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680622946;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCdir0R2N7Mw8K4VEuWgtYhhBjtjAO74SJRu9tyoq5c=;
        b=BSHf82HW/21KQ4YSH2aHtUc2rf5OdcSEBJeAoWSOxuvcWnn35yIVlQDY9vP3bywZE6
         hI4B4hok3SR5K7nmre8GdF+ibr0hcIvdcPCb6aUvd6+PFtcNCbe98aROFrfev4zxdJcJ
         lStxXnSK8g/BTPVittjEKGouX9EKMxdREW6rDTnAGXbooY6TNqeLQCzfPu9ev7vMkPDm
         TPp6mvLIAnz/6x/JvcLMm1xA3r8oryxjusa7ZRx2M1I1SkuXzQFZDWxwdU6uiCi4ZtDy
         kgpjInz/V1VakPo76TpsYju5XUz2r+m2K16BK+qGeJ6BfVqQguj7BeyxTQrfB/LtaJAZ
         Ghbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622946;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCdir0R2N7Mw8K4VEuWgtYhhBjtjAO74SJRu9tyoq5c=;
        b=gyiwVRcnwBre5p6Xif1IryhQm9HdWY7WmtWDPA3LcbKoHuGSQWvTU8ncmD6oseA8UO
         AejvycRTcaZiO8mdVxFPmqIQgTTUvI7ig8316xFKlAPpvkPFSJ35NjR7wbeq2HPiLHJw
         9M7/S1u8EJrvdfVtE2pezNKBrKN//V454gSpwnaoVQw6FNoMm3KKsweMlPzonsYixS0E
         gqBRUdFfWOXK5961van+6JcXHqiTA9Y+XO+s4YScTkFYseFcQKsbLTgsE9PAx1RF5qHj
         w5p6dfSs6Qm6LQ687tRH8gAfJcWzFzQYd3l2FsrJcEfOZBDIOzlpoX/7CdE87gT42Z4J
         TOBA==
X-Gm-Message-State: AAQBX9cHJX/O0j2CJC144dwH3NFCrXVWWmvo3EeC2b8Qw9mtkcQoYTeV
        0LX5eTGAi5dhVDfIj2xN69jGijVati8=
X-Google-Smtp-Source: AKy350ZvbASb0qBE+0Atzlp7HJClHEvzJWlyi+nlY+wStkc+BBeI04b20GQPqncyayObXB90CYwFNQ==
X-Received: by 2002:a17:902:f1c2:b0:1a1:b748:f33f with SMTP id e2-20020a170902f1c200b001a1b748f33fmr2544051plc.69.1680622946374;
        Tue, 04 Apr 2023 08:42:26 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902bb8100b0019a7c890c5asm8501192pls.263.2023.04.04.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:42:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     "Thorsten Otto" <admin@tho-otto.de>, git@vger.kernel.org
Subject: Re: "git diff" does not show a diff for newly added, binary files
References: <3473764.PTxrJRyG3s@earendil>
        <8135fc7b-1953-4702-a9c4-b0f847e69887@app.fastmail.com>
Date:   Tue, 04 Apr 2023 08:42:25 -0700
In-Reply-To: <8135fc7b-1953-4702-a9c4-b0f847e69887@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Tue, 04 Apr 2023 12:17:43 +0200")
Message-ID: <xmqqjzyr3b8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Tue, Apr 4, 2023, at 11:58, Thorsten Otto wrote:
>> "git diff" does not show a diff for newly added, binary files
>> […]
>> I expected a binary diff for the new file, just like it is done
>> when comparing two different, already committed revisions.
>
> Do you use `.gitattributes` to get these binary diffs? What does it look like?

The attribute "binary" can be used like this

    *.mybin	binary

to declare that all files with .mybin suffix are to be treated
binary files.  "git diff", "git format-patch", etc. will treat
such a file as "binary".

What they actually do to "binary files" is a different story.  The
internal diff machinery by default shows "Binary files A and B differ"
just like everybody else's "diff" program does, but has an option to
show "binary patch" we invented.  "git diff --binary" enables the option,
and for some commands, the option is enabled by default.

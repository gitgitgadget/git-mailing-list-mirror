Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3762AC4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 01:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiLFBmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiLFBmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 20:42:49 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D871BC00
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 17:42:48 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id h33so12050836pgm.9
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 17:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yut8f8PEYtPXF9CeQEQkUuz9Tv9IjTpwMNUl4pnmTuU=;
        b=QYrLhHpeJeEqkTbi4o17WlJE2v3Hp47OWsRMV2HwQ0FX1ElO56V8cZttBeGIlXlkgf
         Pl+f1r6XtmC429AKa451FdIvJsuhNkFTyKsw7NZhICHbj+8Ry+cxGb4cdBfQbDNeOYSy
         aluCdyybP93rtH1cZVJC2uQnQOHXlYJHJKnLU731WeVU7H73+2Egu2lzpKrixVH5YYti
         HBS43ovCzRv8PMHW3+tsNtsqpapW/cYywpLTxDsdYqdy8GiF0KWl7cZZLoswBupdoJae
         QP6DR7KmiFYQU2bMDap+DXCtyWJAVqx32EUKo22UoWw8h8M2j9mw1i5sqDWR2KKgdQU7
         0ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yut8f8PEYtPXF9CeQEQkUuz9Tv9IjTpwMNUl4pnmTuU=;
        b=4Z0SLzWDr9S5RcK+GU0/5DHY8qtBJtGZRpT2RzVcQAlevo5obVnAzcr4xKxSchJOaY
         xLepaGPmajth8KWsUPcvG6aLW5h215JD+MJLVSHfft/dyM71M97DwyvAeoWzlI8W/Hoa
         B0Eqny8he6RNvB+mT64SO9waIh/s2D9U7QlOrbVzeSuxeTIfVjeA9l3xIqv5yWfO8cME
         EfomgGa/PGqxQkRlAy3e2I9lCff/o9F0+rxD8f3rBoyuuzzy3gfM4Kso0iG8oB/0vDS8
         Ek7Iymcaks6MBZajmEx4o6/R1Gis/kTGXiLJ/k7KkLrNvHbOQ3gRJNg/cCnTnOJqPh5d
         ejzw==
X-Gm-Message-State: ANoB5pkXEJyLau64dhDKZ+pAySl4o3UVvM7fKoVK+E8zMGF8pDm/kk91
        Bvy3AYn2rPOf6nzTgSFPm1kIxt9PEXuLDQ==
X-Google-Smtp-Source: AA0mqf47d5aA9/MgUWuVrvUv6qYXTNgvs5oeGqbJtNJkodKXYgkQhcdghCe3x945c3zpqpaPHCHCjw==
X-Received: by 2002:a62:198d:0:b0:572:5a7f:9f4a with SMTP id 135-20020a62198d000000b005725a7f9f4amr66832013pfz.33.1670290967755;
        Mon, 05 Dec 2022 17:42:47 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b00189348ab156sm4206128pli.283.2022.12.05.17.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 17:42:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "tionis" <out@tionis.dev>
Cc:     <git@vger.kernel.org>
Subject: Re: bug report: git push fails in worktree
References: <COUBW3AG192J.1UCDLVUZ38VJA@tempest>
Date:   Tue, 06 Dec 2022 10:42:47 +0900
In-Reply-To: <COUBW3AG192J.1UCDLVUZ38VJA@tempest> (tionis's message of "Tue,
        06 Dec 2022 02:03:14 +0100")
Message-ID: <xmqqr0xdnw88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"tionis" <out@tionis.dev> writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Setup two branches.  
> Check the main one out in a repo.  
> Checkout the second one using a worktree with
> ...
> Execute git push

There must be some steps missing still in the above description.
You seem to be expecting "git push" to push things out to
somewhere, but in the above sequence (I am assuming that you started
with "git init" to create a local repository), there is nothing I
see that tells "git push" where to push to.  There must have been
some step not described above that sets configuration to tell where
to push what when "git push" is run without "where to" and "what"
on the command line.

Well, I am assuming too much.  Your "Execute git push" may not mean
"type g i t SPACE p u s h RETURN and do nothing else" (it may mean
"run 'git push https://github.com/tionis/sample <RETURN>'", for
example, and readers cannot tell).

If you didn't use an extra worktree, but otherwise do the same
thing, does "git" push out what you expect it to?


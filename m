Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BE2C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 15:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjEHP3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHP3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 11:29:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEC297
        for <git@vger.kernel.org>; Mon,  8 May 2023 08:29:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf21bb42bso32333505ad.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683559763; x=1686151763;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEAy9jQpSjMUe5od8TyAv94NrVTZgIh0jzQ8DjCnNOU=;
        b=iCW2VdDk8xls/nI1dZl1Qh7drxSJRshE4eSsWBBXYeM1uWA40h+zFVJKeSn3u+eYcV
         C6ffz0GZ5yBHdPqHSfLJ6WwsHU2DpjYNveBIQlYANW5gXdt6QR4tK0eJKdVdMwB0fOXl
         P7/lWqAj7ebBDPZKxCwulAKcSVSrO8vjatqShLOLKQbsFwGv0HGSAHdVMzxUgMQEUFNV
         +ZBISm7KBryf2Y0qApNVuixmwsJe29aI6CW75y4YcZo/IJJZtePRVqTW9kpuF7d3FkKN
         djU+wsOTjYhCTkzBhXvUstL+hgjokSbTLsUbSoBZ0keBB3VHa55qkXcVxrfA8YbbuZJZ
         qJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683559763; x=1686151763;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dEAy9jQpSjMUe5od8TyAv94NrVTZgIh0jzQ8DjCnNOU=;
        b=Fo/2NUNrADhBzUbp09Db1I8PrYAmFN1jgIV2xFGX0SU9vTgsy7G4d0tjnU4TkkZh3J
         9pU7z5KDG1E8mRFTzt4Q6yIBa9klNEH+0U8jTLeitfFQZp1PMJdgha7hydmUxjjEWNRt
         NDyluNGLP6uurru/ng/tTlxr003tRkCeQvLy1ySLdAo73mxCHmZKJj7JqOIgvydGpY//
         kjFUSKm024P+VnpThO4VtMkwqlBNpgSBu/ebe/J30X2boOMMptzFqYWq5gCfw/XClmeg
         xdYDGmVGs8sLm0EdPWv0LQqCVtPHifr5M15lZAB4CrAW8n0l44XOv1D6Og9tyygyiwBW
         Nzyw==
X-Gm-Message-State: AC+VfDwOQtKstc+Kqhoi7wMWavpsXoUvITF72CB5TDOslrRQIOUAJZOq
        BHI8ga5zjRAtCSamGOqOltw=
X-Google-Smtp-Source: ACHHUZ4ioF6AfGbBW/m8own8QTEXrwij6Mlf+AaL0OWi10DcsQ1gLgnqw9ulPk8SXrsc46OR5cyCRQ==
X-Received: by 2002:a17:903:22cd:b0:1aa:ebcc:dd5e with SMTP id y13-20020a17090322cd00b001aaebccdd5emr12843332plg.65.1683559763213;
        Mon, 08 May 2023 08:29:23 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b001ab06958770sm3447599plt.161.2023.05.08.08.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:29:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/24] Header cleanups (final splitting of cache.h, and
 some splitting of other headers)
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 08:29:22 -0700
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com> (Elijah Newren
        via GitGitGadget's message of "Sun, 07 May 2023 03:45:25 +0000")
Message-ID: <xmqqzg6ergdp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:


>   hash-ll, hashmap: move oidhash() to hash-ll
>   fsmonitor-ll.h: split this header out of fsmonitor.h

If you are introducing a bunch of -ll suffixed files, wouldn't you
want to either rename them to ll- prefixed, or rename ll-merge to
match them to make things consistent?

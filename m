Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC0C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 23:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLPXp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 18:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLPXpY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 18:45:24 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE194D5C9
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:45:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 124so2834841pfy.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 15:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=le37+Ro7p3yFn2nZBWx8kQr+AtC+iwoycEgHjlyiUfg=;
        b=SqlWTaSTWrnub1/H5FBds6r1u+Gwb1IUjd5Se1UYDPIAB8VRF7gVOhT7FkZQzij7FN
         iLM3eD1J1LCI0Ifz8i2LZEthgVmZhelVZslHsmvqSZTZG1fgifdT+Q4AaeRQIrw8sxLf
         c5yB3ienGoOf4U1X2jq6LpYcvMSuFwOxHyxq+YpNOAdCtvDwdVK/1pmw0qr0CqZtJbnJ
         WSMK0FNE2QNT2u+z2wvaOnYlt1CylPJQYQH7/WMgA08cDUC41crtSQSiekcnyLLdFdlW
         BzUqLyOYBLy+A7ZCknDxzMxhyAW3JrYQq1XXpXkROn7kcghGLkZCE3lj/KU2hrwyxH90
         wdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=le37+Ro7p3yFn2nZBWx8kQr+AtC+iwoycEgHjlyiUfg=;
        b=H04urzds5bfODmMQ9Oa2EbDHrH0p9WXX9tnZqlYHfOUlZwSSJYnrUlG5IFEMUdm/os
         A/SId8hxPydvVdptWNr+205CE5xFngj7dXkJGXTZ5f+5Z0QuYYJVutkCW577FYqZzNCa
         5o+QkT9W2YahrFkyUkB+6twfDx5UYSzckWF5+otL6cR6p7PijvXFonDKFD68XaVhdP2C
         dMCPXioqydFLAZozZLBkXgZR6exhbYKiRrLD4ou65g9RAwCubmnnHPjXY2sHfG8fO7P4
         jUMhsd96k6jInn3S0Lcpbx1SYfgCwXYfhH6ePeCfLmtYX9XR9E9TXFblanAO217ecTwp
         0HkQ==
X-Gm-Message-State: ANoB5pnnLQ1BN5Dxl7IVnJMv80ty/nMFzZxP3NN4fZrVTxTbpUiLM4pU
        gyfcuCFuqzFF2gY1f0rQ76I=
X-Google-Smtp-Source: AA0mqf60tTc0t+d3TnP1T3nql6FFzGJww5ORoLFepvsW81+/uN3KDuatgQfsnJUXlGqQUhvW2fW/Tw==
X-Received: by 2002:aa7:9297:0:b0:573:f869:2115 with SMTP id j23-20020aa79297000000b00573f8692115mr30373294pfa.9.1671234323404;
        Fri, 16 Dec 2022 15:45:23 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w5-20020a626205000000b005752b9fec48sm1999033pfb.204.2022.12.16.15.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:45:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH v3 2/2] attr: add flag `-r|--revisions` to work with
 revisions
References: <20221216093552.3171319-1-karthik.188@gmail.com>
        <20221216093552.3171319-3-karthik.188@gmail.com>
Date:   Sat, 17 Dec 2022 08:45:22 +0900
In-Reply-To: <20221216093552.3171319-3-karthik.188@gmail.com> (Karthik Nayak's
        message of "Fri, 16 Dec 2022 10:35:52 +0100")
Message-ID: <xmqqr0wykj59.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> ... to optionally allow the users
> to check attributes against paths from older commits.

The above makes it sounds as if attributes are taken from places
that are unrelated to the "older commits" and the point of the
change allows "paths in an older commit" to be inspected.  I do not
think that is what is going on, though.  Isn't the point of the patch
to take attributes definitions from arbitrary tree-ish?

Also, "older commits" is misleading.  You may be chasing a bug in
older codebase and you have a checkout of an old commit, but you
know you have corrected the attributes definition since that old
version.  In such a case, you may want to take the attributes from
the latest release and apply to the currently checked out working
tree or commit that is older.  That is checking attributes taken
from newer commit.

	... to check attributes taken from a commit other than HEAD
	against paths.

or something, perhaps?

> Add a new flag `--revision`/`-r` which will allow users to check the
> attributes against a tree-ish revision.

"tree-ish revision" sounds a bit strange.  We used to use "revision"
very loosely to mean an "object name", but we weaned ourselves off
of such a loose terminology over time.  These days, the word
"revision" only refers to a commit (or commit-ish).

I would understand "... against a tree-ish."  If you feared that
"tree-ish" is not widely understood (which is a valid concern), then
"... against a commit (actually any tree-ish would do)" is probably
what I would write.

> When the user uses this flag, we
> go through the stack of .gitattributes files but instead of checking the
> current working tree and/or in the index, we check the blobs from the
> provided tree-ish object. This allows the command to also be used in
> bare repositories.

Good.

> Since we use a tree-ish object, the user can pass "-r HEAD:subdirectory"
> and all the attributes will be looked up as if subdirectory was the root
> directory of the repository.

Is this meant to explain a feature, or a misfeature?  In other
words, when would this be useful?  I would omit this paragraph if I
were writing it.

> We cannot use the `<rev>:<path>` syntax like the one used in `git show`
> because any non-flag parameter before `--` is treated as an attribute
> and any parameter after `--` is treated as a pathname.

I do not see what this one wants to say.  <rev>:<path> is an
established way to name an object that is sitting at the <path> in
the tree-ish whose name is <rev>.  The user can use "-r
<rev>:<path>" and if the <path> in <rev> is a tree, then all the
attributes will be looked up as if <path> were the root.  So the
users can use the <rev>:<path> syntax, cannot they?

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> Co-authored-by: toon@iotcl.com

Co-authoring is fine, but as one of the copyright holder, the other
author needs to sign it off, too.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A3C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB3E60C3D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhGVIcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhGVIc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 04:32:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C082C0613D3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 02:13:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t2so5867046edd.13
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=o/j+c0XDan/Jtjwx0/RjR9GqBSNgH2+Y0/KRSonGAFw=;
        b=qJ9yFwY8E8q7Ts1Df8IfW7FqbpjULP9NCj+l/hin7NsOH7HVYu4Qrup2Cjct/d9seq
         /isTZrkpfLlh3nau7S+21Gl5BvhdN05UxKQyEQXBAnLhCTLTCNrGKazMAmQ9cOESXc2A
         cfWQ48uey4l/Bt1/iJft+QUW+VH5nRkyCXt/ciwj8DKz9VCvceFDRMJXiCYnWqFx2Rcf
         Mb3yfrYzdrYS4S6DHKd/4iCRvcUqkiHtNOKcbTmtnHYzoXJ6iwtoTqI+Ax3JnrPjV6vf
         eMGQ81n08I/tXYJ8WlxGIVT6eZ1cjNDdAq5I6xHUEcokPTZoqBEgrtCjVhPUStbDNhk1
         wQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=o/j+c0XDan/Jtjwx0/RjR9GqBSNgH2+Y0/KRSonGAFw=;
        b=sEAicE2C0uC1OhMSr/OyIzavTTePHVZ4jEJMD4IF55Da+fUAr7X+yJrN6/bG3AgeIg
         wSiT9O/pdOrnipYMPWFIvuW0r+LNvBJZu3ByeX47sjWLgHddOLxQ/Z4aq0yWocsYNs+Y
         VYvvN/+m26Qlg9xm/VAxwG5e67SmzouvlC9I8vcKXpSj8rhmp+1kWwCHr7PaBEBaq72z
         nGc10LwcKmZzjPsCjhbDj2ld9n+AUzOb17Om/bTvORrELxG7psOXj8iL8dTyJJv1pdxF
         Zekop9v+gFi5wCCFcAjHPxwIQBmkw+vPtP7H0MPT5oFQlYAy+NscEZiLOUh8x7CnyjRe
         brFQ==
X-Gm-Message-State: AOAM533ZP75uUOZ22Nkn31Uu1NDgSWpyT4GsuJGO0kl52fYq5x2sZL4z
        iEsTyxQjrz4Kq/Afxrmp1LQ=
X-Google-Smtp-Source: ABdhPJxGEVSLy3VvtuRWjkSXaQJI34roSgIHEqXlXJGUI/bhSKfMN62orGW3VIsB8GIosuLCZl65mQ==
X-Received: by 2002:a05:6402:d63:: with SMTP id ec35mr53779486edb.347.1626945182573;
        Thu, 22 Jul 2021 02:13:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m26sm9845105edf.4.2021.07.22.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:13:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Angelo Borsotti <angelo.borsotti@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Extracting a file
Date:   Thu, 22 Jul 2021 11:05:58 +0200
References: <CAB9Jk9AafnUQr6q8t=b4Dh0PZHUA=fKJmtXxxObuGpF_w-_2wQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAB9Jk9AafnUQr6q8t=b4Dh0PZHUA=fKJmtXxxObuGpF_w-_2wQ@mail.gmail.com>
Message-ID: <871r7qvhhr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Angelo Borsotti wrote:

> Hi,
>
> sometimes there is a need to extract a file from a commit.
> E.g. some changes have been applied to it in the work directory,
> and the app being implemented no longer works properly.
> It would be fine to have a look at that file, some commits ago,
> when all worked fine.
> Of course, it is possible to recover the entire old commit, or to
> make a new branch, or checkout the file (which requires to save
> the new one before), but the most simple and safe way is to
> extract the file, giving it a new name.
> That is possible, using this (hard to remember) trick:
>
> git show HASH:file/path/name.ext > some_new_name.ext
>
> Would not be better to have a "copy" command to copy a file from a commit
> to a new one in the current directory?

That's an interesting feature request, FWIW you can do this now with:

    git mv A B &&
    git checkout HEAD -- A

I wonder if having a "git copy" for that would be more confusing that
not, i.e. a frequent difficulty new users used to have with git if they
were used to cvs/svn was to look for a "copy" command, thinking that
git's data model (like those older VCS's) needed the user to use a "mv"
or "copy" to track history.

On the other hand perhaps git's so thoroughly established that it's not
much of an educational issue anymore.

> This would make a git repository resemble a (readonly) filesystem, which
> actually it is.
> Note also that the ability to get from a repository what one has stored
> in it is the most basic feature anyone wants from a repository.

Git is actively not such a "read-only FS" in the sense of some version
control systems, i.e. needing to declare that you are now going to
"edit" the file etc.

It is for bare repositories, but a checkout explicitly concerns itself
with you doing arbitrary changes on the FS, and git needing to keep up.

So maybe there should be a "copy", but if your starting point for
wanting it is to make git behave like a read-only FS I don't think
that'll lead anywhere productive.

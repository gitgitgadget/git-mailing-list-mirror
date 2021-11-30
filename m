Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2749C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 04:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbhK3Etq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 23:49:46 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:45908 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbhK3Eto (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 23:49:44 -0500
Received: by mail-pl1-f181.google.com with SMTP id b11so13911893pld.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 20:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHQPFqm1mlMDLrDDdAAe5dDOovtb0ievvsm3hWt/huw=;
        b=fzG6shDSA+oQfhznGHGXGgahrcCgLoRa0lBJI/eJQ2VgOJbSdBSgEbdZVssL6oefCn
         emYTozHDcNQ4RJCFIQhPj8Bk0TPeffjLfuZgM+KJ50cajdEdGe/eGSug6Jl5XVHZcmyA
         FcKe0iNY9IYLUgTTyO7YsXDjuukmKqgUTqMFazgVj9gMXwT17rvO2i93pqhUOULOijYO
         KzPvjIIwfxs9hFJ2FcJmerc6usgQEO/gcN+9L52zMLVFLQMaIyhyw+94wzdB1KCV859K
         HH3R3KSD096zLTZOR5PCmY//8LBijuN/5WRcokgALj0rDKXL9ZjYaT9t9MjCnQoNM9GC
         OMJg==
X-Gm-Message-State: AOAM533lUuZMdHuUwSZ4M8h2B/SutJtPDxB6uqCCEHHGdGrlVw7b88pr
        ZK2ChgMXdOKqPW/csIkC58lRX3hztLH1r/sKgQE=
X-Google-Smtp-Source: ABdhPJwL9aRTZ6kvgkAbgmNIbMiwr6wINuqKzZiKvD7552rxtM7UzQXtah3DbrOVumnmayr2jicKOWnSMmUM8/X5d+Y=
X-Received: by 2002:a17:902:7d8b:b0:144:e29b:4f2b with SMTP id
 a11-20020a1709027d8b00b00144e29b4f2bmr65636368plm.57.1638247586014; Mon, 29
 Nov 2021 20:46:26 -0800 (PST)
MIME-Version: 1.0
References: <CA+34VNLj6VB1kCkA=MfM7TZR+6HgqNi5-UaziAoCXacSVkch4A@mail.gmail.com>
 <CAPig+cQ224Tz5iQ5Yt4fMadehLmrJWGzH7kwUSr+UT4hcQf14w@mail.gmail.com>
 <CA+34VNJbOHYhYgN+p7EsGiRAzf+aAQGeMxCzG1dizFjDRVQVbg@mail.gmail.com> <CAPig+cTGq-10ZTBts2LXRVdPMf2vNMX8HTuhg_+ZHSiLX-brOQ@mail.gmail.com>
In-Reply-To: <CAPig+cTGq-10ZTBts2LXRVdPMf2vNMX8HTuhg_+ZHSiLX-brOQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Nov 2021 23:46:15 -0500
Message-ID: <CAPig+cSRonrX2SUARS=spEnWzapH6osvi3ZvZ2rPURA2zRSkvQ@mail.gmail.com>
Subject: Re: misleading message printed when worktree add fails
To:     Baruch Burstein <bmburstein@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 28, 2021 at 12:00 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Okay, that's happening because the "Preparing" message is sent to
> stdout, whereas the "fatal" error is sent to stderr, and the streams
> are being flushed on Windows in a different order than what we
> typically see on Unix platforms even though the "Preparing" message is
> actually output first by the code.
>
> A general fix (not specific to git-worktree) might be to have die()
> (or maybe vreportf()?) flush stdout before reporting the error message
> on stderr. That should make output order more predictable, such that
> general status messages appear before error messages.

An RFC patch has been posted to address this issue.
https://lore.kernel.org/git/20211130043946.19987-1-sunshine@sunshineco.com/

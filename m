Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E2EC433EF
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 20:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiAAUSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 15:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiAAUSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 15:18:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1FBC061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 12:18:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w16so120519847edc.11
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 12:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLrSIXio+ewzs3FVqr3+UaTPKXk72gBCYZ/gkkUxrsc=;
        b=XtVhRYVxhFA+VW0xN7Yoj8Z2GtgWoEMaAq6PyyVPJ7WX9fSfD9103eb5qkIioD3tmk
         OSCluViWZxNnGSuAxfDwsZ/I3wW1hB88o7Nt5/0IlyXtX/oWpq4okyko8zDnIwUAaRQL
         /uR6rB/15Gl8YCMvL/zD6Vy+q8qF4gyxjHG+o2YIZViphj2j+fzD+lI8eo83J0Fbkj8l
         FpPGyP/PkWYK4Ia2GiBn7SlXPY3ImPAby45QApzh97XnzSPJc1NmPcAhpIn5s0GDE84r
         mPDx6tzx8FjNhw7fGa7d3WBim3jW763Y4EwRq1gV6Vlbpj7GmaZmtY0BavwXH3tdw5QU
         Qgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLrSIXio+ewzs3FVqr3+UaTPKXk72gBCYZ/gkkUxrsc=;
        b=Vlwn7pFCZ9vZ7f9HrpEFN3ofBUlDHJQ9Z0GO/1f6BXmZP6NUDfu6xLwqizH6yG4h8n
         biO+Tt7KAxCZKmbI4LPAjs3zqUm8Zv5IykI2CJR8Oi2XVSYKW+cCVBfmthqVCR7Poyyk
         x3LuNmh7yOb82volLqBxcYumIfehpSyrVKlIhyR+VgcyCa8NyYe7oAZ1GJOEULiVh2QQ
         hNwi5w9vL3SmreDvcHzAC8QbkZ+A0AvTPsMUquIg5PRNJoZNg78Bik9yk6kzQ9PVGGJg
         4CZD6NlsDVMBKHfHmQaP8IE9k6A28htunJ70nRwggsgxJRzycmRVWEe3ndFaSDOv/3Ys
         kuAQ==
X-Gm-Message-State: AOAM532nx5sxZj9bw5NhG1Mco8RXMA37CA6XhQp4IvF7lSucSOKR1C7B
        YH0Rsu2UU7xtyhSBIsFHP5k2GY1AFzOJeaPRkysKvkYW2bw=
X-Google-Smtp-Source: ABdhPJy920/2CwonSpiMd8+XVttBf+N28WYRZaMgbNvXDmZITYgK6AnG1h8hoy98/VUHeQnVubsrHv2XkoaqkTLG2Ko=
X-Received: by 2002:a05:6402:190c:: with SMTP id e12mr40197149edz.153.1641068285600;
 Sat, 01 Jan 2022 12:18:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <9da8e77c1d7c3645fdad74080c0093f420dcfef4.1640927044.git.gitgitgadget@gmail.com>
 <20220101201139.elxj76zr2ihrjkdr@gmail.com>
In-Reply-To: <20220101201139.elxj76zr2ihrjkdr@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Jan 2022 12:17:54 -0800
Message-ID: <CABPp-BFyw-=L2UAXuQcdAUDK1UYuOKdMd1UfUav7nUwyhFypnA@mail.gmail.com>
Subject: Re: [PATCH 2/8] merge-tree: move logic for existing merge into new function
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 1, 2022 at 12:11 PM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Fri, Dec 31, 2021 at 05:03:58AM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > In preparation for adding a non-trivial merge capability to merge-tree,
> > move the existing merge logic for trivial merges into a new function.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/merge-tree.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index 06f9eee9f78..9fe5b99f623 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -366,15 +366,11 @@ static void *get_tree_descriptor(struct repository *r,
> >       return buf;
> >  }
> >
> > -int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> > -{
> > +static int trivial_merge(int argc, const char **argv) {
>
> I guess the brace should probably stay on its own line

Whoops, indeed.  Thanks for spotting.

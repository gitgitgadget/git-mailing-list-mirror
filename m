Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5BFC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF3220835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNZLjqAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfK0R54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:57:56 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:54781 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0R5z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 12:57:55 -0500
Received: by mail-pj1-f73.google.com with SMTP id d21so11449262pjs.21
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CZ12x2n6/Rf2YhjPFjgjHjrhBnzuf2iHRkMRlU1ww6g=;
        b=ZNZLjqAC8QPU56u9f40Pv52AwhABTsKwezH4kq+C9V2FCXil3pNoSGWp1JykbmQbzH
         01EqV1IVSg9zCdWjp/wrX6h+H/Vs4HG6yu2853+S6eDhZFImKTKgrg3Pbj9QRvYfXaho
         WDXQEP0VZLKa6zQLUqwl0cTIINRHdI7un82oKDRZIllrXKbEXiSKDEK/50u1IrY7e2rS
         SOkTGjZYX7EVvuXi2VTc2ckqyQLFRfXoVvUiOI/U87PgQY3HO4V7Y2vKeRO+tixVWt/U
         DnahvZNnIpccRGG+CkPJKp6sTTdfzCIYAJWFvrUsd9oQmVV2fgvDIGKqwOkndoIUeWnE
         qO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CZ12x2n6/Rf2YhjPFjgjHjrhBnzuf2iHRkMRlU1ww6g=;
        b=LHwB3a8WWpwJMbKkFMN4WrwKz8tmmQ0IHZoP4ctFNm9pOjqtLPZb7typZnaRKTg0js
         QAZxUOukq6OgCaMQrWEkCo2aNvN4OR+nKJ6M+Dy8dcENtCzXfdJ9eYPkR6CgLwp9p7n4
         4ONTr1p7EhY/cKZ5Twb9Yx3Rj2wV44PKQMlp0dJGanoYOTEFU3AGgoDLy0zghdh4GMT9
         dHwTZ5ZBc5pdIYxhnqHC4iU+jUiVcQwWAAgocdnTko6OMgXo3Ly1bPbXCKVdX23KcmR2
         yvCEFfxiMk1lNqzlSEl/P9hEmlh1c3esDxzI+woL0ZyTxOgO++r6/Rasn0su6WGLFD7Z
         10GA==
X-Gm-Message-State: APjAAAWUgk7U9b7O9msV/AEw7lsKAfv/5T9GDSzcEoXFhDy8GVXy2WNd
        tPOjvz35v+TTB17YJCCmE2bV3KiUU4qCSWmwkriU
X-Google-Smtp-Source: APXvYqwLlccBrj6A+qOtXwShw5hyQG2PUMqzIDeqGiwPtrccIncvCEyrhVaAeSn71RjOqtZaf1bVnGvpAmypJLBHTEXn
X-Received: by 2002:a63:4b07:: with SMTP id y7mr6382699pga.373.1574877474920;
 Wed, 27 Nov 2019 09:57:54 -0800 (PST)
Date:   Wed, 27 Nov 2019 09:57:51 -0800
In-Reply-To: <20191112103821.30265-13-szeder.dev@gmail.com>
Message-Id: <20191127175751.165445-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191112103821.30265-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: Re: [PATCH v2 12/13] name-rev: eliminate recursion in name_rev()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     szeder.dev@gmail.com
Cc:     gitster@pobox.com, stolee@gmail.com, l.s.r@web.de,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Note that this slightly changes the order of lines in the output of
> 'git name-rev --all', usually swapping two lines every 35 lines in
> git.git or every 150 lines in linux.git.  This shouldn't matter in
> practice, because the output has always been unordered anyway.

I didn't verify that the changing of order is fine, but other than that,
this patch looks great.

> This patch is best viewed with '--ignore-all-space'.

Thanks for the tip! I ended up unindenting the loop to see the changes
better, but I should have done this instead.

> -static void name_rev(struct commit *commit,
> +static void name_rev(struct commit *start_commit,
>  		const char *tip_name, timestamp_t taggerdate,
>  		int from_tag)

There are many changes from tip_name to name->tip_name in this function
that mean that tip_name is no longer used within this function. Should
this cleanup have been done in one of the earlier patches?

Apart from that, overall, this patch looks like a straightforward good
change. When we have a parent, instead of immediately calling name_rev()
recursively, we first add it to an array, and then (in reverse order)
add it to a priority queue which is actually used as a LIFO stack.

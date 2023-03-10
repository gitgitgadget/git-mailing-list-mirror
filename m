Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2DC6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjCJVaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjCJV3s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 16:29:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A9612D418
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:29:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w200-20020a25c7d1000000b00b3215dc7b87so2051444ybe.4
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678483758;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ob2N5sSPji7FSQuNwS5fBgiazTDH5ZOnJrsuxr5sVy4=;
        b=Lfg32lJGrXYvOLTZhEictHOmtnY16OImU6f+WjGF0KMY99kz4WBTO505u5ueq4lbkG
         i5/EG7AgQyU3gcii7UVWr/8xxhlNqaJixB7wDcTF2kfpFjgLhUKwYqexvPAI8ZLHgW6v
         pdlnbMGmQz3gxLII3LaMbYqPBrT7fp+0RfH2tttVTL7tth4t1OPuh0X3zosQU8X5fcws
         kg3hgaMoYA27l2sJY7sHUbWnYLoG4qvV/MaxwrE0PcOcDjL+pFGELAxEIWfrj8wp+BFl
         OSYkx4cm6hjwsL/xCrPqRQ3W7qVamdJb+4TJGkeTQhOoJkSFvL5kash0pR9HnGD9WxzU
         5gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678483758;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob2N5sSPji7FSQuNwS5fBgiazTDH5ZOnJrsuxr5sVy4=;
        b=YDqTktGQTOHQuybbeUOqJo+BseYdw/5pQuif18Nmb3FE8lBoLTPqZM6TwM5eEJiB7n
         4yT6yV73vW6LAv1/nuvAY5zgf2rFoh/w+uo9W7n3ujDXFaVlIdAfR7OBdEtims0/p80g
         +AoDSyHNRcYz4nA8wYRFmTvCUio3F/vpn73ASX24GSIZGEmMKbS0vdWkwebdUFW+UOzC
         5tPeueGKxh3UCv4YPYsRjdHkV6soHzLUSppJBFFvwoZwB/M5PMJe+oEAC+rsx+x7D2zk
         qamVFrN8BOmbQNJ/zv0oKKE7H+cjol9RxXPI3HEDecFK+9hUTpF4ClVOdg7uESm54/qH
         iA9A==
X-Gm-Message-State: AO0yUKW9v7FkotAe5eWBnqYFzZNhM7BftF/yrYwOqFtYK2itdu9P4Y6N
        4OF+MDniUX9GzFXlXyapUORS/C6Ppa15hcmHvpXs
X-Google-Smtp-Source: AK7set8CtQ53JHUxP2OE18GvBlc5gDfSWCh2E8hn7QI380apZLw+Gs+w1+y1ETWEwKp/x7tOUzxNZhFNUL4SxSsK0jju
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:f63:e36e:a446:b3ac])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ad5a:0:b0:536:4d58:54b2 with
 SMTP id l26-20020a81ad5a000000b005364d5854b2mr17968436ywk.4.1678483758822;
 Fri, 10 Mar 2023 13:29:18 -0800 (PST)
Date:   Fri, 10 Mar 2023 13:29:16 -0800
In-Reply-To: <pull.1490.v2.git.1678301252360.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310212916.4138690-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2] object-file: reprepare alternates when necessary
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>     Update in v2
>     ============
>     
>      * Instead of creating a new public reprepare_alt_odb() method, inline
>        its implementation inside reprepare_packed_git().

[snip]

> diff --git a/packfile.c b/packfile.c
> index 79e21ab18e7..06419c8e8ca 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1008,6 +1008,16 @@ void reprepare_packed_git(struct repository *r)
>  	struct object_directory *odb;
>  
>  	obj_read_lock();
> +
> +	/*
> +	 * Reprepare alt odbs, in case the alternates file was modified
> +	 * during the course of this process. This only _adds_ odbs to
> +	 * the linked list, so existing odbs will continue to exist for
> +	 * the lifetime of the process.
> +	 */
> +	r->objects->loaded_alternates = 0;
> +	prepare_alt_odb(r);

I understand that the change to inline what was originally
reprepare_alt_odb() was in response to a reviewer comment, but I would
prefer the original version, since this assumes that prepare_alt_odb()
only adds to what's there instead of first clearing the odb linked list
and odb_by_path hashmap.

But I guess clearing a linked list and hashmap can be a bit cumbersome
in C, so maybe it would be reasonable to assume that this behavior
would not change. In any case, maybe a comment should be added
to prepare_alt_odb() saying that if an update of the alternates
is needed, one can do so by clearing loaded_alternates and re-
invoking prepare_alt_odb() (at least so that a developer changing
prepare_alt_odb() can see the comment and understand what behaviors this
function needs to preserve).

Everything else (the new functionality, the commit message etc.) looks
good, of course.


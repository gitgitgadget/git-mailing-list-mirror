Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDA9C7EE23
	for <git@archiver.kernel.org>; Tue, 16 May 2023 00:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245454AbjEPAQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 20:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245075AbjEPAQT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 20:16:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C775B88
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:16:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso24645230276.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684196178; x=1686788178;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DtMbFrJPZ3jn+mCAwmOyDQ0dPbGwiruZs5ut8593J3Y=;
        b=7wtHm2lsD1srqhTlYHM9gjZZTSiEzFxef0xD9ASQ3WQvtshZwAzEuJ+FYXNce2Molp
         8wUn5om/ZegsfzDAXZdyJ9IgQZNU9Hroea6qNL+zm/NKYqYBnJXf0VsQAkI5HrtihF80
         NpQVGO6AhnzdPJpN01CDSTrf2iSn2J+a7LY63AdOENUwFG1JlOKyDVjzfpZ4Q4vPjaPz
         xZTaDJYmKt9Ivrc8qrl/uZyFoC75YOGy8Y0Dq7ctyhOnmhGGTR23CpXWTL06Zv7NOMEk
         iIM0LNGYTl116CiWxWE/w8a2KkYfIRB5KeF04REIqScx0MBp53jSBX2Ztx8PAmD/mjpM
         8o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684196178; x=1686788178;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtMbFrJPZ3jn+mCAwmOyDQ0dPbGwiruZs5ut8593J3Y=;
        b=aYvHGztvh7zk5iM8nYt7yh/IK/nGnOsive4cRA8GEjQl7kR6Fr4zkNun8+Zap5aV5z
         YkVFQDS5t0pDSm/h7m9EkCQcV5OdBgIXVeVQ7kYhMmsARGh+tDskmS2R/8Rg1NpE23bR
         FWl7m8lnr9ZCaTyg69cuhSC2IMP0NLDArH1Yy1SZCBvhdVzXnOEk7lSG67brFywmteV4
         QgU0dO3ZSgy1oLDGq9OjDRQNccbDQpCTFQcaA2o5qKi7fgYE+kPaPvUde7KjQAviBv3R
         Kboy9n+52zt8XTOv+oIygjA4+6K3EdvpGuxtC+MwAoNr0BPzVo97xcyKio6f19wArDwh
         vIuA==
X-Gm-Message-State: AC+VfDym88YOj2kqbhTiR06kk/bnWJJmr1qPL8YixKEoyG9LPmfu13Tf
        27qwRgpjf4i3IA2tkDiCoQUPTrG0ddOHeOIjNHuk
X-Google-Smtp-Source: ACHHUZ6yHH0GcqK3EGyBg3JLPtnZ6HEcJBKTwmgtOInYcLpmwnL4qjVoNhyH3sHMr8jPJmuBZHDH/b5gij6LkJJwH0L3
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:3aab:56bd:1f4b:d239])
 (user=jonathantanmy job=sendgmr) by 2002:a25:54c2:0:b0:ba2:b2b4:8bd5 with
 SMTP id i185-20020a2554c2000000b00ba2b2b48bd5mr12176709ybb.8.1684196177793;
 Mon, 15 May 2023 17:16:17 -0700 (PDT)
Date:   Mon, 15 May 2023 17:16:15 -0700
In-Reply-To: <41d48379b3dc4b621b097e145fc3be6257466654.1683875072.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516001615.1460450-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 26/27] hash-ll, hashmap: move oidhash() to hash-ll
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
 
> Move this function to hash-ll, so that khash.h can stop depending upon
> hashmap.h.

[snip]

> Diff best viewed with `--color-moved`.  Note that there's a small but
> important change to khash.h in this patch as well to allow this move,
> which is easy to overlook.

[snip]

> diff --git a/khash.h b/khash.h
> index a0a08dad8b7..ff881631778 100644
> --- a/khash.h
> +++ b/khash.h
> @@ -26,7 +26,6 @@
>  #ifndef __AC_KHASH_H
>  #define __AC_KHASH_H
>  
> -#include "hashmap.h"
>  #include "hash.h"

Is this the small but important change to khash.h? I thought that this
is the reason for the change, not what "allow[ed]" this move.

> diff --git a/object-name.c b/object-name.c
> index 45f4d51305b..7e96c97051e 100644
> --- a/object-name.c
> +++ b/object-name.c

[snip]

> +struct raw_object_store {
> +	/*
> +	 * Set of all object directories; the main directory is first (and
> +	 * cannot be NULL after initialization). Subsequent directories are
> +	 * alternates.
> +	 */
> +	struct object_directory *odb;
> +	struct object_directory **odb_tail;
> +	struct kh_odb_path_map *odb_by_path;

This is not present as a minus line (that line uses kh_odb_path_map_t).
I thought this was so that we could forward declare "struct
kh_odb_path_map", but I don't see such a forward declaration. (Was it
declared elsewhere?)

Everything else looks good.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B6CD8CAC
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 17:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjJJRnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjJJRnw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 13:43:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFFC99
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 10:43:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a397a7c1cso2261308276.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696959830; x=1697564630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5gVXTb4oxNhsBngrztOWw9+mmnVa1aa+c9+QgTEyNpI=;
        b=3u+N0i7CZiy5Y7CilKLvez18BKOKKNcGTrSUW2smkNsVMqEgK62TVfJHvjYGfmYKJB
         l94yNiR/6CeRevRv0HCxqOZThq/yGWSBijYl+7sqGot9WGvDe6w4vSnEWwimRpJzYaXy
         0d5Bv7SRyuURSSbgx/qWTNCaY+289IQXvuNLtkh4yLoGGYWtO0clHTHo+LpuUGWB34NA
         LGmicKm130uDcRAWv4G+DBcgm13CqAgqSVkGuNq1mUEUxjl94V8qz/pXefnpTTVKnb1M
         Z4jURUoCVneasRf56NmoFTgqhRLGB+fgwAntNnnDkFl8P4eLjbptkg8AYkgUKZofjwgz
         5eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959830; x=1697564630;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gVXTb4oxNhsBngrztOWw9+mmnVa1aa+c9+QgTEyNpI=;
        b=si+J2JRy8+uZmnbtGCy8lOdpYMT8EcIGSimod1PEShSR1ahmzP+eJrV9kn10Hh5N6A
         SVWlZZxfRvI5e6D9tJLv9mjgpdXhjdAVHSIKpCK4QlPbbri/i1lTjAPlOmwT5lq0wmNf
         FHYLZAac69fzRlb+A6YNJN3NgVSIbD8HYWZEnHuV3GV9Ngx+Ydm3FeTtSivclebHK5/1
         a+PqjJ1643yQDUs8stykMpd7nYk8NgVdznP0UGLg3SNgBlG3rztVsOaea7nM3nmw+cK+
         724ewldSNZZeEHctBw0U3suB8bXtPgGuLSMMx9Yjed9JpH5p24+JnjsxpFTj7HH8qjFe
         B9EA==
X-Gm-Message-State: AOJu0YyVRcCZjzsc/rb/O1K2zFqXCUyUw1/aeqSqX2MyyvZw0rn38rvv
        YL7JEUSxI1jWyBErdPaUzUjddr6Pl245xxbX+me7
X-Google-Smtp-Source: AGHT+IF2BDIpzuqswARpyktkERm3YqpopzQLDm9gzXttEIR8AHjjC6w0fYDaLJIpyBoAPzV5arVVbLrOmJ08uEeVrEA2
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1002:fbcf:d571:5625])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1603:b0:d7a:bfcf:2d7 with
 SMTP id bw3-20020a056902160300b00d7abfcf02d7mr309041ybb.6.1696959829870; Tue,
 10 Oct 2023 10:43:49 -0700 (PDT)
Date:   Tue, 10 Oct 2023 10:43:47 -0700
In-Reply-To: <1de0a6f3-e223-4e84-a6d2-51d9b51a02f6@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231010174348.2150150-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 4/4] parse: separate out parsing functions from config.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     phillip.wood123@gmail.com
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

phillip.wood123@gmail.com writes:
> Hi Jonathan
> 
> On 29/09/2023 22:20, Jonathan Tan wrote:
> > diff --git a/parse.h b/parse.h
> > new file mode 100644
> > index 0000000000..07d2193d69
> > --- /dev/null
> > +++ b/parse.h
> > @@ -0,0 +1,20 @@
> > +#ifndef PARSE_H
> > +#define PARSE_H
> > +
> > +int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
> 
> Previously this function was private to config.c, now it needs to be 
> public because it is still called by 
> git_config_get_expiry_date_in_days(). As this is essentially an internal 
> helper for git_parse_int() and friends it is a bit unfortunate that it 
> is now public. Perhaps we should change 
> git_config_get_expiry_date_in_days() to call git_parse_int() instead.
> Then we can keep git_parse_signed() and git_parse_unsigned() private to 
> parse.c.

It could be argued also that it fits in with the rest of
the parsing functions - this one parses intmax, and we have
others of various signedness and size. I'm open to changing
git_config_get_expiry_date_in_days() too, though...we probably don't
need so many days.

> > +/**
> > + * Same as `git_config_bool`, except that it returns -1 on error rather
> > + * than dying.
> > + */
> > +int git_parse_maybe_bool(const char *);
> > +int git_parse_maybe_bool_text(const char *value);
> 
> This used to be private to config.c and now has callers in parse.c and 
> config.c. We should make it clear that non-config code is likely to want 
> git_parse_maybe_bool() rather than this function.
> 
> Best Wishes
> 
> Phillip

The difference between these 2 functions here is that bool_text supports
only the textual forms (used, for example, in git_config_bool_or_int()
which accepts both boolean strings and integers), which might be useful
elsewhere too. But it could be better documented, yes.

Looking at "What's Cooking", this series is about to be merged to
master. We could hold off merging that, but I think we don't need to
- it could be argued that git_parse_maybe_bool_text() could be better
documented, but even if we wrote it from scratch, I would probably put
the extra documentation in its own patch anyway (so one patch for moving
the code, and another for adding documentation).

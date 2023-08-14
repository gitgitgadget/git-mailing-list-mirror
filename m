Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EF3C001B0
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 22:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjHNWJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 18:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjHNWJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 18:09:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C03BBB
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:09:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d67d20284dbso3871584276.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692050953; x=1692655753;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qC9gWXo7j/cjVb/o4yYfJLM1U0IE2l7Wcs02DNhT/2o=;
        b=JOODBLVkxwI8/y0ANHxicYj1+jR8witIgG+e0bKVG8BeksvIzIe2DVW8c7vpokmTg+
         3ydxyeXC57cOhxB6szdZi4ppNyqlWmL8fJuJv0Q2xAeI/EeG66h2jvbKjoGF9h/drrOh
         HjrHy7zy0Ut0YAku13cE+f/0UHxZN+r9mqhSSpArNQhT7I9gLswF47NYGLbCrSkoDmpX
         1LF1WZO8et4fWJKFeQwBx3ah8iNSRAi+iCcQxyyoxCYypGHECwSioxIkph1+0ms0IeMf
         IgUGZ/alrRoH0M7AqjhEfaaI3rkHcsO3vrTs/nIeUJ2+sQUItwUJim1ldAl07MoXEuO0
         3j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692050953; x=1692655753;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qC9gWXo7j/cjVb/o4yYfJLM1U0IE2l7Wcs02DNhT/2o=;
        b=ejQb3DW0HijDOc0kwO/NsZczP6qEhlr83Iei69FQii8TEqmTpf1AT88EILzVXgd4wY
         uMQNzL7GFHyemftIlMWVpJy4UZYpry34cPfBi6tzSkkW7hcV/fwGiTcdEqTGZnSQFkxF
         lED3NI8KLLxJyLDHNwdX9a4cJGjqxvrsrrkjD6DTiEQyNUb63EX/iYd4f1VluW7CiZg8
         gYlHDWD7m8YE73kWADu/UhGGjS2LX+bgPyvikYXXZBOtE0QM7/Prnx00SYKKKOz69GPs
         cYdmfNuopQI8jIpQZk0kKFsYk5mbyO7XWHHKCuuEBO5raH2b/HRW7FJjf6jPfUc0DPra
         1E2A==
X-Gm-Message-State: AOJu0YxfLtsLC3H+1Gz/q16ie+D6YSz4mLj+EmssFtoDzxBX0DhlFcI/
        zvitPFbOsPO5acfotl5jzSCeZQ5Cf009HmThrHgA
X-Google-Smtp-Source: AGHT+IE6dLqMb5FrBRUXWenhPe7KwNWVFd3mAhOgbXj6AqpGonUSfzdcIWJsae6X/tyB35QcLWgM8mBDoIfBlYZlB0VN
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:51f6:bcfb:aa2f:af1f])
 (user=jonathantanmy job=sendgmr) by 2002:a25:e78f:0:b0:d62:b8f5:d744 with
 SMTP id e137-20020a25e78f000000b00d62b8f5d744mr141414ybh.9.1692050952812;
 Mon, 14 Aug 2023 15:09:12 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:09:10 -0700
In-Reply-To: <20230810163654.275023-4-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230814220910.60930-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH v2 4/7] parse: create new library for parsing strings
 and env values
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, chooglen@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> While string and environment value parsing is mainly consumed by
> config.c, there are other files that only need parsing functionality and
> not config functionality. By separating out string and environment value
> parsing from config, those files can instead be dependent on parse,
> which has a much smaller dependency chain than config.
> 
> Move general string and env parsing functions from config.[ch] to
> parse.[ch].
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>

Thanks - I think that patches 1 through 4 are worth merging even now.
One thing we hoped to accomplish through the libification effort is to
make changes that are beneficial even outside the libification context,
and it seems that this is one of them. Previously, code needed to
include config.h even when it didn't use the main functionality that
config.h provides (config), but now it no longer needs to do so. (And
same argument for hex, although on a smaller scale.)

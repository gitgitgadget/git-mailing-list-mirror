Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB80C61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 18:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjBVSTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 13:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjBVSTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 13:19:16 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB70233C0
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 10:19:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536e8d6d9ceso51687647b3.12
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 10:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jq+tpaWCn2BsGwEX2Yipr0xQ6VYs5seuJi4kd3br0+8=;
        b=lWAJyk0YfalVbhOE91o0P6DAh5Wa/C3POS0b8ykGPM9y0uaZ2Z8ldg3PCdVMT3zD4I
         g6Gf7PhhEkubjT7CvjKjUE4zFt6E/2lUWB0EL5N1d1Qn4RHVLxRSbQvMPBIudHhBJTfq
         i3EQ3+wnV9ZwW5FlWgZBSWr7wKLv9ohMKJEYIRzvgqdiqkPjGEHGVeCK/zrHxMWTdpea
         Wn/wwGXSB8XrheXXzf6TYZkd5ScLUr0Oz89lmAxyqRrsOpwLjbbvz4rOrDqTZQlbXmY5
         KHhjP0eKbJ31dpsckOkNnvjCMl5SWO91deR9VpY1iePOKSTcr8ftnMlOCGTn+sNzWWKt
         H5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq+tpaWCn2BsGwEX2Yipr0xQ6VYs5seuJi4kd3br0+8=;
        b=1CGz/BttEX+ajzbg0jP98eTQAEFsb5HryIF9fvPpvWOJV9XfK+8rT9vPkxuFF2VJ2t
         6yAs9T7yDP7ZMogDh96MccIF2DhzbQ4AAO+cPXROlN4UYKt3IvZLdraXljuXwu9ixUrc
         iV0Jht/mjFtJ5dR+kQXb1FdBZCPdSBFucQTI3SIU1DfHkofrUlVCVWHtQBys32vxOj2r
         Yj8X6tXsLadqk3s5diAKzQbZoJYkveJjlmOmzHnfVhd9EzGCzL/g3BVTZk0e4eZyG0MW
         gnATG7/Bftn0C+OMI4FJ5YdULpGQczRJHcZXpRmWWaK5NJ2kENeDyFEFGb3f00UuvI5B
         3Vkg==
X-Gm-Message-State: AO0yUKUSd+VOpLAgEgBcbn3hQqfeycSPVfc40MkqTsJsx+EA2WLsoCz9
        AbS7YV0IcX112wfnPBcTs+zVxu1fi7upfPquFziS
X-Google-Smtp-Source: AK7set+VQ07RuuLq4XpWIuo9P/f5vyFnODmTrURRcb6lSlG6eX88p2IsZegXD6myULh+YCB/1kNQDu2ZPy3YteUiAvU8
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:3ecf:b5c8:5259:3383])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1143:b0:90d:a6c0:6870 with
 SMTP id p3-20020a056902114300b0090da6c06870mr1608544ybu.2.1677089954623; Wed,
 22 Feb 2023 10:19:14 -0800 (PST)
Date:   Wed, 22 Feb 2023 10:19:08 -0800
In-Reply-To: <20230220181324.25116-1-five231003@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230222181908.1177403-1-jonathantanmy@google.com>
Subject: Re: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, jonathantanmy@gmail.com,
        git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:
> Also, is the shallow object not sent when cloning due to the partial
> clone filter and hence a subsequent fetching is done to ask for this
> object? If so, then will such a fetch counted as an args->update_shallow?

What do you mean by the shallow object? If you mean the last commit that
is sent (that is, without its parents), then that is a commit and is not
excluded by the filter.

As for args->update_shallow, that's a good question. Just glancing at
the code, even if it is set, I don't think there would be any difference
in operation since the lazy fetch does not fetch any refs (and in fact,
in protocol v2, we skip the ref advertisement in this case, as far as I
can remember).

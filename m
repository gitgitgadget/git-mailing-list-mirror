Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71874C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 21:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjBJVt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 16:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjBJVt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 16:49:58 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F63E0A1
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 13:49:57 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id bj12-20020a056a02018c00b004fac0fa0f9eso3090393pgb.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QwM7GduAPXFYEtHHPmSlDOZLmfSnbsFw9QCLqecW6I=;
        b=C6E6YulIcghiXPc0iaRxdTvlVjBmWj5HtyVyiRG4M0wldTfJskNsGdXOb1QYy9ImN9
         fenJopPjnFK04no0jbqDYbktIvt2Yn0z9GWaEz3GPNXdhgSzVkvdxwB+HV0FAuEIB0Ii
         +CGX1etFLRKxfpcAMxPrIyYMu+nqLU8hfGr2UbEDcg0Hf+WOmpLrb0K6lw0w3IOR6Olm
         vuoaMj+f0wPGIPBLE0OyVfHqk7IsAJEjU6IeQ0Vm7Xr4BT+ihosJu5iJgJAKPbIKA6s5
         JfhhAM3jCDFYvw11ABTUg7MbFEjtQ4TVrZ7YEAnXqFeljr2mdUg/g//X9jZrKXDmzROy
         45Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QwM7GduAPXFYEtHHPmSlDOZLmfSnbsFw9QCLqecW6I=;
        b=C3Zi0CC2MOI1XuNITg5e3L7lP5QCMG+zZEbQk6Dl6N2zEISoq7hGptKNTzp1W3vOVs
         Di5xGLGDt8vhUH6aaBN/y/eRWO/hGxk/QxLfRZm9u9Y6YBVly2t6mDLmO9+TtDKnFIPn
         ZQqE7PqZrerO3+XhTDkWsqIdnSvCYr8cwD6KEvtC9WiGrnPTjBDZHhazbNm20w/IO+Fa
         ddSr8JErmd2LRT1XQXrwDLEZIbSkG72mhmQVF2JOOJUXMEHJafvWmCgtv0DEP5L/7j44
         GMa5ZvA1gpUBqB5Pcnq1ninVZTTkNSkg5jVWKbG7YyJisDjeVKoXlG3VPkKAYL8zhykr
         RG2Q==
X-Gm-Message-State: AO0yUKXu4HvboDYkB/ntCrVVtEs3nWYxuGhJJtLC/N5jrInC0lgasVr3
        TOC8/RjV/kB10YWNgC/bDWwO4NHk+JnTcTkCMdXi
X-Google-Smtp-Source: AK7set8hQXv4LMffRnfzXs1sEZuzso852NQFjX8+IUuIqi8+0nwSX03t9Uvjyn+1UfCALBGgvKcafNuur2tiDoV3Jcjx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:b25e:0:b0:4fa:85f4:f9a with SMTP
 id t30-20020a63b25e000000b004fa85f40f9amr3246355pgo.121.1676065796857; Fri,
 10 Feb 2023 13:49:56 -0800 (PST)
Date:   Fri, 10 Feb 2023 13:49:51 -0800
In-Reply-To: <20230209122857.M669733@dcvr>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210214951.684909-1-jonathantanmy@google.com>
Subject: Re: [RFC] fetch: support hideRefs to speed up connectivity checks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:
>    git -c transfer.hideRefs=refs \
> 	-c transfer.hideRefs='!refs/remotes/$REMOTE/' \
> 	fetch $REMOTE
> 
> I initially considered passing --negotiation-tip OIDs, but this seems
> like an easier solution as I'm not yet familiar with this code
> and prefer to avoid writing too much C.

--negotiation-tip supports ref name globs too. Would that be sufficient
for your purposes?
 

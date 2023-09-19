Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C50BCE79AD
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 22:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjISWOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 18:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjISWOa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 18:14:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A96F5
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 15:13:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81c02bf2beso4820777276.2
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695161620; x=1695766420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qu76Z2RZiqArPHy9LupMU2CWA64nk07OmRJSoxU2ig0=;
        b=jvn7LRtEi2/AcaYvBffgl560BoWu0KMlOjr9r7gkU6T0Ob5hI92jfjIbQk4LB6W68W
         Ddit/djUXv3zGr3i9tvZ4BQdi4b47fUzXOJSwUKf3ePHaxrYdgAA4BvCb3UzNcnT9erz
         sjfPhmPupI6xmOJ4D+BdETVJ5x/qkUCTUYQyIizt/iDY0Dm4ZaldGJkbLcadVxolHbNT
         0szTxqxhlaeoiGdOEyS2k+HVkZ1BriO8/9psa6BF0QOiCOZfg9zLH6Ns48sWtkt1sbcJ
         OtyL44P6zSQXwbqcrYKGREIKoEfK3W+P9TRxvZ2LgAwpLtICnHCTcP5v6V0gSQwfY21R
         EgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695161620; x=1695766420;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qu76Z2RZiqArPHy9LupMU2CWA64nk07OmRJSoxU2ig0=;
        b=rgse0SacO4vJwgC/uOUNK3f440nUGuYCLTyStFHbJg44WpraocvMWqK8P6pLDeLfT+
         ByNXYDk1UIBQuoCkG7IG5sNIg+vll9iw8JHgTc7TC31V7pVLb841BhgJdvlkdVPV2hus
         rmpQK7ZORaHmmjSa9mrqTuSqafA3nODnoF0zrA8ZUdo2F529qW7pPSZ46/+8UL6RzHQG
         ZPp/6NDPH/GPFuk3AQ8SL1YVuRWQ7jtq6CM42A38Udx+G7mr+fQ1kr1xbesoJjsfRZNS
         zP4xlpW3cC7XIHrCQQZpo7HYEod8rTFNfuLzr/Q7Tn90BRCeOEXWQsSwFFoqHVYJKNOw
         Dz/Q==
X-Gm-Message-State: AOJu0Yzf93vOgAcCJUgyKxR1aHOqIOBABBAFCpN4vb5chQK4puAdq0h5
        RQBDXcgolwd3AxmKNlzexPjvtk+oy/0JIgnbtsN/
X-Google-Smtp-Source: AGHT+IGtYKqkyfF5mblFNaVgynITGGRUoCmSOAssvyrPQ6u9a/cRmqG8HkRJGXpXPeuNSwK+O4GGCfQKQkDfsW/bcW3D
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:def5:f709:d6a:7375])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ce8b:0:b0:d81:503e:2824 with
 SMTP id x133-20020a25ce8b000000b00d81503e2824mr11660ybe.10.1695161619815;
 Tue, 19 Sep 2023 15:13:39 -0700 (PDT)
Date:   Tue, 19 Sep 2023 15:13:37 -0700
In-Reply-To: <040766861e21afe5f686299560677e429be11844.1694125210.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919221337.2177936-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 05/13] trailer: trailer location is a place, not an action
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Linus Arver <linusa@google.com>
> 
> Fix the help text to say "placement" instead of "action" because the
> values are placements, not actions.
> 
> While we're at it, tweak the documentation to say "placements" instead
> of "values", similar to how the existing language for "--if-exists" uses
> the word "action" to describe both the syntax (with the phrase
> "--if-exists <action>") and the possible values (with the phrase
> "possible actions").
> 
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 2 +-
>  builtin/interpret-trailers.c             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 72f5bdb652f..b5284c3d33f 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -117,7 +117,7 @@ OPTIONS
>  	and applies to all '--trailer' options until the next occurrence of
>  	'--where' or '--no-where'. Upon encountering '--no-where', clear the
>  	effect of any previous use of '--where', such that the relevant configuration
> -	variables are no longer overridden. Possible values are `after`,
> +	variables are no longer overridden. Possible placements are `after`,
>  	`before`, `end` or `start`.
>  
>  --if-exists <action>::

Not shown in the diff as printed in this email, but this option is
indeed documented with "<placement>". Up to and including this patch
makes sense.
 

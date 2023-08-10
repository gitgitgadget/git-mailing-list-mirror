Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC38C04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjHJUhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHJUhf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:37:35 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4823C2733
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:34 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5841be7d15eso15418097b3.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691699853; x=1692304653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BmYK46Bf5WfWQL4czvtv9xi+3fS2QWhkWiMlQ3eHxQ=;
        b=F5V/Ivz2KYFkh6Eir6VUaGf8L8QHkuyfIVcaZCH3f2S/1aVkX0Hjcu72iTQsXHNj8a
         tZ/t/oAoPrE2bT5svv64LNvI7id4I8vvI8i8Rdwwy6WwZO33v5XdCc1YyXULwmkZaAqT
         i4KgeyU3YvU5GxqIKrbpJH3fP79jFG5PaHS56J6KArvOvptiayoG0euXBejOxSP/yx36
         v2klEMxWpPp937rYxwSgfPGVlXfez92EmXmBAAechrB5tJaQN7Jq8JNFJniTJNnPyxee
         /7tBjhKyBEW0HDlXi9UMCRd683qjf0jnWYMijZRHOqB1qMYPNMidjuESiZGgDNB6fp+6
         Ga2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699853; x=1692304653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BmYK46Bf5WfWQL4czvtv9xi+3fS2QWhkWiMlQ3eHxQ=;
        b=HfHknguj5oJ7N1txIQ9wvzYjj1Yr/z7qEtDeQMraRopdFqfgzAiTwnv6sY9uiikmN9
         LHcvzEMLznZUe6UEZb2DPGDdQYU6nlvWTGKTa3x9l0ZN4lF8F/pcbUgZnxQh7E387Pie
         itdZ96jvUhCxcQ3jSMv+HgRmztWLQKj0QcRdAVgOciT/jO5FRh+QHq5EXo/Y0q5rge6G
         rwVJSfvBlaxP84t67qQHLbGME46DwTYuTye23/2kQ6WU91fOJoO9eFFOnEloap5sj7PH
         7zWRFZlMV7ceYPEO+8gepfPGuEVNRnscD/Gj3f10URVEAHzkMgTJAQVT7D7ayA8BAslj
         k++w==
X-Gm-Message-State: AOJu0Ywf5HFmg8BQmYd1hKE+XjESLyI2xyTp5hUqY2DriC0WGGtmCUdJ
        cHsBMSgqMu7asUlEGMAF/eQRNtyRxXz8pZoS2HgITA==
X-Google-Smtp-Source: AGHT+IEs8vDqcTmIi2oySnsRvXZeFgs9DjnJCpbYTkYr/Yosmw/DiIEbFpnKjEjMEhBjIpzST98lyw==
X-Received: by 2002:a0d:f405:0:b0:576:896a:dbc5 with SMTP id d5-20020a0df405000000b00576896adbc5mr3965867ywf.48.1691699853249;
        Thu, 10 Aug 2023 13:37:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f184-20020a0ddcc1000000b0057a44e20fb8sm570698ywe.73.2023.08.10.13.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:37:32 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:37:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 0/4] commit-graph: fsck zero/non-zero generation number fixes
Message-ID: <cover.1691699851.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNUiEXF5CP6WMk9A@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series expands on a patch that Peff sent earlier in this thread to
remove a section of unreachable code that was noticed by Coverity in the
`verify_one_commit_graph()` function.

The first couple of patches addresses the main issue, which is that we
couldn't verify ancient commit-graphs written with zero'd generation
numbers. The third patch adds additional tests to ensure our coverage in
this area is complete, and the final patch is a cleanup.

Thanks as always for your review.

Jeff King (1):
  commit-graph: verify swapped zero/non-zero generation cases

Taylor Blau (3):
  commit-graph: introduce `commit_graph_generation_from_graph()`
  t/t5318-commit-graph.sh: test generation zero transitions during fsck
  commit-graph: invert negated conditional

 commit-graph.c          | 23 ++++++++++++++++++-----
 t/t5318-commit-graph.sh | 18 ++++++++++++------
 2 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.42.0.rc0.29.g00abebef8e

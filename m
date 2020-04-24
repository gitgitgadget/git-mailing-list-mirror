Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A54C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DA52071E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=envato.com header.i=@envato.com header.b="jpqbNo+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgDXAXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgDXAXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:23:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAB1C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:23:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f18so8116576lja.13
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=envato.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=5kkeeyuQ4qBaZXp8ykLq0aURzkgvf9AkmTmk8HASmTo=;
        b=jpqbNo+CoVqw4sT5F71vW1Bu8UHmSktwK9S6vo0D6rCQ2wInQ+vwoOzjlankJTI33O
         oG2dmMmVHNvE+M0n8rwsj27CQyeknkqGHOnw2uDJcDXtLiti04HcM+yESKb9Wn4oX9Ap
         YW1OOKLxlV6cIooS9C4KOTzU2i2EqpK49cBpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5kkeeyuQ4qBaZXp8ykLq0aURzkgvf9AkmTmk8HASmTo=;
        b=Jfo8JFHWjHTNZh6N3qD0mM5YI0toNcnbSus/rLdCdU094aWXsxSnN01qAWUlP0xkmP
         uCpZkE0c273S8evinywx/N0BYbRalQDWSirs9NKw/ptKtmJDtw02cXSsrQY3shYFWkq6
         J0a3oQ5DHXjsYA6yLZAOoaZdcdyN0jn4ToeA9P08QfG0FWfCFu7w36uN11aUkroSfhT3
         AhBq3CQsqSJ4FROiK38poaS9qdF7Ueb4OXSEz9n9irAgqqCBv+/tSCZ/uuesHOsgQw/B
         g0/xPkH6lJT4UDHfFH2ISXCS/NASWaz9VPlAKziODl5TEgVkuOi/ILpgRpT/kEr6cxHY
         b6WQ==
X-Gm-Message-State: AGi0Pub5x+lzkP3u0SU25ywfnS5hWAqoslwJAlpyxkFmEe+4snSXKAPO
        R79hXT4V7xMVTeEjmzOlQgsAfu5P02fKqQCQGK/hyzN1VKbVlw==
X-Google-Smtp-Source: APiQypIhbZCw3vxQuuU28StsW4WuBk3us2qTAB2jXSVwRL1yRZQJ79+Zy6dh10Mk424SWCVFr6G8Vi4XnXYN4Le48g4=
X-Received: by 2002:a2e:5855:: with SMTP id x21mr3954610ljd.75.1587687793184;
 Thu, 23 Apr 2020 17:23:13 -0700 (PDT)
MIME-Version: 1.0
From:   Stan Pitucha <stan.pitucha@envato.com>
Date:   Fri, 24 Apr 2020 10:23:02 +1000
Message-ID: <CAJ2_uEOk8xoLvK8B8PYc0_=kA8W_LqKwGyhKghemQDdRzA2nFA@mail.gmail.com>
Subject: Bad experience with gpg signing failures
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,
There are two issues I keep running into with gpg signing usability:

1. When gpg fails to sign the commit, the error message is not
forwarded. That means you always get "gpg failed to sign the data"
when the actual gpg error is for example "gpg: skipped ...: Unusable
secret key". This makes the errors hard to deal with, because you
don't know which command actually failed without GIT_TRACE. That's
especially bad in case of transient errors.

2. When gpg fails to sign the commit, it's not reported where it's
available. I found that it's possible to recover it from
COMMIT_EDITMSG from man pages, but it would be great if "gpg failed to
sign the data" message was followed with "your message draft was saved
to .git/COMMIT_EDITMSG" to make it more discoverable / not require
reading full manual to find out about it.

-- 
Stan Pitucha


Site Reliability Engineer at Envato

http://envato.com


The email and any attachments are confidential and may contain
information that is exempt from disclosure by law and subject to
copyright. If you have received this message in error please let me
know and delete it.

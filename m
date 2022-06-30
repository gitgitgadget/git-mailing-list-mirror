Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A0C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 15:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiF3P2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiF3P2A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 11:28:00 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1159F3D4B5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 08:28:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u7so7813292qvm.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=dm0Kqj5Ic595mDPXP8WjVHfYFQfyGMFGyyos4RLvHq8=;
        b=SFIjyejDsfTZUJ47AWlYp++XHa3hNxjRYyifIM2ThY9qKbtK7aJRtMiAJlWgpKO5UT
         ZdK+AlTUnwRNAlmXf2F4RnP2gpNXd6TKNG4u+k2kYlr2g/fGAWH5VN8zxpwLfvirO4Ir
         0Wv0btaO3FxM4IcC9BqvUgc4xhktZwL/kide4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=dm0Kqj5Ic595mDPXP8WjVHfYFQfyGMFGyyos4RLvHq8=;
        b=WK+CXaG9dVuOLgbUvj1G3lXAiA4a7+BbxM2wBdGlnnQdJ9yoACeN2oVc2rciizjhAL
         tLk6DukM//y8cTePyfGxAOYt7jWxELENGxmQELXB8XNeTuZsFJD2uPQwZwEwtra72ANe
         QHy3OsbMN/t6NAMNrO+Tvsan321VYtUJJDJ6g1zFsn5XDg7IbVLIvtre0e86svBSWOi/
         vW7PUoFRPWkOuPaJGbCX1kDZXY+bH21ZpVVYrDzGl9pl3SqZPqI0GOMTwFFTKYH4kYjU
         Jv67iBT88GXcwVtjIoiex8+FRH3lvko4hTHFb1vTrngUQNoILIZo+ZFvja1+/lLZSxJU
         w/nA==
X-Gm-Message-State: AJIora85rJ5q/dxFgowrL+XsLmACTPODxXOejRVUA3iEOci1vxXKqece
        JzAKZ1IIUoWYpskyxp7Dwa4Yz8ju47VnGQ==
X-Google-Smtp-Source: AGRyM1u2hn5nmNqZgBY0iN4o0N8ZN7x+ai0qEI/NbB56cixQQfB5UDXjajlb4BrjR8Y03TycJySW4g==
X-Received: by 2002:ac8:5dd1:0:b0:31d:34db:e0d with SMTP id e17-20020ac85dd1000000b0031d34db0e0dmr184764qtx.592.1656602879008;
        Thu, 30 Jun 2022 08:27:59 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a400f00b006af147d4876sm13534443qko.30.2022.06.30.08.27.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:27:58 -0700 (PDT)
Date:   Thu, 30 Jun 2022 11:27:57 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Non-interactively rewording commit messages
Message-ID: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, all:

What's the best approach to non-interactively rewrite specific commit
messages? In this particular case, I am trying to automatically retrieve code
review trailers sent to the mailing list and put them into corresponding
commits.

For example, I have a set of commits:

abcabc: This commit does foo
bcdbcd: This commit does bar
cdecde: This commit does baz

They were all sent to the mailing list and a maintainer sent a "Reviewed-by"
to the second commit. In a usual interactive rebase session this would be:

pick abcabc
reword bcdbcd
pick cdecde

When the edit screen comes up for the bcdbcd commit, the author would manually
stick the new trailer into the commit message. However, I can automate all
that away with b4 -- just need a sane strategy for non-interactively rewriting
entire commit messages at arbitrary points in the recent history.

Any pointers?

-Konstantin

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732C7C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJQRKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQRKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:10:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3D01D0F6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:10:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so10476197wmq.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:to:references:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfQF+861c5DCdyngHyqZvkIOLC2gv8070Gvcc8Er9Ts=;
        b=qUOlsmNCbwC8+QjTJy4rmFnkLNSNXN/N4d8cRQCXAkoB+D2hKeDCIPKXmLMtbETFmO
         MrqcDJd6kLR6botaEWu6tEDiBFLOuBC13i/ZnB5gP0agEMImpON6JcsIVHQ3WT44b4CE
         D6UHul8CGGj9r+zBiP4klDKe6UJZHHn6QH0Z1kUVLnBNB0s6sWJfdKDC+vj4Xb3XKgS9
         jNAIbkmPkhyPsyXepg2Cnqt+R9xMpyYiinIWNosai3rSgsnVYyDh3gocUKu6THrqY73Z
         xDALzoS31glkZd8RfYz1TKCxbrnJcOiX5EePMl6B7u+QyL+c6oQ/PN646NctJuJgp8uG
         TJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:to:references:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfQF+861c5DCdyngHyqZvkIOLC2gv8070Gvcc8Er9Ts=;
        b=7LG65iVHgcdW5gesLw7McqTM7CeVj8axh0EZD4+fvBXzREKy+qoi6tjFu+iPBSRkcO
         pOj7bbJ6hHPEzo9yfaqFBLz+Tmy+az2lXTUuB5g8tD9jA+hHv/jRMjU6h6eUTNxKaiIu
         LmIxC8DJBmCEuTtA6QCYDILGp3ujrwUVkulVCHI76O8uQzWSE5mk20HSnzfzNDp9/GHs
         MhtNCsMcdpXOwPoBwnDTOTpO+axM3r/4nNR9mCuryTH3NJnjQN5KkuK/oHsOzC0ZRyCe
         kUZjiP8gQMyhR/rou49QmNNELzNtaK2Wt7VUMT9l1S2LPH8ogRR9WQ9p8z+nfGPHmroB
         8IiA==
X-Gm-Message-State: ACrzQf0jxey7prc2vWXugenYtm3n52j7Glo8nzpZyVHXPyTbJFIz6Mga
        yWAILXxSm14jQH2Qt2gOdZEOGNQTV3U=
X-Google-Smtp-Source: AMsMyM4C7QgefXE0bHBzV/BcJZJNG+EIqJnCKZDw97z1gfTM3thUWl/ZtWIoukvv4LlVpN23yS2A8Q==
X-Received: by 2002:a05:600c:3547:b0:3c6:e224:79b6 with SMTP id i7-20020a05600c354700b003c6e22479b6mr8341748wmq.188.1666026645501;
        Mon, 17 Oct 2022 10:10:45 -0700 (PDT)
Received: from smtpclient.apple (2a02-a444-ebbe-1-31d1-65b8-8bfb-fce9.fixed6.kpn.net. [2a02:a444:ebbe:1:31d1:65b8:8bfb:fce9])
        by smtp.gmail.com with ESMTPSA id j18-20020adff012000000b00228fa832b7asm8812778wro.52.2022.10.17.10.10.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2022 10:10:44 -0700 (PDT)
From:   Paul Wagland <pwagland@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: git gc error with git 2.37.2? (Introduced in 5a5ea141e7)
Message-Id: <2C46C994-6023-4C69-92DF-73291A6AF94D@gmail.com>
References: <ebb035c1-d313-4f8e-b850-a6e11eeb374bn@googlegroups.com>
To:     git@vger.kernel.org
Date:   Mon, 17 Oct 2022 19:10:44 +0200
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On git-users, I started a discussion(*) about a git gc error that I was =
getting that started with git 2.37.2. After some followup from Mathias =
on that list, I have determined that the issues that I a having started =
with the following commit:  https://github.com/git/git/commit/5a5ea141e7 =
("revision: mark blobs needed for resolve-undo as reachable", =
2022-06-09)

When I compile git locally with:
   git checkout dc8c8deaa6
   make
   git rev-list --objects --indexed-objects

Then it works.

   git checkout 5a5ea141e7
   make
   git rev-list --objects --indexed-objects

Then I get the error:
   fatal: missing blob object =
=E2=80=981d0f34d1c4314efcff527847755e4ccc77d44fb6'

How can I further diagnose how to fix this?

Cheers,
Paul

(*) discussion on git-users: =
https://groups.google.com/g/git-users/c/MKpmgpSC7xw/m/R5rLYDxJAgAJ=

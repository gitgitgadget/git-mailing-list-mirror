Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B855DC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A99206D5
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDz7wRVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbgKXPUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbgKXPUC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 10:20:02 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76FC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:20:02 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id y197so20715315qkb.7
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=04TslhbIDQN980fFO6aVxT3gpIaPkBxvcCHKcecw0Aw=;
        b=DDz7wRVILqMPyBCE28BU+PuQmu0bvHVtXCOdFHgz7Yd1LHEHJXiv2VIOQgEG8fLmfH
         mxTjpeETS5jYpb5kMKV96fOKQwXlCthPM0COPByqzgipvNEd+XAfVsC6PEYIyNP+487a
         BZG1l1/EPI+9rf9uNSwUfwkdLnpMIXG3lDM5wSpFAdFKNSxadBKcTBfY9cKA30fJhXg9
         4nFRV+HU5rr0hLVJYyR7vx6UY5xp0mv7fi2ltm+1IOursXiYQXsj8K37K5IgNzbDmwcz
         93OCjdLOZCRBFK8/yc/U3t8eF/ZMkwIVBN0sd+KIyUYsLFynf5UIK5CuOZZuCnwoQHfQ
         HGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=04TslhbIDQN980fFO6aVxT3gpIaPkBxvcCHKcecw0Aw=;
        b=cvm4r7WJ89twazZrs2j91isvakOU7BSnR5BLEa8uyD/QTjddy8wFAATn0Ni9BavMij
         YOdwaahjjgJG2bzOl7l+73rR7FSJE1Qnvh2AJN9VpmaRhtvkBa79cc16FI9L/WbX89iy
         yqlra+JdfO7j/oehrJTMZOdNvLfRFoWbIDktqPxFBdHYEM3+Yr69ZtxqPYhPQYT+RwWB
         a5DxzbN8aIeMx7Y7yTSlYi1tpQSQRgvu8OZaQxCO5ZcQh1Ph6EASgfoBdN9flVp4W7Y6
         d5NVEvl37436bLFE9wIXLTFbY0XbYQJdYlEQeyTF21hrbiTyg+BJxpWYdZ/kWKsQz7tS
         fWHA==
X-Gm-Message-State: AOAM531D3bIiHu01bWnK6I8COxmeK+eqkeci55EjELS2Kg/RcuUGlnZl
        asULinn9KJYVMOPSxxEoaGQ=
X-Google-Smtp-Source: ABdhPJzdt0NMoFDVptFfopTDPzfnh77eOB8X65LMQj2X6RJcNskbxTry6/gsBDngOVNf/U6Ml/WO7A==
X-Received: by 2002:a05:620a:7ea:: with SMTP id k10mr5093600qkk.292.1606231201708;
        Tue, 24 Nov 2020 07:20:01 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id e126sm3641631qkb.90.2020.11.24.07.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 07:20:01 -0800 (PST)
To:     git@vger.kernel.org
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        Dan Albert <danalbert@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [BUG] git imap-send does not honor 'core.askpass'
Message-ID: <76d2be10-0c42-70f4-101c-ee15e3039821@gmail.com>
Date:   Tue, 24 Nov 2020 10:20:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I've just noticed that 'git imap-send' does not look at 
the core.askpass config variable, because it does not call
git_default_config. Setting 'GIT_ASKPASS' in the environment
works, though.

I've CC'ed people that seem to have been involved in adding
credential support for imap-send (git log  --grep credential 
--grep imap-send --all-match).

Cheers,

Philippe.

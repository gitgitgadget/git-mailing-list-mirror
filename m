Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D6CE94139
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 00:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjJGAu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 20:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJGAuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 20:50:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A710C5
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 17:50:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso3861341276.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 17:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696639854; x=1697244654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pX8j54s/jhaX0Pk3pXjNF98SkQjlXHHdZdaaLIDenHw=;
        b=j/aaLVP/KOoT6y7WlMn6GWlqnkmXNvFLNxjsFxBGogj8Vq14sAYup9FIv5/6L2El67
         S8jImIRW9CHkO7Fuw1GRmPJwpk8ixoLzVyavZlCx9Lfk5qUCPNN7V8p57fUxZ7z+E0EL
         Ig9G7OUUPAle6cm4zzfhyZMcaAWSEP37yPirEcL9vDn+9Ut2DCg1GAu/gVX0PoAGCZLj
         5WhYlgr1dJpMes8tmhh/RlUglGY6UDrBsF5VJKPfgqGUaXigkg1yqx5vocSEs9T1DXzJ
         VtOfRKv4f5O39lkTrKYXGMHg/+n7roS+rZ9KaelULDZoAA4zH8HR3CKtq6AnGJgoqa9T
         +mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696639854; x=1697244654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pX8j54s/jhaX0Pk3pXjNF98SkQjlXHHdZdaaLIDenHw=;
        b=TUrC9+eeJG8KwPjXE3vz78od3MUZBKgjG+T2ASLtEPVVwyc2jQwVd7OxHJiuFzk7kU
         i1mhwT9qnxWbzIw8z/1/IYP1hB8HFNGcpB/ERH17iI7H+RYBy6RMHRb/e3UefRSYoYfH
         fCk0rn4DHy535IJPqF7w8gZ3zYlJ7zfFCegiDtxL+H5TGG5bt6TVIQcIii7E8FkHy4f+
         5fzb7E6z4pkMEX+qIkqOQOPx3ZxA+S56d6kc0phXwwOZpbOSxlHpZ7BTyKCgkoQYFKH5
         oiMLmnr3IyhjQEjbXOZkGCwMaiW16/PUhVbl9Qcf1srWZWSzWyzMF/dWF3ORmHpa4Y6m
         CkhQ==
X-Gm-Message-State: AOJu0Yx1dGFSe0HH+ebdLLY0aTUTM2xjUlmukZM6gnE8br+RZlChhWPu
        g4QVk+0ukszDblT8kS41Or5JOXsz6w6Q
X-Google-Smtp-Source: AGHT+IE19N4G8DzlUvXYi2L/Turxl/wxOfAGjscfO5xXjHOVlih7lu3qK+EGGitHOhPcrQewq8wdeZ1xh2Ox
X-Received: from jojwang1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3b1d])
 (user=jojwang job=sendgmr) by 2002:a25:9349:0:b0:d80:12c:d49b with SMTP id
 g9-20020a259349000000b00d80012cd49bmr169075ybo.8.1696639853788; Fri, 06 Oct
 2023 17:50:53 -0700 (PDT)
Date:   Sat,  7 Oct 2023 00:50:42 +0000
In-Reply-To: <20231007002811.2337315-1-jojwang@google.com>
Mime-Version: 1.0
References: <20231007002811.2337315-1-jojwang@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231007005042.2997590-1-jojwang@google.com>
Subject: Re:[PATCH 1/1] add: Enable attr pathspec magic for git-add.
From:   Joanna Wang <jojwang@google.com>
To:     jojwang@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>+test_expect_success 'check that attr magic works for git' '
>+'
Sorry, i forgot to take this out. I can fix it in the next pathset after
the next round of review.



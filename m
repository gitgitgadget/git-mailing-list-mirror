Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF60C7EE23
	for <git@archiver.kernel.org>; Mon, 22 May 2023 15:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjEVPo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEVPoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 11:44:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F4BB
        for <git@vger.kernel.org>; Mon, 22 May 2023 08:44:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-3f607766059so8151545e9.3
        for <git@vger.kernel.org>; Mon, 22 May 2023 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684770262; x=1687362262;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WD8E0f06ablgjcVUmI9ch+QB6ddLb4iHDcSMHRjcDPo=;
        b=YTJ+3SxgHLFIGjJlILk95poW4uCS5HbYZfazLcFexrD9UPxZRRbiuvlKPCWqLjrzCL
         Luwu+CL/Uh1fCngpmFHx13D7HNbisjCLqSbqtdPAldwSTkhIR4ksLodgq5qVlBWk8w/p
         IuNW42CghBhfXnKOn1Eg2UGTvsCFK/z1TCMglre0oxzrgKrm2bE9Y+W8sYPQr/IutRf3
         r3l5QwGPYM3ZjisK6OxZWor3XxJqY76820ceePIAVOQssgUziHC3YR5BcBktHyZZQuu7
         3cPf9oLX+bPngUJ1lsW8vYNEZuhZK9YZ231FFjgQbbwbeV0IYLMr9rwbYFh7ti4lVIlL
         LjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770262; x=1687362262;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WD8E0f06ablgjcVUmI9ch+QB6ddLb4iHDcSMHRjcDPo=;
        b=QSgzCeFsbYPf4GjZHG0CEsCe/3ndPsYyL+jmx9ptRnCoGouC7j76RIHl/2ZE/rZ0Pn
         hQcVtwgMf6LI3Wdh8q+QnDPsCQ8LySJlpG0DXmjDW5tAHIDQiQZ3f+OlApXeKvtQzKc8
         9fB63oArmjB4+gHbevm7cdwqNBDaZKbt1jWVHkme7kA1ASjrTaLzdbk3QgB9OR+CWEXD
         9HwJK6SEMc/gA0KGGsj5OBjd7bD/btGYHUCM5PUYyU6gZBsV712pCVPKy4fVDW6XUgHt
         9KOuXnylh8MXWHFobuDXEzgk3TWD1kBux0RotQPrhJNxc31somaAtARjlXiZFQzALE5T
         mNDw==
X-Gm-Message-State: AC+VfDyb+IUTQdfDjQie6qvVUUu3DYgqL9BmOErdhe3zx1Zv9t4++cNn
        cuLYjWNs35Gf+hLMpna8oXTUhVn5HUglQlqjzYKQ4if5YXHm25GD
X-Google-Smtp-Source: ACHHUZ7PfqgrTT0yLQXntPZTIMK2okaQYrkXXOfDNzBaHet2eketF5TWD6FMNs6JZSgOyV/LmywiHy2Z3SDX9M3ld3Q=
X-Received: by 2002:a05:600c:2105:b0:3f5:fc88:dcb9 with SMTP id
 u5-20020a05600c210500b003f5fc88dcb9mr5277520wml.19.1684770262157; Mon, 22 May
 2023 08:44:22 -0700 (PDT)
MIME-Version: 1.0
From:   Iakov Nakhimovski <iakov.nakhimovski@gmail.com>
Date:   Mon, 22 May 2023 17:44:11 +0200
Message-ID: <CAM9q8UoE5OGLkZ7MduXqWjxyGV7xNFBXsEbaYG1H61zZ9AO_XA@mail.gmail.com>
Subject: fatal: could not fetch SHA from promisor remote with git 2.40
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!
We are running a Jenkins server with a number of worker nodes both
Linux and Windows and have recently got a problem on some of the
Windows nodes. The following git call sequence:
git clone --filter=blob:none --no-checkout <internal-gitlab-hosted-repo-url> .
git sparse-checkout init --cone
git sparse-checkout set <list of dirs>
git checkout <sha>
and then after some commits when trying to reuse the working tree:
git clean -f -x -d
git sparse-checkout set <same list of dirs>
git fetch --filter=blob:none
git checkout <sha_new>

fails with: "fatal: could not fetch SHA from promisor remote". The
"SHA" in the error message does not match the requested one.

After googling for the error message we found
https://stackoverflow.com/questions/75514869/cannot-rebase-after-fetch-fetch-says-fatal-could-not-fetch-sha-from-promisor
which seemed similar. We checked and confirmed that things work just
fine with git 2.38.0.windows.1 (and 2.35.1.windows.2) but not with
2.40.0.windows.1. Downgrading solved the immediate problem.

Now, we could not find any other references to the issue and unable to
reproduce this in an isolated environment which is worrying as we
would need to update git at some point and would like to be sure that
the issue is fixed by then.

Question: is this issue known and tracked somewhere in git development?

Appreciate any tips and comments.

Best regards,
Iakov

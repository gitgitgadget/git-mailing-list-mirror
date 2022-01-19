Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4947AC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 17:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356556AbiASR6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356548AbiASR6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 12:58:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9271C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:58:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so7299549wme.0
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=12SrSG1uetFuLuyQjU3lG6aYOXIgNNKTgOIRvvErHsE=;
        b=QfLjKJeqyDbqEbi2Fp4B8pXeSFeF7ojrvwBq+xUy1FBy6gsyrE1a6NgmeolTHq5b9k
         htv3SV9NqsMAFyRmziLfR5HuImbonjPS79j9vUC3R0OtZPdnabtDwX3kUTebwlVF6bED
         mlGC5YG5k5ux8gbZAjX+jnHpua8eOrgDmqCZv5k/Nz7hbkopd03matecCfP3u3saIWVd
         OeVR2dksyEPxEZtxDK8WOCW/Cyavuz8ErHky3zIZkKBMlnb3StD19zn3PHedbpFIP/ZH
         uwOR9itOk+UPHrJS1MDWGkpxHiXHdwskM4VdUvlaRbtRP3bwl/IREZmsCdEE610+6CLa
         D64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=12SrSG1uetFuLuyQjU3lG6aYOXIgNNKTgOIRvvErHsE=;
        b=Max6EB4v9qHyfvRlY93Jmi3UB6H/nW+K8SlXje7/uLx2APMJGugUq6C8iyDd530Sfw
         i9xdpTMeN2DtRc8RNDo0e4S96Vh25FbNWIqx/hEGnqDAprs2xXFw2sU09mkAZHu3a+dS
         +ggrT9+3oFapWU4NCQdmK+/icuZaDXklG4aSxZOlTZNHYmKjwMo4wsxygWtri1SufTtd
         r40lBm8wkSFICgD0SNVXN30Sw8FogcV6JOcPkGkyqE3kl7pKa9R11BcI7NwKch9AFYYo
         sIl2GAjPLJf3S+MIx+nG/UcqVUsr7TTR/8ErwZ84hKT5FqEoToq5Ooxz7XHZcHOx6nuz
         8fSw==
X-Gm-Message-State: AOAM533MQrOjVNXsuxrGzoxhoS8YUmeJ1uxBQwLKWoEZGzYpEvCBGgfp
        ahQ6VXty9TsQnqSRkpVtdF34BS9/UJk=
X-Google-Smtp-Source: ABdhPJzE12iBYIkFOg4HehDK88M08Bm6sl79BY0oAqNMMk0eby/jlE6gj7i02QLSITQKCOhtrUCWrQ==
X-Received: by 2002:adf:f312:: with SMTP id i18mr29392279wro.589.1642615124406;
        Wed, 19 Jan 2022 09:58:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm407161wrr.97.2022.01.19.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:58:43 -0800 (PST)
Message-Id: <pull.1191.git.git.1642615122.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Jan 2022 17:58:40 +0000
Subject: [PATCH 0/2] cat-file: add a --stdin-cmd mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This WIP patch is mostly stealing code from builtin/update-ref.c and
implementing the same sort of prefixed command-mode that it supports. I.e.
in addition to --batch now supporting:

<object> LF


It'll support with --stdin-cmd, with and without -z, respectively:

object <object> NL
object <object> NUL


The plus being that we can now implement additional commands:

fflush NL
fflush NUL


That command simply calls fflush(stdout), which could be done as an emergent
effect before by feeding the input a "NL".

I think this will be useful for other things, e.g. a not-trivial part of
"cat-file --batch" time is spent on parsing its argument and seeing if it's
a revision, ref etc.

So we could e.g. add a command that only accepts a full-length 40 character
SHA-1, or switch the --format output mid-request etc.

 1. https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget@gmail.com/

requires ee4d43041d ab/cat-file

John Cai (2):
  strvec.c: add a strvec_split_delim()
  cat-file: add a --stdin-cmd mode

 builtin/cat-file.c  | 128 +++++++++++++++++++++++++++++++++++++++++++-
 strvec.c            |  23 ++++++++
 strvec.h            |   8 +++
 t/t1006-cat-file.sh |  72 +++++++++++++++++++++++++
 4 files changed, 230 insertions(+), 1 deletion(-)


base-commit: 00780c9af44409a68481c82f63a97bd18bb2593e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1191%2Fjohn-cai%2Fjc-cat-file-stdin-cmd-mode-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1191/john-cai/jc-cat-file-stdin-cmd-mode-v1
Pull-Request: https://github.com/git/git/pull/1191
-- 
gitgitgadget

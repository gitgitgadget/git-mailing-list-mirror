Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476F620986
	for <e@80x24.org>; Mon, 10 Oct 2016 13:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbcJJNm7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 09:42:59 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34476 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbcJJNm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 09:42:58 -0400
Received: by mail-qt0-f171.google.com with SMTP id q7so53828646qtq.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 06:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=I6dUn9PYMF+K9t4xC3bhIiEwbf4NZYoIFWaeuUVW9Os=;
        b=JMty0Ccf7SQoXL7h0vvqFh8k2+g2dhbMjiFIfPldwtbr2P3oZ3v2XYduP+wBV8Ezd7
         NtyZoSM4T12ictGAXfN78Dzmyo6bH5eQgvM1pRCFGt//auD2BV5vuL6VxbwgYiAgzMlV
         rCIK7ULXwaOXciYMkmBDcyrGeibElHb83Z8qzhR2QtpXx7VKkEQjyNq8X/KhsspaGjg6
         p7Rur2G0yNWDWj4j86NmtN/SK2Xgur957lScYbJIFnaniowxiIAckFc8Z65inSz9Bffv
         jUdjUUWFwMCGxlXcODLjZNN/ChlWy/D2Z1bqm5fOP5KAc9gWRIWxV57Y21XlvKejyHFj
         48jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=I6dUn9PYMF+K9t4xC3bhIiEwbf4NZYoIFWaeuUVW9Os=;
        b=fKAisvANpn1a9zhLhl3nwrPWSdEn7kYAqZKODpPx9JjD3uXF8HzYyN3UaQyQtyG3QM
         4RxGsToMvIolsHX6yiS0Azy2VikMc/Dhb5Zz2hPJJxWrqmwyMvbRoAwlfk5Vj8J0qgLS
         9wY91cPel8aKBUZRMKOCx12QaSxlKYga7GdsT2+e6YktO9mBmZTs/4emkAqPQAYE/GGo
         X1pCcBWFAVuK2RbCxGwQp/gIA0KtA7LAVUEJTt8pg9MEGA8RQoGTj2+4sC21t5Y3bACr
         P6PavYz/Ae+R39xO6OCLtrRDq7M5wKt2d5Ee9OeG34NtVMH51OY4ZuY47qxqILbHMwJs
         Fx6g==
X-Gm-Message-State: AA6/9RnlryM09BySUAQB4PX9c7qCxYFqxVKrAw4//mqcV45SzSu+gqz/ZyTV1LT6D2Fu6Ffojoi+O6Fz7x0h8Q==
X-Received: by 10.194.0.205 with SMTP id 13mr35518645wjg.87.1476106956603;
 Mon, 10 Oct 2016 06:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.236.135 with HTTP; Mon, 10 Oct 2016 06:42:36 -0700 (PDT)
From:   Seaders Oloinsigh <seaders69@gmail.com>
Date:   Mon, 10 Oct 2016 14:42:36 +0100
Message-ID: <CAN40BKqPdPP2+K4FBzgDDfYiGkzk1gYcOeP==_t+pr5w0rj0EQ@mail.gmail.com>
Subject: git filter-branch --subdirectory-filter not working as expected,
 history of other folders is preserved
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From

https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History

Now your new project root is what was in the trunk subdirectory each time.
> Git will also automatically remove commits that did not affect the
> subdirectory.
>

We have a git repository that looks like

sdk/
android/
ios/
unity/
windows/

Which we'd like to split into 4 repositories, 1 for each platform.  To
start this process (for splitting android out), I ran,

git filter-branch -f --prune-empty --subdirectory-filter android -- --all

Which rewrote a ton of history and commits, and looked like it worked, but
on closer inspection had left a ton of history behind.

If I run

git log --all -- unity/

It returns a list of commits that happened in the unity/ subfolder of the
original root.

commit c4ea2797...
> Author: tom... <tom@...ve.com>
> Date:   Thu Feb 25 14:20:59 2016 +0000
>
>     kick off build
>

> ...
>


Which only contains an edit to a file with path "unity/tom" relative to the
root *before* the filter-branch, doesn't exist any more, and from my
understanding of the docs, shouldn't have been taken across.

It's also not an isolated instance, if I run the same checks against
"ios/", "windows/", any file that existed in a folder other than "android"
to the old root, that history is also preserved.

I've just about resorted to running multiple other, explicit filters to
remove all references to those other folders, but it seems like this would
be redoing the job that I understood git filter-branch should have been
doing.

Any help in this regard is greatly appreciated.

seaders.

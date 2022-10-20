Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF3DC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 17:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJTRBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJTRBo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 13:01:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FAE1E09B9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:01:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l4so20847704plb.8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Guz9FIUhy2jOtShw8Nhmr6fDAY76P3ERiqvpqMpHCNw=;
        b=Wa9iKcz/2QwDC/HwIy0obURLqcSWGIaDWTHfXoWvTvLZnTqHlqJpYz7iJq2tJ7GeYy
         Dlt5SH85MpVLFbDwuOjMyFYINXYZClp646IeBK9Jn/XCALY+8Ctwdp1Mf+/FoFmLQBWQ
         DRTkICRYGXNaDfBc8BpSQ4OmRxwyv2DgHj+es9zU1hWe6w3javTQTM6EwZyfYPnwtsTe
         XQMyDm6y+fuE78wbmIw3C3zLqORvMS9V7g7G1CCKHe+2KyOEtjApZVcJxZMHCbZdPIky
         bz9tixEGvxYQSGgh6+CZLXklNhqCmv2ro2i3H5dSVbl37Dd5Mxfp59/DuWV1l7n2uRH3
         7KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Guz9FIUhy2jOtShw8Nhmr6fDAY76P3ERiqvpqMpHCNw=;
        b=F17WEcED/cXR6xOOcBHL27xjA7pA/Pce5MyWu71CjECnnMKceviNpgu01bxNrk+tyQ
         lZHC/ygclcfoljYsQKnoUYeI9Bp7nXoVCvOa9F6uYa7R2on6VNZink3ddPrduawBQvzV
         3HSBFwTltYQgmZXS0IxfskiNpJwF8hRp/Bl7MP/Nc5S7+xYyacaWm0dQppdOqd49cS1n
         otvVypeC5cTUhuC2Dr/DLDS9cQ6IvWM5uERmAIAzhKjarmt4ArxbfyZcKHtfcYRK3JM2
         Zw3pFK9lNuLUyBorVyZWdhydNPVgO5UwqavCs97WjJKG1nXaJVy7Q9LvLMF/XqZIY0Po
         XaYA==
X-Gm-Message-State: ACrzQf2Vw8REmk0RvNah0WyaugIg620VnoCe1xxB2vCAkSBGmiiS0zYx
        vz9jqhsdcqN/8xMiBApdlYUoOSlbAqorLnw8zaqwQ0NU22I=
X-Google-Smtp-Source: AMsMyM5Fo/scw/fbeCO3stsmf6Z5KI5LJ/S+LTvkK8mlK6NBok+dBgjik1VCJjbubLGqpba8v9cq/gYuVE7T37gbqUM=
X-Received: by 2002:a17:902:8309:b0:17a:695:b5bf with SMTP id
 bd9-20020a170902830900b0017a0695b5bfmr14416968plb.35.1666285288501; Thu, 20
 Oct 2022 10:01:28 -0700 (PDT)
MIME-Version: 1.0
From:   "herr.kaste" <herr.kaste@gmail.com>
Date:   Thu, 20 Oct 2022 19:01:05 +0200
Message-ID: <CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com>
Subject: rebase -i --update-refs can lead to deletion of branches
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have the following:

While doing a

`$ git rebase --interactive  --update-refs X`

I *removed* the "update-ref" lines from the todo list.  The rebase runs
as expected and prints e.g.

```
Successfully rebased and updated refs/heads/test.
Updated the following refs with --update-refs:
refs/heads/master
refs/heads/permissive-interactive-rebase
refs/heads/variable-annotations-meta-block
```

After that all refs have been removed/deleted.

```
$ git branch  --list
* test
```

Now, I should just have not used `--update-refs` in the first place but anyway
I decide late that I rather don't want to update "master" etc. and it should
probably not delete the local refs.

Actually, I so love the new feature that I switched it *on* by default, and just
wanted to overwrite the behavior in the todo editor.

Regards
Caspar Duregger

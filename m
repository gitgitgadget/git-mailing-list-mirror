Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BBF51FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763978AbcLSSZp (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:25:45 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36648 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763948AbcLSSZo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:25:44 -0500
Received: by mail-pg0-f42.google.com with SMTP id f188so63617905pgc.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zaDgkuYaRh13OAbWNuDwp9HT1sIgUfHeUrm5HON1YiU=;
        b=sHVDFxEHjxeVWBEgVyDfkorciTL38PBSnKfVxs9KMWzlZjOxT0Z9G08bIyVIYRcnCH
         G7C56KoUAGdrAnklcRODb8B/l3FkDQmHmDr1nMF+8nMaWzmqrBfrcjjuzor/w7k9cu7O
         5TtLZjVuczodHJePaWsr8M+7sSM5G24d0MjOLJT2oGOjiXx8lGfakE0rIVfQCe/jlKv5
         HrT/dAuUqaLXXBENJO1aRCrD8gU7T45ZWJKA7PvkdQUNtfg4K765SLSfqhuH39Lpn/DC
         gxh5oq6Crg5ZG3sV8TA4DMRRcELu8rFIu3GJ5zpPtUJrl/mVRKz7Q5c1W8OLbF3+B5EU
         jC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zaDgkuYaRh13OAbWNuDwp9HT1sIgUfHeUrm5HON1YiU=;
        b=kckioI2yoYVZ9eJDo+MPfTuallGni0E5JsJyLaVkk+jXrzScCdn1gcKqDaXao0IIMl
         QfcDKsazotvmbrxkJI/dVbOOTjx2aCRaQ0KGuIh54vMZvDnPcnyxKTfKI69Ium9h9lqA
         0hTLSSUeLeWJT4aQc1i0HzDqDItQDmZowi0oj2m4QZGaOh6j4DflVMyTjcGuGcmnvHba
         /v93+4+UJJGg3YFgRGaEHdOaMo9WXp8glzFbMM4GYysHvSUGLT+BSGmoKo58smAhKt4f
         2iXRvN1a/ITYspgcarAN319rVyH2bZBlfP/Q8CTwUVj0pMe76w7YRljNwrBX0VU/CoZ/
         1WZg==
X-Gm-Message-State: AKaTC03WD4bRN2k72HgYv6JiGf4bARYUEHHekM9cxa5JKO7Q231aAwS3JbvVWrtt2eW6q1zr
X-Received: by 10.98.13.130 with SMTP id 2mr16435267pfn.185.1482171943546;
        Mon, 19 Dec 2016 10:25:43 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm33098745pfk.73.2016.12.19.10.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 10:25:42 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/3] push only submodules
Date:   Mon, 19 Dec 2016 10:25:30 -0800
Message-Id: <1482171933-180601-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series teaches 'git push' to be able to only push submodules while leaving
a superproject unpushed.

This is a desirable feature in a scenario where updates to the
superproject are handled automatically by some other means, perhaps a
code review tool.  In this scenario a developer could make a change
which spans multiple submodules and then push their commits for code
review.  Upon completion of the code review, their commits can be
accepted and applied to their respective submodules while the code
review tool can then automatically update the superproject to the most
recent SHA1 of each submodule.  This would eliminate the merge conflicts
in the superproject that could occur if multiple people are contributing
to the same submodule.

Brandon Williams (3):
  transport: refactor flag #defines to be more readable
  submodules: add RECURSE_SUBMODULES_ONLY value
  push: add option to push only submodules

 builtin/push.c                 |  2 ++
 submodule-config.c             |  2 ++
 submodule.h                    |  1 +
 t/t5531-deep-submodule-push.sh | 21 +++++++++++++++++++++
 transport.c                    | 15 +++++++++++----
 transport.h                    | 31 ++++++++++++++++---------------
 6 files changed, 53 insertions(+), 19 deletions(-)

-- 
2.8.0.rc3.226.g39d4020


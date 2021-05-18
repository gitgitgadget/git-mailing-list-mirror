Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C718C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D54E610FA
	for <git@archiver.kernel.org>; Tue, 18 May 2021 08:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347585AbhERIvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346712AbhERIvl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 04:51:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83787C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:50:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11so5170624pjm.0
        for <git@vger.kernel.org>; Tue, 18 May 2021 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqwklp+P31KA0cz336D9W4e5wsk6evdJ6WFY3896bZM=;
        b=R1EeAcYS51mtwdrsQlM/h+UHhyufpE14Czz8WvmBxrH/5I3v0WAuLkeKB3da67bl4N
         Gtt5E/5+GfJNyr72FXg+Tsy8S5pRl0VilvLAv/jziQCi2KLGySzuomJHdU4DuQIPKPu7
         vpri49YUTnqr0O+7B+zrotpWp7NpeJkKJNM14nV700clXcNc3jkWB97PCHgslpTIZxgJ
         rhdZFYFzKrdPnCVRJeeOz+pXG1Nj99fFv4eYkvkyMzdBUIKmmhc70nF2Kr1KwQ1SPOBv
         loKz7zogZpbIKi0pMMPKikjJb900pH6OE1cUd2cGsFtO+chHoDFfEvv2iGDIsAlDJow+
         NBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqwklp+P31KA0cz336D9W4e5wsk6evdJ6WFY3896bZM=;
        b=owV5K/JFXZhUiZLK2kKrfvQtg6mBuR6w3Pb5ViPKohLRSUJetyeKQxArU0hW2emz6o
         DtQFUY6WMtSBWpaFnlhl6uj7aj/nDs+nZjA9gA0qAAN8YoGHR6bYMz0P8d9dWxy/PS2h
         Qbz0ZMzHFuDabVH0mYweb/lfpyxXehPa1k2yYQNtO7JRVVjYfyBLkrNWwVsgCsqJPFly
         IxeMOfgifp+HoTwWm01XW8j/+FHceDnFLxwZVgFKCl8pXnQUK0we3PVM5kAqgtcYTYB6
         L9atPq+xFKw1pVC0lhuGxziQ9UtIEb8mOUNaHJqHxNYawiKhrLGc9yIz3j8FlBT258w5
         pXcQ==
X-Gm-Message-State: AOAM531z7ANJBfIOdUBjv2ekFyVgdH/0EEwE7nU86I1tZdL1ftN81gsb
        g0w3U4mPQT74By1acBE3ggZyoiyzQi7nLz7axng=
X-Google-Smtp-Source: ABdhPJzflVsoPwsbpsMSCf6BgptWiZ7LaOeCMBME02ExdN2OFYAqmyImvXvTUBCCpS9gVNKU6TRiwg==
X-Received: by 2002:a17:902:d503:b029:f2:c88c:6349 with SMTP id b3-20020a170902d503b02900f2c88c6349mr3479454plg.84.1621327822455;
        Tue, 18 May 2021 01:50:22 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.147])
        by smtp.gmail.com with ESMTPSA id t1sm12231076pjo.33.2021.05.18.01.50.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 01:50:22 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, avarab@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v2 0/3] packfile-uris: commit objects exclusion
Date:   Tue, 18 May 2021 16:49:50 +0800
Message-Id: <cover.1621327467.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g7e39198978.dirty
In-Reply-To: <20210507021140.31372-1-dyroneteng@gmail.com>
References: <20210507021140.31372-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

* Rename the "uploadpack.blobpackfileuri" configuration to
  "uploadpack.excludeobject".
* In addition to blobs, packfile-uris now supports the exclusion of
  commit objects (recursive and non-recursive).
* Added a patch to modify the packfile-uris.txt file.
* Added a patch for related tests in t5702.

About renaming, I do not know whether it will bring some compatibility
impact, packfile-uris now is an experimental feature, how to deal
with this situation, hoping to get some advice.

Also, I did not consider implementing packfile-uri support for tree
objects, because in the design scenario of packfile-uris, it seems to
be of little use.

Teng Long (3):
  packfile-uris: support for excluding commit object
  packfile-uris.txt: excluding commit object
  t5702: excluding commits with packfile-uris

 Documentation/technical/packfile-uri.txt |  20 ++--
 builtin/pack-objects.c                   |  53 ++++++---
 fetch-pack.c                             |   5 +
 t/t5702-protocol-v2.sh                   | 145 +++++++++++++++++------
 upload-pack.c                            |   5 +-
 5 files changed, 166 insertions(+), 62 deletions(-)

Range-diff against v1:
1:  1f2fb5c85f < -:  ---------- Packfile-uris support excluding commit objects
-:  ---------- > 1:  73e64147b1 packfile-uris: support for excluding commit object
-:  ---------- > 2:  4abab98a76 packfile-uris.txt: excluding commit object
-:  ---------- > 3:  e824cc26a7 t5702: excluding commits with packfile-uris
-- 
2.31.1.442.g7e39198978.dirty


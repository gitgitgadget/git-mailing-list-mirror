Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C2FC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 19:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjCHTVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCHTVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 14:21:21 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6CC9A54
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 11:21:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so1804945wmi.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 11:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678303278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=410TqsSfQSFOPLlWnvliuZlLNxR555y8pHj2a3iU8Qo=;
        b=NtrlEZD/GrF6n4LDUl2YZ7A+xwfX1Pzy6/yzUxcwnw1+YiZWok4gqBQ1RVMUNUeDvL
         LVBg8ve1j1JI34+m+Pv6EFjpiiUj/2w6p7/7Y6stdxwgNNowPw94Fjnzw4yRNdm3lVd2
         ep08hAqrJ9ZQ9kA9h4QhE5Swd6ImiSj/Gbv0o4QnTFtaWop387uG7WxFZTUD/IG9Nm12
         eGcSm/VC565JUzofrgluWgwkRZBM8yNEMgI6F3ilXNMEl09icWTeHMoghsmNzIOUmBFt
         Xtdb3GhkFFlGOrn3AfFiO/U7T+3bZAwP9YSCg0bCdeShkyc704VOJw0oOdXtc70pZk6a
         bKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678303278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=410TqsSfQSFOPLlWnvliuZlLNxR555y8pHj2a3iU8Qo=;
        b=hvNEtJqZvAGDo8mVcSpOLxRMsZfvv8mhbngJ//gKMA5n/L/odaiOs2/VtjrJDe4z3l
         KNxhX1jsQEQ7Ztx/ZuBmGqWMEvLWY7CRJI/uExZnjOm7xkrRl0//8gKHmgG3WQ5HRw5y
         KWlDkBn/ZSMPeQ1YMv5Lg8Zi39pJhbAEBF2lD+B+uVws5R8Mds8XPQkk4h1/S6KHgT1t
         fyuAXA9zG3of1/yB8fyGyCcDHe8w9xD2szgaDkQfZzuHNAzhw6QJwGvqo0iUmQHnfVrx
         Yi75CVRVp/RWbqNDhmwy4nLijcoyWGGhtCcWdKBxwnuyzl2NMKdVXptD639J1DvIzguS
         hekA==
X-Gm-Message-State: AO0yUKVU6yGDpJGTgCiV0/5GU2u/XRb3/KfdromVOYaI+GCGtNA6ZKR+
        DO2UedxzsKdn3CdDv5b3oqiYfmJamXszlw==
X-Google-Smtp-Source: AK7set/YTgSDNgeLTAUcQE2550Am+qGJnh5EMApEJuxhpqXjvZBEn1dJA3eibV3YNrIOYQ7DfzY8og==
X-Received: by 2002:a05:600c:1546:b0:3eb:2f06:c989 with SMTP id f6-20020a05600c154600b003eb2f06c989mr17692183wmg.22.1678303278147;
        Wed, 08 Mar 2023 11:21:18 -0800 (PST)
Received: from DESKTOP-FOQ07IR.localdomain ([2a00:a040:191:d233:88f:49ca:44fe:37f])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c458b00b003e20970175dsm321455wmo.32.2023.03.08.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:21:17 -0800 (PST)
From:   Roy Eldar <royeldar0@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH RESEND 0/2] status: improve info for detached HEAD
Date:   Wed,  8 Mar 2023 21:20:48 +0200
Message-Id: <20230308192050.1291-1-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a repository is cloned using "git clone -b" and a tag is specified,
HEAD is automatically detached. As a result, "git status" shows
"currently not on any branch", which is not very useful.

Teach "git status" to generate the "HEAD detached at" message in this
case as well, in a similar way to when a tag is checked out.

In the case of "git checkout", the name of the ref that was checked out
is retrieved from the reflog; for "git clone", the name of the ref isn't
present in the reflog entry, so we use the abbreviated hash instead.
This is also consistent with the "detached HEAD" advice.

Roy Eldar (2):
  t7508: test status output for detached HEAD after clone
  status: improve info for detached HEAD after clone

 t/t7508-status.sh | 12 ++++++++++++
 wt-status.c       |  7 +++++++
 2 files changed, 19 insertions(+)

-- 
2.30.2


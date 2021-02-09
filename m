Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B94C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF3D64E9C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhBIRdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhBIRdk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:33:40 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E8BC061574
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cl8so1970326pjb.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqcZ4pKxYZ2TcL7Lxas6Rgvsw5gVsHTRMpDWtqCJJZc=;
        b=HkjruQDH3l0Tvfu/TGPIlaaZtUubMXdr3qE5VtCHfYrOis0OKZSnnuDRsW7abdO2T9
         29wAskTLIpSYLGrH6lsp6l0eZjR8VgkmOlqB8fo4Spf1eJji6MOAjS9XxB7Rgx5cR9oT
         bXypvDcSuuw9B8KcgYamTZ+x1XLsYM4oS4p4896DIjtNHFIB16i8ychJx9aidfv5khfE
         BBoh9ca+9Tf7pVTA0c56G1Gi49qCpkVdceDm7spGHhDLmvBZg7rcfIGykts5VuaircXO
         NGlbg1cbb/AG+CxNfkxsA8XrOmNLnPp3kCubf0xolbrrxptYIr/rk7lDQmHmyaQ3LbQN
         nBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqcZ4pKxYZ2TcL7Lxas6Rgvsw5gVsHTRMpDWtqCJJZc=;
        b=NbOFDw1i1dk5P+hQZtgAEpyd7jnFH8nlFAbgSCRz4zE/heAthC15fwQ+zcYMuRFvlD
         UQAcCmdp5IEAiqw4FzbwpCFvbH9iv3OWdNHHhhseWFE9oqurphQVxWRCrFDsD0rrPZOb
         BTzsCuk9yyUMsW8nwvkRgiZJj5fHJEL3jfPDxsJRi2QrLJOBP2NNNMJtdpIvQ9IBBk1j
         JYFvmM9ea3qIsP+UOwr7dxS32CxnuiSW2wYFMalJIkP6zfypGZbogFZl6dF/HOdhyQYM
         G1CVeWYVmbHMRA90LKlRSqHsj/LzsJEr5+fmAWd4gwh8fhhEtmtaLvWSDoCjC6hNmsJu
         sxWQ==
X-Gm-Message-State: AOAM531xI38K4Q5Iw/sUCxBOLFk1/hQSblfU3gJ6FQCQfHLLdq/hN5Ms
        /2FBIlhdGDBuiSJ1lidqlL5HV4E7TdjiZQ==
X-Google-Smtp-Source: ABdhPJyX6BjM6PV0FoxtqR3+zEnMkrFlgdV3FhcjizbdRUP91lW8PmPBQiIElIqsjE/7CDajt/+LbA==
X-Received: by 2002:a17:90a:f182:: with SMTP id bv2mr5262129pjb.47.1612891980088;
        Tue, 09 Feb 2021 09:33:00 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.32.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:32:59 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 00/10] Modernizing the t7001 test script
Date:   Tue,  9 Feb 2021 23:02:44 +0530
Message-Id: <20210209173254.17712-1-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this patch series modernize the t7001 test script by changing the
style of its tests from an old one to the modern one and by cleaning
up the test script.

Changes since v1:

- Change commit messages and added brief explanation about commit.
- Modernize subshell formatting
- Use ': >' rather than '>'

Thanks everyone for your feedback and suggestions.

shubham verma (10):
  t7001: modernize test formatting
  t7001: indent with TABs instead of spaces
  t7001: remove unnecessary blank lines
  t7001: modernize subshell formatting
  t7001: remove whitespace after redirect operators
  t7001: avoid using `cd` outside of subshells
  t7001: use '>' rather than 'touch'
  t7001: put each command on a separate line
  t7001: use here-docs instead of echo
  t7001: use `test` rather than `[`

 t/t7001-mv.sh | 432 ++++++++++++++++++++++++--------------------------
 1 file changed, 204 insertions(+), 228 deletions(-)

-- 
2.25.1


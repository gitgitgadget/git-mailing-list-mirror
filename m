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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F5EC56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2089206F9
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoidztzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbgKXNal (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388060AbgKXNak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 08:30:40 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF47C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:40 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id o25so23789387oie.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWeIuoKvrkvUG57NbESvMuU1vQYBeX2Ixsug+E4RFbY=;
        b=KoidztzBkqDJm8sPmy1Wt80ClQ0CKTRwk5Fvrc/bULSV+NIFfytG1GsT0AjhrlhHQ+
         nMtJqaMZZnig00njo8JdsEWsp2B00TVXAgPxems5Y/Cqs1XgR7375i5Q8n4lMSwz6KU0
         59WMN7bZwv5p1Fw1aFs/OrkjXWaUJNOlhNhjE9aA6VH+LBxb0crOUMIiUM1H2MhF+3PW
         L4+hlAxwBY2PFx/FmwtA8ro+FqMdI5/ib7lM/YfrLkQHU+xSQuiErdltAXN4bdg/+KAN
         YcRS9XwKP3L83xN7G5KVQGBz8GIQU3sdE8v5+pNC2mMvwuVxMP1t38Xcw5M1BJcNgH6s
         9ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWeIuoKvrkvUG57NbESvMuU1vQYBeX2Ixsug+E4RFbY=;
        b=fyN77J/fpStVl39W6iRUshIhc3wRn6YZGgQAQ8GyAz7rD/xRNsurTn8yBoGcQTueTJ
         x+hUEwOBDQmhPlWlkOd4nBbUoaBmrAu9YtVpnpEGYHIWFuuz6hd0DTEBkrrnB/p8l4WO
         HLHU2NUBem7PlbGfTS94tlYaafyAXTwwkfvuwUAbVvG7t2uhjAzsKwDXlsyJNcFJmLJV
         ZeBHIskCB7m9VqI7B+TwXCZaeWF0DgqV0IpFoFqnZCVGneG93asUsGvHL2zvRTInFZXl
         uUtUDbqSOSAvh37G5Qhp+Q8idofkDv7agvSF+FvSg8nEH22pkssvWdjQ3fIb6jre+gJY
         H1iA==
X-Gm-Message-State: AOAM531jEWwA6+WFTqeDB+lWJqoc8+z4TjwjvSuRFAicuXL+idEVdpjo
        ngjdgon+nt4FvM0XswzMFW01XLZbrtFn3g==
X-Google-Smtp-Source: ABdhPJwwn9hirM4j+L8CNnV8v1BdMKo3ENRgYl0Hzc2DX/C/efPp7uyjhHbnCoUDtNkW4j8suC9sUw==
X-Received: by 2002:aca:3c2:: with SMTP id 185mr2524999oid.87.1606224639621;
        Tue, 24 Nov 2020 05:30:39 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g82sm9382481oib.38.2020.11.24.05.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:30:39 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/6] pull: improve default warning
Date:   Tue, 24 Nov 2020 07:30:31 -0600
Message-Id: <20201124133037.89949-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series attempts to silence a bit more the default pull warning (when no pull.rebase is
configured, or pull.ff).

Basically; display the warning only when a fast-forward merge is not possible.

More work is needed to add a ff-only option.


Felipe Contreras (6):
  pull: refactor fast-forward check
  pull: cleanup autostash check
  pull: trivial cleanup
  pull: move default warning
  pull: display default warning only when non-ff
  test: pull-options: revert unnecessary changes

 builtin/pull.c               | 79 ++++++++++++++++++++----------------
 t/t5521-pull-options.sh      | 22 +++++-----
 t/t7601-merge-pull-config.sh |  8 +++-
 3 files changed, 61 insertions(+), 48 deletions(-)

-- 
2.29.2


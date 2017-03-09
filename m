Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5305920135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbdCIBcr (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:32:47 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34360 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754765AbdCIBcp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:32:45 -0500
Received: by mail-pg0-f45.google.com with SMTP id 77so19732776pgc.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4M5OIwWlTg+tX9NCNLKx0lZ4lv/b6i535KFUfm+wPA=;
        b=vnaHgkRTzc/cg4C3hKeZwTa8PKzntg/awTzFnRh1vpKvbCVRkjcY2wWrSwf/X05cGd
         jE52jx500tERxnDjzhGmbKHYwIEbDhyuTpAJOUCHH/3mx8I8MkcpNBsgUTMnnniCwigw
         apIyTgNUMbkmRXUUpWYa1SNqtclbEaeU6FL6ibtuyFun7KHjnHP8eFsH1fI7uKky+5TM
         fVhskub9PzNQXJARkCndEE6KxhPOdAA1d6K19Odl4XTH8k2VjqexuRmTX+AAfGEymIY8
         /BaGu/18VqiblVdoXJeUYg4GsFwQ1Jbj5KDxaHBwee01t3z+4g0z864BxAQl0vTu5Fnl
         34Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M4M5OIwWlTg+tX9NCNLKx0lZ4lv/b6i535KFUfm+wPA=;
        b=lIGn2v+M1OZOLfzxvY1Bfy8eO2LG/hRSFZ9qG0FrHN2EVqbC486lUXmig7eQuOR9rf
         OtSQnB47xI7HrtO9L7MeaNNH/NKE7OBKJ6Fwd9l2aiAlFzJx/VjLVI+spExfddRKoWM3
         jb/FGVU0zQUTUIuw/900Kjh+scoGKJBAif6gHe+sHFFCJKTUNr4rKqUU3D33Bgq0vbji
         Ssn7hwnlTIKWJQD1YTnNs4Bwwnf46L0FnmY7SOMrV/UChvPB/XONGQp7YRo0+5O2FxpI
         Tmuq1Pbsyd9LUdmU5Jgt09ttOwl38ZGIJwQUYy7yeJSR6FJd95YzWeSIpUmkgmDn3poQ
         IVoQ==
X-Gm-Message-State: AMke39k86gFyevH1bzxrTyW5ULxQNt3vjbnf4XY3mebbtoTYUDrVyqcIKzSm4YZL9x1v+BUP
X-Received: by 10.98.77.131 with SMTP id a125mr10873138pfb.90.1489022633613;
        Wed, 08 Mar 2017 17:23:53 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:23:52 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 00/11] decoupling a submodule's existence and its url
Date:   Wed,  8 Mar 2017 17:23:34 -0800
Message-Id: <20170309012345.180702-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Differences from v1:
* Reordered some of the patches
* added submodule.<name>.active boolean config option which can be used to do
  more fine grain selection of submodules while still decoupling the existence
  from the URL.
* submodule.<name>.active has precedence over the pathspec stored in
  submodule.active

Brandon Williams (11):
  submodule--helper: add is_active command
  submodule status: use submodule--helper is-active
  submodule deinit: use most reliable url
  submodule sync: use submodule--helper is-active
  submodule--helper clone: check for configured submodules using helper
  submodule: decouple url and submodule existence
  submodule update: add `--init-active` switch
  clone: add --submodule-spec=<pathspec> switch
  completion: clone can initialize specific submodules
  submodule--helper init: set submodule.<name>.active
  submodule add: respect submodule.active and submodule.<name>.active

 Documentation/config.txt               |  15 ++++-
 Documentation/git-clone.txt            |  23 ++++---
 Documentation/git-submodule.txt        |  11 +++-
 builtin/clone.c                        |  36 ++++++++++-
 builtin/submodule--helper.c            |  33 ++++++----
 contrib/completion/git-completion.bash |   1 +
 git-submodule.sh                       |  40 +++++++++---
 submodule.c                            |  36 +++++++++--
 t/t7400-submodule-basic.sh             | 109 +++++++++++++++++++++++++++++++++
 t/t7413-submodule-is-active.sh         | 107 ++++++++++++++++++++++++++++++++
 10 files changed, 376 insertions(+), 35 deletions(-)
 create mode 100755 t/t7413-submodule-is-active.sh

-- 
2.12.0.246.ga2ecc84866-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A650C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 01:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjDEB1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 21:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjDEB1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 21:27:45 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FE22D43
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 18:27:44 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-17683b570b8so36710994fac.13
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 18:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680658064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILselMKVz3uyLDAd0yLOa77KIgQsHF8/u54e8JFyumI=;
        b=fJDTS6FUVaORia/q+vqu1o+Iuo1jUpiQC4RekmZUl2kOALzFNaWrO2FZsV38lTSB2P
         ClbC8pgMmF6V/ABnZeSy9Q+zDChtrzUdfxluOm6nYi4GKsp/CKSmGV0l+1hH2wTuRC0x
         y5VNlCAuSYg/qw1PbX7+KmhfQDk07Tvow7RHXSniBwwdBArhYpK5bF1qZIIiKY9dn7Zy
         U9u+3zXXow8JEzKb4XrWIHV3TNdv+Vcjugl23UbhLVQu06pSkFFMMZ0c6+B1h+vvcxf+
         QCXNdyChBHf5rN5gQjPl5ilY2BXoiUMuizYOD+4c6nTq/+z9OVJASKheWnU7Es9xb7xh
         qI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680658064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILselMKVz3uyLDAd0yLOa77KIgQsHF8/u54e8JFyumI=;
        b=3NhiXA+DoiRyp8Ij8qIOQeyLpz12k7WE58HeLUylBGH9WvYhCARGg8sEUq8/VeJn78
         3UpI/zyXuVz6AXb1rmyeHhdD/A18IC/XR+IQK+xSTwLZuzl+2YENlwzden6otPwWcYYJ
         PUEDjFd1Be/rTBkIqbhp0i/5FuzNh6IijaUkx8r/N6AdMVwtXEBFM9A6GXYYzJKa+IRD
         WbFgcSVimWrPD5Ju+6AVlnvUVT9QjDPHIRlwWpOlvWWcSFd0K24q33OUKnF3KQFeZqJs
         7VJ4EbRnTcWVGon7GxmDyrEpnPh7rQusvueFsue3qvy05nnB3aQI3mZVnRmBDq34lSyn
         bq3Q==
X-Gm-Message-State: AAQBX9eqc/1dL6ThknxUh7vZx4PcZ6sr7UpNjzt8B8Lx2U4Fa4eFRule
        XmaC/bKHgRP7EIyVaBLtX4u8S0vv0cg=
X-Google-Smtp-Source: AKy350ax63ac/v5f09ktGPKWOQA63NguNG3oR0aKQH9B5yA9evDdXz4L6IRPu0+hIwSrSx5C/PzHwg==
X-Received: by 2002:a05:6871:795:b0:180:857:d47d with SMTP id o21-20020a056871079500b001800857d47dmr2286247oap.57.1680658063761;
        Tue, 04 Apr 2023 18:27:43 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s12-20020a4aad4c000000b00539b8372bd7sm6041342oon.29.2023.04.04.18.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 18:27:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] Add fetch.updateHead option
Date:   Tue,  4 Apr 2023 19:27:40 -0600
Message-Id: <20230405012742.2452208-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's surprising that `git clone` and `git init && git remote add -f` don't
create the same remote state.

Fix this by introducing a new configuration: `fetch.updateHead` which updates
the remote `HEAD` when it's not present with "missing", or always with
"always".

By default it's "never", which retains the current behavior.

This has already been discussed before [1].

[1] https://lore.kernel.org/git/20201118091219.3341585-1-felipe.contreras@gmail.com/

Felipe Contreras (2):
  Add fetch.updateHead option
  fetch: add support for HEAD update on mirrors

 Documentation/config/fetch.txt  |  4 ++
 Documentation/config/remote.txt |  3 ++
 builtin/fetch.c                 | 69 ++++++++++++++++++++++++++++++++-
 remote.c                        | 21 ++++++++++
 remote.h                        | 11 ++++++
 t/t5510-fetch.sh                | 49 +++++++++++++++++++++++
 6 files changed, 156 insertions(+), 1 deletion(-)

-- 
2.40.0+fc1


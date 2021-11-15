Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A182C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75BE61361
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhKOLzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhKOLzS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 06:55:18 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AFBC061746
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:52:23 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b11so14183732pld.12
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfAki//qcZQGMx9fEivF9L0yERT9N7mhGKH/cJDCHTg=;
        b=FRx1amsftBd3LykDlrigzs+cetzUi0qrBPc5BJ+P6ihLjzQ+OW7KfXtt6qpsVGqBai
         vyWT8A+HpVtfyWk+exxuiOUyDatWfwM6v6Klyj7lIh7J3+9e16jK+zZDIstqUrh9o4fb
         eIBqRiDBxTy/96rVx23G2MtekYrILEwffnkiWAhDoI6u/5Ok4B1Dk5HUXr3QMwR+Z6NY
         K9FO2zKmTmN7/DHuDnB75wwnUCxrdrrUHK5KoewtBhRqTOqaPw/GDWuA99Moi6bskBxm
         7XqTY8zwv9AjpJEClKsszNYfPuVMDm4unXWIPw1swA9pD+DsZFqmZFa1YNOaandsrp/e
         cS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfAki//qcZQGMx9fEivF9L0yERT9N7mhGKH/cJDCHTg=;
        b=hVuROk84o9UIHnn6iDT0HjrY0Hz6dPDtr4PMKzb+VKohne4JHeFUteWjYk4jAY/C2S
         9wdnHArvPzTMWrFSQ54Fy09Ds6RHOHOUt10fjX8Y6eF6VbyH1XiDfEHBHOZIe73ueSwm
         xW0YAjsLdoCu4qkK/SOROtqJ4ohEVYaixhyzHCiJOTWqB+VUprVOag0yPPinZ6aVH4HA
         cIJ2YV/dwii9RMts0q/a8/d8Vh7q4U/YIHNAjWxrOGZHl+yfjA9zvk73MW64+7cQlphd
         3TVurCQklciNYjEKg7ZOmNs50YNH0w2S4tU5fhHkKeiO6RWVYIo5hnwYm6V2TGJVdjsv
         D40Q==
X-Gm-Message-State: AOAM531agpziSTTCsFlABqVVMy3DsT7SmIP9UTGUGbkQVIAI4wqWyEWd
        0JjbojKVxT/ZsY+pEMLreBkI7xKH0ydHWQ==
X-Google-Smtp-Source: ABdhPJxXL7QcJ9CfEUgG2Ep5l0S4HWSFORQrEu8I2XLREJ4TF3dS5LsbME0wHC1m7QPQmyiwi27r3g==
X-Received: by 2002:a17:90b:94:: with SMTP id bb20mr63101096pjb.210.1636977142279;
        Mon, 15 Nov 2021 03:52:22 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id s2sm17543280pfg.124.2021.11.15.03.52.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 03:52:21 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 0/3] support `--oid-only` in `ls-tree`
Date:   Mon, 15 Nov 2021 19:51:50 +0800
Message-Id: <20211115115153.48307-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.9.g5fbd2fc599.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes, we only want to get the objects from output of `ls-tree`
and commands like `sed` or `cut` is usually used to intercept the
origin output to achieve this purpose in practical.

The patch contains three commits

    1. Implementation of the option.
    2. Add new tests in "t3104".
    3. Documentation modifications.

I'm appreciate if someone help to review the patch.

Thanks.

Teng Long (3):
  ls-tree.c: support `--oid-only` option for "git-ls-tree"
  t3104: add related tests for `--oid-only` option
  git-ls-tree.txt: description of the 'oid-only' option

 Documentation/git-ls-tree.txt |  8 +++--
 builtin/ls-tree.c             | 11 +++++++
 t/t3104-ls-tree-oid.sh        | 55 +++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

-- 
2.33.1.9.g5fbd2fc599.dirty


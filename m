Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE812C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 11:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbiKQLak (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 06:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiKQLae (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 06:30:34 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B043429A2
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id k22so1496729pfd.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQGiq7zrrVzZkXGL8AIBXmqNnVR5nVBegVs3We6TlN8=;
        b=S877kzQtAlGHPxmx2v12035OM74ZJybCtHblLhoXxyQ2NjwGEIw6HbNM7NhCxS763N
         mXoNDq1DmDDbmU91xPbwT7APV1VIjctfFD+NF9VSXX2uzaPWJ1yexcVJlEqYsK0Dl4s0
         rYLlU3WKW4LTE/aTqiYVriy6dd5lu1r7jtuKZH7IOx42kif20hUYkGtdNZ9FXYBtl1+V
         aiV2H8p0G8LdnV0rQ7Xv/ehwMzRd+dGJaU3FFokXOOyjYIjxxgBHcZRrwuX8MPdymctt
         /7yHkTw8pVg09lD2QC8mgNfSqv10FUoT78qmyeBJO3ztwVxNMhiLtrISfL5Dr563I5wV
         rrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQGiq7zrrVzZkXGL8AIBXmqNnVR5nVBegVs3We6TlN8=;
        b=tjut1aKTWl6XZTyt4zddeWgcxTjlS9JNfSwaK3c5JuLWHj9ivPuJ7amZLDpkRkA4xE
         DXd8/7TFFlIl7G6C5KqSGFjrLf2gcL6Ex4A4pREi3pcI4q/new91KufvLaoDyYdfRTfO
         1v1zdVDGI6mSSOzBMvIdjSOk+ufYsgLpIajIyIESYhQMHQTaI9CZcv4Ba/q3/3KpWWJr
         LCxL83MQAbeyb/YT0++7SPH/RqogdYb8MnIeThn+7/W4neGG4etz6LnSTHFQNcbtr03Y
         YLHnSMmwPHCa2JZI5wLLOsbO1AUUsYOWyTTC5UR9wWgUzUANfv9iYgJAqj6JbIgx99Qp
         Bvbg==
X-Gm-Message-State: ANoB5pmZeaSGYKYP2zbHpTPNoszbMQwXjY9awG7aN/kdD74YpHq6HGvz
        VJaUIjA7LNolid2ckFjau2S1PfI2UWF2AA==
X-Google-Smtp-Source: AA0mqf7U1uIjwobK7c9Lv8pNLfvmZ/GNvUH5NIpSnS6dOKIkjVBqFJ7S8S2lt5Boq2NyVMmZhBeImQ==
X-Received: by 2002:a63:5d45:0:b0:476:dd29:75a8 with SMTP id o5-20020a635d45000000b00476dd2975a8mr1534004pgm.547.1668684632518;
        Thu, 17 Nov 2022 03:30:32 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b00186c5e8b1d0sm1056117pln.149.2022.11.17.03.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:30:32 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 0/6] ls-tree: introduce '--pattern' option
Date:   Thu, 17 Nov 2022 19:30:17 +0800
Message-Id: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.426.g770fc8806cb.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This RFC patch introduce a new "ls-tree" option "--pattern", aim to match the
entries by regex then filter the output which we may want to achieve. It also
contains some commit for preparation or cleanup.

The idea may be not comprehensive and the tests for it might be insufficient
too, but I'd like to listen the suggestion from the community to decide if it's
worth going forward with.

Thanks.

Teng Long (6):
  ls-tree: cleanup the redundant SPACE
  t3104: remove shift code in 'test_ls_tree_format'
  ls-tree: optimize params of 'show_tree_common_default_long()'
  ls-tree: improving cohension in the print code
  ls-tree: introduce 'match_pattern()' function
  ls-tree: introduce '--pattern' option

 Documentation/git-ls-tree.txt |   7 ++-
 builtin/ls-tree.c             | 109 ++++++++++++++++++++++++++--------
 t/t3104-ls-tree-format.sh     |   1 -
 t/t3106-ls-tree-pattern.sh    |  70 ++++++++++++++++++++++
 4 files changed, 161 insertions(+), 26 deletions(-)
 create mode 100755 t/t3106-ls-tree-pattern.sh

-- 
2.38.1.426.g770fc8806cb.dirty


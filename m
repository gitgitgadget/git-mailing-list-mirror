Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A3AC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 02:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhLHCMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLHCML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 21:12:11 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0699C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 18:08:40 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id k4so731514pgb.8
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 18:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zsfUb45z2i+siFA23eNrg3O9jtpntzkwDY46GpHffek=;
        b=QkKxvSZVZ5e5umZv1Y4WdWISLX3hwxH5YkKAzv8C167xGHlhZeb+DZ+He4i/1/4BPC
         jnxjXuEuS86qDuA9TYIxkx9s0Ch7eSaa3jw1Wxy1959/h0LTF3l7MxlLbI/0fIyAwTYf
         oDRg1jSpFhxuOdHUbKokrUbAyz9cn9P7kiBOHSPzL0F9U4/7lrDA7FqBDQkcNmuXjp30
         bK4VNrsc89Z8jVMDdiBMxa/9ZRSalPWnWjwsHOTC75bDV4b+Zxio9cfiOa++UCFzufH5
         tdLRpvDn0lA+WdjF0Dx6pYf5Qva+HWijudZoP7RBYx8uNn6pL0x6hjpt8WLmiVrov3s+
         Ab8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zsfUb45z2i+siFA23eNrg3O9jtpntzkwDY46GpHffek=;
        b=TdsLgCeysq0yujKS+t9p++mSszZ09sT83+X7Yaqv93LD/iCgC3ojD/9yIup4Gunq34
         PorGdGTbga1viiE5B+BECkSPclYMkSvxhMlgYULwLOfxQAQemXC7ENLfRzRBQ7CE9Q76
         Vx/+rAUV1A+KVwUayc2wvHlpUq6nDyWbZeZZeEgnpKJAaoO/Q4U4RZofppaWUN3ZXtFu
         uWv8bcsLr7UG5+a00Qnbvfa83q4PYMbXpgIRg3JXeU/bzw7iBjIIVEJN0jBUoMk61VJN
         A3elqr0/EChFR2XoLOP3Ff/ujRZrgK2wp02QAVVSZWyqPoDEpp8blN7jJ20xdcEEYm05
         aU5g==
X-Gm-Message-State: AOAM5319YpLLwRaizePfz+kdqglrJo6R+cqPAHaKKh88No6wGnYmWBSW
        saDAfr9q5w1wEgkY5uHAIQC7D94groWCpEzD86M=
X-Google-Smtp-Source: ABdhPJzR1YSGDMfjU4VISLs266xK/DW9e0k32qQTopIKjqnzeZgKgbcIRvTPdnDwT0gYMhU3SFva3A==
X-Received: by 2002:a05:6a00:b8a:b0:49f:ed97:16be with SMTP id g10-20020a056a000b8a00b0049fed9716bemr2889403pfj.16.1638929320103;
        Tue, 07 Dec 2021 18:08:40 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id np1sm4280214pjb.22.2021.12.07.18.08.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 18:08:39 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, congdanhqx@gmail.com, gitster@pobox.com,
        peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v5 0/1] support `--object-only` option for "git-ls-tree"
Date:   Wed,  8 Dec 2021 10:08:30 +0800
Message-Id: <cover.1638891420.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.gd2a07a0ec5.dirty
In-Reply-To: <cover.1637642029.git.dyroneteng@gmail.com>
References: <cover.1637642029.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Diffs from patch v4:

* Change `--oid-only` to `--object-only`.
  Word "oid" may not be easily understood for users.

* The commit message was modified in terms of Junio's advice.

* Use "OPT_CMDMODE()" to make `--name-only`, `--object-only` and
  `--long` mutually exclusive with each other.

* After options been parsed, translate options to bitmask, then use
  cleaner bitwise to determine which fields will be shown.

* Add tests for mutually exclusive options.

* Documentation modifications about the change of option name.

Thanks.

Teng Long (1):
  ls-tree.c: support `--object-only` option for "git-ls-tree"

 Documentation/git-ls-tree.txt |   7 +-
 builtin/ls-tree.c             | 125 ++++++++++++++++++++++++----------
 t/t3103-ls-tree-misc.sh       |   8 +++
 t/t3104-ls-tree-oid.sh        |  51 ++++++++++++++
 4 files changed, 154 insertions(+), 37 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

Range-diff against v4:
-:  ---------- > 1:  38d55a878c ls-tree.c: support `--object-only` option for "git-ls-tree"
-- 
2.33.1.10.gd2a07a0ec5.dirty


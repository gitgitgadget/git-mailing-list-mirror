Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B392C33C8C
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 17:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AAE20848
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 17:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="JJ0B0mlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAERlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 12:41:35 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56237 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAERlf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 12:41:35 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so6599108pjz.5
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHgNw0k3WbpO6SrvzJYMHvlUii/QCYbRe/ahenooQdE=;
        b=JJ0B0mlDQNL16okUByuxTa4yowzxfpOOreYSQ5H+wO3oKG/Z9Cxx2wKoT2WgR/67X4
         g3RyjcxQlRuIZm80T8+GYWF4zIaub48amX5AQtpjPM6qDEFOdWquRC59F03yz50h/yMD
         wN2y8pcnHl4btFiZv04XsTdPCOL5ONA4k7Bj3L743wUg5snTfT84SxAYhREtFcUZcIhi
         SDYjxaoROsC9/1+8IdJMx2TfFjBwdGCg+X4rZXromk/VrltVJrbT9UQsCykOcqEbe1f7
         soRl88DzoO42tyXG1PIr75Cq7ylpRg5o6W8x+fO8NIvnywyGgEqWvdu4r7ykTzNG/xeg
         Duyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHgNw0k3WbpO6SrvzJYMHvlUii/QCYbRe/ahenooQdE=;
        b=WWgCSuU5Cwy6MBNxbY4xh1o1rxFObNMwCDdYh18S9IANEG65fvC+G4YxarkE3zHxyY
         FB8nWcH5RlCgbTh+KLhpkyzAR2jAmcEZu/Q4ZAuv+TGkFJmvDwO1DkjdQ2gBrey/3YGW
         pKOEavIjv4+dzs+bJ2oUIiwOUGxvs1KFbh8tqw3lfzHB7wXjMWsssrQ6fzSiXi2MB0BV
         yC6eEdIbIgHMV5AAl8qImli+JtfpDPsQOaEBolZfujjRgCnoAao3DSGMyP12JLTj8Igj
         4XgEZoqcxNsx93nCjq51zM8q9eW/NmWeXFn9C7dC7wXi10BGgEFJRsr+HqVe21jrcIjE
         itrg==
X-Gm-Message-State: APjAAAVQz9U+576YFFfsR4XzBV5O6WyNLupCf30oCW4wM/sTCUnUT7nu
        Vq8JlXvQmvlkdge5izQfxq/4GApBD8U=
X-Google-Smtp-Source: APXvYqw8Bh8HHvBfswFPdWwi8LTPXxuR5NUIbDPNn4uPrtZQQl2ujtvey63HFMqSrgNWZwaFqXcLAQ==
X-Received: by 2002:a17:90a:9284:: with SMTP id n4mr37121452pjo.84.1578246094298;
        Sun, 05 Jan 2020 09:41:34 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id b15sm71371353pft.58.2020.01.05.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 09:41:33 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 0/1] commit: make the sign-off trailer configurable
Date:   Sun,  5 Jan 2020 17:41:26 +0000
Message-Id: <20200105174127.9278-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch that adds commit.signOff as a configuration option.  The
config/commit.txt documentation where the significance of the
signed-off-by trailer is highlighted is copy-pasted from
config/format.txt.

Even with the note in config/{commit,format}.txt, I still think it's
worthwhile to have the trailer as a configuration option for
contributors that always have the rights to send patches.

Hans Jerry Illikainen (1):
  commit: make the sign-off trailer configurable

 Documentation/config/commit.txt |  8 ++++++++
 Documentation/git-commit.txt    |  4 ++++
 builtin/commit.c                |  4 ++++
 t/t7502-commit-porcelain.sh     | 36 +++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

--
2.25.0.rc1.298.g45d5f025e1

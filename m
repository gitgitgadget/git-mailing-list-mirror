Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F64C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA75622C9F
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVUrOxcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHGV6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGV6r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:58:47 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A483C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 14:58:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o22so2418578qtt.13
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 14:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7BtMysgIcohJ9ewN+XqfN7nzNFAIQOJqi2eM33mwWm4=;
        b=OVUrOxcyDloT23Gnmuh7bd9AwNL98dZhFLYA9R1nE5JyfjhFkDTT45bMNmLh0LVwF7
         okT4vec17GjLRybSeE3o/+u4Bgl3SXh+oOHgUoeAN8nCwDa8fg7LGdNjkRo3Tw3PhTsN
         ktUBTMThrcsNrPmI86/xqiBHnVYCceeZcg4rly53km/5/ciyOUrgVwnRtZi+nn/bjgsa
         /MGcxPZdel0VzXV7J68cygzGcMGTDzX0RF4UYBqBzxGAaDuoLfLcrSDNugydV7i4yet6
         KLoVRElOkxpt6nuwOzk1rwpjFDq1KSIRLAf4dVn+ohJWX0DFAO1un0HxiR5GM3B63938
         jKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BtMysgIcohJ9ewN+XqfN7nzNFAIQOJqi2eM33mwWm4=;
        b=qOLSk16OFrpnHFdONlNg8iHMYKimoiWskJuq99UmpQoYtwC01Q6R7iZi3efMm5hj4p
         D1OzKoiQf6nJLK6H58xD9UwbCPnwzgfRprPHFgRiMrFZiL4ZJGBDM98qd8YNB/wK3B6u
         LO4c4eFQ8jB6SltNFRkZIbtPPxKJDMAJxQA9oCYSEopxILEXuqVlQNgBVK7Nhpq1Jonb
         rcNVIXQA2kPd6PQ+sbPKyt5r2pqXg2c06MjrpM1662P+b8YNQN5meV/cCqvQSXX37mJ0
         fCGh4RwnaEz7sbDBm1FC8iF1f8yi/6MdF8qSZNlduXdTIo34HhCPmpMegMA5qce0WjH4
         WOdQ==
X-Gm-Message-State: AOAM530YLwRaGyQKFLmw3jznXc6eJpsk9rp+i6lcfrz82/Cwpzy3HF/L
        3M3GQ7eIaNXY62CCB/J73vhDbc6tv6oNvQ==
X-Google-Smtp-Source: ABdhPJzSYGT0zqKVWaKbmWP3FJuD8tJyG8x/NCJhn4DWxgSYpIFhnBsdVZRCojeuelWoZ/N1XaZqHA==
X-Received: by 2002:ac8:4e28:: with SMTP id d8mr16294487qtw.134.1596837526074;
        Fri, 07 Aug 2020 14:58:46 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id 84sm7141579qkl.11.2020.08.07.14.58.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 14:58:45 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>, gitster@pobox.com,
        christian.couder@gmail.com, sunshine@sunshineco.com,
        martin.agren@gmail.com
Subject: [PATCH v5 0/5] Introduce --first-parent flag for git bisect
Date:   Fri,  7 Aug 2020 17:58:33 -0400
Message-Id: <20200807215838.19571-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200804220113.5909-1-alipman88@gmail.com>
References: <20200804220113.5909-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for catching those style violations, Eric. (And to everyone
else who reviewed!)

Junio, here is the (hopefully) final update with Eric's style
corrections applied to 2/5.

Aaron Lipman (5):
  t6030: modernize "git bisect run" tests
  rev-list: allow bisect and first-parent flags
  cmd_bisect__helper: defer parsing no-checkout flag
  bisect: introduce first-parent flag
  bisect: combine args passed to find_bisection()

 Documentation/git-bisect.txt       |  13 +++-
 Documentation/rev-list-options.txt |   7 +-
 bisect.c                           |  79 +++++++++++++---------
 bisect.h                           |   9 +--
 builtin/bisect--helper.c           |  23 ++++---
 builtin/rev-list.c                 |   9 ++-
 git-bisect.sh                      |   2 +-
 revision.c                         |   3 -
 t/t6000-rev-list-misc.sh           |   4 +-
 t/t6002-rev-list-bisect.sh         |  45 +++++++++++++
 t/t6030-bisect-porcelain.sh        | 104 ++++++++++++++++-------------
 11 files changed, 195 insertions(+), 103 deletions(-)

-- 
2.24.3 (Apple Git-128)


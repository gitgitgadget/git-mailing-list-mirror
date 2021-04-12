Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B339C04FE4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 09:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0E961207
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 09:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbhDLJSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbhDLJRR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 05:17:17 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71908C06138D
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aQpZ9/1TtnpAriNgMfy1asibmOtZ5V7lkQcOthn0zCM=; b=ZJPXrrtSP/iI2ABKDe6jc7u63Z
        1D5rdKbaVUurIjhfS6EtVbYDG7Z1/CC0+0XGgELstxzpCrPn9evEk+ui+llEWmGf7yy+6O2FybK+I
        TUtrIMSP37ONntU5A7+Eqyd3ZV0jzFTlEztS3w13xQ3KKKCDz5Lo+lwzu/m0x74HAx+w=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1lVsJX-0000qB-0t; Mon, 12 Apr 2021 08:52:59 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>, Feiyang Xue <me@feiyangxue.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Subject: [PATCH 0/2] git-p4: encoding of data from perforce
Date:   Mon, 12 Apr 2021 09:52:49 +0100
Message-Id: <20210412085251.51475-1-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using python3, git-p4 fails to handle data from perforce which is
not valid UTF-8.  In large repositories it's very likely that such data
will exist - perforce itself does no validation of the data by default.

Historically git-p4 has just passed whatever bytes it got from perforce
into git.  This seems like a sensible approach - git-p4 has no idea what
encoding may have been used and it seems likely that different encodings
are used within a repository.

I was trying to do a more thorough job, moving more of git-p4 over to
using bytes.  Unfortunately the changes end up being large and hard to
review.  In most cases it's probably sufficient to just avoid decoding
the commit messages.

There have been a couple of previous proposals around trying to decode
this data using a user-configured encoding:
http://public-inbox.org/git/CAE5ih7-F9efsiV5AQmw3ocjiy+BT6ZAT5fA0Lx0OSkVTO8Kqjg@mail.gmail.com/T/
http://public-inbox.org/git/20210409153815.7joohvmlnh6itczc@tb-raspi4/T/



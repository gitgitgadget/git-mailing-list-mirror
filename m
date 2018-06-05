Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817C61F403
	for <e@80x24.org>; Tue,  5 Jun 2018 08:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeFEIzf (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 04:55:35 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:43875 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeFEIze (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 04:55:34 -0400
Received: by mail-wr0-f170.google.com with SMTP id d2-v6so1471923wrm.10
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eM/I10cnBYxcRxO/P+NpZMJFrJsgEsFi65iubm16Cyo=;
        b=S8vKqjgAOxetCoRUEsq1B/9ZgAMU6zKdAbrforhiCYksQOlZIcP5f1ecnCCYsLefhV
         zYr7XaceCpvOJT1rBZRAszW4BW95RM+9vdhnk+cgVSi4UShI9Jf5Oua07denfF0wB8TL
         HsXQyKOx6zdR6EUZ0EftM2zGIGzz75nPPIcT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eM/I10cnBYxcRxO/P+NpZMJFrJsgEsFi65iubm16Cyo=;
        b=c0+k3jFa7hq0b+m2TrqmtP/WEJ08cxAMVwdZxScIlBF0LpY5BCgSdxPC+8TBa4mhJS
         J3+xY8BfmTlOziXInX3MdZjKKEDV8/riiRaiiupdlRqPtiimRPWWn9IRRi7Xeoh2KMxW
         oOW5V9DbYGxMk3wHVWq5beXqUH5hDVV/HYEheDNPPyqJqZzYOSM6gvdmvNEuc8qkD5Em
         5n7jouHQ7MtLC0Eue6xEXDxgwLpAcOUuSeEm+R510f0mT6hAIUF7DpH46b/nUuDlF9qR
         oFfw2ok1lho1/hK0yUbmL/dMXvN6dJDGX90AA2EOD5b36eBzXNmcdukW6XPWWubv6soQ
         0icQ==
X-Gm-Message-State: ALKqPwenYnNmOP2ASJ6q9tMIUZUyfAWJNXn5dugO4q190YRplYdl+gFy
        JEXaCwg+W8N7k4pHQTKLE8UeXq2D
X-Google-Smtp-Source: ADUXVKLh0caOqtaSiDfPVFwsqM9t/nb8BrQ80U54iQT5TXf156UAMJTQGtmZlRUmezf2ePy22RVQ9A==
X-Received: by 2002:adf:cf0d:: with SMTP id o13-v6mr18157628wrj.112.1528188933123;
        Tue, 05 Jun 2018 01:55:33 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id 12-v6sm1252499wmn.27.2018.06.05.01.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 01:55:32 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/1] git-p4: better error reporting
Date:   Tue,  5 Jun 2018 09:55:23 +0100
Message-Id: <20180605085524.10838-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If git-p4 cannot talk to the Perforce server, it will either give a
confusing error message, or just crash. Even I get tripped up by this.

This change just checks that the client can talk to the server, and in
particular that the user is logged in (the default login timeout is 12
hours).

It would be nice to also check for ticket expiration during long
Perforce operations, but this change does not attempt to do that.

Luke Diamand (1):
  git-p4: better error reporting when p4 fails

 git-p4.py         | 55 +++++++++++++++++++++++++++++++++
 t/t9833-errors.sh | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100755 t/t9833-errors.sh

-- 
2.17.0.392.gdeb1a6e9b7


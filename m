Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88E6202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 21:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbdCIVIM (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 16:08:12 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35397 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdCIVIK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 16:08:10 -0500
Received: by mail-pg0-f46.google.com with SMTP id b129so30591648pgc.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 13:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1B3iZjfO5gAcOYX+Eu11IRAokzeoa9H86gAF8L/sDXk=;
        b=Zptotrq77OrF11z51tdU8S2DqwfKboh4jdOarqIw6LaHZwYajG/vBPvxqq3eigrY4A
         jZGp6WzTvZH7duQMYOGYqL8MqYMLon9K7CybL46lXVin+ofInJEQSPiYJtDLnoezoFuQ
         ze3kBc3V8H56BImHdM2a7/M/jClKQ18xwRjok/eagfPexM2kWocbJLTbN1hcOK2WSagc
         3KucmfyKbFCV067exJucb7suvqJG9cm/ScuXbBbq9inFgdGO3MMHDCAYKW1GP03vNeHY
         j9BX1K0XJ+j8hHA883pKrCwrxM51l9+vyqwgVuhhzyOlh5SUyKTF02riNfZEUjyhF6GQ
         qh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1B3iZjfO5gAcOYX+Eu11IRAokzeoa9H86gAF8L/sDXk=;
        b=nKsMX9yA3XnAo4TUHXXpyj7bvfgTWRHluRGbNip6VAhY9ZtvPd+uFEoor6sswIfS2Y
         MqoaaQNFc1WxKry/4vLQLL0zh6P5bR3XkcRxLzfDDcOP/7QL0sh8itoIAohbQ1iIPflQ
         UIeccfyfKkr/gOLW1DuXGRylU0PE73bA3z/dkwSGB3VkMLjPfPJ+gYZGcrARFVVDFAEb
         CF7oXR//wTmQ/uBInYGo4+ygFqe8GOFbjw9WCq+y3+41KqrOEVHS82nyaxBmA0GCtf6N
         7H23E6fGZNjDNCTW82t0wBIJj1dt5Tz9CTankgTmeCZoMul8/+CJbNmA2Gh87K1+7ZRn
         aUZA==
X-Gm-Message-State: AMke39ly1SmObp091/OILXYNzrKYOS+MmmhD0gUnFLwDpruAc+1R84EPn16uXrgT8a0GCFmx
X-Received: by 10.99.63.71 with SMTP id m68mr15974702pga.115.1489093687424;
        Thu, 09 Mar 2017 13:08:07 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id s21sm14270000pgg.65.2017.03.09.13.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 13:08:06 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com
Subject: [PATCH 0/2] bringing attributes to pathspecs
Date:   Thu,  9 Mar 2017 13:07:54 -0800
Message-Id: <20170309210756.105566-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This small series extends the pathspec magic to allow users to specify
attributes that files must have in order for a pathspec to 'match' a file.

One potential use for this is to allow a repository to specify attributes for a
set of files.  The user can then specify that attribute as a pathspec to
perform various operations only on that set of files. One simple example:

	git ls-files -- ":(attr:text)"

can be used to list all of the files with the 'text' attribute.

Brandon Williams (2):
  pathspec: allow querying for attributes
  pathspec: allow escaped query values

 Documentation/glossary-content.txt |  20 ++++
 attr.c                             |  17 ++++
 attr.h                             |   1 +
 dir.c                              |  43 ++++++++-
 pathspec.c                         | 165 ++++++++++++++++++++++++++++++--
 pathspec.h                         |  16 +++-
 t/t6135-pathspec-with-attrs.sh     | 190 +++++++++++++++++++++++++++++++++++++
 7 files changed, 442 insertions(+), 10 deletions(-)
 create mode 100755 t/t6135-pathspec-with-attrs.sh

-- 
2.12.0.246.ga2ecc84866-goog


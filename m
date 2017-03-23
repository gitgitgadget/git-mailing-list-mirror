Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6100B20958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935643AbdCWVJ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:09:29 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33215 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932579AbdCWVJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:09:28 -0400
Received: by mail-pg0-f53.google.com with SMTP id w20so27201819pgc.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KhcHOaW59kTDls3P5nX5r8CVjTFLRjySEWgD8Y3qE5Q=;
        b=M/dow7FpMkKOVgCiLkTW5s0Uul8653li8oNjwu4q+D7nJwyh43EyS/sjKSzuI908fR
         tsY0DSjZ9aqD/JIFW8iOu373qtZyXOWqrHRus+Y2/wb5DkZsHj5kQ5f6mtLWauDUkXhQ
         ouY8zUzOZkb1LZxZ5E4opBZZ23dpYdxdHfgqOPsG5gn/0NqPpMAtI32qQU/3V9uXKipL
         XjSMwCr4djyPKjJo4SZanxbkgE5R0innoEIBsPW7i9mZ1OIEIpXMI1KSiVIhjlnUzKSN
         5HKMNJaJPxsJhrDGsdtQGIWwSqIW25eR+9hkuW2/6vJrIIj8jPjVQauoOOyvZ94xmlDq
         xM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KhcHOaW59kTDls3P5nX5r8CVjTFLRjySEWgD8Y3qE5Q=;
        b=ZaHON/mXAhX5UuN7soI4T2GlRqEsSQPfLEncPCtC/YvglMfc6JcuZYDDn9icntim+p
         PrFwWPnyoBsb9ZyfIckAROf8hJ0c0BSLl+ods7Bwve5Ke1mvH/9X6HgBFEa8AgylCCCs
         FEW6wNwjier8ws6qpPecPKtWyNhHTKvZZA1XjSkcDn76Hs5JccpXgekLBBKUDWvSra9K
         YwXnk/dITfLFB3EIyeYnsvJCLQYbx2nll/Tz6Q7LxCIjFd+nzcH7SIcf7khlUkBgUNUW
         AfgVpRAxRf4D+IHWGNmWZRYoAwUNE16VGmKeGCrDIjlKWtBhbONJi58uwVWgXEwh2dUY
         Ia7w==
X-Gm-Message-State: AFeK/H2/LxL6462oq2WA4iJhiE8rdbRYh9BZ0ItvCpaBX/fVJYikrLoV91tEg+aQwCpj+xQM
X-Received: by 10.84.175.67 with SMTP id s61mr6219632plb.126.1490303367080;
        Thu, 23 Mar 2017 14:09:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id d10sm186188pfl.59.2017.03.23.14.09.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 14:09:26 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/8] short status: improve reporting for submodule changes
Date:   Thu, 23 Mar 2017 14:09:16 -0700
Message-Id: <20170323210924.26818-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323004329.15892-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
* broken down in a lot of tiny patches.

Jonathan wrote:
> Patch 1/3 is the one that gives me pause, since I hadn't been able to
> chase down all callers.  Would it be feasible to split that into two:
> one patch to switch to --porcelain=2 but not change behavior, and a
> separate patch to improve what is stored in the dirty_submodule flags?

This part is in the latest patch now.

Thanks,
Stefan


v3:
This comes as a series; first I'd like to refactor is_submodule_modified
to take advantage of the new porcelain=2 plumbing switch to check for changes
in the submodule.

On top of the refactoring comes the actual change, which moved the
rewriting of the submodule change indicator letter to the collection part.

Thanks,
Stefan

Stefan Beller (8):
  submodule.c: port is_submodule_modified to use porcelain 2
  submodule.c: use argv_array in is_submodule_modified
  submodule.c: convert is_submodule_modified to use
    strbuf_getwholeline_fd
  submodule.c: port is_submodule_modified to use porcelain 2
  submodule.c: factor out early loop termination in
    is_submodule_modified
  submodule.c: stricter checking for submodules in is_submodule_modified
  short status: improve reporting for submodule changes
  submodule.c: correctly handle nested submodules in
    is_submodule_modified

 Documentation/git-status.txt |  9 +++++++
 submodule.c                  | 56 ++++++++++++++++++++-----------------------
 t/t3600-rm.sh                | 18 ++++++++++----
 t/t7506-status-submodule.sh  | 57 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 13 ++++++++--
 5 files changed, 116 insertions(+), 37 deletions(-)

-- 
2.12.1.438.gb674c4c09c


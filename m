Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF741F453
	for <e@80x24.org>; Wed, 17 Oct 2018 16:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeJRAhC (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 20:37:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38573 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJRAhC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 20:37:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9-v6so30773899qtf.5
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WP05bgG911axyBVjgpn7yxMHh94hkgaANBLccsrddmI=;
        b=ezb1yoRBGPCx1JTjF2mXiXFP0r38r85A/2/sS+59mX9d4Dtdq4S/0iL9g8dgTVXC7d
         J6SX0x+mgW6A0rj/Y6njceELj/j43FfbmwRgmzo8N/eO5YdXIj4buZEgoPpyZPhS9HaB
         3/krgEcQILS0z0katdhS8ObbeZUAzeZMB9YugxQjCR3UbfwpM6n3mV53+z64AvJHNpuD
         TTFQ0z3Q+EHiaAurFhmRu4AKq6iLUtx+hK9afC9S/O0Nw9sxCHiUwBxD+A3wZbobdOMc
         jjwgxEtPFeiQzsrx1YLdz3pc3QA6s2EG9vtDKIGdv1U99mYRIkSETmuQeoWpGw76w1sP
         uuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WP05bgG911axyBVjgpn7yxMHh94hkgaANBLccsrddmI=;
        b=Gw1iPJPPduC8cP28xRW6xfcWxG5HQvKsO+IXsvsjoTDnjsy3CUa/x2377bMwGmYyxR
         bSW6wGuCOy67DmlKzRCijZBgvmpdjLfm4Gj2Ff84NinNU5IXNXVZvnWu3AfMcJwMmv2f
         xqiAWfgTKLmkcEmIVSn64vSFIqQbNpmTYewxSlGd5Cg9ZBN+bcTHEiS2cZw2zjNn5fPn
         ujmxphQfm6sH+mDlKAmFWuZRECqagIrGxh4ueoF1dM9TkK8PDYpLmUKw8MGjkz4bG0Mg
         +qMMzL6NcTN4Pkvp77HOuHO91VHgHsTlTHS/MTuqOo3VetvBqnxkd0rQoBqECPI9zeG1
         I9yg==
X-Gm-Message-State: ABuFfohzFRqZupKyBn/lepIqMXB3Da3MNq1tuyP9z75AxxSJKqZ+m8CF
        V58cD0KTZbcevdmbRVXQONZ6Ymri+44=
X-Google-Smtp-Source: ACcGV63wOChTUZ6Q5a+ZUUJWRwRNK1+vmB2UWGs0gsWZPaon+FnhgMWFjxshik4awXfxBVymqoG+4g==
X-Received: by 2002:ac8:4a11:: with SMTP id x17-v6mr25789879qtq.232.1539794430632;
        Wed, 17 Oct 2018 09:40:30 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id x12-v6sm10843700qtk.6.2018.10.17.09.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 09:40:29 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1 0/2] speed up git reset
Date:   Wed, 17 Oct 2018 12:40:19 -0400
Message-Id: <20181017164021.15204-1-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

The reset (mixed) command unstages the specified file(s) and then shows you
the remaining unstaged changes.  This can make the command slow on larger
repos because at the end it calls refresh_index() which has a single thread
that loops through all the entries calling lstat() for every file.

If the user passes the --quiet switch, reset doesn’t display the remaining
unstaged changes but it still does all the work to find them, it just
doesn’t print them out so passing "--quiet" doesn’t help performance.

This patch series will:

1) change the behavior of "git reset --quiet" so that it no longer computes
   the remaining unstaged changes.
   
2) add a new config setting so that "--quiet" can be configured as the default
   so that the default performance of "git reset" is improved.
   
The performance benefit of this can be significant.  In a repo with 200K files
"git reset foo" performance drops from 7.16 seconds to 0.32 seconds for a
savings of 96%.  Even with the small git repo, reset times drop from 0.191
seconds to 0.043 seconds for a savings of 77%.

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/2295a310d0
Checkout: git fetch https://github.com/benpeart/git reset-refresh-index-v1 && git checkout 2295a310d0

Ben Peart (2):
  reset: don't compute unstaged changes after reset when --quiet
  reset: add new reset.quietDefault config setting

 Documentation/config.txt    | 6 ++++++
 Documentation/git-reset.txt | 4 +++-
 builtin/reset.c             | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)


base-commit: a4b8ab5363a32f283a61ef3a962853556d136c0e
-- 
2.18.0.windows.1



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 478CD1F463
	for <e@80x24.org>; Sun, 15 Sep 2019 21:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfIOVSH (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 17:18:07 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42535 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOVSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 17:18:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id w9so3321739qto.9
        for <git@vger.kernel.org>; Sun, 15 Sep 2019 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+Hj1ZjI+MDT58cvzbLHwL4iSazYyuCo0S7e1bRygcs0=;
        b=onIz0hzu0AM5ZclxO/3cJZU9vZI9MYxjal5oaL8R1c7tb5mWg1KiYV/JeMCiwSYivE
         RYtSYn/cYjnX4a5jacEUsqH8Zg2feZ3ZhTDjKLujnRsfFbBpiS62KvtXMVWUdAE/NjL3
         JXOHm/Ig80UQ4wb+3uGyRUG/W5sBTnI2l1+w3GjjPHx3IEIHOfO/cH8/lbuRs5iAQiSt
         PMAS7t1tpymTAFbyzTQ6V0rYXjKUAKTr/qZBnhv9I/jKXAjMV3Fp6BPz92h8A6/Ayb04
         aeO1sb7+VmRxLt4advHreBCYEyrB7yB7p52hEhUTuG+fq5Yqo4+jHBi1v8MZUMbVtC3g
         F2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+Hj1ZjI+MDT58cvzbLHwL4iSazYyuCo0S7e1bRygcs0=;
        b=kl92Hxf0vxTlsS+u/UkVywkeTJUTpGnaKE0ayyS6sf8dbtAeL3srlTSSmfM6UC0RG2
         UipUqbPiMFCWq1cPl/0QyL8kzjpTMySWNyzGa7wtQMTlk1SU1i7WoJLKAs3WPBs8F7Kq
         N4RxlVmVTZhEqs5yirGvq+oeEjR6OJ9RtAYILloCeEjo96OI7kwNL1hIMymFFSAYfhdu
         jfQ9oTHkyYFCpJK5zIkZxr9QHQ8DlEiFdTaqFw9RamvUb0tNJ2beVMIDpqpkvaanZZbB
         1hSRpeaZWdeyb80LnY4QUAX0QAYqIC4Oi41l09KfNZqK+VP1GTr9hP8EJtzKEJcBE0+y
         8/uQ==
X-Gm-Message-State: APjAAAXOrZlc0uO4cwMRYlcZU3/WzWfxp1HL/bMEgRrDoXJLXHtkWfEO
        rVe3cAWqzf82xGYiFADm08abCKI7uJIeO0iK48CHm61oJ5b1eH0E0nZsYPE7zIRYANLIa02a7Gu
        xKgwlcfIh/Fr4br/0CFkh/yziwVweLYw+B1dfOeHIaAe2fL60sA8OAX2gzYl0ymsbn5Yqc6ViIw
        ==
X-Google-Smtp-Source: APXvYqy1I0T2RznoZBIAZHz1ZycW5zp0FNQ2BqBgFJcTQhQ0sGTItLuIl2RAtobbXZlg1MiPJkKBkUa+QnWhSe+HluQ=
X-Received: by 2002:a0c:fe82:: with SMTP id d2mr39629341qvs.123.1568582286294;
 Sun, 15 Sep 2019 14:18:06 -0700 (PDT)
Date:   Sun, 15 Sep 2019 14:18:01 -0700
Message-Id: <20190915211802.207715-1-masayasuzuki@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH 0/1] fetch: Cache the want OIDs for faster lookup
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When mirroring a repository with a lot of refs, there is a case where the client
takes a long time to calculate the want OIDs. This is observable with Chromium's
repository for example.

$ mkdir testing
$ cd testing
$ git init . --bare
$ git remote add origin master https://chromium.googlesource.com/chromium/src --mirror=fetch
$ git fetch origin

With the commands above, it takes a long time before sending a fetch request. I
stopped the command after 15 minutes.

Debugging this, it seems most of the time is spent on iterating the want refs to
see OIDs are included there. This patch speeds up this process by using oid_set.
Now the client can send a fetch request almost immediately.

Masaya Suzuki (1):
  fetch: Cache the want OIDs for faster lookup

 builtin/fetch.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.23.0.237.gc6a4ce50a0-goog


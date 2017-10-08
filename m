Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0041FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 18:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdJHSYl (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 14:24:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbdJHSYk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 14:24:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67284821C1
        for <git@vger.kernel.org>; Sun,  8 Oct 2017 18:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 67284821C1
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=fweimer@redhat.com
Received: from oldenburg.str.redhat.com (ovpn-116-76.ams2.redhat.com [10.36.116.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F295A60BE1
        for <git@vger.kernel.org>; Sun,  8 Oct 2017 18:24:39 +0000 (UTC)
To:     git@vger.kernel.org
From:   Florian Weimer <fweimer@redhat.com>
Subject: Special strings in commit messages
Message-ID: <f54bea17-c245-c644-f974-ca2ac84901c6@redhat.com>
Date:   Sun, 8 Oct 2017 20:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 08 Oct 2017 18:24:40 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a commit which looks like this:

$ git cat-file commit 4ca76eb7b47724c2444dfea7890fa8db4edd5762
tree c845be47a0653624b1984d0dc1a0b485b527811d
parent 9eee98638ef06149e17f94afaa357e3a9e296e69
author Florian Weimer <fweimer@redhat.com> 1507481682 +0200
committer Florian Weimer <fweimer@redhat.com> 1507481682 +0200

19: glibc-fedora-nis-rh188246.patch

 From baba5d9461d4e8a581ac26fe4412ad783ffc73e7 Mon Sep 17 00:00:00 2001
From: Jakub Jelinek <jakub@redhat.com>
Date: Mon, 1 May 2006 08:02:53 +0000
Subject: [PATCH] Enable SETENT_BATCH_READ nis/nss option by default

* Mon May  1 2006 Jakub Jelinek <jakub@redhat.com> 2.4.90-4
- SETENT_BATCH_READ /etc/default/nss option for speeding up
   some usages of NIS+ (#188246)


This commit causes git rebase to fail, with this error:

fatal: could not parse .git/rebase-apply/0008

At this point, .git/rebase-apply/0008 contains this:

“
 From baba5d9461d4e8a581ac26fe4412ad783ffc73e7 Mon Sep 17 00:00:00 2001
From: Jakub Jelinek <jakub@redhat.com>
Date: Mon, 1 May 2006 08:02:53 +0000
Subject: [PATCH] Enable SETENT_BATCH_READ nis/nss option by default

* Mon May  1 2006 Jakub Jelinek <jakub@redhat.com> 2.4.90-4
- SETENT_BATCH_READ /etc/default/nss option for speeding up
   some usages of NIS+ (#188246)
---
  nis/nss | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nis/nss b/nis/nss
index 
0ac6774a1ff29f012efaec9c4be1fcc3b83da7e8..d720e719267db5f741b67e7b98e4052e503c4333 
100644
”

Followed by the diff.  The preceding patch, .git/rebase-apply/0007, is:

“
[fweimer@oldenburg glibc-patches]$ cat .git/rebase-apply/0007
 From 4ca76eb7b47724c2444dfea7890fa8db4edd5762 Mon Sep 17 00:00:00 2001
From: Florian Weimer <fweimer@redhat.com>
Date: Sun, 8 Oct 2017 18:54:42 +0200
Subject: 19: glibc-fedora-nis-rh188246.patch


”

Based on strace output, something in git rebase calls git mailsplit, and 
it probably sees the "\nFrom " string and treats it as a start of a new 
mail message, and things go downhill from there.

I will escape "\nFrom " in commit messages (probably as "\n.From " or 
maybe "\n>From ", plus escaping for "\n."/"\n>" to make the encoding 
reversible), but I wonder if there is something else I need to escape 
while I'm at it.

Thanks,
Florian

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D5FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5966D60F9E
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJTBIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:08:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36980 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229627AbhJTBIp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 21:08:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D488F60734;
        Wed, 20 Oct 2021 01:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634691992;
        bh=qV+5/eCQDqbjAr39UhEvgya26btZKdThDZPlDmhTUmw=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Y/7qsIpdNnQganqd3+Tlz+Eyjh/bTts4P+odkJUzpME+d5Kc+nr0IuBYjNMFi+CQG
         TKfxfRyIfkuLXkxa3YaeoSgJ4mfpGugiikr5bgrM6mr9BwHO9Nui81/fJOBcPpyOdq
         eOJEw82ue7E0VzuuXaTbQOZZn68QOe5u9NZ7TEQiXI9MQQkV5PHQcu2GKkh69HozpQ
         1WMYByQav3kw7wYbVGWSdaOTSC1YOewsiGk8Qc59liWDeX/d6u3v14tLL4F+XaPZvF
         Wev4HQI/EHA4SG+zSHdDBk/WkIgEJhw22A+ifhalNAf+uYdee+Gb17K9X0uIXeBuXj
         62I4zxX1k9SHbwQWWLdSfqTJCj0/qGmox9fKhuTBghiut0jZuVrv/1W3IszEsycWp2
         yKiOUHDdbbJHrHdsC4saa+/kA1eTNWuIJdFLMjaSSqPFQC8wiSw12/IbHHfjoIanrQ
         vSiKrACTiYCws3jZjjsKapNb/YVc4/TjKueifxWHLOKYX2m6AoY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/4] Additional FAQ entries
Date:   Wed, 20 Oct 2021 01:06:19 +0000
Message-Id: <20211020010624.675562-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces some additional Git FAQ entries on various
topics.  They are all things I've seen in my professional life or on
Stack Overflow, and I tire of repeating myself, so I've written
documentation.

The first covers monorepos.  It tries to strike a neutral tone and
indicate that we're improving support for them, but it does note that
many large users still run into scale problems, especially at a point
where it's inconvenient to change[0].  I do frequently see these problems
on some scale, so my hope is that we can make users consider this case
carefully.  I have mentioned only scalability features which are
released and reasonably mature, but if I've missed any that I should
have mentioned, please let me know, since I don't always follow the list
as closely as I should.

The second covers proxies, in the generic sense of that word.  It
instructs users how to use an HTTP proxy intentionally, and it also
notes that any proxy which buffers or tampers with the data will break
Git.  I frequently see users with TLS middleboxes or antivirus software
other than the Windows default with breakage on Stack Overflow[1], and
we see them occasionally on the list as well.  Because these tools are
known to cause both functionality and security problems, both for Git
and in general[2][3][4], we explicitly recommend against them here.  I
am happy to provide additional citations to Project Zero, various bug
reports, security experts, and the cryptographic literature if folks
have doubts about whether this is the right approach.

The third should be relatively uncontroversial.  We discuss using eol
attributes in gitattributes, which we had neglected to cover before, and
illustrate their utility.  In addition, we fix a reference.

The fourth and final patch covers syncing working trees.  An earlier
version of this patch has come up on the list before and I had never
sent a rerolled version.  I realize that we don't love that people want
to do this, but users are currently using cloud syncing services and
experiencing data loss, so I figured we'd better tell them how to do it
as safely as they can so they stop losing data.

I realize that folks are busy with the Contributor Summit and other
things, and so of course reviews may be delayed.  I've tried to pick
people who I think will have relevant interest in each of these areas,
but of course feedback from anyone is welcome.

[0] For instance, the Windows repo.
[1] In addition to users for whom SSH "magically" works when HTTPS does
    not, many of which are likely the same issue.
[2] https://robert.ocallahan.org/2017/01/disable-your-antivirus-software-except.html
[3] https://twitter.com/parityzero/status/826489070310207489
[4] https://groups.google.com/g/mozilla.dev.platform/c/Bh8U0DLHrCc

brian m. carlson (4):
  gitfaq: add advice on monorepos
  gitfaq: add documentation on proxies
  gitfaq: give advice on using eol attribute in gitattributes
  gitfaq: add entry about syncing working trees

 Documentation/gitfaq.txt | 107 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 6 deletions(-)


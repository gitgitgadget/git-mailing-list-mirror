Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C852C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 21:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbhLJWBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 17:01:13 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:11760 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344474AbhLJWBM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 17:01:12 -0500
Received: from host-84-13-153-69.opaltelecom.net ([84.13.153.69] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mvntX-00051U-7j; Fri, 10 Dec 2021 21:57:35 +0000
Message-ID: <e30ae0dd-739b-7ecd-735e-992395b31ccc@iee.email>
Date:   Fri, 10 Dec 2021 21:57:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-GB
To:     Git List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.email>
Subject: New (better?) hash map technique in limit case.
Cc:     Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently I saw a report [1] on a new theoretical result about how to
manage hash maps which get nearly 'full', which beats Knuth's limit
formula. The full paper is at [2]

As I understand it, the method adds the gravestone entries early during
has collisions to avoid clumping of such collision insertions, rather
than always having to enter the collision list at the end. This keeps
the available slots relatively randomly spaced.

It feels like the old random bus arrival problem where the average wait
for next bus is identical to the average time since the last bust, which
is the same as the average bus interval (thus 1 + 1 = 1), and the
technique maintains that advantageous perception.

Given Git's use of hashes, it sounds like it could have uses, assuming
the theory pans out. I've not yet gone through the paper itself [2] but
hope springs eternal.

Philip

[1]
S. Nadis and M. I. of Technology, “Theoretical breakthrough could boost
data storage.”
https://techxplore.com/news/2021-11-theoretical-breakthrough-boost-storage.html
(accessed Nov. 18, 2021).

[2]
M. A. Bender, B. C. Kuszmaul, and W. Kuszmaul, “Linear Probing
Revisited: Tombstones Mark the Death of Primary Clustering,”
arXiv:2107.01250 [cs, math], Jul. 2021, Accessed: Nov. 18, 2021.
[Online]. Available: http://arxiv.org/abs/2107.01250

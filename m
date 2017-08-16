Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B7F1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbdHPUZG (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:25:06 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:56193 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbdHPUZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 16:25:06 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Wed, 16 Aug 2017 22:25:05 +0200
  id 0000000000000096.000000005994AA21.0000546F
Date:   Wed, 16 Aug 2017 22:25:04 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     git@vger.kernel.org
Subject: git add -p breaks after split on change at the top of the file
Message-ID: <20170816202442.aumzwa443spqgyul@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

The following session reproduces the issue with Git 2.14.1:

    $ git init test
    $ cd test
    $ echo x >file
    $ git add file
    $ git commit -m commit
    $ printf 'a\nb\nx\nc\n' >file

    $ git add -p
    diff --git a/file b/file
    index 587be6b..74a69a0 100644
    --- a/file
    +++ b/file
    @@ -1 +1,4 @@
    +a
    +b
     x
    +c
    Stage this hunk [y,n,q,a,d,/,s,e,?]? <-- press s
    Split into 2 hunks.
    @@ -1 +1,3 @@
    +a
    +b
     x
    Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]? <-- press e

    Now delete the line "+a" in your editor and save.

    error: patch failed: file:1
    error: file: patch does not apply

I expected git add -p to stage this change without error. It
works fine without splitting the hunk (by deleting the first and
last + line in the diff).

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

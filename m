Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986681F770
	for <e@80x24.org>; Mon, 31 Dec 2018 10:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeLaKld convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 31 Dec 2018 05:41:33 -0500
Received: from smtp.msys.ch ([46.175.8.2]:15492 "EHLO sleipnir.msys.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeLaKld (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 05:41:33 -0500
X-Greylist: delayed 756 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2018 05:41:32 EST
Received: from mail.msys.ch (smtp.msys.ch [46.175.8.2])
        by sleipnir.msys.ch (8.14.3/8.14.3) with ESMTP id wBVCHIx3004831
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 31 Dec 2018 12:17:19 GMT
Received: from dev.arcapos.ch (dev.arcapos.ch [46.175.8.141])
        (authenticated bits=0)
        by mail.msys.ch (8.14.3/8.14.3) with ESMTP id wBVCHH2J001140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 31 Dec 2018 12:17:17 GMT
From:   Marc Balmer <marc@msys.ch>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
Message-Id: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch>
Date:   Mon, 31 Dec 2018 11:28:47 +0100
Cc:     roger.strain@swri.org, gitster@pobox.com
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
X-SMTP-Vilter-Version: 1.3.6
X-Spamd-Symbols: BAYES_00,RCVD_IN_DNSWL_LOW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

One of the last three commits in git-subtree.sh introduced a regression leading to a segfault.

Here is the error message when I try to split out my i18n files:

$ git subtree split --prefix=i18n
cache for e39a2a0c6431773a5d831eb3cb7f1cd40d0da623 already exists!
   (Lots of output omitted)
436/627 (1819) [1455]       <- Stays at 436/ while the numbers in () and [] increase, then segfaults:
/usr/libexec/git-core/git-subtree: line 751: 54693 Done                    eval "$grl"
    54694 Segmentation fault      (core dumped) | while read rev parents; do
   process_split_commit "$rev" "$parents" 0;
done

Please note that this regression can not easily be reproduced, normally a subtree split just works.

Reverting the last three commits "fixes" the issue.  So I kindly ask the last three commits to be reverted.





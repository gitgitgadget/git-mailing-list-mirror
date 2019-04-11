Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381AF20248
	for <e@80x24.org>; Thu, 11 Apr 2019 19:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDKTt2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 15:49:28 -0400
Received: from amber.ccs.neu.edu ([129.10.116.51]:47543 "EHLO
        amber.ccs.neu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKTt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 15:49:28 -0400
X-Greylist: delayed 1983 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2019 15:49:27 EDT
Received: from zimbra.ccs.neu.edu ([129.10.117.202])
        by amber.ccs.neu.edu with esmtps (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <cgemici@ccs.neu.edu>)
        id 1hEfBj-0000L5-Qd
        for git@vger.kernel.org; Thu, 11 Apr 2019 15:16:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.ccs.neu.edu (Postfix) with ESMTP id A418F1B20002
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 15:16:23 -0400 (EDT)
Received: from zimbra.ccs.neu.edu ([127.0.0.1])
        by localhost (zimbra.ccs.neu.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YhinO5hKb2e2 for <git@vger.kernel.org>;
        Thu, 11 Apr 2019 15:16:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.ccs.neu.edu (Postfix) with ESMTP id 5CFC31B20003
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 15:16:23 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zimbra.ccs.neu.edu
Received: from zimbra.ccs.neu.edu ([127.0.0.1])
        by localhost (zimbra.ccs.neu.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2RuJGA5QiBu7 for <git@vger.kernel.org>;
        Thu, 11 Apr 2019 15:16:23 -0400 (EDT)
Received: from zimbra.ccs.neu.edu (localhost [127.0.0.1])
        by zimbra.ccs.neu.edu (Postfix) with ESMTP id 030481B20002
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 15:16:22 -0400 (EDT)
Date:   Thu, 11 Apr 2019 15:16:22 -0400 (EDT)
From:   Can Gemicioglu <cgemici@ccs.neu.edu>
To:     git@vger.kernel.org
Message-ID: <408662419.10955610.1555010182939.JavaMail.zimbra@zimbra.ccs.neu.edu>
Subject: Bug Report for git apply
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.200.205.253]
X-Mailer: Zimbra 8.6.0_GA_1153 (ZimbraWebClient - FF68 (Linux)/8.6.0_GA_1153)
Thread-Topic: Bug Report for git apply
Thread-Index: t/HlgvWcXqWXQB3m0Q8QGjQiRNYV5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed a problem when trying to apply a patch file that contained many separate patches in a single file. Trying to apply this patch gave me a "No such file or directory" error for one of the files in the middle and after looking around I realised this file was also created earlier in the patch. I tested this myself with these steps and saw a similar error:

1. Create a new file and commit.
2. Move the file to a different folder and commit.
3. Create a single patch for these 2 commits by using git format-patch and concatenating the two resulting files (01.patch, 02.patch) into one (combined.patch).
4. Roll back to 2 commits earlier.

At that point if I try to use 'git apply combined.patch', it will throw the same no such file error. However, if I use 'git am combined.patch' instead it works. If I apply the first 2 patches separately instead, using 'git apply 0*' it also works but if I first try to check if it will work with 'git apply --check 0*' it actually throws the same error again.

I'm guessing there's something like a check to make sure the file exists that throws an error even if the file was going to be created by previous commits.

Tested on git version 2.21.0 on Ubuntu 18.04

Best,
Can Gemicioglu

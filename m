Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44477C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 04:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiDGEPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 00:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiDGEPA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 00:15:00 -0400
X-Greylist: delayed 2503 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 21:13:00 PDT
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.18.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911111C42E1
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 21:13:00 -0700 (PDT)
Received: from [94.228.196.57] (helo=[192.168.2.117])
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ncIru-0002Bj-UE
        for git@vger.kernel.org; Thu, 07 Apr 2022 05:31:34 +0200
Message-ID: <100e7faf-af63-7982-04ee-8302799c2f61@syntevo.com>
Date:   Thu, 7 Apr 2022 06:31:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To:     git@vger.kernel.org
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: [BUG?] git stash push fails on removed file pathspec
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Steps:

$git init TestRepo && cd TestRepo
$echo 1 >1.txt
$git add . && git commit -m 1
$git rm 1.txt
$git stash push -- 1.txt
   error: pathspec ':(,prefix:0)1.txt' did not match any file(s) known 
to git
   Did you forget to 'git add'?

At the same time, `git stash push` and `git commit -m 1 -- 1.txt` work 
as expected, stashing/committing removed file.

I tested in these versions and it happens in both:
* 2.36.0.rc0.9.g07330a41d6 (current master)
* 2.35.0

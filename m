Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB08208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 16:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbdHLQDb (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 12:03:31 -0400
Received: from fallback8.mail.ru ([94.100.181.110]:60982 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750864AbdHLQDa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 12:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=QAV0K0engtSr/T1GzW5PHmCLGQSpu5lNK1tXTwKFTts=;
        b=DBG3E0xaaIMwzFhJrURFbgLxkt04oWAAYDYfkPF7OAk4O9whtBci2kRx8Qf8M5mhQ1nzLZ3jQU8UIoZYfC25Q2X7NZXzZyf6kWg+K5SRkNRYOotFASZV8x6oH+wbkd4P58V3iHDlKksZqjzYtNrrt67YNnLKFl3BvlXr7ZoKdQI=;
Received: from [10.161.64.42] (port=53190 helo=smtp34.i.mail.ru)
        by fallback8.mail.ru with esmtp (envelope-from <S-trace@list.ru>)
        id 1dgYsp-0002Ol-ON
        for git@vger.kernel.org; Sat, 12 Aug 2017 19:03:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=QAV0K0engtSr/T1GzW5PHmCLGQSpu5lNK1tXTwKFTts=;
        b=DBG3E0xaaIMwzFhJrURFbgLxkt04oWAAYDYfkPF7OAk4O9whtBci2kRx8Qf8M5mhQ1nzLZ3jQU8UIoZYfC25Q2X7NZXzZyf6kWg+K5SRkNRYOotFASZV8x6oH+wbkd4P58V3iHDlKksZqjzYtNrrt67YNnLKFl3BvlXr7ZoKdQI=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <S-trace@list.ru>)
        id 1dgYsn-0001EU-GK
        for git@vger.kernel.org; Sat, 12 Aug 2017 19:03:25 +0300
To:     git@vger.kernel.org
From:   Soul Trace <S-trace@list.ru>
Subject: [BUG] git am sometimes unable to apply git format-patch output file
Message-ID: <a6e69bd1-b91f-3150-c3a6-9378793e5e43@list.ru>
Date:   Sat, 12 Aug 2017 19:02:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-7FA49CB5: 0D63561A33F958A501632B11F6A9B43F376A17621F56C1CCE2CF9DD8B0AC64B7725E5C173C3A84C35F75EFA33666CBAE51EC3250276A9B985705F49E3A860CEDC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: 5AE72FDDE7364D076C1580B1C8976A1CF12403749330B2B809E9FEA5FBC356A847AE316E8A91DB650B47E63E2143B6554FC8CD6CCD93B9B9DEBF17BCC0047F86E08AD13A84CB3945E91F6811258419373A5DB60FBEB33A8A0DA7A0AF5A3A8387
X-Mras: OK
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

Using git i have found that git am command may sometimes fail to apply 
patch file which was created by the git am command.


Steps to reproduce:

# 1. Clone test repository:

git clone https://github.com/S-trace/git_am_bug_test.git

# 2. Format patch file for last commit:

git format-patch HEAD~

# 3. Go to previous commit:

git checkout HEAD~

# 4. Apply back patch file created in step 2:

git am 0001-UPDATE-Update-ascend_MOGOLIA_ULG_normal.xml.patch

The git am command fails on my machine with the following error message:

Applying: Update ascend_MOGOLIA_ULG_normal.xml
.git/rebase-apply/patch:6522: trailing whitespace.
     </scene>
error: patch failed: ascend_MOGOLIA_ULG_normal.xml:1
error: ascend_MOGOLIA_ULG_normal.xml: patch does not apply
Patch failed at 0001 Update ascend_MOGOLIA_ULG_normal.xml
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


But patch command can handle this patch file:

patch -p1 -i 0001-UPDATE-Update-ascend_MOGOLIA_ULG_normal.xml.patch


Versions information:

git --version
git version 2.11.0

patch --version
GNU patch 2.7.5
Copyright (C) 2003, 2009-2012 Free Software Foundation, Inc.
Copyright (C) 1988 Larry Wall

License GPLv3+: GNU GPL version 3 or later 
<http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Larry Wall and Paul Eggert

uname -a
Linux omen 4.10.0-26-generic #30-Ubuntu SMP Tue Jun 27 09:30:12 UTC 2017 
x86_64 x86_64 x86_64 GNU/Linux

lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 17.04
Release:        17.04
Codename:       zesty


Thank you.


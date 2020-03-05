Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40723C3F2D1
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125AE2073D
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCEPpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:45:12 -0500
Received: from elephants.elehost.com ([216.66.27.132]:30763 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgCEPpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 10:45:11 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 025Fj9hX098949
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 5 Mar 2020 10:45:09 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Git'" <git@vger.kernel.org>
Subject: [Test] t1901 - sparse checkout file when lock is taken fails (subtest 19)
Date:   Thu, 5 Mar 2020 10:45:03 -0500
Message-ID: <018001d5f305$0c709af0$2551d0d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXzA4JCphsLzbqhTjSWmFiauycMuQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

This one has me confused. It fails 100% of the time on NonStop. The test
looks reasonable, as do the messages. I am not certain that test_i18ngrep
works properly - it falls down to the return 1 statement which causes the
test to fail. The error message generated is "File already exists" not "File
exists" as is required in the test. We should not be testing for specific
text content originating from strerror - I thought we had this decision in a
different thread.
https://public-inbox.org/git/xmqq36intlpj.fsf@gitster-ct.c.googlers.com/

Thoughts?

expecting success of 1091.19 'fail when lock is taken':
        test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
        touch repo/.git/info/sparse-checkout.lock &&
        test_must_fail git -C repo sparse-checkout set deep 2>err &&
        test_i18ngrep "File exists" err

error: 'grep File exists err' didn't find a match in:
fatal: Unable to create '/home/ituglib/randall/git/t/trash
directory.t1091-sparse-checkout-builtin/repo/.git/info/sparse-checkout.lock'
: File already exists.   <----- this is the test issue

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.
not ok 19 - fail when lock is taken
#
#               test_when_finished rm -rf
repo/.git/info/sparse-checkout.lock &&
#               touch repo/.git/info/sparse-checkout.lock &&
#               test_must_fail git -C repo sparse-checkout set deep 2>err &&
#               test_i18ngrep "File exists" err
#

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



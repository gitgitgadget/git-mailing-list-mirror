Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AFFC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 17:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBORpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBORpO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 12:45:14 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DC93C297
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:45:07 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31FHilV52272344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 17:44:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Git List'" <git@vger.kernel.org>
Subject: [Bug] Test 1450.91 Fails on NonStop
Date:   Wed, 15 Feb 2023 12:44:59 -0500
Organization: Nexbridge Inc.
Message-ID: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdlBY8/FMyQDMTVMTaCdpq4b73lBSA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 1450.91 fails...

I am not sure what is going on here other than test_must_fail is not
processing the completion code.  This was run on both NonStop platform
variants with sh and bash. The expected file contains what is expected.
actual is empty. There are no very large files anywhere in the trash
directory.

expecting success of 1450.91 'fsck error on gitattributes with excessive
size':
        blob=$(test-tool genzeros $((100 * 1024 * 1024 + 1)) | git
hash-object -w --stdin) &&
        test_when_finished "remove_object $blob" &&
        tree=$(printf "100644 blob %s\t%s\n" $blob .gitattributes | git
mktree) &&
        test_when_finished "remove_object $tree" &&
        cat >expected <<-EOF &&
        error in blob $blob: gitattributesLarge: .gitattributes too large to
parse
        EOF
        test_must_fail git fsck --no-dangling >actual 2>&1 &&
        test_cmp expected actual

+ + git hash-object -w --stdin
+ test-tool genzeros 104857601
blob=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+ test_when_finished remove_object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+ + git mktree
+ printf 100644 blob %s\t%s\n e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
.gitattributes
tree=f8614bda784833ac9ab9e82c4ca296948c6ddd60
+ test_when_finished remove_object f8614bda784833ac9ab9e82c4ca296948c6ddd60
+ cat
+ 1> expected 0<<
error in blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391: gitattributesLarge:
.gitattributes too large to parse
+ test_must_fail git fsck --no-dangling
+ 1> actual 2>& 1
test_must_fail: command succeeded: git fsck --no-dangling
error: last command exited with $?=1
not ok 91 - fsck error on gitattributes with excessive size
#
#               blob=$(test-tool genzeros $((100 * 1024 * 1024 + 1)) | git
hash-object -w --stdin) &&
#               test_when_finished "remove_object $blob" &&
#               tree=$(printf "100644 blob %s\t%s\n" $blob .gitattributes |
git mktree) &&
#               test_when_finished "remove_object $tree" &&
#               cat >expected <<-EOF &&
#               error in blob $blob: gitattributesLarge: .gitattributes too
large to parse
#               EOF
#               test_must_fail git fsck --no-dangling >actual 2>&1 &&
#               test_cmp expected actual
#
1..91
J


--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.




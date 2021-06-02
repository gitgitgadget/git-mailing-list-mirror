Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA281C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6C661DA1
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 17:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFBRyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 13:54:37 -0400
Received: from elephants.elehost.com ([216.66.27.132]:53905 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhFBRyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 13:54:37 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 152HqoA1031730
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 Jun 2021 13:52:50 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: RE: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
Date:   Wed, 2 Jun 2021 13:52:44 -0400
Message-ID: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AddX191tLjJ3tfp+TVWvdQdxkcDxUg==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 2, 2021 4:30 AM, Junio C Hamano wrote:
>Subject: [ANNOUNCE] Git v2.32.0-rc3
>
>A release candidate Git v2.32.0-rc3 is now available for testing at
>the usual places.  It is comprised of 589 non-merge commits since
>v2.31.0, contributed by 84 people, 31 of which are new faces [*].

Here is the current -x output from t5300. That last known working version was 2.31.1.

<snip>
ok 1 - setup

expecting success of 5300.2 'pack without delta':
        packname_1=$(git pack-objects --progress --window=0 test-1 \
                        <obj-list 2>stderr) &&
        check_deltas stderr = 0

+ + git pack-objects --progress --window=0 test-1
+ 0< obj-list 2> stderr
packname_1=
error: last command exited with $?=128
not ok 2 - pack without delta
#
#               packname_1=$(git pack-objects --progress --window=0 test-1 \
#                               <obj-list 2>stderr) &&
#               check_deltas stderr = 0
#

Working area is:
-rw-rw-r-- 1 JENKINS.JENKINS JENKINS    4096 Jun  2 12:47 a
-rw-rw-r-- 1 JENKINS.JENKINS JENKINS 2097152 Jun  2 12:47 a_big
-rw-rw-r-- 1 JENKINS.JENKINS JENKINS    4096 Jun  2 12:47 b
-rw-rw-r-- 1 JENKINS.JENKINS JENKINS 2097152 Jun  2 12:47 b_big
-rw-rw-r-- 1 JENKINS.JENKINS JENKINS    4096 Jun  2 12:47 c
-rw-rw-r-- 1 JENKINS.JENKINS JENKINS    4100 Jun  2 12:47 d
-rw-rw-r-- 1 JENKINS.JENKINS JENKINS 4228179 Jun  2 12:48 expect
-rw-rw-r-- 1 JENKINS.JENKINS JENKINS     328 Jun  2 12:48 obj-list
-rw-rw-r-- 1 JENKINS.JENKINS JENKINS     605 Jun  2 12:48 stderr

Stderr contains:
Enumerating objects: 8, done.
Counting objects: 100% (8/8), done.
fatal: fsync error on '.git/objects/pack/tmp_pack_NkPgqN': Interrupted system call

The maximum platform I/O size is 56Kb.

I'm happy to help figure this out but need some direction. I don't know the pack-object code.

Sincerely,
Randall


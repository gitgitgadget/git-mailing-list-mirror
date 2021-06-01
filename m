Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA68C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2FF61378
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhFAPL2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 1 Jun 2021 11:11:28 -0400
Received: from elephants.elehost.com ([216.66.27.132]:10092 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFAPL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 11:11:27 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 151F9i9k010025
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 1 Jun 2021 11:09:44 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: RE: [BUG] t5300 fails tests on NonStop x86 at 2.32.0-rc2
Date:   Tue, 1 Jun 2021 11:09:38 -0400
Message-ID: <00c901d756f8$275a5ab0$760f1010$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AddWSmKEBn6qYzntR323iwR7YFQaVwAqxbYwAABVNiA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 1, 2021 10:52 AM, I wrote:
>To: 'git@vger.kernel.org' <git@vger.kernel.org>
>Subject: RE: [BUG] t5300 fails tests on NonStop x86 at 2.32.0-rc2
>
>On May 31, 2021 2:36 PM, I wrote:
>>To: 'git@vger.kernel.org' <git@vger.kernel.org>
>>Subject: [BUG] t5300 fails tests on NonStop x86 at 2.32.0-rc2
>>
>>This one started at 2.32.0-rc1, AFIAK:
>>
>>expecting success of 5300.2 'pack without delta':
>>        packname_1=$(git pack-objects --progress --window=0 test-1 \
>>                        <obj-list 2>stderr) &&
>>        check_deltas stderr = 0
>>
>>+ + git pack-objects --progress --window=0 test-1
>>+ 0< obj-list 2> stderr
>>packname_1=
>>error: last command exited with $?=128
>>not ok 2 - pack without delta
>>#
>>#               packname_1=$(git pack-objects --progress --window=0
>>test-1 \ #                               <obj-list 2>stderr) && #
>>check_deltas stderr = 0 #
>>
>>Stderr contains:
>>
>>Enumerating objects: 8, done.
>>Counting objects: 100% (8/8), done.
>>fatal: fsync error on '.git/objects/pack/tmp_pack_Y6t3Br': Interrupted
>>system call
>
>I thought this was limited to the NonStop x86, but it also apples to NonStop ia64. Any wisdom on where this might be, so I can
debug?

This may be a recurrence of a MAX_SIZE problem from a few years ago with xread, xwrite. The I/Os that are failing appear to be using
using IO sizes larger than the platform maximum. This will cause fsync to fail with EINTR. Pointers on where this might be, please?

Thanks,
Randall


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DD0C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 13:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEB261413
	for <git@archiver.kernel.org>; Tue, 25 May 2021 13:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhEYNUR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 25 May 2021 09:20:17 -0400
Received: from elephants.elehost.com ([216.66.27.132]:42097 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhEYNUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 09:20:05 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14PDHkkK082315
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 May 2021 09:17:47 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'Jean-No=C3=ABl_AVILA'?=" <jn.avila@free.fr>,
        <git@vger.kernel.org>
References: <036b01d750ed$642b75c0$2c826140$@nexbridge.com> <YKwsSgtfhaGq5z8k@nand.local>
In-Reply-To: <YKwsSgtfhaGq5z8k@nand.local>
Subject: RE: [ANNOUNCE] Git v2.32.0-rc1 - Defect in t0301.3, t1092.6, t5300
Date:   Tue, 25 May 2021 09:17:40 -0400
Message-ID: <037d01d75168$5a5aaea0$0f100be0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQL3YcCf4XS4xcUH/cdSTyimgfP8cQJPnSr7qKGP2rA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 24, 2021 6:44 PM, Taylor Blau wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: 'Junio C Hamano' <gitster@pobox.com>; 'Jean-Noël AVILA' <jn.avila@free.fr>; git@vger.kernel.org
>Subject: Re: [ANNOUNCE] Git v2.32.0-rc1 - Defect in t0301.3, t1092.6, t5300
>
>On Mon, May 24, 2021 at 06:37:29PM -0400, Randall S. Becker wrote:
>> On running the test suite on NonStop, t1092 fails in subtest 6 - but
>> not when run with --verbose and -x, so I can't supply a log. This may
>> be timing related. I wanted to report this in case anyone had any
>> insight on whether there are any possible transient vulnerabilities.
>
>The failure in t1092 sounds should be addressed by
>
>  https://lore.kernel.org/git/pull.960.git.1621886108515.gitgitgadget@gmail.com/
>
>> t0301.3 often has transient failures - which has been experienced for
>> a while. Most importantly, t5300 continues to fail completely on the
>> x86 platform, but not ia64, which I previously reported.
>
>Not sure about these, though.

Thanks will wait for the roll on that one. We had one loggable transient failure in t1096.15:

expecting success of 1092.15 'merge with outside renames':
        init_repos &&

        for type in out-to-out out-to-in in-to-out
        do
                test_all_match git reset --hard &&
                test_all_match git checkout -f -b merge-$type update-deep &&
                test_all_match git merge -m "$type" rename-$type &&
                test_all_match git rev-parse HEAD^{tree} || return 1
        done

+ init_repos
Updating files: 100% (14/14), done.
HEAD is now at 5d0e8a6 initial commit
Updating files: 100% (14/14), done.
HEAD is now at 5d0e8a6 initial commit
Updating files: 100% (14/14), done.
HEAD is now at 5d0e8a6 initial commit
Updating files: 100% (10/10), done.
Updating files: 100% (7/7), done.
Updating files: 100% (10/10), done.
Updating files: 100% (7/7), done.
+ test_all_match git reset --hard
+ test_all_match git checkout -f -b merge-out-to-out update-deep
+ test_all_match git merge -m out-to-out rename-out-to-out
--- full-checkout-err   2021-05-24 22:49:44 +0000
+++ sparse-checkout-err 2021-05-24 22:49:50 +0000
@@ -1 +0,0 @@
Updating files: 100% (5/5), done.
+ return 1
error: last command exited with $?=1
not ok 15 - merge with outside renames
#
#               init_repos &&
#
#               for type in out-to-out out-to-in in-to-out
#               do
#                       test_all_match git reset --hard &&
#                       test_all_match git checkout -f -b merge-$type update-deep &&
#                       test_all_match git merge -m "$type" rename-$type &&
#                       test_all_match git rev-parse HEAD^{tree} || return 1
#               done
#



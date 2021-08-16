Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E627C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6112360F14
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhHPScQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 16 Aug 2021 14:32:16 -0400
Received: from elephants.elehost.com ([216.66.27.132]:53471 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHPScP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 14:32:15 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17GIVdkF077432
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Aug 2021 14:31:39 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com> <YRaYnDR6RlgJRr/P@coredump.intra.peff.net> 
In-Reply-To: 
Subject: RE: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Date:   Mon, 16 Aug 2021 14:31:34 -0400
Message-ID: <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMBTs001OO8pWyP/FbVHKiIK4dspwGtgrwqqRWJPbCAAAa8QA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 16, 2021 2:09 PM, I wrote:
>To: 'Jeff King' <peff@peff.net>
>Cc: 'Junio C Hamano' <gitster@pobox.com>; 'git@vger.kernel.org' <git@vger.kernel.org>
>Subject: RE: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
>
>On August 13, 2021 12:07 PM, Jeff King wrote:
>>On Fri, Aug 13, 2021 at 10:22:19AM -0400, Randall S. Becker wrote:
>>
>>> >Just a report that t0301.9 hung again on 2.32.0-rc1 on the NonStop
>>> >ia64 platform, and t5563.8 hung on the x86 platform. These did not
>>
>>We don't seem to have a t5563. Do you mean t5562?
>Yes.
>
>>
>>> 2.32.0-rc2 passes on the NonStop x86 platform. ia64 is slower and
>>> still running. The test failure is t9001 because there is no sendmail
>>> on the platform. Is there a suitable dependency that I can use add to
>>> bypass this test?
>>
>>Hmm, we shouldn't be depending on platform sendmail for the tests
>>(after all, we do not want to actually send mail!). What does the failure look like?
>
>This looks strange. There is no signal 34 defined by the platform.
>
>test_must_fail: died by signal 34: git send-email --from=Example <nobody@example.com> --to=nobody@example.com --smtp-
>server=/home/git/git/t/trash directory.t9001-send-email/fake.sendmail --transfer-encoding=8bit 0001-Second.patch longline.patch not ok
>33 - reject long lines #
>#               z8=zzzzzzzz &&
>#               z64=$z8$z8$z8$z8$z8$z8$z8$z8 &&
>#               z512=$z64$z64$z64$z64$z64$z64$z64$z64 &&
>#               clean_fake_sendmail &&
>#               cp $patches longline.patch &&
>#               cat >>longline.patch <<-EOF &&
>#               $z512$z512
>#               not a long line
>#               $z512$z512
>#               EOF
>#               test_must_fail git send-email \
>#                       --from="Example <nobody@example.com>" \
>#                       --to=nobody@example.com \
>#                       --smtp-server="$(pwd)/fake.sendmail" \
>#                       --transfer-encoding=8bit \
>#                       $patches longline.patch \
>#                       2>actual &&
>#               cat >expect <<-\EOF &&
>#               fatal: longline.patch:35 is longer than 998 characters
>#               warning: no patches were sent
>#               EOF
>#               test_cmp expect actual
>#
>/

I should point out that all 6 failures in t9001 have the same characteristic - signal 34.


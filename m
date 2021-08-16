Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD92AC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81FA604D7
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhHPUoO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 16 Aug 2021 16:44:14 -0400
Received: from elephants.elehost.com ([216.66.27.132]:25255 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhHPUoN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:44:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17GKhUN7086365
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Aug 2021 16:43:31 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com> <YRaYnDR6RlgJRr/P@coredump.intra.peff.net> <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com> <YRqwIAL/JgJp+RyI@coredump.intra.peff.net>
In-Reply-To: <YRqwIAL/JgJp+RyI@coredump.intra.peff.net>
Subject: RE: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Date:   Mon, 16 Aug 2021 16:43:25 -0400
Message-ID: <01c501d792df$5fcb24b0$1f616e10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMBTs001OO8pWyP/FbVHKiIK4dspwGtgrwqAxbvBFwBEWuByaj0b1hg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 16, 2021 2:36 PM, Jeff King wrote:
>To: Randall S. Becker <rsbecker@nexbridge.com>
>Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org
>Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
>
>On Mon, Aug 16, 2021 at 02:31:34PM -0400, Randall S. Becker wrote:
>
>> >33 - reject long lines #
>> >#               z8=zzzzzzzz &&
>> >#               z64=$z8$z8$z8$z8$z8$z8$z8$z8 &&
>> >#               z512=$z64$z64$z64$z64$z64$z64$z64$z64 &&
>> >#               clean_fake_sendmail &&
>> >#               cp $patches longline.patch &&
>> >#               cat >>longline.patch <<-EOF &&
>> >#               $z512$z512
>> >#               not a long line
>> >#               $z512$z512
>> >#               EOF
>> >#               test_must_fail git send-email \
>> >#                       --from="Example <nobody@example.com>" \
>> >#                       --to=nobody@example.com \
>> >#                       --smtp-server="$(pwd)/fake.sendmail" \
>> >#                       --transfer-encoding=8bit \
>> >#                       $patches longline.patch \
>> >#                       2>actual &&
>> >#               cat >expect <<-\EOF &&
>> >#               fatal: longline.patch:35 is longer than 998 characters
>> >#               warning: no patches were sent
>> >#               EOF
>> >#               test_cmp expect actual
>> >#
>> >/
>>
>> I should point out that all 6 failures in t9001 have the same characteristic - signal 34.
>
>Oh. Then the notion from my other mail of "if it's die(), then other tests would presumably see similar failures" might be true. ;)

When running 

/home/git/git/t/trash directory.t9001-send-email: git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="/home/git/git/t/trash directory.t9001-send-email/fake.sendmail" --transfer-encoding=8bit 0001-Second.patch longline.patch
fatal: longline.patch:35 is longer than 998 characters
warning: no patches were sent
/home/git/git/t/trash directory.t9001-send-email: echo $?
162

So this is strange. Where is perl run? I'd like to catch the completion inside git.


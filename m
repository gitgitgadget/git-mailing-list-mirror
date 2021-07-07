Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2C5C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B1E61CBD
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGGXZb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 7 Jul 2021 19:25:31 -0400
Received: from elephants.elehost.com ([216.66.27.132]:31313 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhGGXZa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 19:25:30 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 167NMbCq058773
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Jul 2021 19:22:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>, "'Jeff King'" <peff@peff.net>
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com>        <patch-2.3-a920a9971e8-20210707T103712Z-avarab@gmail.com> <xmqqo8bdda2j.fsf@gitster.g>
In-Reply-To: <xmqqo8bdda2j.fsf@gitster.g>
Subject: RE: [PATCH 2/3] strbuf.h API users: don't hardcode 8192, use STRBUF_HINT_SIZE
Date:   Wed, 7 Jul 2021 19:22:32 -0400
Message-ID: <057901d77386$f9496e30$ebdc4a90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIlbOLtgAnMEnBo0WJBBQDIMqEADALU4JwAAmE3g1yqcoMwAA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 7, 2021 6:38 PM, Junio C Hamano wrote:
>To: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>Cc: git@vger.kernel.org; Jeff King <peff@peff.net>
>Subject: Re: [PATCH 2/3] strbuf.h API users: don't hardcode 8192, use STRBUF_HINT_SIZE
>
>Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Change a couple of users of strbuf_init() that pass a hint of 8192 to
>> pass STRBUF_HINT_SIZE instead.
>>
>> Both of these hardcoded occurrences pre-date the use of the strbuf
>> API. See 5242bcbb638 (Use strbuf API in cache-tree.c, 2007-09-06) and
>> af6eb82262e (Use strbuf API in apply, blame, commit-tree and diff,
>> 2007-09-06).
>>
>> In both cases the exact choice of 8192 is rather arbitrary, e.g. for
>> commit buffers I think 1024 or 2048 would probably be a better default
>> (this commit message is getting this commit close to the former, but I
>> daresay it's already way above the average for git commits).
>
>Yes, they are arbitrary within the context of these callers.
>
>I do not think using STRBUF_HINT_SIZE macro in them is the right thing to do at all, as there is no reason to think that the best value for
>the write chunk sizes in these codepath has any linkage to the best value for the read chunk sizes used by strbuf_read() at all.  When
>benchmarking reveals that the best default size for
>strbuf_read() is 16k, you'd update STRBUF_HINT_SIZE to 16k, but how do you tell that it also happens to be the best write buffer size for
>the cache-tree writeout codepath (answer: you don't)?

And benchmark results are going to be highly platform dependent, as we have seen with our exotic platform.
-Randall



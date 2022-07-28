Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BD7C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiG1Qwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiG1Qwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:52:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885366B90
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:52:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E16E8197639;
        Thu, 28 Jul 2022 12:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zRCTFxb8wzGtdBSSd3N7WyCPodOAoMjfG68TS7
        5QF1k=; b=TAKKqc/ZZkEzEOhdy2sVOqfQo1NHI8xDCysQUvA76RwO/LsgnAycPE
        rNu89wF2aBMmy6d/JCA5klHE9hcUgEyNRdkJsTGuR7+c3tJyNc0w8akujQUnl8jc
        ZF1K/r9V2MFDFiTi9HTmDo/wPSpxal93/DHjZRJ21Oa8Vrx3idRrM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D998F197638;
        Thu, 28 Jul 2022 12:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7279A197636;
        Thu, 28 Jul 2022 12:52:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re* --creation-factor=100 does not show code
References: <1196830250.20220726145447@yandex.ru>
        <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
Date:   Thu, 28 Jul 2022 09:52:44 -0700
In-Reply-To: <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr> (Johannes
        Schindelin's message of "Thu, 28 Jul 2022 16:59:32 +0200 (CEST)")
Message-ID: <xmqqo7x9ch7n.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4381142-0E95-11ED-8540-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Eugen,
>
> On Tue, 26 Jul 2022, Eugen Konkov wrote:
>
>> $ git range-diff --creation-factor=100 branch...origin/branch
>> 1:  a87daecd47 < -:  ---------- Add mocked exchanges for ...::AutoRenew::General test
>> -:  ---------- > 1:  36eaeb56a9 Add mocked exchanges for ...::AutoRenew::General test
>> 2:  9594ccf145 = 2:  70681dd13b Remove a call to DB::state
>> 3:  740903e01c = 3:  5745ae5702 Run cpanm without tests
>> 4:  e8e6cac09c < -:  ---------- Do not use 'require'
>>
>> --creation-factor=101 does =)
>>
>> but maximum value for percentage is 100. So expected behaviour is to display range-diff when value 100 was provided
>
> Please see https://git-scm.com/docs/git-range-diff#_algorithm for an
> explanation what the meaning of the factor is, and why 100 is not the
> maximal sensible value.

When I had to give a huge value to the option the last time, I think
I used --creation-factor=999 or something.  The thing that bugged me
in the output of "git range-diff --help" is that SYNOPSIS section
has "--creation-factor=<factor>" but the OPTIONS heading says
"--creation-factor=<percent>" and the word is used in description as
well.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: range-diff: clarify --creation-factor=<factor>

The value is not a per-cent that ranges from 0 to 100.  The SYNOPSIS
section gets it right, but the body of the documentation said "percent"
which confused readers.

While we are at it, rephrase "smaller one" that corresponds to
"larger value" earlier in the sentence to "smaller value" to be more
explicit, to avoid misleading eyes of the readers to an unrelated "a
large change" nearby.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-range-diff.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/Documentation/git-range-diff.txt w/Documentation/git-range-diff.txt
index fe350d7f40..e49630e8ad 100644
--- c/Documentation/git-range-diff.txt
+++ w/Documentation/git-range-diff.txt
@@ -61,11 +61,11 @@ This is known to `range-diff` as "dual coloring". Use `--no-dual-color`
 to revert to color all lines according to the outer diff markers
 (and completely ignore the inner diff when it comes to color).
 
---creation-factor=<percent>::
-	Set the creation/deletion cost fudge factor to `<percent>`.
+--creation-factor=<factor>::
+	Set the creation/deletion cost fudge factor to `<factor>`.
 	Defaults to 60. Try a larger value if `git range-diff` erroneously
 	considers a large change a total rewrite (deletion of one commit
-	and addition of another), and a smaller one in the reverse case.
+	and addition of another), and a smaller value in the reverse case.
 	See the ``Algorithm`` section below for an explanation why this is
 	needed.
 



Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653CC3E8C5
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBA321D46
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JoMd/GQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKRSPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:15:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53285 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgKRSPi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:15:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E0D810CF50;
        Wed, 18 Nov 2020 13:15:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k/qzcN/pRmn3dERPL0PsdEHdmJc=; b=JoMd/G
        QXMmt9UA8BE6Bwe6U3dYTuaeEbzGypCUR2EgZV30pDOsSOzrFIZzCFA4CP6olCZ6
        2peF7S1Vru7tmRYSB54NPYdTPSziCRs2LHs2U4zGZ96OTqFrS4peHNWm1q4+GNhD
        qPndPrXn0qLlRyP6Ar1Zjc+88QWxLpecVjebg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=haWM1YJz6po/x0TtnmxZoF0I/ekX5ymk
        J2VDPGV/beHVCCPHue2mYU0+nNWSkm4fuG8aWiJFH/zRsmzVCDr3ExdMP4xX8p10
        tyjo1VyPXzdjvK2NRw8U48CYsGCHqXLnj4E2ANgXe74GI2LG6Ffrk/qEl33uzORG
        lbudmbNHlco=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2692210CF4D;
        Wed, 18 Nov 2020 13:15:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1CDA410CF4C;
        Wed, 18 Nov 2020 13:15:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH v4] help.c: expand options for help.autocorrect
References: <20201118172849.24715-1-sir@cmpwn.com>
        <xmqq1rgq35my.fsf@gitster.c.googlers.com>
Date:   Wed, 18 Nov 2020 10:15:31 -0800
In-Reply-To: <xmqq1rgq35my.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 18 Nov 2020 10:02:29 -0800")
Message-ID: <xmqqwnyi1qgs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C4B3D9E-29CA-11EB-8483-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Drew DeVault <sir@cmpwn.com> writes:
>
>> Some users would prefer to never suggest corrections at all.
>
> Here is how I would have phrased it.
>
> Key points:
>
>  - The log message starts with the description of the current state
>    of the system and introduces the problem the patch tries to
>    solve.
>
>  - Then gives orders to the codebase to "be like so"
>
>  - The addition of "never" is the primary change to solve the stated
>    problem.  "immediate" is not the essential part but is merely
>    adding a synonym while we are in the vicinity.
>
> Thanks.

Also, I think we would want _some_ test, as the base form of
help.autocorrect is already tested.  Perhaps something like this.

 t/t9003-help-autocorrect.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git c/t/t9003-help-autocorrect.sh w/t/t9003-help-autocorrect.sh
index b1c7919c4a..8f1035c3c2 100755
--- c/t/t9003-help-autocorrect.sh
+++ w/t/t9003-help-autocorrect.sh
@@ -49,4 +49,17 @@ test_expect_success 'autocorrect running commands' '
 	test_cmp expect actual
 '
 
+test_expect_success 'autocorrect can be declined altogether' '
+	git config help.autocorrect never &&
+
+	test_must_fail git lfg 2>actual &&
+	if test_have_prereq C_LOCALE_OUTPUT
+	then
+		: cannot test with poisoned i18n
+	else
+		grep "is not a git command" actual &&
+		test_line_count = 1 actual
+	fi
+'
+
 test_done

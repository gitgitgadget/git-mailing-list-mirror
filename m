Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08CCC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 05:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86464613C8
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 05:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244081AbhI2Fft (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 01:35:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64706 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbhI2Ffs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 01:35:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78C65F5D0A;
        Wed, 29 Sep 2021 01:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pTb6hq2E3o2++HoJkaxlFTNmLimyHVOzS7xnQK
        88QVA=; b=YCht6smNd8V/dyYULXpepXVnNCdzrSoBlBo9TF1fVPHqBUo+f1gZLF
        RoTUXb5QyPcvEA/HjAUoBtu8upVh/aU6CmJocr1mi2ZI9TBjv6t1mD8kBFXJbxIm
        /ws2kPB/JKr7QyR/1cqFRXdh1v3eMeqitTzo3+MR/EDGDN/Xvq6vM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DF36F5D09;
        Wed, 29 Sep 2021 01:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97188F5D08;
        Wed, 29 Sep 2021 01:34:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 1/2] grep: refactor next_match() and
 match_one_pattern() for external use
References: <20210929011952.611792-1-someguy@effective-light.com>
Date:   Tue, 28 Sep 2021 22:34:05 -0700
In-Reply-To: <20210929011952.611792-1-someguy@effective-light.com> (Hamza
        Mahfooz's message of "Tue, 28 Sep 2021 21:19:51 -0400")
Message-ID: <xmqqfstoeyia.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD248E3E-20E6-11EC-9C8B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Needs a magic comment to squelch a compiler warning.

grep.c:1187:8: error: this statement may fall through [-Werror=implicit-fallthrough=]

 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index 6f8bc95703..fe847a0111 100644
--- a/grep.c
+++ b/grep.c
@@ -1187,6 +1187,7 @@ int grep_next_match(struct grep_opt *opt,
 				if ((field != GREP_HEADER_FIELD_MAX) &&
 				    (p->field != field))
 					continue;
+				/* fall thru */
 			case GREP_PATTERN: /* atom */
 			case GREP_PATTERN_BODY:
 				hit |= match_next_pattern(p, bol, eol, ctx,
-- 
2.33.0-839-gdb857d08e8


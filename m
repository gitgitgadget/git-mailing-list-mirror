Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCA6207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 01:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756750AbcI0BWP (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 21:22:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61590 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756436AbcI0BWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 21:22:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B59B6423A9;
        Mon, 26 Sep 2016 21:22:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id; s=sasl; bh=PRIL4sMGD7ZGxf/hWO+t2e5p/i0
        =; b=LaBPDQwrBlIbBYG2HyYSwCAOzdp5P7wy+mEbPgoT9uRDQMRgIcCZm/QM/hI
        BbiTj+wDp7v2MBLksDM2nzWQxgpHG2QTS3bDwWUYrn9DLGZOFQEXp/himLGQPqxd
        FjwSdruhZkkskjQYPIMTkSJ6FjYdT+RMl9jhy0HidrGIehmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id; q=dns; s=sasl; b=lB1J96Et0VmWFY4u2oROXljOJRFZi
        BNB1bfpWcxD1sGzCsZbWf/qcG4UGfJmdcC6LkFENWrJIfM/RjPrAUIoK7Sfm/Qhx
        QAI0BFXhlN2l8SH0jFt8nZTXmYNud9f37flDm8ymRYAQld2CYXlDtqg/7DXjZp1a
        x3H47IQ4/mrJ88=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE72F423A8;
        Mon, 26 Sep 2016 21:22:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 318A7423A7;
        Mon, 26 Sep 2016 21:22:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] Locally alias "latin-1" to "ISO-8859-1"
Date:   Mon, 26 Sep 2016 18:22:09 -0700
Message-Id: <20160927012211.9378-1-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-556-g5bbc40b
X-Pobox-Relay-ID: D1B8827C-8450-11E6-A81D-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some systems do not seem to ship "latin-1" as a valid locale, even
though they happilly accept more modern official name "ISO-8859-1".
Naturally, "iconv -f iso-8859-1" succeeds while "iconv -f latin-1"
fails on such a system.

We already have in utf8.c to accomodate overly strict iconv_open()
that does not like various spellings of UTF-8 when our users spell
it differently from the most official "UTF-8" form.  Piggyback on
the mechanism and teach outselves that "latin-1" used to be the way
to say "ISO-8859-1".

I feel dirty for doing it this way, but I found it the easiest
workaround to apply recent patches we saw on the mailing list.

Junio C Hamano (2):
  utf8: refactor code to decide fallback encoding
  utf8: accept "latin-1" as ISO-8859-1

 utf8.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

-- 
2.10.0-556-g5bbc40b


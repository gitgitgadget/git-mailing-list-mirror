Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA24207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 20:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbcIZUIi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 16:08:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51823 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753183AbcIZUIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 16:08:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 168F540AA9;
        Mon, 26 Sep 2016 16:08:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1XtTmIIBBr86Up9WeTqlD3kr718=; b=sjBhF8
        7ZJW41QSyksZElSFqTA4I/RNBx0T+0oLECd3+FJUiCcecJ7Ma5OLzDnQGrVO06SR
        Asn0JubdEoy5C+IrKt8ZcfLna7KsqBquiWUDLYO/ws2zcIbMN/UBnip7aNbPGROI
        0tfkp4LjT1XVoNl3oi/3f9BU++C+eTpSnHp1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=shjIVWh2Rv2b0XL/1vxDHwce4wQH5nJn
        cDs4kV4gzYA4+ROEkheItmii9sTZ0w2k56l3r3VzLdq8N2exqRbcsFUr6ZeS4DZ/
        mtlpjrZDtuMWjQRQ5MNRyZn6oejuT8qrHBCUW8oafliLgqus29AWs3Ha8Qge9A02
        tqEcCgcpxIs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E44540AA8;
        Mon, 26 Sep 2016 16:08:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8363C40AA7;
        Mon, 26 Sep 2016 16:08:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 2/2] fsck: handle bad trees like other errors
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
        <1474918365-10937-3-git-send-email-novalis@novalis.org>
Date:   Mon, 26 Sep 2016 13:08:33 -0700
In-Reply-To: <1474918365-10937-3-git-send-email-novalis@novalis.org> (David
        Turner's message of "Mon, 26 Sep 2016 15:32:45 -0400")
Message-ID: <xmqqh992qv9a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01851F3C-8425-11E6-9FC4-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> From: David Turner <dturner@twosigma.com>
>
> Instead of dying when fsck hits a malformed tree object, log the error
> like any other and continue.  Now fsck can tell the user which tree is
> bad, too.
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  fsck.c                                             |  18 +++--
>  t/t1450-fsck.sh                                    |  17 ++++-
>  .../307e300745b82417cc1a903f875c7d22e45ef907       |   4 +

To prevent further headaches in this directory, can we have
.gitattributes that tells us that everything in there are binary
files?  Something like the attached.

The other object was transferred as a binary patch, but I have no
faith in what I applied from your e-mail message for this file that
went though latin-1 to utf-8 conversion X-<.

 t/t1450/bad-objects/.gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1450/bad-objects/.gitattributes b/t/t1450/bad-objects/.gitattributes
new file mode 100644
index 0000000..a173f27
--- /dev/null
+++ b/t/t1450/bad-objects/.gitattributes
@@ -0,0 +1 @@
+[0-9a-f]*[0-9a-f]	-diff



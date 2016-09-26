Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C84207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 20:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754144AbcIZUL7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 16:11:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58627 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753989AbcIZUL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 16:11:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C519141873;
        Mon, 26 Sep 2016 16:11:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z4+Uri5FDwg/RkpSJJ0MzoQOmNo=; b=CMkwoU
        CORUIRZnANDreI63NnFIqPTR0rLyAyKPnG+hT4RVhbJlyTi+nw+/T0YPBJ/gXa3f
        fCrulgdVk3044QTCiTqnjpR1DzxdlpqTjsiEvrUDKIjvvqLZCusNm2YZgtdghXBm
        uT1T++EblDdJTkti8LiA+E+6819ql3R0BIFgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kVRRmpedBefo+ZhuyViwpdWmsRrGrzM0
        dNTjyQra6RgGz0vIwNyewdom0EaQUK0ATJHYny/pAVFOROrxM/CLcDGDGS89vdih
        vFHdVzq3RqEWL6qbP/Ka6P68GuLWfUAvGvo2X6StDqRqS+pCVyhv+WI6gGHpsi7u
        YQ8+MQV7YB0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC30641872;
        Mon, 26 Sep 2016 16:11:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EFDE41871;
        Mon, 26 Sep 2016 16:11:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 2/2] fsck: handle bad trees like other errors
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
        <1474918365-10937-3-git-send-email-novalis@novalis.org>
        <xmqqh992qv9a.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Sep 2016 13:11:55 -0700
In-Reply-To: <xmqqh992qv9a.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 26 Sep 2016 13:08:33 -0700")
Message-ID: <xmqqd1jqqv3o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79C08A86-8425-11E6-8242-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> To prevent further headaches in this directory, can we have
> .gitattributes that tells us that everything in there are binary
> files?  Something like the attached.
>
> The other object was transferred as a binary patch, but I have no
> faith in what I applied from your e-mail message for this file that
> went though latin-1 to utf-8 conversion X-<.
>
>  t/t1450/bad-objects/.gitattributes | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t1450/bad-objects/.gitattributes b/t/t1450/bad-objects/.gitattributes
> new file mode 100644
> index 0000000..a173f27
> --- /dev/null
> +++ b/t/t1450/bad-objects/.gitattributes
> @@ -0,0 +1 @@
> +[0-9a-f]*[0-9a-f]	-diff

I suspect that the t/t1007 directory in 1/2 may deserve a similar
treatment.

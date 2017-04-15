Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB1920D09
	for <e@80x24.org>; Sat, 15 Apr 2017 07:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbdDOHfY (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 03:35:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64965 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751511AbdDOHfW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 03:35:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5C5C791EE;
        Sat, 15 Apr 2017 03:35:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MNw1kUJW16vv
        9zRYn5rdi8fYcb8=; b=MVnbIxp9Kx8r6yhP2W4BNWpPraDpbKCrwBpeBEsWO/cw
        QJhTDuWg8ie/BPaP9xbO8y5y+jrsGok6CBRI+1VGE34ErEENcaYFnA4kElKXqHMC
        yvQhiIHdya2XLktC1/esLyEYTXwid0Bs3wGOwtxJO+LqVIIao9tjphX3ONrt8ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M1iCb7
        JPxs3gliYKihLRiap9ihgsXUULp8IPSskwtgGb3+Hkqvvz0QiLpQfwvEuyHbNciO
        JIncqUTCcaeFaopKCGhdOcLJP5qogHEOE715JpIF0dhf5717xACuDQ+KbVT+RU+7
        KqUUn50SMaTjHX8R/GC5EZR/kwyrq1iC/fXo0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE095791ED;
        Sat, 15 Apr 2017 03:35:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 583A4791EC;
        Sat, 15 Apr 2017 03:35:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, David.Taylor@dell.com
Subject: Re: [PATCH] worktree add: add --lock option
References: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
        <20170412135805.29837-1-pclouds@gmail.com>
Date:   Sat, 15 Apr 2017 00:35:19 -0700
In-Reply-To: <20170412135805.29837-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 12 Apr 2017 20:58:05 +0700")
Message-ID: <xmqqzifim8co.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 141FAC4E-21AE-11E7-A657-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> -	unlink_or_warn(sb.buf);
> +	if (!ret && opts->keep_locked) {
> +		/*
> +		 * Don't keep the confusing "initializing" message
> +		 * after it's already over.
> +		 */
> +		truncate(sb.buf, 0);
> +	} else {
> +		unlink_or_warn(sb.buf);
> +	}

builtin/worktree.c: In function 'add_worktree':
builtin/worktree.c:314:11: error: ignoring return value of 'truncate', de=
clared with attribute warn_unused_result [-Werror=3Dunused-result]
   truncate(sb.buf, 0);
           ^
cc1: all warnings being treated as errors
make: *** [builtin/worktree.o] Error 1

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2282F20899
	for <e@80x24.org>; Fri, 11 Aug 2017 22:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbdHKWPM (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 18:15:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51425 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753627AbdHKWPK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 18:15:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FC9DAC7D7;
        Fri, 11 Aug 2017 18:15:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kI/KLo2ub4jPsdwrI7fkWj81XyM=; b=ocRgGM
        MAfHPz506TXURPtT8xByku9U4GSpAdVTe6/4S0Z5lNfKTINpnSIOr05zvhjWg/dG
        NN7RNDkJOgLYLYzNg+orQ573D0cSgVLkhidxQY59RGhyfsw+sIwXbYjZNUqQFsoF
        Wwflj8+j8paQLSHRBwYsNAEfXSEbErDj9xtec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EHOQAFiI1du2E+9oITJwi3ljgftXmHMc
        RSM7qSRRtvE5kbb64lgJkObjwtyyTLuwLWD28Qn2xaHwB8GYR0Ap/oWTpDL5jmfw
        XZIENZoFy5Vkn9tE7x92QvvM2KmL4llRcto5rOKQ7YDpCZpgSkS8Wk91X4BeS95G
        T4lm25vmsFw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D6CBAC7D6;
        Fri, 11 Aug 2017 18:15:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6996AC7CC;
        Fri, 11 Aug 2017 18:15:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] http: handle curl with vendor backports
References: <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
        <cover.1502462884.git.tgc@jupiterrise.com>
Date:   Fri, 11 Aug 2017 15:15:06 -0700
In-Reply-To: <cover.1502462884.git.tgc@jupiterrise.com> (Tom G. Christensen's
        message of "Fri, 11 Aug 2017 18:37:32 +0200")
Message-ID: <xmqq1sohzr85.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 895133AC-7EE2-11E7-99A2-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tom G. Christensen" <tgc@jupiterrise.com> writes:

> The curl packages provided by Red Hat for RHEL contain several
> backports of features from later curl releases.
> This causes problems with current version based checks in http.c.
>
> Here is an overview of the features that have been backported:
> 7.10.6 (el3) Backports CURLPROTO_*
> 7.12.1 (el4) Backports CURLPROTO_*
> 7.15.5 (el5) Backports GSSAPI_DELEGATION_*
>              Backports CURLPROTO_*
> 7.19.7 (el6) Backports GSSAPI_DELEGATION_*
>              Backports CURL_SSL_VERSION_TLSv1_{0,1,2}
> 7.29.0 (el7) Backports CURL_SSL_VERSION_TLSv1_{0,1,2}
>
> This patch series will update the current version based checks for
> protocol restriction and GSSAPI delegation control support to ones
> based on features to properly deal with the above listed backports.
> The fine grained TLS version support does not seem to be
> distinguishable via a preprocessor macro so I've left that alone.

Thanks; these feature macros ought to be more dependable, and I
think this moves things in the right direction (regardless of which
features we might later pick as mandatory and cut off supports for
older versions).

> I have build tested these changes against upstream curl 7.12.0 (fails),
> 7.12.1 and 7.15.5. I have also built and run the testsuite against the
> Red Hat provided curl versions listed above.

Hmph, what does "(fails)" mean here?

>
> Tom G. Christensen (2):
>   http: Fix handling of missing CURLPROTO_*
>   http: use a feature check to enable GSSAPI delegation control
>
>  http.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

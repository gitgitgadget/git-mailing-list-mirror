Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2C720954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbdLGTRk (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:17:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59420 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752501AbdLGTRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:17:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70DA2C2CFA;
        Thu,  7 Dec 2017 14:17:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a3qZe1XRL6nR15R50ACsxfQWB04=; b=QO1TEx
        Jjb8aHAkuMHesLzcR3gCalFJle3ft0gbfMjDFRNuWXhEbKDex5B22VU/byN642kL
        zJUGUy6pjKEoukgo+Pr+8Jydj5y8HY3AmWbzXT2YcZYX4axeZRBjm2V+19ZGNGND
        sFKrBsGqsP6sszt8Xzhx9EJpjEGKr4yEimUTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QO064IKQPPmxWHvlETRP6sNywfZaDAhp
        GSSBuAsmRECJks85ejGZDPOOC2qpR/bZdEOzjc4yFfyppzpEPHWFCqox/WFfxs83
        O5kAR4kWr/jiGgfrb+cCRTSSoKkaRM6AzR+emh+QA/nnjuCqNckmLJIALL4x5WQ8
        Zw2e4UBKn1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69244C2CF9;
        Thu,  7 Dec 2017 14:17:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6D72C2CF8;
        Thu,  7 Dec 2017 14:17:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] diff: add tests for --relative without optional prefix value
References: <20171207190135.28660-1-jacob.e.keller@intel.com>
Date:   Thu, 07 Dec 2017 11:17:36 -0800
In-Reply-To: <20171207190135.28660-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 7 Dec 2017 11:01:35 -0800")
Message-ID: <xmqq374me4a7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4988109E-DB83-11E7-8D25-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

>  for type in diff numstat stat raw; do
> -	check_$type file2 --relative=subdir/
> -	check_$type file2 --relative=subdir
> -	check_$type dir/file2 --relative=sub
> +	check_$type . file2 --relative=subdir/
> +	check_$type . file2 --relative=subdir
> +	check_$type . dir/file2 --relative=sub
> +	check_$type subdir file2 --relative

OK, I didn't think it would be sensible to unconditionally pass the
directory and use "-C ." as a no-op.  It looks good.

I think the new one should go before the dir/file2 test; all three
earlier tests (including this new one) are about taking a patch
relative to subdir/ spelled in different ways, and the one about
dir/file2 alone is different.

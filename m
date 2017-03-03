Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6A320133
	for <e@80x24.org>; Fri,  3 Mar 2017 21:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbdCCVNw (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 16:13:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50115 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751722AbdCCVNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 16:13:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4370F6659E;
        Fri,  3 Mar 2017 16:08:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nw0dDPrhbrAfxKtwqHa7D8JjSno=; b=NrC2g1
        uv135eiv0wuOPqYkddyWzr+txoyM3/MKrAb+Fk2CdDMohgTKcE6393I9u+m/dOWg
        U/jUhnilfrDvIHA/PvHmqlY0pVYhyxkc4rEXezRYpqkjG3/BQEhN+NeCr1gBD6lJ
        yxc5OEisG1zm+xfCUBGhhD0xHbZqtLnWqW/Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OPFO2dsCBB+ypxIVwQEHdjJYCIWETDD/
        MgU8kyXhwbvN2ZUWARSz/zdHtbjynJjVdwXFKfkNv+SAhrQRFP6tPav3WFxf/smS
        RjyNTTdYaPVACjoB4erwFCUyNXwPXgTfk3yT8DcCDIlYYrgYS6uiZvWebtYk9Jr9
        +srSpHXoAZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C9766659C;
        Fri,  3 Mar 2017 16:08:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E7F96659B;
        Fri,  3 Mar 2017 16:08:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 0/3] Conditional config include
References: <20170224131425.32409-1-pclouds@gmail.com>
        <20170301112631.16497-1-pclouds@gmail.com>
        <20170303063329.ji6do6eqjbpuwmxz@sigill.intra.peff.net>
        <20170303095252.GA12072@ash>
Date:   Fri, 03 Mar 2017 13:08:34 -0800
In-Reply-To: <20170303095252.GA12072@ash> (Duy Nguyen's message of "Fri, 3 Mar
        2017 16:52:52 +0700")
Message-ID: <xmqqwpc66pbh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90A7DFAE-0055-11E7-ADB1-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Mar 03, 2017 at 01:33:29AM -0500, Jeff King wrote:
>> For those following on the mailing list, there is some discussion at:
>> 
>>   https://github.com/git/git/commit/484f78e46d00c6d35f20058671a8c76bb924fb33
>> 
>> I think that is mostly focused around another failing in the
>> error-handling of the config code, and that does not need to be
>> addressed by this series (though of course I'd welcome any fixes).
>> 
>> But there's a test failure that probably does need to be dealt with
>> before this graduates to 'next'.
>
> The patch to fix it is this
>
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index f0cd2056ba..e833939320 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -102,7 +102,7 @@ test_expect_success 'config modification does not affect includes' '
>  
>  test_expect_success 'missing include files are ignored' '
>  	cat >.gitconfig <<-\EOF &&
> -	[include]path = foo
> +	[include]path = non-existent
>  	[test]value = yes
>  	EOF
>  	echo yes >expect &&
>
> Junio could you squash this in?
>

I said yes, but I won't, as the series already has SQUASH??? for
other things, so I'll just queue this at the tip.  I _might_ get
inclined to do the squashing and cleaning up myself later, but
please don't hold your breath.


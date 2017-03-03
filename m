Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E44B20133
	for <e@80x24.org>; Fri,  3 Mar 2017 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbdCCTkD (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 14:40:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60707 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751677AbdCCTkA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 14:40:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 413CB6509F;
        Fri,  3 Mar 2017 14:39:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qjTC1DzxZjAZLDJRlXZ3RFi/i2c=; b=Bt3CY7
        /hr0SzUnVz3ObW8ZWvppoXSFPTlWxqFipNAUQZH/9Epcu5+hkXPnc1DH6xQ2iOBd
        loaj312m4Qt2XbP9PbeDuXsy9JKnPHQgq0FJtFLtqtTNr5lbVN9H3f0nF2F7Xvvp
        QsgYsdh8uK2xTvlkZXSESWDw3JFfHlPRALxes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cZ4jPAZLvRLueN/Xab+bMyVWqG3dqJak
        KzWD5uTNSf+f+T/ePDfwoCLx+SfD65peZAfDp053D+sNrCOulK5KQ6y68OsPrTyN
        ZxHFiYGvNYRw44CVIW0awNNZf3m4lK/GCt/LU9duPUZoeTqwYqkFin4qEONYdmnq
        /kQBWri1+Gk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A3346509E;
        Fri,  3 Mar 2017 14:39:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4F3F6509B;
        Fri,  3 Mar 2017 14:39:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 2/5] Use -y where possible in test t7610-mergetool
References: <20170303134022.GA6258@arch-attack.localdomain>
Date:   Fri, 03 Mar 2017 11:39:30 -0800
In-Reply-To: <20170303134022.GA6258@arch-attack.localdomain> (Denton Liu's
        message of "Fri, 3 Mar 2017 05:40:22 -0800")
Message-ID: <xmqqd1dy880d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F5C953A-0049-11E7-89ED-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In these tests, there are many situations where
> 'echo "" | git mergetool' is used. This replaces all of those
> occurrences with 'git mergetool -y' for simplicity and readability.

"-y where _possible_" is not necessarily a good thing to do in
tests.  We do want to make sure that both "yes" from the input and
"-y" from the command line work.  Changes to "-y" done only for the
tests that are not about accepting the interactive input from the
end-user is a very good idea, but "replaces all of those" makes me
worried.

> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool file1 file1 ) &&
> -	( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
> +	git mergetool -y both >/dev/null 2>&1 &&
> +	git mergetool -y file1 file1 &&
> +	git mergetool -y file2 "spaced name" >/dev/null 2>&1 &&
> +	git mergetool -y subdir/file3 >/dev/null 2>&1 &&

So these replace "the user interactively keeps typing <ENTER>" with
"-y", which sounds good.  These are obviously more about what the
code actually does.

> -	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool "spaced name" >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
> -	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
> +	git mergetool file1 >/dev/null 2>&1 &&
> +	git mergetool file2 >/dev/null 2>&1 &&
> +	git mergetool "spaced name" >/dev/null 2>&1 &&
> +	git mergetool both >/dev/null 2>&1 &&
> +	git mergetool subdir/file3 >/dev/null 2>&1 &&

The reason for the lack of "-y" in the rewrite, in contrast to what
was done in the previous hunk we saw, is not quite obvious.

> @@ -177,7 +177,7 @@ test_expect_success 'mergetool in subdir' '
>  	(
>  		cd subdir &&
>  		test_expect_code 1 git merge master >/dev/null 2>&1 &&
> -		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
> +		git mergetool file3 >/dev/null 2>&1 &&

Likewise, and likewise for the remainder of the patch where the
updated command line does not say "-y".

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64611F406
	for <e@80x24.org>; Fri, 22 Dec 2017 21:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756878AbdLVVIE (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 16:08:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756086AbdLVVID (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 16:08:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36ECFBD01A;
        Fri, 22 Dec 2017 16:08:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Mhyu36Nym2xj
        vi8Exe2OQ/kxKK4=; b=Bbbovf7ZOZLZv8okRdfpHXLdOa9D84dxv4NAFrzEBlfH
        KknVAqeEo/5YjD2j/zoC0NwUIWaU9MejlJ6RwPYfSx0pG15+9vFdnmBTWGq48sJQ
        KwPIX5CZuF5/oNFaPqzXtXR7MMTBgfEwnyUhl5WIFMr6ksjkcZDAiyRWKsrAYp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fnbTXp
        PiX0foqykstU41uPn57avFJgzLLdyKREq5LPngrD9YUF6UhpthCgQqf9AKdfecRt
        8FvDJXcezw281Hk+iVSJUFKzXM5dvT6ynuo92TpmvsJtwwqNHV+gaMgDNJBZu2y3
        nrXLuK6ZjZ40kgk08RucaTmbjI23bWIAA9NRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E9BBBD019;
        Fri, 22 Dec 2017 16:08:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A48A3BD017;
        Fri, 22 Dec 2017 16:08:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/1] check-non-portable-shell.pl: Quoted `wc -l` is not portable
References: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
        <20171221212646.24461-1-tboegi@web.de>
Date:   Fri, 22 Dec 2017 13:07:59 -0800
In-Reply-To: <20171221212646.24461-1-tboegi@web.de> (tboegi@web.de's message
        of "Thu, 21 Dec 2017 22:26:46 +0100")
Message-ID: <xmqq4loiqxn4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 326A1E86-E75C-11E7-AF41-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

I'll flip these and add a helped-by to credit Eric.

    check-non-portable-shell.pl: `wc -l` may have leading WS
   =20
    Test scripts count number of lines in an output and check it againt
    its expectation.  fb3340a6 ("test-lib: introduce test_line_count to
    measure files", 2010-10-31) introduced a helper to show a failure in
    such a test in a more readable way than comparing `wc -l` output with
    a number.
   =20
    Besides, on some platforms, "$(wc -l <file)" is padded with leading
    whitespace on the left, so
   =20
            test "$(wc -l <file)" =3D 4
   =20
    would not work (most notably on macosX); the users of test_line_count
    helper would not suffer from such a portability glitch.
   =20
    Add a check in check-non-portable-shell.pl to find '"' between
    `wc -l` and '=3D' and hint the user about test_line_count().
   =20
    Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
    Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

> ---
>  t/check-non-portable-shell.pl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
.pl
> index 03dc9d285..e07f02843 100755
>
> Use () around the hint.
> Thanks to Eric for the sharp eyes.
>
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl

Don't try to apply this patch to your tree yourself ;-)

> @@ -21,6 +21,7 @@ while (<>) {
>  	/^\s*declare\s+/ and err 'arrays/declare not portable';
>  	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
>  	/\btest\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (=
please use =3D)';
> +	/\bwc -l.*"\s*=3D/ and err '`"$(wc -l)"` is not portable (please use =
test_line_count)';
>  	/\bexport\s+[A-Za-z0-9_]*=3D/ and err '"export FOO=3Dbar" is not port=
able (please use FOO=3Dbar && export FOO)';
>  	# this resets our $. for each file
>  	close ARGV if eof;

Thanks.  The dq before \s*=3D is rather cute ;-)


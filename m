Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C51E20C11
	for <e@80x24.org>; Wed,  6 Dec 2017 21:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbdLFVjZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 16:39:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58672 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751610AbdLFVjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 16:39:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70008B165E;
        Wed,  6 Dec 2017 16:39:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yX0proIVQvyz
        GHM9F9e8VKK3tkU=; b=eJ1YRLzUop5Fxg5lE/AKCo4mCu5KlfONkGX9f0kwnpeI
        N4OiZoH+CQPJdAvE/b9Z8jZVzXHzm2qrHTwvGQq1kGfX3jwwqHf2MoNDFOo2M1Fd
        tfErMCiSN+q+PYMQktUuOUVkyJz0raMmwES4uZrWRFpYcwcsTyc+DQDBtkGpssQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ifSCa0
        iodIdoB+YMoBP8/1NaU+llDgOeBqWigQMn/Hwyo0RRnCer39GmA8EmDFcKBiY0g5
        zqCK3VjX6s2SSlAGqJugByOy75zWSjJbECsnCPyHTj8oHJXAZKUqX92XdLuhR8F9
        A9P5DFoq01izEPL26XitweHLXy07ajfvKpAeo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67E9BB165C;
        Wed,  6 Dec 2017 16:39:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9DE4B165A;
        Wed,  6 Dec 2017 16:39:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Cc:     <git@vger.kernel.org>, Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: [PATCH v2] send-email: extract email-parsing code into a subroutine
References: <xmqqlgiiobcy.fsf@gitster.mtv.corp.google.com>
        <20171206153821.24435-1-nathan.payre@etu.univ-lyon1.fr>
Date:   Wed, 06 Dec 2017 13:39:22 -0800
In-Reply-To: <20171206153821.24435-1-nathan.payre@etu.univ-lyon1.fr> (Nathan
        Payre's message of "Wed, 6 Dec 2017 16:38:21 +0100")
Message-ID: <xmqqvahjfsdx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED0EE55A-DACD-11E7-9F56-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Nathan Payre <nathan.payre@etu.univ-lyon1.fr> writes:

> The existing code mixes parsing of email header with regular
> expression and actual code. Extract the parsing code into a new
> subroutine 'parse_header_line()'. This improves the code readability
> and make parse_header_line reusable in other place.
>
> Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
> Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
> Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon=
1.fr>
> Thanks-to: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Thanks, but...=20

> +    my %parsed_email;
> +	$parsed_email{'body'} =3D '';
> +    while (my $line =3D <$c>) {
> +	    next if $line =3D~ m/^GIT:/;
> +	    parse_header_line($line, \%parsed_email);
> +	    if ($line =3D~ /^\n$/i) {
> +	        while (my $body_line =3D <$c>) {
> +                if ($body_line !~ m/^GIT:/) {
> +                    $parsed_email{'body'} =3D $parsed_email{'body'} . =
$body_line;
> +                }
> +	        }
> +		}
> +		print "la : $line\n";
> +	}

... throughout this patch, not limited to this section, indentation
is strange and there seem to be many "print" that show messages that
do not seem to be meant for end-user consumption.  I can see that
this aspires to improve the readability, but not quite yet ;-).

Also "reusable in other place" is by itself not an unconditional
plus, until readers can be convinced that that 'other place' really
wants to be able to call this function.  Is there some untold
motivation behind this change---such as a planned update to actually
use this helper subroutine?

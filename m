Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761A120985
	for <e@80x24.org>; Wed, 21 Sep 2016 16:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938728AbcIUQun (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:50:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58014 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934786AbcIUQum (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:50:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39DB73CC88;
        Wed, 21 Sep 2016 12:50:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IbpaB8G5GeA/
        r75UBj3AaUk20d0=; b=cQj/kvp7FSk3Ir8zcXozgSswb0DK2OQKUI3+vKvIlELH
        f8pjkPbCEf9aI2ucN8kOiDRC/cUUehrEZ0FWOcZABT9bXfe8wBnWx+JzTBuOv/q0
        hDyLHpA4o9j6bEbMVa+YJoGSRrEr41DXv0+sAV38iLVaFapirWPD/ip4xtd4u/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BzGwvi
        /oOcCfQC3G2YqH9MDb3QitX1DoKK2l6WMQ1Mqy4pKS8IywnHFVHOxfXK89uQnJL3
        sNsk+AdMbzZi+nwypBeErulX/5eXeuTLvR6K5gFqyS0uSqXFk65bLOeNVAJdf8J6
        +lMGLCirrtr5te51SMbEnYG14bnP5AEyg2wQ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3108C3CC85;
        Wed, 21 Sep 2016 12:50:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1A8F3CC80;
        Wed, 21 Sep 2016 12:50:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Kay Sievers <kay.sievers@suse.de>
Subject: Re: [PATCH 3/3] gitweb: Link to "git describe"'d commits in log messages
References: <20160921114428.28664-1-avarab@gmail.com>
        <20160921114428.28664-3-avarab@gmail.com>
Date:   Wed, 21 Sep 2016 09:50:38 -0700
In-Reply-To: <20160921114428.28664-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 21 Sep 2016 11:44:28 +0000")
Message-ID: <xmqqvaxp9oyp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 877A5E62-801B-11E6-BA91-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> There's surely room for improvement here, but I just wanted to address
> the very common case of sticking "git describe" output into commit
> messages without trying to link to all possible refnames, that's going
> to be a rather futile exercise given that this is free text, and it
> would be prohibitively expensive to look up whether the references in
> question exist in our repository.

When I saw 2/3 I wondered about one thing and 3/3 shares the same,
which is that we only use regex match and do not validate for a
false match.  Would it be too expensive to pick up what _looks_ like
a rev (e.g. hex or g(refname regexp)-hex) then validate it with
"rev-parse --verify --quiet" to make sure it is a rev, before
actually making it a link?  Even if are we trying to account for
people referring to commits that do not exist in this repository
(e.g. some other project, in a submodule repository, or just an
earlier incarnation of rebasing that has since been lost), it seems
to me that it does not help to mark them with a link that won't
resolve.

> ---
>  gitweb/gitweb.perl | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 101dbc0..3a52bc7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2036,10 +2036,24 @@ sub format_log_line_html {
>  	my $line =3D shift;
> =20
>  	$line =3D esc_html($line, -nbsp=3D>1);
> -	$line =3D~ s{\b([0-9a-fA-F]{7,40})\b}{
> +	$line =3D~ s{
> +        \b
> +        (
> +            # The output of "git describe", e.g. v2.10.0-297-gf6727b0
> +            # or hadoop-20160921-113441-20-g094fb7d
> +            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with=
 -
> +            [A-Za-z0-9.-]+
> +            (?!\.) # refs can't end with ".", see check_refname_format=
()
> +            -g[0-9a-fA-F]{7,40}
> +            |
> +            # Just a normal looking Git SHA1
> +            [0-9a-fA-F]{7,40}
> +        )
> +        \b
> +    }{
>  		$cgi->a({-href =3D> href(action=3D>"object", hash=3D>$1),
>  					-class =3D> "text"}, $1);
> -	}eg;
> +	}egx;
> =20
>  	return $line;
>  }

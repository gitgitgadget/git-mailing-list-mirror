Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C491FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 22:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933202AbdCaWsS (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 18:48:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55465 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932935AbdCaWsR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 18:48:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78762804AB;
        Fri, 31 Mar 2017 18:48:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VvDJ62rr3+mb
        YVWmz8EOeBHOLHg=; b=IfAWHdqCAjlzfEXea1oPnp7GwI/fOrjXQhjaC/i5B/nI
        ytezkqckH1rPR+88kh7oFR6+VPM6BLmRR8w62053rD5WcCJaF+p50EsfGwWBilzS
        YUq3f/2Oy75ZoihekQJUgrud/VDdLc7RCjjGJepW6nIm1izJTwvz0sH10KpzGE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Gi8fxJ
        0m1qzTp3ud7XRXv16+wzuV0VE8sFGj5xmToK2btl7GLUbRTLbprgSmDMGrTdrkg7
        FGDDE8yzjMtKlgbDBrTd8IlQUVvNdFQ+EAnUlaFxvSe2tM6lPp0ZZ3YHWQIzzMeT
        S3OppAeUEznfyhAPbS4xn4Ld0Qt0/J6t9X2Yk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71B55804AA;
        Fri, 31 Mar 2017 18:48:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E520E804A9;
        Fri, 31 Mar 2017 18:48:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>
Subject: Re: Very promising results with libpcre2
References: <CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>
Date:   Fri, 31 Mar 2017 15:48:14 -0700
In-Reply-To: <CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 31 Mar
 2017 23:23:34
        +0200")
Message-ID: <xmqqtw69vz9t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20B70682-1664-11E7-B13D-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> That enables the new JIT support in pcre v2:
>
>       s/iter    rx fixed   prx
> rx      2.19    --  -33%  -44%
> fixed   1.47   49%    --  -17%
> prx     1.22   79%   20%    --

The numbers with JIT does look "interesting". =20

I couldn't quite tell if there are major incompatibilities in the
regex language itself between two versions from their documentation,
but assuming that there isn't (modulo bugfixes and enhancements) and
assuming that we are going to use their standard matcher, it may be
OK to just use the newer one without linking both.


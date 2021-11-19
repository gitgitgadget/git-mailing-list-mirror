Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF91C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 06:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4239F61AA7
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 06:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhKSGsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 01:48:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55456 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSGsb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 01:48:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92F011545C7;
        Fri, 19 Nov 2021 01:45:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=feD0Q+ubaM6Y
        3yyUTGjgS/02iyegiOfi1Zupkcc4vnk=; b=Q7rBjA6OoBzqt/FKdMlAEDd/fL6s
        5GgOGpeRbq9DpUvPgDHkXswOLPQeS0TFa6S0gkbttl2O41fmTnwS3Xi5vjDw1oct
        ienccMieyyqIJe5Ay6mEPfC+3if/IWLHZen9Lnm8qKJQHmYTKd0AfL83G1BS2gVu
        J0SGjQDeloWgTx4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7811F1545C6;
        Fri, 19 Nov 2021 01:45:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C30AE1545C5;
        Fri, 19 Nov 2021 01:45:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v4 15/23] Makefile: add a "TRACK_template" for
 GIT-*{FLAGS,DEFINES,...}
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
        <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
        <patch-v4-15.23-337953e4994-20211117T101807Z-avarab@gmail.com>
Date:   Thu, 18 Nov 2021 22:45:25 -0800
In-Reply-To: <patch-v4-15.23-337953e4994-20211117T101807Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 17 Nov
 2021 11:20:14
        +0100")
Message-ID: <xmqqbl2gskxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 476541C2-4904-11EC-94FE-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -2238,12 +2235,7 @@ SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):\
>  	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(PAGER_ENV):\
>  	$(perllibdir_SQ)
> -GIT-SCRIPT-DEFINES: FORCE
> -	@FLAGS=3D'$(SCRIPT_DEFINES)'; \
> -	    if test x"$$FLAGS" !=3D x"`cat $@ 2>/dev/null`" ; then \
> -		echo >&2 "    * new script parameters"; \
> -		echo "$$FLAGS" >$@; \
> -            fi
> +$(eval $(call TRACK_template,GIT-SCRIPT-DEFINES,SCRIPT_DEFINES))
> =20
>  define cmd_munge_script
>  sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \

Attempting to apply 1-14 on top of 'master' gets stuck here, as
"GIT-SCRIPT-DEFINES: FORCE" appears after "define cmd_munge_script".

Are you basing these patches on some unrelated work?



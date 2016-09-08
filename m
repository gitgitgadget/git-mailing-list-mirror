Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB3320705
	for <e@80x24.org>; Thu,  8 Sep 2016 19:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758268AbcIHTof (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 15:44:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65348 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751895AbcIHToe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 15:44:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69C3C3CD31;
        Thu,  8 Sep 2016 15:44:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Nhtk/KMQF2Z+
        tVrbyQsjvB9UwUk=; b=lpGcfL1u7Db2CpyfFtrmRpGFQnmkErTJFvi3I9uD2hHH
        AEhuGN2bhBOgT97p13edAZD3deC7L+97odmMdgPaIKtCsUM5cJQoNuGSBCoJU/AZ
        2c2+GOvQZf9j9NwlWLRuu+3j9TqC/Ht2e8vTWk9cIUqzZEtqFPo6KvPmhAbCEEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=p1wHmw
        zuWWWF3tAKy+vGJVeHpJjVgT/KE5fV0jT37rT3S/z6WjDjUI2yOjbnTg4pTU8iHi
        IZiAFvpU0AyxDGzS36ho7vrXCGm7sZo5YEtOBJH0XBm5kUCooQ6bwvWLLCOj/f5R
        rdlTTdMCSi1NehEfoF3CtNeySsPc+wmSZ0pk4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 617063CD30;
        Thu,  8 Sep 2016 15:44:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDAD53CD2F;
        Thu,  8 Sep 2016 15:44:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH 2/3] t0001: work around the bug that reads config file before repo setup
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
        <20160908134719.27955-1-pclouds@gmail.com>
        <20160908134719.27955-3-pclouds@gmail.com>
Date:   Thu, 08 Sep 2016 12:44:30 -0700
In-Reply-To: <20160908134719.27955-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 8 Sep 2016 20:47:18 +0700")
Message-ID: <xmqqfupagorl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA354058-75FC-11E6-9F6E-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> git-init somehow reads '.git/config' at current directory and sets
> log_all_ref_updates based on this file. Because log_all_ref_updates is
> not unspecified (-1) any more. It will not be written to the new repo's
> config file (see create_default_files() function).

I vaguely recall this was discussed recently somewhere.  Is this
related to <20160902091130.jxckdeomw35eewky@sigill.intra.peff.net>?


> This will affect our tests in the next patch as we will compare the
> config file and expect that core.logallrefupdates is already set to tru=
e
> by "git init main-worktree".

Ugh.  The "mv" workaround is fine to demonstrate that you have fixed
one of two problems, but as you said, it would be nice to have another
that expects failure until both of them gets fixed.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  t/t0001-init.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index d64e5e3..393c940 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -385,7 +385,9 @@ test_expect_success MINGW 'bare git dir not hidden'=
 '
>  '
> =20
>  test_expect_success 're-init from a linked worktree' '
> +	mv .git/config work-around-init-reading-wrong-file &&
>  	git init main-worktree &&
> +	mv work-around-init-reading-wrong-file .git/config &&
>  	(
>  		cd main-worktree &&
>  		test_commit first &&

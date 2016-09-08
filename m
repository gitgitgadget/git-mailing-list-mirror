Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826F120705
	for <e@80x24.org>; Thu,  8 Sep 2016 19:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758332AbcIHTh6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 15:37:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62215 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751121AbcIHTh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 15:37:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 529B43DE23;
        Thu,  8 Sep 2016 15:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NluVKqKzWkia
        zFF04Qgbg2raqsE=; b=qegevpnnU7OhPTvoX58xacZYhQFKjwFPiqJF7IsjjUKZ
        l35l+7JrPkjO2ifuEX1Dzez3frbjDK1RM4N2fJ0pyhOjG75bUNzZ/42ROzL0m8Yw
        CrfnUdzTicMMiAWK+uzIzbl2inNef/PJ/H6Y6KsOX2V7pIJq6SxpMUpZ/oQ6yws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UUYQ+C
        Ca27vWtnDLMOaW5jT2CNM1HhcDY6F/xZosEnH+46PZv34+6a8mcQI1cyf/9/RJMS
        st6BJOSjkoA6AaxpVgc1O6I4J3+xO9XBr39wMXk0lD4lfHcWFWP3M9YNoNnUH5so
        MgCu73UFWKiBQOZmIakbGIAydnlOvytY9QlPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C4093DE22;
        Thu,  8 Sep 2016 15:37:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA3EA3DE20;
        Thu,  8 Sep 2016 15:37:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH 1/3] init: correct re-initialization from a linked worktree
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
        <20160908134719.27955-1-pclouds@gmail.com>
        <20160908134719.27955-2-pclouds@gmail.com>
Date:   Thu, 08 Sep 2016 12:37:53 -0700
In-Reply-To: <20160908134719.27955-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 8 Sep 2016 20:47:17 +0700")
Message-ID: <xmqqk2emgp2m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD9152D2-75FB-11E6-B959-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When 'git init' is called from a linked worktree, '.git' dir as the mai=
n
> '.git' (i.e. $GIT_COMMON_DIR) and populate the whole repository skeleto=
n
> in there. It does not harm anything (*) but it is still wrong.

-ECANNOTPARSE.  Did you mean "... worktree, we treat '.git' dir as
if it is the main '.git' ..." or something entirely different?

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 3a45f0b..6d9552e 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -138,7 +138,7 @@ static void copy_templates(const char *template_dir=
)
>  		goto close_free_return;
>  	}
> =20
> -	strbuf_addstr(&path, get_git_dir());
> +	strbuf_addstr(&path, get_git_common_dir());
>  	strbuf_complete(&path, '/');
>  	copy_templates_1(&path, &template_path, dir);
>  close_free_return:
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index a6fdd5e..d64e5e3 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -384,4 +384,19 @@ test_expect_success MINGW 'bare git dir not hidden=
' '
>  	! is_hidden newdir
>  '
> =20
> +test_expect_success 're-init from a linked worktree' '
> +	git init main-worktree &&
> +	(
> +		cd main-worktree &&
> +		test_commit first &&
> +		git worktree add ../linked-worktree &&
> +		mv .git/info/exclude expected-exclude &&
> +		find .git/worktrees -print | sort >expected &&
> +		git -C ../linked-worktree init &&
> +		test_cmp expected-exclude .git/info/exclude &&
> +		find .git/worktrees -print | sort >actual &&
> +		test_cmp expected actual
> +	)
> +'
> +
>  test_done

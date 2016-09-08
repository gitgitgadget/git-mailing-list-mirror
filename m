Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DF320705
	for <e@80x24.org>; Thu,  8 Sep 2016 19:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965473AbcIHTyi (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 15:54:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52844 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751311AbcIHTyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 15:54:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A6443CE99;
        Thu,  8 Sep 2016 15:54:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8iPOk6wkW2Fq
        axw2eWJawFDcw+w=; b=maBmF9j8Obk2vaQENEIgp05WF2ZBBo8iroC6888+0O5J
        C3lw/xo0uGaVs6ncmnV494X8//2B+nY/eyr6MR+sf5gX4mDQEYcGnaCLxbUIgQf8
        j5jBWeHeGAPW2stNeO66QCvGYNCLTMYu9DDqNE33nkloEknEeM7SXBZgqW+c6nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dajPQG
        0fL+lQH55Zy7AbDgIo5tb3URsAEJpRLGjL+PItMMTdq2ej8HPeE/JltBubFnxQP1
        qwX3lEBgoHYfmGtO6qQJhHIIC0zi+aR4Kagl39jpowttp1abYD8T3QnC+FmrUMhB
        yuBbNdgo66B0uqPCRBXV31DFhcbIRJljGMppQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 728153CE98;
        Thu,  8 Sep 2016 15:54:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB71B3CE97;
        Thu,  8 Sep 2016 15:54:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH 3/3] init: do not set core.worktree more often than necessary
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
        <20160908134719.27955-1-pclouds@gmail.com>
        <20160908134719.27955-4-pclouds@gmail.com>
Date:   Thu, 08 Sep 2016 12:54:34 -0700
In-Reply-To: <20160908134719.27955-4-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 8 Sep 2016 20:47:19 +0700")
Message-ID: <xmqqbmzygoat.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 11A89AC2-75FE-11E6-86E1-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +/*
> + * Return the first ".git" that we have encountered.
> + * FIXME this function for not entirely correct because
> + * setup_git_directory() and enter_repo() do not update first_git_dir
> + * when they follow .git files. The function in its current state is
> + * only suitable for "git init".
> + */

Would it be possible to move this to "init-db.c" then?

The very first thing cmd_init_db() does to what is in the
environment.c is to call set_git_dir() via set_git_dir_init() to
tell it where the ".git" thing is, no?  Can't that code remember the
location itself, instead of adding code that is known not to be
usable by other callers?  That would help avoiding the future
confusion.

> +const char *get_first_git_dir(void)
> +{
> +	return first_git_dir ? first_git_dir : git_dir;
> +}
> +
>  const char *get_git_common_dir(void)
>  {
>  	return git_common_dir;
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 393c940..d59669a 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -393,9 +393,11 @@ test_expect_success 're-init from a linked worktre=
e' '
>  		test_commit first &&
>  		git worktree add ../linked-worktree &&
>  		mv .git/info/exclude expected-exclude &&
> +		cp .git/config expected-config &&
>  		find .git/worktrees -print | sort >expected &&
>  		git -C ../linked-worktree init &&
>  		test_cmp expected-exclude .git/info/exclude &&
> +		test_cmp expected-config .git/config &&
>  		find .git/worktrees -print | sort >actual &&
>  		test_cmp expected actual
>  	)

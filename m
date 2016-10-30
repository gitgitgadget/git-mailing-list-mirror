Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B0720193
	for <e@80x24.org>; Sun, 30 Oct 2016 22:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbcJ3WZW (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 18:25:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61149 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752580AbcJ3WZV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 18:25:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01AFA4C144;
        Sun, 30 Oct 2016 18:25:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F2N4p1KGmm83
        BlJpwgeVf4kUVxk=; b=CF82ojVJS/p22ivxfgWDPCSG18AIOeJCz3aZJ8v2YXeh
        ORoIO4ROBm+XYjnSreehKD5ftdDPrKdv9LHRSHo7yU2hJ6wQCPwxmNo8cExBsq8H
        jMqQOqnaaJ0P0Hav8jS7Lo2arjJ1xhnC3TbzKfDc77rn/B+gaQRgfCdlaDUoRKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=A2OZUB
        TCe1pT8pQGYJ74d5iWUX3iqmp7uz+0mLjzOBj1EP8qSzcNKMvByQdKNtNWeOOUfY
        tKo7MJKalYtLMszALf9tu9I+BhbXZDDqd0SVYFyGUsbZEFdSapNp8smfgqMyzdkv
        iRANPqbvQC5TQJMH8qXidC05lPQGICFnIVjT0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED7F84C143;
        Sun, 30 Oct 2016 18:25:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 769964C142;
        Sun, 30 Oct 2016 18:25:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     842477@bugs.debian.org, git@vger.kernel.org,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH] git-sh-setup: Restore sourcability from outside scripts
References: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu>
Date:   Sun, 30 Oct 2016 15:25:17 -0700
In-Reply-To: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu>
        (Anders Kaseorg's message of "Sat, 29 Oct 2016 22:10:02 -0400 (EDT)")
Message-ID: <xmqqlgx5v5iq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD88F8EA-9EEF-11E6-908D-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> v2.10.0-rc0~45^2~2 =E2=80=9Ci18n: git-sh-setup.sh: mark strings for
> translation=E2=80=9D broke outside scripts such as guilt that source
> git-sh-setup as described in the documentation:
>
> $ . "$(git --exec-path)/git-sh-setup"
> sh: 6: .: git-sh-i18n: not found
>
> This also affects contrib/convert-grafts-to-replace-refs.sh and
> contrib/rerere-train.sh in tree.  Fix this by using git --exec-path to
> find git-sh-i18n.
>
> While we=E2=80=99re here, move the sourcing of git-sh-i18n below the sh=
ell
> portability fixes.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---

Looks good.

Our in-tree scripts rely on the fact that $PATH is adjusted to have
$GIT_EXEC_PATH early (either by getting invoked indirectly by "git"
potty, or the requirement to do so for people and scripts that still
run our in-tree scripts with dashed e.g. "git-rebase" form) by the
time they run.  But when sh-setup dot-sources git-sh-i18n for its
own use, it should be explicit to name which one of the many copies
that may appear in directories on user's $PATH (one among which is
the one in $GIT_EXEC_PATH) it wants to use.  And this patch does the
right thing by not relying on the $PATH, but instead naming the
exact path using $(git --exec-path)/ prefix, to the included file.

In other words, I think this patch is a pure bugfix, even if there
is no third-party script that includes it.  We may want to have the
above as the rationale to apply this patch in the proposed log
message, though.

> Is this a supported use of git-sh-setup?  Although the documentation is
> clear that the end user should not invoke it directly, it seems to impl=
y
> that scripts may do this, and in practice it has worked until v2.10.0.

It is correct for the documentation to say that this is not a
"command" end users would want to run; they cannot invoke it as a
standalone command as it is written as a dot-sourced shell library.

Even though it is intended solely for internal use, so far we have
not removed things from there, which would have signalled people
that third-party scripts can also dot-source it.  We may want to
reserve the right to break them in the future, but because this is a
pure bugfix, "can third-party rely on the interface not changing?"
is not a question we need to answer in this thread---there is no
reason to leave this broken.

Thanks.

>  git-sh-setup.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index a8a4576..240c7eb 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -2,9 +2,6 @@
>  # to set up some variables pointing at the normal git directories and
>  # a few helper shell functions.
> =20
> -# Source git-sh-i18n for gettext support.
> -. git-sh-i18n
> -
>  # Having this variable in your environment would break scripts because
>  # you would cause "cd" to be taken to unexpected places.  If you
>  # like CDPATH, define it for your interactive shell sessions without
> @@ -46,6 +43,9 @@ git_broken_path_fix () {
> =20
>  # @@BROKEN_PATH_FIX@@
> =20
> +# Source git-sh-i18n for gettext support.
> +. "$(git --exec-path)/git-sh-i18n"
> +
>  die () {
>  	die_with_status 1 "$@"
>  }


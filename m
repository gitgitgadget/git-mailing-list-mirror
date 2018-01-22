Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDC51F404
	for <e@80x24.org>; Mon, 22 Jan 2018 20:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751046AbeAVUuo (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 15:50:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64703 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeAVUun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 15:50:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C024BC95A7;
        Mon, 22 Jan 2018 15:50:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RIzqFIE93OnN
        uWH8ueEW9umippQ=; b=Uff+xe7DLtpFsK1Ah6NfWxGgsG1taL3XsdSqSNbt3g5E
        tWdLIwgUsH9bs2QEt22qhrd8xCvzElZhv7QtF5RiyUb1NMao3jA3LgUSMeASEpmP
        YRb3pKz1gX1DimpjH6obHDa7P8IJBJv7XXjCmTSLwL98hSweYUNWUwzLjJOZsn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bwqYYH
        lOc75cNgSPwQ5tg52GsZnkdnQx06rHUdIK+997L70B/LxIRR2Z8lWL+KCG1NaOLm
        fPXtHYKF0+kUETMtiZosOQ388Can/+OaQkDjsR1ipew1V/ORfQtHTpUOssm+Tg7B
        tHM+99kVZiiQbwJUo55TAe+gmFprnX3AQ5KWo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7265C95A6;
        Mon, 22 Jan 2018 15:50:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DC35C95A5;
        Mon, 22 Jan 2018 15:50:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/12] fetch: add a --fetch-prune option and fetch.pruneTags config
References: <20180121000304.32323-1-avarab@gmail.com>
        <20180119000027.28898-1-avarab@gmail.com>
        <20180121000304.32323-13-avarab@gmail.com>
Date:   Mon, 22 Jan 2018 12:50:41 -0800
In-Reply-To: <20180121000304.32323-13-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 21 Jan 2018 00:03:04 +0000")
Message-ID: <xmqq372xmxcu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E9098598-FFB5-11E7-9569-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a --fetch-prune option to git-fetch, along with fetch.pruneTags
> config option. This allows for doing any of:
>
>     git fetch -p -P
>     git fetch --prune --prune-tags
>     git fetch -p -P origin
>     git fetch --prune --prune-tags origin
>
> Or simply:
>
>     git config fetch.prune true &&
>     git config fetch.pruneTags true &&
>     git fetch
>
> Instead of the much more verbose:
>
>     git fetch --prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:r=
efs/remotes/origin/*'
>
> Before this feature it was painful to support the use-case of pulling
> from a repo which is having both its branches *and* tags deleted
> regularly, and wanting our local references to reflect upstream.
>
> At work we create deployment tags in the repo for each rollout, and
> there's *lots* of those, so they're archived within weeks for
> performance reasons.
>
> Without this change it's hard to centrally configure such repos in
> /etc/gitconfig (on servers that are only used for working with
> them). You need to set fetch.prune=3Dtrue globally, and then for each
> repo:
>
>     git -C {} config --replace-all remote.origin.fetch "refs/tags/*:ref=
s/tags/*" "^refs/tags/*:refs/tags/*$"

I think the last one is supposed to be a regular expression on
existing values.  Shouldn't the asterisks be quoted? =20

Otherwise, it would appears as if "refs/tags:refs/tags///" are
replaced with "refs/tags/*:refs/tags/*", but it certainly is not
what you are doing.  I also wonder why the existing one does not
expect a leading '+', which I think is what we place by default
when you clone.

> +-P::
> +--prune-tags::
> +	.... This option is
> +	merely a shorthand for providing the explicit tag refspec
> +	along with `--prune`, see the discussion about that in its
> +	documentation.

So would "git fetch -P origin" be like "git fetch --prune --tags
origin"?

>  +
>  See the PRUNING section below for more details.
> =20
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index 18fac0da2e..5682ed4ae1 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -148,6 +148,30 @@ So be careful when using this with a refspec like
>  `refs/tags/*:refs/tags/*`, or any other refspec which might map
>  references from multiple remotes to the same local namespace.
> =20
> +Since keeping up-to-date with both branches and tags on the remote is
> +a common use-case the `--prune-tags` option can be supplied along with
> +`--prune` to prune local tags that don't exist on the remote. Tag
> +pruning can also be enabled with `fetch.pruneTags` or
> +`remote.<name>.pruneTags` in the config. See linkgit:git-config[1].
> +
> +The `--prune-tags` option is equivalent to having
> +`refs/tags/*:refs/tags/*` configured in the refspecs for the
> +remote. This can lead to some seemingly strange interactions:
> +
> +------------------------------------------------
> +# These both fetch tags
> +$ git fetch --no-tags origin 'refs/tags/*:refs/tags/*'
> +$ git fetch --no-tags --prune-tags origin
> +------------------------------------------------

This description is too confusing.  First you say "having
... configured in the refspecs for the remote", but configured
refspecs for the remote (I presume that you are missing 'fetch' from
that description and are talking about the "remote.$name.fetch"
configuration variable) are overridden when you give explicit
refspecs from the command line, so the above two are not even
equivalent.  The first one gives a refspec explicitly from the
command line, so other configured refspecs like

    [remote "origin"] fetch =3D +refs/heads/*:refs/remotes/origin/*

should be ignored, while the second one, if --prune-tags tells Git
to behave as if=20

    [remote "origin"] fetch =3D refs/tags/*:refs/tags/*

also exists in the config, would not cause other ones for the same
remote from getting ignored.  So...

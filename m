Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1711207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757497AbcILTMp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:12:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50561 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752595AbcILTM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:12:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C78F3C056;
        Mon, 12 Sep 2016 15:12:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+lp/XCMcdV/tHUjHAKKBTX3NB/s=; b=nKwP8c
        HYaJIIEcefSsUw8gu+c4XyCCYwkZB0lvdkhFVr04pMjPkaDjDJy7z+zhesTuGvmE
        BLd68YTMHDClCGmyvaezoGEIwRrRo56XWwdczPIt4eMtv8lExyIW+7D3yxQhWC1R
        gIvlPD4Cu4ZvgfWDvFr0hII+X4TicCdKpkp4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sp07AmVk8pta720DovMkK8gJwLToUqua
        u3r6BMyEhxfSFweONLrJRbkq/erlLKj9jNec1AVY1S85VUDCnXv3uq//YfVeUACv
        n6nTqSu5poyGAWG0uZVpAYKuHZEaccYcX6PHPCSZdgwYkHBqz0ag/G3mLVevAeI8
        9wP7EDL7evQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74FFF3C055;
        Mon, 12 Sep 2016 15:12:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9BF33C054;
        Mon, 12 Sep 2016 15:12:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/perf/run: Don't forget to copy config.mak.autogen & friends to build area
References: <20160910150512.19473-1-kirr@nexedi.com>
Date:   Mon, 12 Sep 2016 12:12:26 -0700
In-Reply-To: <20160910150512.19473-1-kirr@nexedi.com> (Kirill Smelkov's
        message of "Sat, 10 Sep 2016 18:05:12 +0300")
Message-ID: <xmqqh99l2aqt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D88A1348-791C-11E6-B202-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> Otherwise for people who use autotools-based configure in main worktree,
> the performance testing results will be inconsistent as work and build
> trees could be using e.g. different optimization levels.
>
> See e.g.
>
> 	http://public-inbox.org/git/20160818175222.bmm3ivjheokf2qzl@sigill.intra.peff.net/
>
> for example.
>
> NOTE config.status has to be copied because otherwise without it the build
> would want to run reconfigure this way loosing just copied config.mak.autogen.
>
> Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> ---
>  ( Resending as separate patch-mail, just in case )
>
>  t/perf/run | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/perf/run b/t/perf/run
> index cfd7012..aa383c2 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -30,7 +30,7 @@ unpack_git_rev () {
>  }
>  build_git_rev () {
>  	rev=$1
> -	cp ../../config.mak build/$rev/config.mak
> +	cp -t build/$rev ../../{config.mak,config.mak.autogen,config.status}

That unfortunately is a GNUism -t with a bash-ism {a,b,c}; just keep
it simple and stupid to make sure it is portable.

This is not even a part that we measure the runtime for anyway.

>  	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
>  	die "failed to build revision '$mydir'"
>  }

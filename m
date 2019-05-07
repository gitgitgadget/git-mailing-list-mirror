Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1B91F45F
	for <e@80x24.org>; Tue,  7 May 2019 09:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfEGJEn (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 05:04:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60214 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEGJEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 05:04:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E004913EC52;
        Tue,  7 May 2019 05:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BqdLXgQLajiO1173gsk7tE7/yWs=; b=qRiWPU
        tLdCQAD/FU9VC+3POFCyx1U1+RE+XBI4YmT2TQ+pc+RztBp135coBrRygNPSOLOp
        5aDXrf0oubNwSXcqzFlMZ1Gw5ErPmjH3ov095QGAa5h0bXKrRLhi3zeRvNuK5rJW
        zJ/HwqqGvT7cV/8p/5DS2v2/6aQ76VHT/FGR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rYkPPOivoiEHkGro05tLG/nTVARiuKdm
        A5nSid8qfX/F05NSjurwNx7DEzV5zGUykbpkg17r8q9o7hK/BUMXbxklIw7LdsWo
        /+fY9vPkYFfc0y8pe9BRH13WUc2WylQiaq+NcrEPf+NAtmQVu8Irk9Bz+fdX8uYW
        0GfabZX8psA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D818113EC50;
        Tue,  7 May 2019 05:04:40 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49DA413EC4E;
        Tue,  7 May 2019 05:04:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Boxuan Li <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2] t4253-am-keep-cr-dos: avoid using pipes
References: <20190505081633.41157-1-liboxuan@connect.hku.hk>
Date:   Tue, 07 May 2019 18:04:39 +0900
In-Reply-To: <20190505081633.41157-1-liboxuan@connect.hku.hk> (Boxuan Li's
        message of "Sun, 5 May 2019 16:16:33 +0800")
Message-ID: <xmqqy33iljo8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 258A1C9A-70A7-11E9-A494-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Boxuan Li <liboxuan@connect.hku.hk> writes:

> The exit code of the upstream in a pipe is ignored thus we should avoid
> using it. By writing out the output of the git command to a file, we can
> test the exit codes of both the commands.

We are trying to catch breakages in "am" in these two tests (see the
title of the test file), and we rely on format-patch to correctly
produce its output---if we assume that the command being tested,
i.e. "am", could be fed garbage, the tests become pointless.

And once we decide to rely on the correctness of format-patch in
these two tests, there no longer is a reason to fear that
invocations of it upstream of a pipe would lose the exit status.

So while the patch is not wrong per-se, but these two changes are
borderline Meh.

> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
> Thanks to Eric Sunshine's review, I've removed spaces after '>'
> and changed 'actual' into 'output'.
> ---
>  t/t4253-am-keep-cr-dos.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
> index 553fe3e88e..6e1b73ec3a 100755
> --- a/t/t4253-am-keep-cr-dos.sh
> +++ b/t/t4253-am-keep-cr-dos.sh
> @@ -51,14 +51,16 @@ test_expect_success 'am with dos files without --keep-cr' '
>  
>  test_expect_success 'am with dos files with --keep-cr' '
>  	git checkout -b dosfiles-keep-cr initial &&
> -	git format-patch -k --stdout initial..master | git am --keep-cr -k -3 &&
> +	git format-patch -k --stdout initial..master >output &&
> +	git am --keep-cr -k -3 output &&
>  	git diff --exit-code master
>  '
>  
>  test_expect_success 'am with dos files config am.keepcr' '
>  	git config am.keepcr 1 &&
>  	git checkout -b dosfiles-conf-keepcr initial &&
> -	git format-patch -k --stdout initial..master | git am -k -3 &&
> +	git format-patch -k --stdout initial..master >output &&
> +	git am -k -3 output &&
>  	git diff --exit-code master
>  '

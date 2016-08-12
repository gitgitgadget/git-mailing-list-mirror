Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD701F859
	for <e@80x24.org>; Fri, 12 Aug 2016 17:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbcHLR4x convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Fri, 12 Aug 2016 13:56:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752644AbcHLR4w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 13:56:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 473F634992;
	Fri, 12 Aug 2016 13:56:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W13322BPM2Oh
	b+xpKZHifhepHDY=; b=oQxNOcnEvmA9Ek/3XMWzB4vPl+Ia9SWhQndh0gZnGngf
	5uHY8Gfy+B/mqD9F82zuJHei2XS5PKSsWCzK9kAYas0hY5jgXaNlnofzAgDF51cy
	k1T+cdg7veaprUFc3Vltky9P10+np+94NwVqncX3JzEJ2H3oW2iM/zs8ubVyWnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pF15Lq
	x2S9rsCAirHp6MbDGNbp2ERSYUkrBX8lvCR80empN/5rq0W4qZA8g7WTQ2WZ62dY
	e6II3CDO/2Z1gTI1gm1gMbF5hEbGIDTKGYxhM7l8JYPq7iqVavUEwO6GZE/OPaXl
	YPw4OglqaNjAHUHgiq1+Zltshxn6r54lrX05A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4019134991;
	Fri, 12 Aug 2016 13:56:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B760F34990;
	Fri, 12 Aug 2016 13:56:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	tboegi@web.de
Cc:	git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v1 1/2] t0027: Correct raciness in NNO test
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
	<1471020662-20746-1-git-send-email-tboegi@web.de>
Date:	Fri, 12 Aug 2016 10:56:48 -0700
In-Reply-To: <1471020662-20746-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 12 Aug 2016 18:51:02 +0200")
Message-ID: <xmqqa8ghyiov.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2558F128-60B6-11E6-ACC5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> When a non-reversible CRLF conversion is done in "git add",
> a warning is printed on stderr (or Git dies, depending on checksafe)
>
> The function commit_chk_wrnNNO() in t0027 was written to test this,
> but did the wrong thing: Instead of looking at the warning
> from "git add", it looked at the warning from "git commit".
>
> This is racy because "git commit" may not have to do CRLF conversion
> at all if it can use the sha1 value from the index (which depends on
> whether "add" and "commit" run in a single second).
>
> Correct this and replace the commit for each and every file with a commit
> of all files in one go.
>
> The function commit_chk_wrnNNO() will to be renamed in a separate commit.
> Thanks to Jeff King <peff@peff.net> for analyzing t0027.
>
> Reported-By: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---

Missing sign-off.  The reasoning above looks very clearly explained.

Thanks.


>  t/t0027-auto-crlf.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 2860d2d..ab6e962 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -119,8 +119,7 @@ commit_chk_wrnNNO () {
>  		fname=${pfx}_$f.txt &&
>  		cp $f $fname &&
>  		printf Z >>"$fname" &&
> -		git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
> -		git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1
> +		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
>  	done
>  
>  	test_expect_success "commit NNO files crlf=$crlf attr=$attr LF" '
> @@ -394,11 +393,11 @@ test_expect_success 'commit files attr=crlf' '
>  
>  #                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
>  commit_chk_wrnNNO ""      ""      false   ""        ""        ""          ""          ""
> -commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""          ""          ""
> +commit_chk_wrnNNO ""      ""      true    ""        ""        ""          ""          ""
>  commit_chk_wrnNNO ""      ""      input   ""        ""        ""          ""          ""
>  
> -commit_chk_wrnNNO "auto"  ""      false   "$WILC"   ""        ""          ""          ""
> -commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""          ""          ""
> +commit_chk_wrnNNO "auto"  ""      false   ""        ""        ""          ""          ""
> +commit_chk_wrnNNO "auto"  ""      true    ""        ""        ""          ""          ""
>  commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""          ""          ""
>  for crlf in true false input
>  do
> @@ -408,7 +407,7 @@ do
>  	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF      ""         CRLF_LF
>  	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
>  	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""          ""          ""
> -	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        ""          ""          ""
> +	commit_chk_wrnNNO auto  crlf  	$crlf   ""        ""        ""          ""          ""
>  	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF     ""          CRLF_LF
>  	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
>  done
> @@ -417,7 +416,8 @@ commit_chk_wrnNNO "text"  ""      false   "$WILC"   "$WICL"   "$WAMIX"    "$WILC
>  commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
>  commit_chk_wrnNNO "text"  ""      input   ""        CRLF_LF   CRLF_LF     ""          CRLF_LF
>  
> -test_expect_success 'create files cleanup' '
> +test_expect_success 'commit NNO and cleanup' '
> +	git commit -m "commit files on top of NNO" &&
>  	rm -f *.txt &&
>  	git -c core.autocrlf=false reset --hard
>  '

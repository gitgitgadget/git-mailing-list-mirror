Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256D11F45F
	for <e@80x24.org>; Tue,  7 May 2019 09:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEGJXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 05:23:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62837 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfEGJXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 05:23:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B130063E42;
        Tue,  7 May 2019 05:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RnrGbG4jday0vnkOcBucsv+O3ws=; b=cPW9At
        Da3oIhVwFmdT4BH2jvGvGLANH7kRumIkwOIvubTPluSwR8W8NsdYqp1GQkGXmRxZ
        lTQhn95sioLp5SMa127yAn6/7399lFoHlYBa1WRer1yG8I0yVhZTnlcg/QwDUe23
        aVwMtCQnsMyVzJ21PIOrmputIzWAZJE/WNyX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g7FYuYeBQoTkfsFhTxMeSztRp72a3FyM
        8mOl0xcxS/IwFqRkilVS2fJwEmFqbTD3+Nc7I3GRjQtbiH3fvaA2Hp89ugDI/oTe
        tbz2Mk4xUuBSdENVJQjZe2n9qbqEu/VJCHDaIp1CGimUO3aYeenj6V7bhCHPxZjF
        qXmeDqQ6joY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA2ED63E40;
        Tue,  7 May 2019 05:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D55D363E3E;
        Tue,  7 May 2019 05:23:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dustin Spicuzza via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Dustin Spicuzza <dustin@virtualroadside.com>
Subject: Re: [PATCH 1/1] cvsexportcommit: force crlf translation
References: <pull.132.git.gitgitgadget@gmail.com>
        <9b508af11be125ce5fd80c40c732dbcaf45067fb.1556575126.git.gitgitgadget@gmail.com>
Date:   Tue, 07 May 2019 18:22:59 +0900
In-Reply-To: <9b508af11be125ce5fd80c40c732dbcaf45067fb.1556575126.git.gitgitgadget@gmail.com>
        (Dustin Spicuzza via GitGitGadget's message of "Mon, 29 Apr 2019
        14:58:47 -0700 (PDT)")
Message-ID: <xmqqtve6lito.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B620BDCA-70A9-11E9-88A1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dustin Spicuzza via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Dustin Spicuzza <dustin@virtualroadside.com>
>
> When using cvsnt + msys + git, it seems like the output of cvs status
> had \r\n in it, and caused the command to fail.

This is a bit under-explained in that it does not make it clear
where the right place to fix would be.  From "X did Y which caused
the command to fail", a possible right fix could be "so fix it by
telling X not to do Y", but of course a patch to fix cvsnt won't
come to this list ;-)

I haven't thought things through, so let's think it aloud and
enumerate what should have been explained in the log message here.

 - With binmode(":crlf"), (i.e. if the platform uses CRLF convert
   external CRLF into internal '\n'), the change hopes not to affect
   platforms that do not use CRLF.

 - "it SEEMS LIKE the output of cvs status had CRLF in it", i.e. it
   is uncertain if everybody on the platform has the same issue.
   But by using binmode(":crlf"), if some other implementations of
   "cvs status" on the platform used LF, they won't get negatively
   affected by this change, either.

So, I guess the change is safe enough that it does not hurt other
people.

>
> This fixes that.
>
> Signed-off-by: Dustin Spicuzza <dustin@virtualroadside.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-cvsexportcommit.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index d13f02da95..fc00d5946a 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -431,6 +431,7 @@ END
>  sub safe_pipe_capture {
>      my @output;
>      if (my $pid = open my $child, '-|') {
> +	binmode($child, ":crlf");
>  	@output = (<$child>);
>  	close $child or die join(' ',@_).": $! $?";
>      } else {

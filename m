Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E758202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 19:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbdCOTZ5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 15:25:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59426 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750877AbdCOTZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 15:25:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 143987DFC9;
        Wed, 15 Mar 2017 15:25:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v0iRmWd28dxeZ4KBDBGCjV/8b5w=; b=xF/l7R
        TALwOdqri07ABj2xR0Au2Jnyv8HoHNEJW3Dh2gI7LWqAJ/tllHDl+iTaof7/vizK
        QMFFX438b2w1hMzzWMcopupQaR9jTDY5OKCiP9GrYo9fVls3o4A9Kjjr/PyJ/58F
        kr7HgO5OPvEKrfReN89W2+XXWGApWYXyExWL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wtGKj9yvpybcAV9AXSyjyKwiJKBZGtIu
        x5UAODJa1mIDZy4huswf6fIp3Ck4opdArPH+m3p5viZdxPdka8+MCGkcbbRD5xt/
        l1tZYDTFX6l0qcs/XhW9xUfMLEDh0e4Dy3Bjul2O5qVknDh7iA0hjPhmKIH7fpsj
        xSx9fcNcZXY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DA8F7DFC8;
        Wed, 15 Mar 2017 15:25:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 631B87DFC7;
        Wed, 15 Mar 2017 15:25:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] git-prompt: add a describe style for any tags
References: <cover.1489581340.git.git@drmicha.warpmail.net>
        <8d8fcdb4134090328662bf6fa5dfdba6c73fb6a5.1489581340.git.git@drmicha.warpmail.net>
Date:   Wed, 15 Mar 2017 12:25:53 -0700
In-Reply-To: <8d8fcdb4134090328662bf6fa5dfdba6c73fb6a5.1489581340.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Wed, 15 Mar 2017 14:15:09 +0100")
Message-ID: <xmqqvarae3zy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35301452-09B5-11E7-AF2C-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git-prompt has various describe styles, among them "describe" (by
> annotated tags) and "default" (by exact match with any tag).
>
> Add a mode "tag" that describes by any tag, annotated or not.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  contrib/completion/git-prompt.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 97eacd7832..c6cbef38c2 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -82,6 +82,7 @@
>  #     contains      relative to newer annotated tag (v1.6.3.2~35)
>  #     branch        relative to newer tag or branch (master~4)
>  #     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
> +#     tag           relative to any older tag (v1.6.3.1-13-gdd42c2f)

I guess this feature makes sense.  

I just wish we had a well-known unannotated tag we can use for such
an example; using v1.6.3.1 that is annotated does not help to make
the distinctin between describe and tag stand out.  We want to
convey "both annotated one and unannotated one can be used".

I am wondering if it makes sense to do something like this instead:

#	tag 	similar to 'describe' but also allow unannotated tags

>  #     default       exactly matching tag
>  #
>  # If you would like a colored hint about the current dirty state, set
> @@ -443,6 +444,8 @@ __git_ps1 ()
>  					git describe --contains HEAD ;;
>  				(branch)
>  					git describe --contains --all HEAD ;;
> +				(tag)
> +					git describe --tags HEAD ;;
>  				(describe)
>  					git describe HEAD ;;
>  				(* | default)

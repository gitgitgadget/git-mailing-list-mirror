Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D94B20372
	for <e@80x24.org>; Fri, 13 Oct 2017 01:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756669AbdJMBsI (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 21:48:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57524 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753615AbdJMBsI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 21:48:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F22EB0471;
        Thu, 12 Oct 2017 21:48:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=trgq1qK0joUzgJdnvZISz/IvAQA=; b=xh/zxw
        D40j/wm1qdxi4A9iGWoQkNO6klM/dVLmDNkGCSbX6LVZ0bwRVj1pgnAg/rwFcFqs
        vuhh/u6rFIuckBuMBIOjha2WyS5cCItft7SoMJn6WfjfPOoTx/LhCviJw70kzYyd
        Etj8+fal+rRSEm50RO8/R7hSoxLWqEis6F1CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f89MebSw9WFudxt2P5+1koIGV47y8M5s
        lXkTjML7rk2X+fnFeE6pRZodDRLLKPcTKuS5GtA4tDJ1jB3OTHik/xsAQWtTdi0k
        m8aHG5HKHtYCB9UoYAOcUV7hEWlZ2VEQWErm8sSfDL7TldIUFGzuXnxV3onyZ4RX
        f7GuxpUzWGE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9662DB0470;
        Thu, 12 Oct 2017 21:48:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C62EB046F;
        Thu, 12 Oct 2017 21:48:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "W. Trevor King" <wking@tremily.us>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Subject: Re: [PATCH v3] pull: pass --signoff/--no-signoff to "git merge"
References: <51d67d6d707182d4973d9961ab29358f26c4988a.1507796638.git.wking@tremily.us>
        <129274f0cc768b7a309f41315580fe1013636516.1507832722.git.wking@tremily.us>
Date:   Fri, 13 Oct 2017 10:48:05 +0900
In-Reply-To: <129274f0cc768b7a309f41315580fe1013636516.1507832722.git.wking@tremily.us>
        (W. Trevor King's message of "Thu, 12 Oct 2017 11:35:42 -0700")
Message-ID: <xmqqd15rx1gq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F4629F0-AFB8-11E7-9E82-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"W. Trevor King" <wking@tremily.us> writes:

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 4df6431c34..0ada8c856b 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -64,14 +64,6 @@ OPTIONS
>  -------
>  include::merge-options.txt[]
>  
> ---signoff::
> -	Add Signed-off-by line by the committer at the end of the commit
> -	log message.  The meaning of a signoff depends on the project,
> -	but it typically certifies that committer has
> -	the rights to submit this work under the same license and
> -	agrees to a Developer Certificate of Origin
> -	(see http://developercertificate.org/ for more information).
> -
>  -S[<keyid>]::
>  --gpg-sign[=<keyid>]::
>  	GPG-sign the resulting merge commit. The `keyid` argument is
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 4e32304301..f394622d65 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -51,6 +51,16 @@ set to `no` at the beginning of them.
>  With --no-log do not list one-line descriptions from the
>  actual commits being merged.
>  
> +--signoff::
> +--no-signoff::
> +	Add Signed-off-by line by the committer at the end of the commit
> +	log message.  The meaning of a signoff depends on the project,
> +	but it typically certifies that committer has
> +	the rights to submit this work under the same license and
> +	agrees to a Developer Certificate of Origin
> +	(see http://developercertificate.org/ for more information).
> ++
> +With --no-signoff do not add a Signed-off-by line.

Makes sense.  Thanks, will queue.

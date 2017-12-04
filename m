Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D31B20954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbdLDVip (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:38:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60202 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752554AbdLDVin (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 16:38:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BFB5CEAA8;
        Mon,  4 Dec 2017 16:38:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LDbSNEvQ1kJFmD+h9TGf8Ut8d1Q=; b=o6MvYs
        xIplTJhLEs6JOO41Tjh6w3/UVwzLUB0Ew2ucIOIaPQN/XiG/5doEKIAI/a9o8v56
        9Eg4+D8L+xIzjcybagGuEk1Ue+F/VwOPINDTxcOn+7iHzmXN39daQ6Sv+V8sC2gk
        yin8ONz9PLse1qTlOA0iLhf4z/uwZxhWbSSDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GHvGieVVp7bUFyAYPdJqF7+opoebJlF8
        gzgmazkQpFgWZVop/gTG5ep5Dh/aY6pRuc6VRQRz8+A2Uai+zmweVldsdZc1JEKL
        2ruC8Dj+325E4u0+FPBBk+u+JjpUSY4p0nVAuXFeNqFJ8LQXeepYmXq9bU+4rjSw
        +XmQaeFUmGw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0109FCEAA7;
        Mon,  4 Dec 2017 16:38:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 653BFCEAA3;
        Mon,  4 Dec 2017 16:38:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, nico@cam.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] progress: print progress output for all operations taking longer than 2s
References: <20171204203647.30546-1-lars.schneider@autodesk.com>
        <20171204213350.GA21552@sigill.intra.peff.net>
Date:   Mon, 04 Dec 2017 13:38:41 -0800
In-Reply-To: <20171204213350.GA21552@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 4 Dec 2017 16:33:50 -0500")
Message-ID: <xmqqvahmkwbi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F8D17E2-D93B-11E7-8A76-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So the minimal fix is actually:
>
> diff --git a/progress.c b/progress.c
> index 289678d43d..b774cb1cd1 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -229,7 +229,7 @@ static struct progress *start_progress_delay(const char *title, unsigned total,
>  
>  struct progress *start_delayed_progress(const char *title, unsigned total)
>  {
> -	return start_progress_delay(title, total, 0, 2);
> +	return start_progress_delay(title, total, 100, 2);
>  }

That makes a lot more sense to me (at least from a cursory
comparison between the two approaches).


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C4A91FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbcHWQuc (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:50:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56491 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752325AbcHWQub (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:50:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0148D3582A;
        Tue, 23 Aug 2016 12:33:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w62iYj1HmfzPN0ABz7h3bdFw1U0=; b=uKDANd
        GbL4DiOQZII+Su6JzmHFc2xCUvJ8rjXzw0JoxXzsHKFL/IaRnM9l7YD05MsETCY9
        9tAxiRLIRbrP5goa78fHxJAThk/TXrHthmskG7G2BV1gtZPvkaHIAP5maVv0nol0
        U4Cs7yjpgxwdlhwKN031Toz+50WQr8AuqjZu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZSfa+m89x6ZM2iLi/InlDxgDsRCJIvBQ
        V0SmQhi1gFAn+lldVeTwwDEVKifY2RxqauzwBY38HffzNYGpYUxqJRSw7sUGWlfv
        tajlG8aEbUGyc5pbrYitCT4iKM8CUCU8nbIPb3kD1DWLSkwki05mcEM+DZiQrc9Y
        gT2roFOY4hE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECA7C35829;
        Tue, 23 Aug 2016 12:33:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75CA635827;
        Tue, 23 Aug 2016 12:33:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] format-patch: show 0/1 and 1/1 for singleton patch with cover letter
References: <20160819234959.26308-1-jacob.e.keller@intel.com>
Date:   Tue, 23 Aug 2016 09:33:39 -0700
In-Reply-To: <20160819234959.26308-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Fri, 19 Aug 2016 16:49:59 -0700")
Message-ID: <xmqq37lvxx5o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A047EB4-694F-11E6-AE1E-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Change the default behavior of git-format-patch to generate numbered
> sequence of 0/1 and 1/1 when generating both a cover-letter and a single
> patch. This standardizes the cover letter to have 0/N which helps
> distinguish the cover letter from the patch itself. Since the behavior
> is easily changed via configuration as well as the use of -n and -N this
> should be acceptable default behavior.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---

This obviously changes the behaviour, but I do not think of a reason
why this change is a bad idea.  

>  builtin/log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 92dc34dcb0cc..8e6100fb0c5b 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1676,7 +1676,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		/* nothing to do */
>  		return 0;
>  	total = nr;
> -	if (!keep_subject && auto_number && total > 1)
> +	if (!keep_subject && auto_number && (total > 1 || cover_letter))
>  		numbered = 1;
>  	if (numbered)
>  		rev.total = total + start_number - 1;

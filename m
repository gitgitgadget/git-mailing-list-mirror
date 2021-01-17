Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D7BC433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 22:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03A6224BD
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 22:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbhAQWos (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 17:44:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54673 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbhAQWor (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 17:44:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1884115BF8;
        Sun, 17 Jan 2021 17:44:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Edt9RfloPqC5aoe0E1z2Ey9rYs=; b=sFN5M0
        TTSfZaeY6+OXWKDw6XqcTCMkFEpYuAIH2iJzRdVrUb5Bb8RJoxcpX61tJCiiXeup
        u5xmvk/MUfA8nX30HGgJJPbS/NfXX9W+vAsr3PgXfXedaXTy/F7wC1+4OWrE365u
        4ziDY6BkY66sNq6x5yl/DLLOYi74p77CZA6lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t0l1F6/H3qwKKzOAFJwCb4L2b6xujG2/
        EWGYDAA24HKMgEBF7k6ADlxnUgddcRy2DvkAHE8uO6nJY6YxPMfZpcAcGl22mX58
        jTPCXjBKOqJu5tmHlANS9bvvjVTi9JMHMIVI4A5xUdWQi8nqs2nwu8HpDAlemvZd
        2HCtkjCFTnM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA924115BF7;
        Sun, 17 Jan 2021 17:44:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 442B8115BF0;
        Sun, 17 Jan 2021 17:44:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Marek <kmarek@pdinc.us>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-2-kmarek@pdinc.us>
Date:   Sun, 17 Jan 2021 14:44:00 -0800
In-Reply-To: <20210117110337.429994-2-kmarek@pdinc.us> (Kyle Marek's message
        of "Sun, 17 Jan 2021 06:03:36 -0500")
Message-ID: <xmqq35yzmbf3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EE2F3B8-5915-11EB-80C4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Marek <kmarek@pdinc.us> writes:

> Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'

Downcase "D"; this will stand out in "git shortlog --no-merges" for
a wrong reason otherwise.

> This aids in identifying where an unrelated branch history starts when
> using `git log --graph --oneline --all`

This is triggerd only with --show-linear-break option, when combined
with [2/2]?  I think that is a bug introduced in the next step.

> Signed-off-by: Kyle Marek <kmarek@pdinc.us>
> ---
>  revision.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 9dff845bed..8556923de8 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -4191,9 +4191,11 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
>  			return "<";
>  		else
>  			return ">";
> -	} else if (revs->graph)
> +	} else if (revs->graph) {
> +		if (!commit->parents)
> +			return "#";
>  		return "*";
> -	else if (revs->cherry_mark)
> +	} else if (revs->cherry_mark)
>  		return "+";
>  	return "";
>  }

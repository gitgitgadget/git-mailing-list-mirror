Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F071F407
	for <e@80x24.org>; Wed, 13 Dec 2017 19:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753737AbdLMTOP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 14:14:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50990 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753299AbdLMTOP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 14:14:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99CFFB7385;
        Wed, 13 Dec 2017 14:14:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hkGADRSXybqw3VQXisYzX0q+s4M=; b=uy48O5
        v3K/pzS0NmsUQsXoWLtv1KWFS93zslAPEcuJX5cZTXp5YJ7PEQsVrjCqPUNbE/ad
        Mfa6130WBi1C9oocjrajiOBTQj9Auwas+xQzcyZIly7DrNybYWyKHk8e3D/pFpuz
        jotJFr1DqyEchDJa/Fta+O4gUwPhv5U7YOTvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J4EWE1yzLt2o9E57GKeTz0WUPdnaBLKc
        Jx1jGoCl5WbhP8vqr16p5Ty6Oy+X1Wgp6pT/TMXriDqviwvBhe6S3M+EKGAzMUXT
        tsrANzkem6rLYrkYnYj9vTExaB/nCJLiwk4OZO2yT2YIoyq0czNPNg3/58+u2tqM
        GBGiuR+fHwY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92246B7383;
        Wed, 13 Dec 2017 14:14:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0DACCB7382;
        Wed, 13 Dec 2017 14:14:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH] path: document path functions
References: <20171212005221.GD177995@google.com>
        <20171213182802.114615-1-bmwill@google.com>
Date:   Wed, 13 Dec 2017 11:14:12 -0800
In-Reply-To: <20171213182802.114615-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 13 Dec 2017 10:28:02 -0800")
Message-ID: <xmqqr2rywid7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE85BA3E-E039-11E7-8D55-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>
> As promised here is an update to the documentation for the path generating
> functions.
>
>  path.h | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 112 insertions(+), 21 deletions(-)
>
> diff --git a/path.h b/path.h
> index 9541620c7..1ccd0373c 100644
> --- a/path.h
> +++ b/path.h
> @@ -4,53 +4,144 @@
>  struct repository;
>  
>  /*
> - * Return a statically allocated filename, either generically (mkpath), in
> - * the repository directory (git_path), or in a submodule's repository
> - * directory (git_path_submodule). In all cases, note that the result
> - * may be overwritten by another call to _any_ of the functions. Consider
> - * using the safer "dup" or "strbuf" formats below (in some cases, the
> - * unsafe versions have already been removed).
> + * The result to all functions which return statically allocated memory may be
> + * overwritten by another call to _any_ one of these functions. Consider using
> + * the safer variants which operate on strbufs or return allocated memory.
>   */

The result of the update definitely is better, but stepping back a
bit, it still does not answer some questions the original did not:

 - is the resulting path absolute?  if relative, relative to what (cwd)?

 - what should a caller write in fmt?  can we have a couple of
   typical calling example?

 - does a caller need to know which hierarchies under $GIT_DIR are
   common and call git_common_path() for them, or does git_path()
   do the 'right' thing for the caller?  If latter, what's the use
   of git_common_path() for callers (outside the implementation of
   path.c API)?

Will queue.  Thanks.

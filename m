Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8419020FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 23:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcF2XAS (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 19:00:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751541AbcF2XAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 19:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 22D3D28982;
	Wed, 29 Jun 2016 18:53:10 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=esZO0fmbE408mxR1cOuTLN2E6Rc=; b=SJ6m0s
	aNdOzd3cE6ctzPWk1mQoi+Agg8FiR9L4yFZMoT9r44YtieVz/G5ZESLTySFA0eyX
	SaejGq67CKEhLhPhQASi4VZr37MZve39g922WJZBS6m4UtCIKRXKUJCORr9jwryC
	8XsndO9+LEaA0T4VHlIhud4GQekvpm7gJfweo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=niRnYnPknEF2gnMqOwnmbiI/5FS70X1m
	chz7JJ2wH31W/It5cT1ke6i9EC5IGNbbJHeQIyuPfcec4QWyevGKVA4V/Xu47+q2
	fjaBjCN33F0gTaWPkg4an/nGT5Yx1b/obzQ0hNanKT9TjCgJ5PCpO7D5fONHCP0e
	LOGEF0XTWDI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B88928981;
	Wed, 29 Jun 2016 18:53:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D0FE28980;
	Wed, 29 Jun 2016 18:53:09 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 5/5] Skip blank lines when matching <commit>^{/foo}
References: <cover.1467209576.git.johannes.schindelin@gmx.de>
	<7cebdcd80a93d1604258e9dc9cb286cd6ba97ba8.1467209576.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 15:53:07 -0700
In-Reply-To: <7cebdcd80a93d1604258e9dc9cb286cd6ba97ba8.1467209576.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 16:15:00 +0200
	(CEST)")
Message-ID: <xmqqh9cb1ub0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 402D8158-3E4C-11E6-B4DF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When trying to match a pattern in the commit subject, simply skip leading
> blank lines in the commit message. This is consistent with the
> pretty-printing machinery: it silently ignores leading blank lines in the
> commit object's body.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Hmm.

I just tried

    $ git commit -s -m '  pull: fast-forward "pull --rebase=true"'

expecting that ":/^  pull:" would find it ;-)

The point of this patch is to make it not work, of course, which 
may or may not be a good thing.  I'd rather keep this separate from
the other fixes.

Also 4/5 is another different class of true bugfix, I would suspect,
so let's take it on a separate topic that can be merged down to
older maintainance tracks.

Thanks.

>  sha1_name.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index ca7ddd6..da354a5 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -912,7 +912,8 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
>  			continue;
>  		buf = get_commit_buffer(commit, NULL);
>  		p = strstr(buf, "\n\n");
> -		matches = negative ^ (p && !regexec(&regex, p + 2, 0, NULL, 0));
> +		matches = negative ^ (p && !regexec(&regex,
> +			skip_blank_lines(p + 2), 0, NULL, 0));
>  		unuse_commit_buffer(commit, buf);
>  
>  		if (matches) {

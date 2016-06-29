Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA15F20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 22:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcF2WFh (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 18:05:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751480AbcF2WFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 18:05:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B094281D4;
	Wed, 29 Jun 2016 17:59:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6zKOY00dTJdtWZ2DqR8FiGLLEE0=; b=Sq3g7Q
	ZksYEFwgfjEoYWKj8MNn5EGTTsF1pc+xyWYFvMTo9TKo4kESyHJ2cV55EFsjw7mB
	4ru3T0s0pTG/D832uVpg8NPbM3X7vSY9Vi1TvL2rbgcC08QQmUms9fN3oiklb8QF
	eD1N/KXKDh4h3VcTmIwx9vYl5Ma7jJYAz9XcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnG0Mp9oedDENmZ8XXBJ5HlygFDkqjcg
	wI4DaQyTlETdEe7t/W9Z1iwH0CuSeuPUmkmNTWN4O+f/17HqUxQrDbo/DEXL9N4Y
	anzqPkNh1G+ilkm6hF4TuGM0LODylDeFDEtRTwlFlaO8jmcymebJN9KmvPg4uQET
	4wjxhLDRn38=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 93AFA281D3;
	Wed, 29 Jun 2016 17:59:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AB45281CC;
	Wed, 29 Jun 2016 17:59:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/5] commit -C: skip blank lines at the beginning of the message
References: <cover.1467209576.git.johannes.schindelin@gmx.de>
	<043eafd7ad4128d3a887c224ec6576d96872d1df.1467209576.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 14:59:37 -0700
In-Reply-To: <043eafd7ad4128d3a887c224ec6576d96872d1df.1467209576.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 16:14:42 +0200
	(CEST)")
Message-ID: <xmqqtwgb1ws6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C725D10E-3E44-11E6-9337-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Consistent with the pretty-printing machinery, we skip leading blank
> lines (if any) of existing commit messages.
>
> While Git itself only produces commit objects with a single empty line
> between commit header and commit message, it is legal to have more than
> one blank line (i.e. lines containing only white space, or no
> characters) at the beginning of the commit message, and the
> pretty-printing code already handles that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 3f18942..1f6dbcd 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -715,7 +715,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		char *buffer;
>  		buffer = strstr(use_message_buffer, "\n\n");
>  		if (buffer)
> -			strbuf_addstr(&sb, buffer + 2);
> +			strbuf_addstr(&sb, skip_blank_lines(buffer + 2));
>  		hook_arg1 = "commit";
>  		hook_arg2 = use_message;
>  	} else if (fixup_message) {

use_message_buffer is the contents of the commit object read
elsewhere, and strstr() skips the header part, so this follows
exactly the same pattern as the one you fixed earlier.  Good.

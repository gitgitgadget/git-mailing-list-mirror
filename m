Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72DD41F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbdAYVjS (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:39:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62858 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751881AbdAYVjR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:39:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0A33636AF;
        Wed, 25 Jan 2017 16:39:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pOoQmZXQOTqNWNE7z3KXbuqPiRA=; b=YiUybl
        iNudGiGdfZidHhUmVigcPm2uwV6GHx4H1ZZsDqojgJyDuuzd5x89iuuUUQjZoERQ
        4uXE2G1Nzvy/gvzUg9WXuMcOKEn9uQZ6qehnnvgWTe/xRPNZeI33rp0+497uZlgH
        N5YIwjanEIQ3oxj4oIn0OVhMdbuwalAmVozGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C3jnBivmc8amdI6BvhBIKBD5coR/cRQ9
        lSJI7BGtaT8CeE9/pmERqo7Mq2Y7ayRZwfUVwUbNFbtnq+xz38hn2+tx1ewxgZuO
        ctb4ZmND6Cx5YeGg7xd+979wll1O82jWqOsr0CXqxUPvzuuzMTBBa/gcnWsNZXtD
        gLktF1Ji4vU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9720B636AE;
        Wed, 25 Jan 2017 16:39:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1A07636AD;
        Wed, 25 Jan 2017 16:39:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mingw: allow hooks to be .exe files
References: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de>
Date:   Wed, 25 Jan 2017 13:39:14 -0800
In-Reply-To: <dc388b2df3baee83972f007cd77a57410553a411.1485362812.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 25 Jan 2017 17:58:42 +0100
        (CET)")
Message-ID: <xmqq37g6akfx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B839ED72-E346-11E6-9398-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This change is necessary to allow the files in .git/hooks/ to optionally
> have the file extension `.exe` on Windows, as the file names are
> hardcoded otherwise.

Hmph.  There is no longer ".com"?

I briefly wondered if hooks/post-receive.{py,rb,...} would be good
things to support, but I do not think we want to go there, primarily
because we do not want to deal with "what happens when there are
many?"

As Peff pointed out while I was typing this message, ".exe" would be
better spelled as STRIP_EXTENSION, I think.  The resulting code
would read naturally when you read the macro not as "please do strip
extensions" boolean, but as "this extension is to be stripped"
string, which is how it is used in the other site the macro is used
(namely, strip_extension() called by handle_builtin()).

> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/exe-as-hook-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git exe-as-hook-v1
>
>  run-command.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index 73bfba7ef9..45229ef052 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -871,8 +871,14 @@ const char *find_hook(const char *name)
>  
>  	strbuf_reset(&path);
>  	strbuf_git_path(&path, "hooks/%s", name);
> -	if (access(path.buf, X_OK) < 0)
> +	if (access(path.buf, X_OK) < 0) {
> +#ifdef STRIP_EXTENSION
> +		strbuf_addstr(&path, ".exe");
> +		if (access(path.buf, X_OK) >= 0)
> +			return path.buf;
> +#endif
>  		return NULL;
> +	}
>  	return path.buf;
>  }
>  
>
> base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe

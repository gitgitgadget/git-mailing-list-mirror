Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D22560C
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MEKqLqGt"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FDF020CCA;
	Fri, 12 Jan 2024 13:19:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0sDgbzIrQhJKlbeXcL2wRLH73Ld8LTNgCDGsHY
	uV9NU=; b=MEKqLqGtSAAZLL37AnIU0Y6mTDzy1Rv4NKX78vI9xqclPhOY+ogimA
	kIghGILo55NGfj0VtjEz7P/H8ZYA0bFZcDozNgw8BhO7MOCmBADVm6hXClV6V6eM
	4xw9t3OPKE6DhwSQ0VDcRmK0mz1neQ9P78+/ncv6ri5EzhQ3hqPXk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 678F020CC9;
	Fri, 12 Jan 2024 13:19:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B5E520CC8;
	Fri, 12 Jan 2024 13:19:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  Benji Kay <okaybenji@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH] messages: mark some strings with "up-to-date" not to touch
In-Reply-To: <20240112171910.11131-1-ericsunshine@charter.net> (Eric
	Sunshine's message of "Fri, 12 Jan 2024 12:19:10 -0500")
References: <xmqqjzofec0e.fsf@gitster.g>
	<20240112171910.11131-1-ericsunshine@charter.net>
Date: Fri, 12 Jan 2024 10:19:49 -0800
Message-ID: <xmqqa5pabeii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2CD645E4-B177-11EE-A195-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> Let's do the second best thing, leave a short comment near them
> explaining why those strings should not be modified or localized.

I simply could not come up with a short and concise in-code comment
;-) What you picked looks good to me.

Thanks.  


>
> [es: make in-code comment more developer-friendly]
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> This is a reroll of Junio's[1] v1 which adds an in-code comment
> explaining that "up-to-date" messages in plumbing commands should not be
> changed, but doesn't explain _why_, which forces readers to dig through
> project history or the mailing list to understand the motivation. v2
> changes the comment to be more developer-friendly by adding the
> explanation directly to the comment.
>
> [1]: https://lore.kernel.org/git/xmqqjzofec0e.fsf@gitster.g/
>
> Range-diff:
> 1:  36596051c9 ! 1:  782169e0b1 messages: mark some strings with "up-to-date" not to touch
>     @@ Commit message
>          the commit is impossible to ask "git blame" to link back to the
>          commit that did not touch them.
>      
>     -    Let's do the second best thing, leave a short comment near them, to
>     -    make it possible for those who are motivated enough to find out why
>     -    we decided to tell them "do not modify".
>     +    Let's do the second best thing, leave a short comment near them
>     +    explaining why those strings should not be modified or localized.
>     +
>     +    [es: make in-code comment more developer-friendly]
>      
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     +    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>      
>       ## builtin/send-pack.c ##
>      @@ builtin/send-pack.c: int cmd_send_pack(int argc, const char **argv, const char *prefix)
>       	}
>       
>       	if (!ret && !transport_refs_pushed(remote_refs))
>     -+		/* do not modify this string */
>     ++		/* stable plumbing output; do not modify or localize */
>       		fprintf(stderr, "Everything up-to-date\n");
>       
>       	return ret;
>     @@ http-push.c: int cmd_main(int argc, const char **argv)
>       
>       		if (oideq(&ref->old_oid, &ref->peer_ref->new_oid)) {
>       			if (push_verbosely)
>     -+				/* do not modify this string */
>     ++				/* stable plumbing output; do not modify or localize */
>       				fprintf(stderr, "'%s': up-to-date\n", ref->name);
>       			if (helper_status)
>       				printf("ok %s up to date\n", ref->name);
>     @@ http-push.c: int cmd_main(int argc, const char **argv)
>       				 * commits at the remote end and likely
>       				 * we were not up to date to begin with.
>       				 */
>     -+				/* do not modify this string */
>     ++				/* stable plumbing output; do not modify or localize */
>       				error("remote '%s' is not an ancestor of\n"
>       				      "local '%s'.\n"
>       				      "Maybe you are not up-to-date and "
>     @@ transport.c: int transport_push(struct repository *r,
>       	if (porcelain && !push_ret)
>       		puts("Done");
>       	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
>     -+		/* do not modify this string */
>     ++		/* stable plumbing output; do not modify or localize */
>       		fprintf(stderr, "Everything up-to-date\n");
>       
>       done:
>
>  builtin/send-pack.c | 1 +
>  http-push.c         | 2 ++
>  transport.c         | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index b7183be970..3df9eaad09 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -333,6 +333,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (!ret && !transport_refs_pushed(remote_refs))
> +		/* stable plumbing output; do not modify or localize */
>  		fprintf(stderr, "Everything up-to-date\n");
>  
>  	return ret;
> diff --git a/http-push.c b/http-push.c
> index b4d0b2a6aa..12d1113741 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1851,6 +1851,7 @@ int cmd_main(int argc, const char **argv)
>  
>  		if (oideq(&ref->old_oid, &ref->peer_ref->new_oid)) {
>  			if (push_verbosely)
> +				/* stable plumbing output; do not modify or localize */
>  				fprintf(stderr, "'%s': up-to-date\n", ref->name);
>  			if (helper_status)
>  				printf("ok %s up to date\n", ref->name);
> @@ -1871,6 +1872,7 @@ int cmd_main(int argc, const char **argv)
>  				 * commits at the remote end and likely
>  				 * we were not up to date to begin with.
>  				 */
> +				/* stable plumbing output; do not modify or localize */
>  				error("remote '%s' is not an ancestor of\n"
>  				      "local '%s'.\n"
>  				      "Maybe you are not up-to-date and "
> diff --git a/transport.c b/transport.c
> index bd7899e9bf..df518ead70 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1467,6 +1467,7 @@ int transport_push(struct repository *r,
>  	if (porcelain && !push_ret)
>  		puts("Done");
>  	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
> +		/* stable plumbing output; do not modify or localize */
>  		fprintf(stderr, "Everything up-to-date\n");
>  
>  done:

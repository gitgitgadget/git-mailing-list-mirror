From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: Remove some unused code
Date: Sun, 25 Jul 2010 22:42:47 -0700
Message-ID: <7vr5iqaje0.fsf@alter.siamese.dyndns.org>
References: <1280002151-7527-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Edelen <sirnot@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 07:43:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdGSx-0002zN-Nf
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 07:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab0GZFnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 01:43:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab0GZFnA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 01:43:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FD5BC7058;
	Mon, 26 Jul 2010 01:42:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wjkP9GSxUip+RlevwktQ1E0YBAU=; b=k2urbx
	fk5QyUbGzXIVe4Eqjlfy93f4suXZidQNmv7/LiHfpPifvETWSzKBIpS1KSSTc7Ni
	7fjQCz7dzesdudyxVxPgi4VThUtXZu6Ejvbdduk9NVsctzW5ABr4q6LHSAw/sAuy
	lYwX1OCRp7mgY3BW/nM20/HaAVak5ttMXiJ50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fs8dzRY2NXhwBcPCbutjDZnOVmxEtGve
	3PRVOzUhP4V+Ep2tRQca/Oz1vL2hc/os10fuUjSm9YX84bDkEtFMSbmnyeDmgxE6
	HgnVF0mliArtTDrk924vpJq/hGZCrb7XSkBIItG/schFUXLQgxJ9LhsGQAQ37Fj9
	kKKvKxGADFs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38007C7050;
	Mon, 26 Jul 2010 01:42:54 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED911C704C; Mon, 26 Jul
 2010 01:42:48 -0400 (EDT)
In-Reply-To: <1280002151-7527-1-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sat\, 24 Jul 2010 14\:09\:11 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A2F7703A-9878-11DF-A68D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151807>

Elijah Newren <newren@gmail.com> writes:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> I'm not sure if this is too trivial to submit, but I noticed it while
> poking around in upload-pack.
>
> Ever since f0cea83f631689331fce73b51f22707e897f7939, the
> 'create_full_pack' argument has been unused and is always false.  We
> can make it clear that this argument is currently unused and remove some
> associated code from an 'if' block.

While it is true that currently we memset(&rev_list) to always pass NULL
there, I wonder if that was an unintended behaviour change introduced by
the commit you mentioned...

>  upload-pack.c |   29 ++++++++++++-----------------
>  1 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index dc464d7..c2e4eae 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -105,7 +105,7 @@ static void show_edge(struct commit *commit)
>  	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
>  }
>  
> -static int do_rev_list(int in, int out, void *create_full_pack)
> +static int do_rev_list(int in, int out, void *unused)
>  {
>  	int i;
>  	struct rev_info revs;
> @@ -118,23 +118,18 @@ static int do_rev_list(int in, int out, void *create_full_pack)
>  	if (use_thin_pack)
>  		revs.edge_hint = 1;
>  
> -	if (create_full_pack) {
> -		const char *args[] = {"rev-list", "--all", NULL};
> -		setup_revisions(2, args, &revs, NULL);
> -	} else {
> -		for (i = 0; i < want_obj.nr; i++) {
> -			struct object *o = want_obj.objects[i].item;
> -			/* why??? */
> -			o->flags &= ~UNINTERESTING;
> -			add_pending_object(&revs, o, NULL);
> -		}
> -		for (i = 0; i < have_obj.nr; i++) {
> -			struct object *o = have_obj.objects[i].item;
> -			o->flags |= UNINTERESTING;
> -			add_pending_object(&revs, o, NULL);
> -		}
> -		setup_revisions(0, NULL, &revs, NULL);
> +	for (i = 0; i < want_obj.nr; i++) {
> +		struct object *o = want_obj.objects[i].item;
> +		/* why??? */
> +		o->flags &= ~UNINTERESTING;
> +		add_pending_object(&revs, o, NULL);
> +	}
> +	for (i = 0; i < have_obj.nr; i++) {
> +		struct object *o = have_obj.objects[i].item;
> +		o->flags |= UNINTERESTING;
> +		add_pending_object(&revs, o, NULL);
>  	}
> +	setup_revisions(0, NULL, &revs, NULL);
>  	if (prepare_revision_walk(&revs))
>  		die("revision walk setup failed");
>  	mark_edges_uninteresting(revs.commits, &revs, show_edge);
> -- 
> 1.7.2.1.g83744

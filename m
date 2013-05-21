From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/17] builtin_diff_tree(): make it obvious that function wants two entries
Date: Tue, 21 May 2013 10:27:30 -0700
Message-ID: <7v8v38p7jx.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<1368995232-11042-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 21 19:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeqMI-0003H6-B1
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339Ab3EUR1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:27:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274Ab3EUR1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:27:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBE041E1B4;
	Tue, 21 May 2013 17:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hc7gGNdrwHq9/p074wGUWldD6Do=; b=s72Qig
	rIqhiv1xzvcpjj9yFXcnm9Yl4IQ6fcFyrJ4Lcv03tSPAuF/6nCa45GvPNBfh2C0h
	9orFAvg6FkuA++YzNq4cPp7McoS2P75rA006doGp7quz+l4nUOal4YH2Pp7OXPHF
	Gh2ttijoOTEmpB9QSfoa0SPtsJiYatinVzZtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WKH/RuLNEJxuwwabmzUIKAzajnpVKo6W
	oCcNNuEFaCrjG5MaHuoO5ic1kCuAHuFHQQg9ihT3lbHvY0snsa/RZaImrDh94euU
	hbdH3fJ9jbMIxf3tisSGcjYtlNC+iDHPWoPEC1fsFjdohapJtBYaZHIdXvF7kh+x
	OUBk8eP6288=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B30261E1B3;
	Tue, 21 May 2013 17:27:32 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1991E1E1B1;
	Tue, 21 May 2013 17:27:32 +0000 (UTC)
In-Reply-To: <1368995232-11042-5-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sun, 19 May 2013 22:26:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B80BBE64-C23B-11E2-894D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225046>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Instead of accepting an array and using exactly two elements from the
> array, take two single (struct object_array_entry *) arguments.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/diff.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 8c2af6c..ba68c6c 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -153,7 +153,8 @@ static int builtin_diff_index(struct rev_info *revs,
>  
>  static int builtin_diff_tree(struct rev_info *revs,
>  			     int argc, const char **argv,
> -			     struct object_array_entry *ent)
> +			     struct object_array_entry *ent0,
> +			     struct object_array_entry *ent1)
>  {
>  	const unsigned char *(sha1[2]);
>  	int swap = 0;
> @@ -161,13 +162,13 @@ static int builtin_diff_tree(struct rev_info *revs,
>  	if (argc > 1)
>  		usage(builtin_diff_usage);
>  
> -	/* We saw two trees, ent[0] and ent[1].
> -	 * if ent[1] is uninteresting, they are swapped
> +	/* We saw two trees, ent0 and ent1.
> +	 * if ent1 is uninteresting, they are swapped
>  	 */

"While you are touching this comment" is a perfect time to fix the
existing style violation.

Other than that, looks good to me.

> -	if (ent[1].item->flags & UNINTERESTING)
> +	if (ent1->item->flags & UNINTERESTING)
>  		swap = 1;
> -	sha1[swap] = ent[0].item->sha1;
> -	sha1[1-swap] = ent[1].item->sha1;
> +	sha1[swap] = ent0->item->sha1;
> +	sha1[1-swap] = ent1->item->sha1;
>  	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
>  	log_tree_diff_flush(revs);
>  	return 0;
> @@ -403,7 +404,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  	else if (ents == 1)
>  		result = builtin_diff_index(&rev, argc, argv);
>  	else if (ents == 2)
> -		result = builtin_diff_tree(&rev, argc, argv, ent);
> +		result = builtin_diff_tree(&rev, argc, argv, &ent[0], &ent[1]);
>  	else if (ent[0].item->flags & UNINTERESTING) {
>  		/*
>  		 * diff A...B where there is at least one merge base
> @@ -412,8 +413,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  		 * between the base and B.  Note that we pick one
>  		 * merge base at random if there are more than one.
>  		 */
> -		ent[1] = ent[ents-1];
> -		result = builtin_diff_tree(&rev, argc, argv, ent);
> +		result = builtin_diff_tree(&rev, argc, argv, &ent[0], &ent[ents-1]);
>  	} else
>  		result = builtin_diff_combined(&rev, argc, argv,
>  					       ent, ents);

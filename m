From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/4] match-trees: drop "x = x" initializations
Date: Mon, 25 Mar 2013 09:10:48 -0700
Message-ID: <7vzjxrzchj.fsf@alter.siamese.dyndns.org>
References: <20130322161837.GG3083@sigill.intra.peff.net>
 <20130322162155.GB25857@sigill.intra.peff.net>
 <514DFB1A.8040102@lsrfire.ath.cx> <7vli9d4crq.fsf@alter.siamese.dyndns.org>
 <514F8244.8070702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 25 17:11:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK9zU-00032m-Ce
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 17:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758426Ab3CYQKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 12:10:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758200Ab3CYQKv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Mar 2013 12:10:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05ED7B79A;
	Mon, 25 Mar 2013 12:10:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DYgf8B/o7GiG
	BNWAJ09F+/WQjUc=; b=RsuLYaJGjnhzwWb54kDsq9smymTVdLDKKm9sS6IgS/D6
	svgs0nUX/wOqqTUGVr5QzhO3jVMsukrK94FSFnra9TDlJsbk+3YDvNQwlGpY1Pw7
	IlaogeeoeONiA/YRD/iACAw7oTmz6BH7w7SYQtdZueBQUKWVRDDz80Xv1RGpN6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w4Ku+a
	G6K8uZChHlnd5nh6u2PinI23nD+YQbmOpg4F85+lZj4PEd5z7xfSCRd5/6w+2mda
	98ZHSlFcfHZbE5o+ISelavMI9B/Srp+J9RK0LJSkZWYOPkln1us25Lq/RSeg1lrt
	WOdVlygSWdr+poEQW5xM0vwldIi2c29VYjIAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF19DB799;
	Mon, 25 Mar 2013 12:10:50 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29335B798; Mon, 25 Mar 2013
 12:10:50 -0400 (EDT)
In-Reply-To: <514F8244.8070702@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun, 24 Mar 2013 23:46:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F87C9C6-9566-11E2-B3AA-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219042>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 24.03.2013 05:55, schrieb Junio C Hamano:
>> So I like your change for readability, but for GCC 4.4.5 we still
>> need the unnecessary initialization.
>
> Hrm, perhaps we can make it even simpler for the compiler.

And the result is even simpler for human readers, I'd have to say.

> I'm a bit uneasy about this one because we lack proper tests for
> this code and I don't know how to write ones off the bat.

This looks pretty much a straight-forward equivalent rewrite from
your earlier one, which was also an obvious equivalent to the
original, at least to me.  The first four lines in the original were
made into two tree_entry() calls (what a useful helper we haven't
been using!) and that allows us to lose explicit update_tree_entry()
calls.



>  match-trees.c | 68 ++++++++++++++++++++++++-------------------------=
----------
>  1 file changed, 28 insertions(+), 40 deletions(-)
>
> diff --git a/match-trees.c b/match-trees.c
> index 26f7ed1..2bb734d 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -47,6 +47,13 @@ static int score_matches(unsigned mode1, unsigned =
mode2, const char *path)
>  	return score;
>  }
> =20
> +static int base_name_entries_compare(const struct name_entry *a,
> +				     const struct name_entry *b)
> +{
> +	return base_name_compare(a->path, tree_entry_len(a), a->mode,
> +				 b->path, tree_entry_len(b), b->mode);
> +}
> +
>  /*
>   * Inspect two trees, and give a score that tells how similar they a=
re.
>   */
> @@ -71,54 +78,35 @@ static int score_trees(const unsigned char *hash1=
, const unsigned char *hash2)
>  	if (type !=3D OBJ_TREE)
>  		die("%s is not a tree", sha1_to_hex(hash2));
>  	init_tree_desc(&two, two_buf, size);
> -	while (one.size | two.size) {
> -		const unsigned char *elem1 =3D elem1;
> -		const unsigned char *elem2 =3D elem2;
> -		const char *path1 =3D path1;
> -		const char *path2 =3D path2;
> -		unsigned mode1 =3D mode1;
> -		unsigned mode2 =3D mode2;
> +	for (;;) {
> +		struct name_entry e1, e2;
> +		int got_entry_from_one =3D tree_entry(&one, &e1);
> +		int got_entry_from_two =3D tree_entry(&two, &e2);
>  		int cmp;
> =20
> -		if (one.size)
> -			elem1 =3D tree_entry_extract(&one, &path1, &mode1);
> -		if (two.size)
> -			elem2 =3D tree_entry_extract(&two, &path2, &mode2);
> -
> -		if (!one.size) {
> -			/* two has more entries */
> -			score +=3D score_missing(mode2, path2);
> -			update_tree_entry(&two);
> -			continue;
> -		}
> -		if (!two.size) {
> +		if (got_entry_from_one && got_entry_from_two)
> +			cmp =3D base_name_entries_compare(&e1, &e2);
> +		else if (got_entry_from_one)
>  			/* two lacks this entry */
> -			score +=3D score_missing(mode1, path1);
> -			update_tree_entry(&one);
> -			continue;
> -		}
> -		cmp =3D base_name_compare(path1, strlen(path1), mode1,
> -					path2, strlen(path2), mode2);
> -		if (cmp < 0) {
> +			cmp =3D -1;
> +		else if (got_entry_from_two)
> +			/* two has more entries */
> +			cmp =3D 1;
> +		else
> +			break;
> +
> +		if (cmp < 0)
>  			/* path1 does not appear in two */
> -			score +=3D score_missing(mode1, path1);
> -			update_tree_entry(&one);
> -			continue;
> -		}
> -		else if (cmp > 0) {
> +			score +=3D score_missing(e1.mode, e1.path);
> +		else if (cmp > 0)
>  			/* path2 does not appear in one */
> -			score +=3D score_missing(mode2, path2);
> -			update_tree_entry(&two);
> -			continue;
> -		}
> -		else if (hashcmp(elem1, elem2))
> +			score +=3D score_missing(e2.mode, e2.path);
> +		else if (hashcmp(e1.sha1, e2.sha1))
>  			/* they are different */
> -			score +=3D score_differs(mode1, mode2, path1);
> +			score +=3D score_differs(e1.mode, e2.mode, e1.path);
>  		else
>  			/* same subtree or blob */
> -			score +=3D score_matches(mode1, mode2, path1);
> -		update_tree_entry(&one);
> -		update_tree_entry(&two);
> +			score +=3D score_matches(e1.mode, e2.mode, e1.path);
>  	}
>  	free(one_buf);
>  	free(two_buf);

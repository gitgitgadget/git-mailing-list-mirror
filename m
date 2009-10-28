From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach 'git merge' and 'git pull' the option --ff-only
Date: Wed, 28 Oct 2009 15:45:34 -0700
Message-ID: <7vk4yfi1dd.fsf@alter.siamese.dyndns.org>
References: <4AE8C281.50104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3HHB-0006xX-RB
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 23:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbZJ1Wps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 18:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754211AbZJ1Wps
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 18:45:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbZJ1Wpr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 18:45:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9406B89EE0;
	Wed, 28 Oct 2009 18:45:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4Z4XtpZDcJ1a
	lSK1vsJ7+9JQ184=; b=ZG1bAVJSEXtgzgG1wVXfR/4r/FIi7DGXPOlj8vg2DZXs
	j0f/JXGDX+7n3gjJrNd+PQnIV1C678r9NbgmgMOYT2EnXxUbsTuqnMC90FwoInKG
	oLxzUD5DDP87WLsnwI5GbwU62h2zLAaeAyFClghGgJOlvFvgmmYWLJQl6UnpdV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uORMYR
	WRy42HEHoT5kzeBLfUARrv11+Kcrj45FIF+F89N75ybVeCqSGdjEftXjD0KsXQ4x
	mhfk9wJa36rcStMMVYr8YodawIojTOuNai+HfvKnnx450dtHVaGgncAMccUMNIki
	Te4kwy81ApSzG5sUVLyvCGKotTlXttdGcZtQ8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75B9989EDF;
	Wed, 28 Oct 2009 18:45:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 25A9189EDA; Wed, 28 Oct 2009
 18:45:40 -0400 (EDT)
In-Reply-To: <4AE8C281.50104@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Wed\, 28 Oct 2009 23\:15\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A2E99D96-C413-11DE-89AD-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131506>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> For convenience in scripts and aliases, add the option
> --ff-only to only allow fast-forwards.
>
> Acknowledgements: I did look at Yuval Kogman's earlier
> patch (107768 in gmane), mainly as shortcut to find my
> way in the code, but I did not copy anything directly.
>
> Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>

Thanks.  I think you covered the points in the old discussion thread.

> diff --git a/Documentation/merge-options.txt b/Documentation/merge-op=
tions.txt
> index adadf8e..fbf8976 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -60,6 +60,10 @@
>  	a fast-forward, only update the branch pointer. This is
>  	the default behavior of git-merge.
> =20
> +--ff-only::
> +	Refuse to merge unless the merge can be resolved as a
> +	fast-forward.

Do you or do you not allow "already up to date"?  I think it makes sens=
e
to allow it, but it is unclear from these two lines.

> @@ -874,6 +877,9 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
>  		option_commit =3D 0;
>  	}
> =20
> +	if (!allow_fast_forward && fast_forward_only)
> +		die("You cannot combine --no-ff with --ff-only.");

Are these the only nonsensical combinations?  How should this interact
with other options, e.g. --squash or --message?

> @@ -969,8 +975,11 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
>  	}
> =20
>  	for (i =3D 0; i < use_strategies_nr; i++) {
> -		if (use_strategies[i]->attr & NO_FAST_FORWARD)
> +		if (use_strategies[i]->attr & NO_FAST_FORWARD) {
>  			allow_fast_forward =3D 0;
> +			if (fast_forward_only)
> +				die("You cannot combine --ff-only with the merge strategy '%s'."=
, use_strategies[i]->name);
> +		}

I am not convinced this tests the right condition nor it is placed at t=
he
right place in the codepath---even if a specified strategy happens to
allow fast-forward, wouldn't it be nonsense to say

    $ git merge --ff-only -s resolve that-one

in the first place?  Note that I am not saying "I am convinced this is
wrong."

> @@ -1040,7 +1049,7 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
>  		 * only one common.
>  		 */
>  		refresh_cache(REFRESH_QUIET);
> -		if (allow_trivial) {
> +		if (allow_trivial && !fast_forward_only) {

Good.

> @@ -1079,6 +1088,9 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
>  		}
>  	}
> =20
> +	if (fast_forward_only)
> +		die("Not possible to fast forward, aborting.");

Good.

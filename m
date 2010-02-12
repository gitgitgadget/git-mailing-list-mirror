From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Documentation: describe --thin more accurately
Date: Fri, 12 Feb 2010 09:36:16 -0800
Message-ID: <7vhbpm2w6n.fsf@alter.siamese.dyndns.org>
References: <1265778851-5397-1-git-send-email-bebarino@gmail.com>
 <1265961646-28585-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 18:36:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfzRR-0004Qj-NL
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 18:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275Ab0BLRg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 12:36:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab0BLRg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 12:36:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DBF5D99877;
	Fri, 12 Feb 2010 12:36:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WSq86NFxl2kUOWn5RsN8s6Jie9g=; b=XWiIuF
	PBTOFQ2uNbQkAKyd1xmvn/TWK9gF9BwRUoNYl1gQT7dtvOshMU+hGQxwSU5D7dRA
	k2c9jhjCmMxErFoa8b+a6Xqwo/uQtRlPtFkgXft2NHwjqpxBSylqDsdrYp9I+DhI
	ll5zTvQjZUo1BQ+MOV6yMvssF//sLnh3pUXeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MZ/Uw0/QFSzOKqDYUyOR8GQZFWMROI1A
	RAQvsdrUPt1AIPTC/ZUR3PaYWIVeSC1YFtDvC5opfR4v/1EHRV7X/NIjhJmdMrox
	tyvlL6aSlc+QPHLmhMMhofIIFZVojwoWidS4TtkP2Wu2+ZiNoyMPBneuJxoHOR+f
	pR4D+mhCqrQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A23C699874;
	Fri, 12 Feb 2010 12:36:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B18899870; Fri, 12 Feb
 2010 12:36:18 -0500 (EST)
In-Reply-To: <1265961646-28585-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Fri\, 12 Feb 2010 00\:00\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2308569C-17FD-11DF-875E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139730>

Stephen Boyd <bebarino@gmail.com> writes:

> The description for --thin was misleading and downright wrong. Correct
> it with some inspiration from the description of index-pack's --fix-thin
> and some background information from Nicolas Pitre <nico@fluxnic.net>.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>

Looks better, but...

> diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
> index e9952e8..c428f6d 100644
> --- a/Documentation/git-fetch-pack.txt
> +++ b/Documentation/git-fetch-pack.txt
> @@ -44,8 +44,10 @@ OPTIONS
>  	locked against repacking.
>  
>  --thin::
> -	Spend extra cycles to minimize the number of objects to be sent.
> -	Use it on slower connection.
> +	Fetch a "thin" pack, which records objects in deltified form based
> +	on objects not included in the pack to reduce network traffic.
> +	The excluded objects are expected to be present on the receiving
> +	end.

It is useless and misleading to say "expected to be" for fetch-pack and
send-pack.  Imagine you are a first time reader of this documentation and
read the above.  Wouldn't it be very natural to ask yourself: "I want to
take advantage of reduced network traffic by using --thin.  How do I make
sure that my local repository (i.e. receiving end) satisfies that
expectation?"

The answer is, "nothing"---the protocol exchange ensures that condition.

> diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
> index 65a301b..73fe51a 100644
> --- a/Documentation/git-index-pack.txt
> +++ b/Documentation/git-index-pack.txt
> @@ -46,10 +46,10 @@ OPTIONS
>  	'git repack'.
>  
>  --fix-thin::
> -	It is possible for 'git pack-objects' to build
> +	It is possible for 'git pack-objects' to build a
>  	"thin" pack, which records objects in deltified form based on
>  	objects not included in the pack to reduce network traffic.
> -	Those objects are expected to be present on the receiving end
> +	The excluded objects are expected to be present on the receiving end
>  	and they must be included in the pack for that pack to be self
>  	contained and indexable. Without this option any attempt to
>  	index a thin pack will fail. This option only makes sense in

This "expected to be present and they must be included" is correct, but
"running index-pack with this option is how you 'fix' the thin pack by
including them" is missing (not your patch's fault---but because you are
touching in the vicinity on this exact topic anyway...).

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index ffd5025..f32c322 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -179,6 +179,14 @@ base-name::
>  	Add --no-reuse-object if you want to force a uniform compression
>  	level on all data no matter the source.
>  
> +--thin::
> +	Create a "thin" pack, which records objects in deltified form based
> +	on objects not included in the pack to reduce network traffic.
> +	The excluded objects are expected to be present on the receiving end
> +	and eventually must be included in the pack for that pack to be self
> +	contained and indexable. This option only makes sense in
> +	conjunction with --stdout.

Before using such a "thin" pack, the receiving end must add excluded
objects back to make it self-contained and indexable by running index-pack
with its --fix-thin option.

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index bd79119..c67b06c 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -141,9 +141,10 @@ useful if you write an alias or script around 'git push'.
>  
>  --thin::
>  --no-thin::
> -	These options are passed to 'git send-pack'.  Thin
> -	transfer spends extra cycles to minimize the number of
> -	objects to be sent and meant to be used on slower connection.
> +	These options are passed to linkgit:git-send-pack[1]. A thin transfer
> +	significantly reduces the number of sent objects when the sender and
> +	receiver share many of the same objects in common. The default is
> +	\--thin.

It is sometimes true that "number of" send objects is reduced, but the
significant reduction comes from sending smaller amount of data.

If both sides start out with a file with 10000 lines, and you have two
commits since then, one adding a line A and then adding another line B on
top of it.  Without --thin, you would send the last version (10000
original lines plus A and B) in full and a delta that says "starting from
that version, delete line B", in order to represent the two versions (one
with addition of line A, the other with addition of both line A and B).
With --thin, you would instead send two deltas that say "starting from the
10000-line file you have, add line A" and "starting from that result, add
line B", without sending any full version.  The sent number of objects in
these two cases are the same (the version with A added, and the version
with both A and B added). 

> diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
> index 8178d92..1d7c4d4 100644
> --- a/Documentation/git-send-pack.txt
> +++ b/Documentation/git-send-pack.txt
> @@ -48,8 +48,10 @@ OPTIONS
>  	Run verbosely.
>  
>  --thin::
> -	Spend extra cycles to minimize the number of objects to be sent.
> -	Use it on slower connection.
> +	Send a "thin" pack, which records objects in deltified form based
> +	on objects not included in the pack to reduce network traffic.
> +	The excluded objects are expected to be present on the receiving
> +	end.

The same comment as fetch-pack one applies here.

Thanks.

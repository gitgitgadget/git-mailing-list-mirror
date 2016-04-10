From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify signature verification
Date: Sun, 10 Apr 2016 11:46:10 -0700
Message-ID: <xmqqa8l1ti8d.fsf@gitster.mtv.corp.google.com>
References: <20160409200756.GA22694@hashbang.sh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
To: The Fox in the Shell <KellerFuchs@hashbang.sh>
X-From: git-owner@vger.kernel.org Sun Apr 10 20:47:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apKNw-0006v1-3e
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 20:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757193AbcDJSq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 14:46:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756982AbcDJSqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 14:46:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2DB7452B69;
	Sun, 10 Apr 2016 14:46:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ovevc31nwewzUJiIQF5TU0DMpbw=; b=Z1TWQf
	1nm4BFoWJC0FRcHPvHf9PL2+A9tcMMzFAq3GOMNwX5s+/gpQm9oQOOH0xvwzeY29
	ASPElJQsoGZ/o53fFtJY3to/Itm8v2RbT8gM4COJ0wYnrQ2RwGHe32smnDdtxSmH
	VnNfcS/V1XN7qbWZ7zoCQejuCkQK6SZ6/790c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uxP1VJBdO+BC4qVyINxZ4qpFbXhkSTpw
	yLHrX8UydV1A+xsGgjN8tKpj5t8zKmJtklYii0riTOWgijLIUQ5Jp836QG1E4Vck
	uEp1g3ycIXbinjjSMBsXvDnZdZvFo/m0s8AmXRAghDaiWLNbNYA5LWiySY67E8+r
	gVqOoUVGG2k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2403952B68;
	Sun, 10 Apr 2016 14:46:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9716452B67;
	Sun, 10 Apr 2016 14:46:11 -0400 (EDT)
In-Reply-To: <20160409200756.GA22694@hashbang.sh> (The Fox in the Shell's
	message of "Sat, 9 Apr 2016 20:08:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7EE6FA9E-FF4C-11E5-A786-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291185>

The Fox in the Shell <KellerFuchs@hashbang.sh> writes:

> Hi,
>
> I encountered some issues with the git documentation while modifying
> my deployment scripts to enforce that the tree being fetched was
> signed by a trusted key.
>
> It was unclear which commits needed to be signed (in the case of `git
> merge`) and what were the criteria for the signature to be considered
> valid.
>
> Here is a patch proposal.
>
> Signed-off-by: The Fox in the Shell <KellerFuchs@hashbang.sh>
> ---

I'll leave commenting on and suggesting updates for the above to
others.

> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index f08e9b8..edd50bf 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -89,8 +89,10 @@ option can be used to override --squash.
>  
>  --verify-signatures::
>  --no-verify-signatures::
> -	Verify that the commits being merged have good and trusted GPG signatures
> +	Verify that the commits being merged have good and valid GPG signatures
>  	and abort the merge in case they do not.
> +	For instance, when running `git merge --verify-signature remote/branch`,
> +	only the head commit on `remote/branch` needs to be signed.

The first part of this change and all other changes are of dubious
value, but the last two lines is truly an improvement--it adds
missing information people who use the feature may care about.

I'd suggest doing the addition of the last two lines as a standalone
patch, and make the remainder a separate patch on top.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 671cebd..29b19b9 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -143,8 +143,8 @@ ifndef::git-rev-list[]
>  - '%N': commit notes
>  endif::git-rev-list[]
>  - '%GG': raw verification message from GPG for a signed commit
> -- '%G?': show "G" for a Good signature, "B" for a Bad signature, "U" for a good,
> -  untrusted signature and "N" for no signature
> +- '%G?': show "G" for a good (valid) signature, "B" for a bad signature,
> +  "U" for a good signature with unknown validity and "N" for no signature

The reason I said the other changes are of dubious value is shown
very well in this hunk.  I am not sure if it is an improvement to
rephrase "Good" to "good (valid)" and "untrusted" to "good signature
with unknown validity".  They are saying pretty much the same thing,
no?

> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index 54b88b6..62cbae2 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -78,5 +78,5 @@ being displayed. Examples: "--notes=foo" will show only notes from
>  endif::git-rev-list[]
>  
>  --show-signature::
> -	Check the validity of a signed commit object by passing the signature
> -	to `gpg --verify` and show the output.
> +	Check the validity of a signed commit object, by passing the signature
> +	to `gpg --verify`, and show the output.

The update one may be gramattically correct, but I personally find
the original easier to read.  Is there a reason for this change?

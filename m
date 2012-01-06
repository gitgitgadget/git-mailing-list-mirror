From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: rerere.enabled overrides [ -d rr-cache ]
Date: Fri, 06 Jan 2012 12:27:25 -0800
Message-ID: <7vfwfsk24y.fsf@alter.siamese.dyndns.org>
References: <f697b8eff63a8cdd1207c6bfd6b88c532832c6b5.1325855112.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 06 21:27:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjGNx-0001Xd-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 21:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396Ab2AFU13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 15:27:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932638Ab2AFU12 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 15:27:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4628F6BE8;
	Fri,  6 Jan 2012 15:27:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GGZef9zwhUTsGxi713eUlDaard4=; b=jMJch1
	ZV7QF1v7nislygKojwhK6dZgD6GMSEiWKQ46SfHj82gDSEszUAnnYzqurGrXXWp6
	nXwQ2Zt/LW3Iq4CMza2BNmWIRc6IBAEP1uHMg5FDgJ62XKw5+1DtOWwADjcOuX2g
	WyMHxN5YCs+Z0oWRzkSgX6B2qPhNJK1NftAJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I21BvJjbCPIMZt7AGP2XF/Iwel/1VGk7
	PXQXe4tlkjxjLsRd6t0nOudlp8/nFDX9q9jDHrOfLDsYf8Aqm5ajrTYJ/qfHiLtg
	ZYCorhe9lklqXZEPp7w1GuRtiYKZ1cdXodMU32RnJ62mChTAi6jfmo0BujjP96/3
	R6PKWQvYlGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D5306BE7;
	Fri,  6 Jan 2012 15:27:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3B4D6BE6; Fri,  6 Jan 2012
 15:27:26 -0500 (EST)
In-Reply-To: <f697b8eff63a8cdd1207c6bfd6b88c532832c6b5.1325855112.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri, 6 Jan 2012 14:08:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D930B3C8-38A4-11E1-B79C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188046>

Thomas Rast <trast@student.ethz.ch> writes:

> git-rerere(1) does not mention the rr-cache fallback; I decided not to
> touch it as it's a bit of an implementation detail.

It is not an implementation detail but is a (n old) part of the external
UI. Creating .git/rr-cache directory has been the only way to enable it
for quite a while (ever since it was first written as a Perl script early
2006, and the design even survived the rewrite in C late 2006). When the
configuration variable rerere.enabled was introduced with b4372ef (Enable
"git rerere" by the config variable rerere.enabled, 2007-07-06), we
deliberately kept the external interface compatible to avoid disruption.

And your "By default, ... is enabled if there is ... directory" below is
exactly the right description.

The manual page for "rerere" talks about "configuration variable
rerere.enabled"; perhaps it should also refer to git config manual page to
make it more discoverable?

> ... OTOH the
> auto-creation of rr-cache can cause strange behavior if a user has
> rerere.enabled unset and tries it once, as in
>
>   git config rerere.enabled true
>   git merge ...
>   git config --unset rerere.enabled

That is because the last one should be

	git config --bool rerere.enabled false

Perhaps the description for "--unset" option in the manual of "git config"
is not clear enough that there is a difference between a variable not
being set (i.e. we do not know anything about what the user wants) and a
variable explicitly set to false (i.e. we do know the user does not want
it)?  I doubt it, but you may want to check and clarify the section if
needed.

The patch itself looks good; it goes in the right direction.

Thanks.

>  Documentation/config.txt |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 68cf702..04f5e19 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1783,10 +1783,10 @@ rerere.autoupdate::
>  
>  rerere.enabled::
>  	Activate recording of resolved conflicts, so that identical
> -	conflict hunks can be resolved automatically, should they
> -	be encountered again.  linkgit:git-rerere[1] command is by
> -	default enabled if you create `rr-cache` directory under
> -	`$GIT_DIR`, but can be disabled by setting this option to false.
> +	conflict hunks can be resolved automatically, should they be
> +	encountered again.  By default, linkgit:git-rerere[1] is
> +	enabled if there is an `rr-cache` directory under the
> +	`$GIT_DIR`.
>  
>  sendemail.identity::
>  	A configuration identity. When given, causes values in the

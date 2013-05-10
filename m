From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] am: suppress error output from a conditional
Date: Fri, 10 May 2013 07:46:26 -0700
Message-ID: <7vhaia51vh.fsf@alter.siamese.dyndns.org>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
	<1368196005-5354-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 16:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaoan-0005VV-Im
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab3EJOqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:46:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab3EJOq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:46:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4BDB1B8C8;
	Fri, 10 May 2013 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=miHCjIi6Gbsc+JGpWGSLOtJcha8=; b=dcQOB7
	tohhXdJoC+FklgDTAyHSaNcbaofNVS/32v8QwMIfoiaAMTm8sZqYJdQBFZZZOIsn
	GxD9zzhb3JyFbV6mpWMvMctYmo/kBEaNwlwHdzfudmYtF1iEFhpkjkCC3HtAKMRf
	aCP8siJTSfXRqnT2/J0JLccZKeP4wM1esp0gI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ytk02lg9pqBcSnSVyyNg+h0V4Zk+aQa4
	Ca3yQPv0y5eaK9lGT4YukSWHs5VLgp8Z9M1G0bexKGYLV/UdUKMrlh3S8UhKF+lP
	Z8msNRypaZxXlw82mOGDVq0hiNEUze4yclPP1yo6hL1xzsexslHBEzZqLzfIoS2N
	TrW7SaMVdUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA0F91B8C7;
	Fri, 10 May 2013 14:46:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4713B1B8C6;
	Fri, 10 May 2013 14:46:28 +0000 (UTC)
In-Reply-To: <1368196005-5354-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 10 May 2013 19:56:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 656B4986-B980-11E2-BB1D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223857>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In preparation for a later patch that creates $dotest/autostash in
> git-rebase.sh before anything else happens, don't assume that the
> presence of a $dotest directory implies the existence of the $next and
> $last files.  The check for the files is in a conditional anyway, but
> `cat` is executed on potentially non-existent files.  Suppress this
> error output.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-am.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index c092855..88aa438 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -446,8 +446,8 @@ done
>  # If the dotest directory exists, but we have finished applying all the
>  # patches in them, clear it out.
>  if test -d "$dotest" &&
> -   last=$(cat "$dotest/last") &&
> -   next=$(cat "$dotest/next") &&
> +   last=$(cat "$dotest/last" 2>/dev/null) &&
> +   next=$(cat "$dotest/next" 2>/dev/null) &&
>     test $# != 0 &&
>     test "$next" -gt "$last"
>  then

If you are introducing "dotest exists but next/last may not be
present" as a valid new state, it probably should check the presence
and/or absence of them explicitly, but more importantly, it is a
good idea to move "test $# != 0" higher. Earlier it did not matter
because when $dotest existed, next/last were supposed to be there
and absence of them was an error codepath. Now, missing these files
is not an error but is a perfectly normal state, so checking what
can be checked more cheaply makes sense as a general code hygiene.

As you may already know, I am not taking a patch that is not meant
for 'master' to fix regressions in 1.8.3 at this point in the cycle
after -rc2; please hold onto this and other patches as they won't
stay in my mailbox.

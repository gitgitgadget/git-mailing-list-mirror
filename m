From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: mention "pull", not "fetch" in the error
 message.
Date: Sun, 28 Mar 2010 10:14:35 -0700
Message-ID: <7vmxxs4bd0.fsf@alter.siamese.dyndns.org>
References: <4BACC241.4010608@drmicha.warpmail.net>
 <1269615836-13995-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Mar 28 19:14:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvw4Y-0001j3-AS
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 19:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab0C1ROo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 13:14:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0C1ROn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 13:14:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDAF1A6C93;
	Sun, 28 Mar 2010 13:14:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kbmrjsm9o32A07JCZSVGN4nlxoM=; b=n/BNX5
	PLyyDbeuKGxOGdA8rECVd7aQkbdSQ1c1ExARgK0dEylw7UEwCyEVMlCq5bMnRhfM
	TmlUn66sG/U5BZNCQwjmHpLniFbZYjFCOdsuRwnM/8UNT1Rtz/ZU56fyHY9YY8TS
	zFbt4Eij2ZGaA0zwlg6PTsr1v+J5UJguu8qR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T9jWBt3U63AhEQ3jLNcaja4EAorn0PIM
	qTGA7GmfAegAbd3oLXzGmadj3IPQ6OVZBNM/UKf59Gaq+jRY09jVvJ8rn36f3/tS
	Zu2MBwc1EDvjDlCvohFPG+AlJJ9QZAYM/FEWuqm1ncqmhyLcSmNJHV1sGqn0QY3i
	PvGY89sCmK4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9F5DA6C91;
	Sun, 28 Mar 2010 13:14:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33379A6C90; Sun, 28 Mar
 2010 13:14:37 -0400 (EDT)
In-Reply-To: <1269615836-13995-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 26 Mar 2010 16\:03\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64A8AE96-3A8D-11DF-BB78-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143404>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> For newbies who've just been taught "git pull", the error message
> "Where do you want to fetch from today?" is indeed confusing. Change it
> to "Where do you want to pull from today?" in case fetch was called from
> pull.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Just fixed a typo in commit message since v1.
>
>  builtin/fetch.c |    6 +++++-
>  git-pull.sh     |    3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 957be9f..f3246f5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -842,8 +842,12 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
>  	int ref_nr = 0;
>  	int exit_code;
>  
> +	char *cmd = getenv("GIT_USER_COMMAND");
> +	if (cmd == NULL || cmd[0] == '\0')
> +		cmd = "fetch";
> +
>  	if (!remote)
> -		die("Where do you want to fetch from today?");
> +		die("Where do you want to %s from today?", cmd);

>  	transport = transport_get(remote, NULL);
>  	transport_set_verbosity(transport, verbosity, progress);
> diff --git a/git-pull.sh b/git-pull.sh
> index 1a4729f..abc233b 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -216,7 +216,8 @@ test true = "$rebase" && {
>  	done
>  }
>  orig_head=$(git rev-parse -q --verify HEAD)
> -git fetch $verbosity $progress --update-head-ok "$@" || exit 1
> +GIT_USER_COMMAND=pull \
> +    git fetch $verbosity $progress --update-head-ok "$@" || exit 1

I personally don't think this is a good change.  When somebody writes a
wrapper around "git pull" to "make it easier", the name of the command
that is given in the message will still be "pull", and you will have 
exactly the same issue again.

It was never the intent of the use of word "fetch" in the original message
to give the name of one among many commands (i.e. the message was not
about "fetch vs pull").  The word was to convey more abstract concept of
getting new changes that are available on the other end.

An alternative that does not introduce layering violation of making the
lower level porcelain aware of what the caller is doing might be to make
it even more bland, "Where do you want to get changes from today?", or
something.

Or we could even make it even more explicit by saying "Where do you want
to go today?", which was what the original meant to mock ;-).

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: fix funny-sounding error message
Date: Sun, 03 May 2015 16:54:25 -0700
Message-ID: <xmqq8ud5usi6.fsf@gitster.dls.corp.google.com>
References: <1430536360-21901-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 01:54:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp3iV-0003D1-Mp
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 01:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbbECXya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 19:54:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969AbbECXy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 19:54:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 978644EDBC;
	Sun,  3 May 2015 19:54:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FIUOUUG11KQszuGmpi2iKcYOr3M=; b=WElgov
	UnNCOirrF73+ziFYANjQeIrUl59FD+cXYVwwrW7Naytt05CPee+v3rum6k1Q1Ky1
	btDNjbA1g9q453jmGE/5pvwRqf2JIR9xcDGjT7FtBD/8uQSFOuNybPfN7UhBW35F
	406LUJHbW84E8rMNoEnryr+ZiHZjnqD/RMwxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pIwff8MQYFbSLo99sNJp7lytIMCoMUXn
	d9NlsxzTTqRzuJjy0Z/1LUmoAPrCLWt4xdwUz8truOa8m3w+yDYnQR3LruU6Ce6z
	iE7ieahvJKPmkV31UeIu0mucRX/ap/cOo2/QvhNcdKa/3szqSflnM1QkDhMDSADn
	0nRX7Alf/8A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 911A94EDBB;
	Sun,  3 May 2015 19:54:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 059904EDBA;
	Sun,  3 May 2015 19:54:26 -0400 (EDT)
In-Reply-To: <1430536360-21901-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Fri, 1 May 2015 21:12:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB55A982-F1EF-11E4-9DA5-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268299>

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1d15037..c0b4bae 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -972,7 +972,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  
>  		if (!branch) {
>  			if (!argc || !strcmp(argv[0], "HEAD"))
> -				die(_("could not set upstream of HEAD to %s when "
> +				die(_("could not set upstream of HEAD to %s because "
>  				      "it does not point to any branch."),
>  				    new_upstream);
>  			die(_("no such branch '%s'"), argv[0]);

Thanks.

To me neither sounds so funny, but both sound somewhat awkward,
primarily because it is unclear in the first reading what "it" in
"it does not point at any branch" refers to.

Perhaps if you explain in the log message to illustrate why you
found it funny (and the update text is not), it might help, e.g.

    "git branch", ran with <this and that options>, when the current
    branch is <in what state>, dies with

    	fatal: could not set upstream of HEAD to frotz when it does not
    	point to any branch.

    which is funny <because of such and such reasons>.  Saying "because"
    makes it <better beause of such and such reasons>.

I suspect that this message is about a nonsense attempt to set an
upstream for a detached HEAD perhaps?  Then

    fatal: cannot set upstream for a detached HEAD

may be shorter and more directly points at the root cause of the
error?

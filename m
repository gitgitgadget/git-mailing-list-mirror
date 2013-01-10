From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit-tree(1): correct description of defaults
Date: Thu, 10 Jan 2013 10:33:59 -0800
Message-ID: <7vr4ls28h4.fsf@alter.siamese.dyndns.org>
References: <1357820998.10754.6.camel@vanquo.pezone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Eisentraut <peter@eisentraut.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 19:34:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtMxS-0005UQ-UK
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 19:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab3AJSeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 13:34:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744Ab3AJSeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 13:34:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAC01B2D3;
	Thu, 10 Jan 2013 13:34:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5gkfA9/XQ2EHp7J0WM2jGMttDSE=; b=Sttxup
	pTjLCvPMsW6S4Appsq3dEK46RFl/qn7YNcmbEF6/aWDMkiiY/OxGfc2Eifb+ZgkA
	w7ljLrUFHThWtASzxp6OS97zpJO3w9E128KRhEPOF4tf/T4bcgY9/YcHT0LhjCgK
	uuF0f+ObJxhHp/Ro/8ePoCS2y7vk9pWlgM1xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q2R5O9kLfNSvL+m+UMkI7QjZ89COmg+W
	Y0r5Z6l5YYlGZHMBhXWsWiXDRG2aaGqTsAiDT8/sNf0bx1w3BXK5AQt6RLufS3yz
	n9Xyc81RrgwIeilDFvZ18V2ydpSNplvB2MRcUx/1OBvSH4Qw1Y+XPjwiXFEOwqjC
	iGFJzagl+oU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D49A0B2CD;
	Thu, 10 Jan 2013 13:34:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3EDFB2C0; Thu, 10 Jan 2013
 13:34:02 -0500 (EST)
In-Reply-To: <1357820998.10754.6.camel@vanquo.pezone.net> (Peter Eisentraut's
 message of "Thu, 10 Jan 2013 07:29:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50F8A4CE-5B54-11E2-9DEA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213147>

Peter Eisentraut <peter@eisentraut.org> writes:

> The old phrasing indicated that the EMAIL environment variable takes
> precedence over the user.email configuration setting, but it is the
> other way around.
>
> Signed-off-by: Peter Eisentraut <peter@eisentraut.org>
> ---

It could be argued that the observed behaviour is a bug, by the way.

If we followed the normal "command line options trump environment
variables that in turn trump config variables that in turn trump
whatever the default values we compute using cues from the system"
precedence order, EMAIL ought to come between the more specific
GIT_{AUTHOR,COMMITTER}_EMAIL environment variables and the
user.email configuration variable.

But reading the value of EMAIL can also be seen as part of the
"using cues from the system" (it often is set in equivalents of
"$HOME/.profile" by equivalents of "adduser") step, and the original
motivation to add user.email indeed was to allow users to override
EMAIL (or the name we grab from the system) without having to set
the GIT_COMMITTER_EMAIL environment variable.

So the current behaviour is correct, and the patch is a good
(belated ;-) update to the documentation.

Will apply.  Thanks.

>  Documentation/git-commit-tree.txt |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
> index 6d5a04c..a221169 100644
> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -72,13 +72,13 @@ if set:
>  	GIT_COMMITTER_NAME
>  	GIT_COMMITTER_EMAIL
>  	GIT_COMMITTER_DATE
> -	EMAIL
>  
>  (nb "<", ">" and "\n"s are stripped)
>  
>  In case (some of) these environment variables are not set, the information
>  is taken from the configuration items user.name and user.email, or, if not
> -present, system user name and the hostname used for outgoing mail (taken
> +present, the environment variable EMAIL, or, if that is not set,
> +system user name and the hostname used for outgoing mail (taken
>  from `/etc/mailname` and falling back to the fully qualified hostname when
>  that file does not exist).

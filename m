From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V4 2/2] object name: introduce '^{/!-<negative pattern>}' notation
Date: Wed, 13 Jan 2016 11:15:05 -0800
Message-ID: <xmqqh9ihnveu.fsf@gitster.mtv.corp.google.com>
References: <ED12DDDA0C004D23BDDB14973C675800@PhilipOakley>
	<1452660741-5616-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Will Palmer <wmpalmer@gmail.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:15:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQt2-0006W1-QU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 20:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbcAMTPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 14:15:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752809AbcAMTPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 14:15:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BD473A5EA;
	Wed, 13 Jan 2016 14:15:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IufiBVNTOwQSaAmxNK0GoBXxv4c=; b=wKhE/+
	0oSD8KPeuetMvjOzCtoRxkKCN4l7Gk0QyElR3jXrtRWdNbr7f7UbLl6mN6PLlcXD
	IK9yLVKiQhmDta+J8FNEZ+4RP1DxcpKoacHpvAsh9xx/suIW/ep8cAsx1ZXWdSNe
	AcSmz7x5FL6FCvmnNNsLu7l1gcT31sORHdegs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkuGpIAXYV72tgcVFwXvYimQicmGW5dr
	viYeL/CwljcfcxRaI8s+vb7bzfslMoS/LDQdO6TSFzHsud0MBJE+0JzJ0f6+9b0h
	7WywoLtX47vHorL5UXSf3TjWSGFWO4ZIVfjm23O0NOEEB1Ar2XlIdlv0mWjAMzQ5
	QlEDa8I8EyM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22AD53A5E9;
	Wed, 13 Jan 2016 14:15:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7DE6C3A5E8;
	Wed, 13 Jan 2016 14:15:06 -0500 (EST)
In-Reply-To: <1452660741-5616-1-git-send-email-ischis2@cox.net> (Stephen
	P. Smith's message of "Tue, 12 Jan 2016 21:52:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F4A0E94C-BA29-11E5-A11B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283971>

"Stephen P. Smith" <ischis2@cox.net> writes:

> From: Will Palmer <wmpalmer@gmail.com>
>
> To name a commit, you can now use the :/!-<negative pattern> regex
> style, and consequentially, say
>
>     $ git rev-parse HEAD^{/!-foo}
>
> and it will return the hash of the first commit reachable from HEAD,
> whose commit message does not contain "foo". This is the opposite of the
> existing <rev>^{/<pattern>} syntax.
>
> The specific use-case this is intended for is to perform an operation,
> excluding the most-recent commits containing a particular marker. For
> example, if you tend to make "work in progress" commits, with messages
> beginning with "WIP", you work, then it could be useful to diff against
> "the most recent commit which was not a WIP commit". That sort of thing
> now possible, via commands such as:
>
>     $ git diff @^{/!-^WIP}
>
> The leader '/!-', rather than simply '/!', to denote a negative match,
> is chosen to leave room for additional modifiers in the future.
>
> Signed-off-by: Will Palmer <wmpalmer@gmail.com>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
>
> Notes:
>     Changed |say|use the :/!-<negative pattern> regex style, and consequentially, say|.
>     
>     Chose not to chagne subject since it matches the end of
>     git rev-parse HEAD^{/!-foo}
>
>     Mailing list web interface is again not working; therefore, I don't 
>     have URLs for the earlier review comments.

Thanks, this looks good (and it looked good already at the previous
round).

> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index d85e303..0c84d4f 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -176,11 +176,12 @@ existing tag object.
>    A colon, followed by a slash, followed by a text, names
>    a commit whose commit message matches the specified regular expression.
>    This name returns the youngest matching commit which is
> -  reachable from any ref.  If the commit message starts with a
> -  '!' you have to repeat that;  the special sequence ':/!',
> -  followed by something else than '!', is reserved for now.
> -  The regular expression can match any part of the commit message. To
> -  match messages starting with a string, one can use e.g. ':/^foo'.
> +  reachable from any ref. The regular expression can match any part of the
> +  commit message. To match messages starting with a string, one can use
> +  e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
> +  is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
> +  literal '!' character, followed by 'foo'. Any other sequence beginning with
> +  ':/!' is reserved for now.

The original text reads as if ":/foo" looks for 'foo' anywhere in
the log message while ":/!!foo" looks for '!foo' at the beginning,
which was incorrect as far as I can tell, but the updated text
corrects it.  Good.

> @@ -903,7 +913,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
>  			continue;
>  		buf = get_commit_buffer(commit, NULL);
>  		p = strstr(buf, "\n\n");
> -		matches = p && !regexec(&regex, p + 2, 0, NULL, 0);
> +		matches = p && (negative ^ !regexec(&regex, p + 2, 0, NULL, 0));
>  		unuse_commit_buffer(commit, buf);

Hmph, without "negative pattern match", if you asked for ":/foo" and
the commit did not have any body (which I do not think the current
version of Git allows to create by default, but there may be such
commits created by older versions of Git or reimplementation of Git
made by others), p could be NULL.  In such a case, any regex would
not match, so I would expect that commit to be shown.

In other words, I wonder if the above should be

		matches = negative ^ (p && !regexec(&regex, p + 2, 0, NULL, 0));

This would not make practical difference, but I would expect any
change to introduce "negative patch" to an original logic that is

	matches = ORIGINAL_LOGIC_TO_COMPUTE_MATCH

to become

	matches = negative ^ ORIGINAL_LOGIC_TO_COMPUTE_MATCH

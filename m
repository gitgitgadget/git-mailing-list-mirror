From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hooks--pre-commit.sample: check for chars, that are not allowed for a windows file name
Date: Wed, 15 Jun 2016 10:54:06 -0700
Message-ID: <xmqqlh2672yp.fsf@gitster.mtv.corp.google.com>
References: <0102015553154cde-5c798c87-87c1-4acf-919a-c824dce01fae-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: dexteritas <dexteritas1@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 15 19:54:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDF16-0002HX-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 19:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbcFORyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 13:54:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932084AbcFORyK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 13:54:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D660723E32;
	Wed, 15 Jun 2016 13:54:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n+G5hA5vU1XqknThrjTinX4KjNM=; b=LIGLKS
	OP+/aJfY+2NNsY13fNw1I+4FQPbpIaHVjSR2/dxad98nEoGjf/YCVNRXazGZ9erZ
	cYxj8aVuz7hrnqzPsTqQeIE+zQxAHRUoxq51bU3jbC9yBnGj8xI0go+qGC03gaUl
	C+Df+rBifZQABxmtmCsUfCNbpPoLTxQaf9oMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ScY42dpS2S2N5wgX7sf1FtCIoqYxP5n5
	l9Zu3caVEw4ouDlD6UwE2n1nRgiA/MQDVHgHQ9ITyKVb2Uk0GES/410Lg9LvZzF8
	+MqEHjfOXrG1/+RqZRWk3o1sA5Gsc/bPFNaoOMEDSIWx7OwsYOBC568leGElEYEF
	Zu+qXa3qhJ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CEC5223E31;
	Wed, 15 Jun 2016 13:54:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57E0B23E30;
	Wed, 15 Jun 2016 13:54:08 -0400 (EDT)
In-Reply-To: <0102015553154cde-5c798c87-87c1-4acf-919a-c824dce01fae-000000@eu-west-1.amazonses.com>
	(dexteritas's message of "Wed, 15 Jun 2016 08:02:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 288E36BC-3322-11E6-A81A-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297381>

dexteritas <dexteritas1@gmx.de> writes:

> After the ASCII-check, test the windows compatibility of file names.
> Can be disabled by:
> git config hooks.allownonwindowschars true
> ---

Missing sign off.

>  templates/hooks--pre-commit.sample | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
> index 68d62d5..120daf1 100755
> --- a/templates/hooks--pre-commit.sample
> +++ b/templates/hooks--pre-commit.sample
> @@ -17,6 +17,7 @@ fi
>  
>  # If you want to allow non-ASCII filenames set this variable to true.
>  allownonascii=$(git config --bool hooks.allownonascii)
> +allownonwindowschars=$(git config --bool hooks.allownonwindowschars)
>  
>  # Redirect output to stderr.
>  exec 1>&2
> @@ -43,6 +44,27 @@ If you know what you are doing you can disable this check using:
>    git config hooks.allownonascii true
>  EOF
>  	exit 1
> +elif [ "$allownonwindowschars" != "true" ] &&

This line is doubly irritating because (1) the double negation is
somewhat hard to grok, and (2) [] is not part of our CodingStyle.

Because you inherited this from the existing "allow-non-ascii" one,
however, I do not want to see you change this line, if you need to
reroll.

> +	# If you work with linux and windows, there is a problem, if you use
> +	# chars like \ / : * ? " < > |

There is no reason to single out Linux, is there?

This new check is only about Windows and because people on other
platforms, not limited to Linux, may not be aware of some characters
that are not usable on Windows, you are trying to help them, no?

> +	# Check if there are used only windows compatible chars
> +	test $(git diff --cached --name-only --diff-filter=A -z $against |
> +	  LC_ALL=C tr -d '[0-9A-Za-z\[\]\{\}_ -)+-.]\0' | wc -c) != 0

Because this is in "elif", we know we are allowing non-ascii
characters when we come here.  So you need to do a quite similar
check from scratch, which is sensible.  I do not offhand know if
this covers all the characters that Windows users cannot use,
though.

> +then
> +	cat <<\EOF
> +Error: Attempt to add a chars that are not allowed for a windows file name.
> +
> +This can cause problems if you want to work with people on other platforms.
> +
> +To be portable it is advisable to rename the file.
> +
> +Check your filenames for: \ / : * ? " < > |
> +
> +If you know what you are doing you can disable this check using:
> +
> +  git config hooks.allownonwindowschars true
> +EOF
> +	exit 2

Why 2?

>  fi
>  
>  # If there are whitespace errors, print the offending file names and fail.

When the user says

	[hooks]
            allownonascii = false
	    allownonwindowschars = false

what happens?

The user's intention clearly is that the project wants to be usable
on Windows and also wants to exclude characters from codepages that
are not ASCII.  I however suspect that the hook with your patch will
allow people to create a "path>like?this.txt" happily.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] i18n: Only extract comments marked by special tag
Date: Thu, 17 Apr 2014 11:08:18 -0700
Message-ID: <xmqqk3anesml.fsf@gitster.dls.corp.google.com>
References: <cover.1397712142.git.worldhello.net@gmail.com>
	<2ce9ec406501d112e032c8208417f8100bed04c6.1397712142.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 20:08:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Waqjd-0001F2-P0
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 20:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbaDQSI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 14:08:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbaDQSIX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 14:08:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61D1A7A8F9;
	Thu, 17 Apr 2014 14:08:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tE8rkxiCygX3jrDOVGaTYjyM1mI=; b=T/OGr5
	8UAAUAuExUTsWqGDUh2kCbhCDV5XrIx9NjkbxaCkc9rg1MWYdJnvLoW7L1MR0xSV
	oKuDaoTY2isomzQcUweU92asWoaPGkklEmRpPyICAWSE/2oq276vHbfEo+a6Qz4d
	iXW5gRjQTHMXJGoNMLyUCZ0q88lt9wpN9vaR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iMqrm6xBkT2Q71OlYR1vb5LSRMZHt0Nr
	NHaQ490nEpYus4/BX1ZuRev+QKHHOVprt8woURtYmoEFq623DTMzljOe3DLnrjec
	4XbPYbWZ4zjVXDDMFKG6dkQnnH/+7pSZ2qqplbxqkxVk+qKH3t51NZuDb31hkCDW
	CdLl6+uLhoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4774C7A8F7;
	Thu, 17 Apr 2014 14:08:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A85D7A8F6;
	Thu, 17 Apr 2014 14:08:20 -0400 (EDT)
In-Reply-To: <2ce9ec406501d112e032c8208417f8100bed04c6.1397712142.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Thu, 17 Apr 2014 13:37:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 422EF3EE-C65B-11E3-99E0-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246431>

Jiang Xin <worldhello.net@gmail.com> writes:

> When extract l10n messages, we use "--add-comments" option to keep
> comments right above the l10n messages for references.  But sometimes
> irrelevant comments are also extracted.  For example in the following
> code block, the comment in line 2 will be extracted as comment for the
> l10n message in line 3, but obviously it's wrong.
>
>         { OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
>           NULL /* takes no arguments */,
>           N_("ignore paths removed in the working tree (same as
>           --no-all)"),
>           PARSE_OPT_NOARG, ignore_removal_cb },
>
> Since almost all comments for l10n translators are marked with the same
> prefix (tag): "TRANSLATORS:", it's safe to only extract comments with
> this special tag.  I.E. it's better to call xgettext as:
>
>         xgettext --add-comments=TRANSLATORS: ...
>
> Also tweaks the multi-line comment in "init-db.c", to make it start with
> the proper tag, not "* TRANSLATORS:" (which has a star before the tag).

Hmph.

I am not very happy with this change, as it would force us to
special case "Translators" comment to follow a non-standard
multi-line comment formatting convention.  Is there a way to tell
xgettext to accept both of these forms?

        /* TRANSLATORS: this is a short comment to help you */
        _("foo bar");

        /*
         * TRANSLATORS: this comment is to help you, but it is
         * a lot longer to fit on just a single line.
         */
        _("bar baz");


>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  Makefile          | 2 +-
>  builtin/init-db.c | 8 +++-----
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 2128ce3..a53f3a8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2102,7 +2102,7 @@ pdf:
>  
>  XGETTEXT_FLAGS = \
>  	--force-po \
> -	--add-comments \
> +	--add-comments=TRANSLATORS: \
>  	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
>  	--from-code=UTF-8
>  XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index c7c76bb..56f85e2 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -412,11 +412,9 @@ int init_db(const char *template_dir, unsigned int flags)
>  	if (!(flags & INIT_DB_QUIET)) {
>  		int len = strlen(git_dir);
>  
> -		/*
> -		 * TRANSLATORS: The first '%s' is either "Reinitialized
> -		 * existing" or "Initialized empty", the second " shared" or
> -		 * "", and the last '%s%s' is the verbatim directory name.
> -		 */
> +		/* TRANSLATORS: The first '%s' is either "Reinitialized
> +		   existing" or "Initialized empty", the second " shared" or
> +		   "", and the last '%s%s' is the verbatim directory name. */
>  		printf(_("%s%s Git repository in %s%s\n"),
>  		       reinit ? _("Reinitialized existing") : _("Initialized empty"),
>  		       shared_repository ? _(" shared") : "",

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-add: -s flag added (silently ignore files)
Date: Mon, 01 Oct 2012 10:59:24 -0700
Message-ID: <7vipaucbur.fsf@alter.siamese.dyndns.org>
References: <1349075700-26334-1-git-send-email-olaf.klischat@gmail.com>
 <1349075700-26334-2-git-send-email-olaf.klischat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, olaf@sofd.de
To: Olaf Klischat <olaf.klischat@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 20:00:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIkHK-0005Zf-P1
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab2JAR72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:59:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192Ab2JAR71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 13:59:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 911C69907;
	Mon,  1 Oct 2012 13:59:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=occXRowlX1OpYMqtB1xk+fUyQk0=; b=dwLJLq
	PWjeH720xPGfJqJsb5nUfX7l96z8yXduOhiCnY+VeWFMbMrDLGLtOUpgQ61coV/7
	6gKhlPJ9k7V/YRnvwS7lAydlMJFDHyjcSHSL2E+UIkaHBFmVdAsS77QTaZCg4dk0
	diZCraeW4V1QVJ9EY25gIMemvfn8mGbYAqWvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sfd0IrQCtq7WbgDcyRyvEC9+80LosX9V
	L78S2vFXx0zDiaFXPNTtcIpcwpNWQexX7q4ZFtjx9qeODko/YzYWe+I6lT9x+Asq
	QLZoZ9E4pJDlZvRvlRDGQNzZPOnn55EBLhys+s548hpVK3jgFn97GHkM70Oss7eW
	0Sw4v2OPctg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EE879906;
	Mon,  1 Oct 2012 13:59:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB3579905; Mon,  1 Oct 2012
 13:59:25 -0400 (EDT)
In-Reply-To: <1349075700-26334-2-git-send-email-olaf.klischat@gmail.com>
 (Olaf Klischat's message of "Mon, 1 Oct 2012 09:14:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCEAAAFE-0BF1-11E2-B477-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206751>

Olaf Klischat <olaf.klischat@gmail.com> writes:

> Signed-off-by: Olaf Klischat <olaf.klischat@gmail.com>
> ---

I am personally not sympathetic to the reasoning stated in the
proposed commit log message above your signed-off-by line; the
change is not justified at all.

But I'll comment on the code changes anyway.

>  builtin/add.c  |   14 +++++++++++---
>  t/t3700-add.sh |   17 ++++++++++++++++-
>  2 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index e664100..61bb9ce 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -313,7 +313,7 @@ static const char ignore_error[] =
>  N_("The following paths are ignored by one of your .gitignore files:\n");
>  
>  static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
> -static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
> +static int ignore_add_errors, addremove, intent_to_add, ignore_missing, silent_ignores = 0;
>  
>  static struct option builtin_add_options[] = {
>  	OPT__DRY_RUN(&show_only, N_("dry run")),
> @@ -329,6 +329,7 @@ static struct option builtin_add_options[] = {
>  	OPT_BOOLEAN( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
>  	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>  	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
> +	OPT_BOOLEAN('s', "silent-ignores", &silent_ignores, N_("don't fail when ignored files are specified on the command line (ignore them silently)")),

I'd prefer not to see a new option whose worth hasn't been proven in
the field to squat on any short-and-sweet single letter option
name and would suggest replacing that 's' with 0, at least for now.

> @@ -339,6 +340,11 @@ static int add_config(const char *var, const char *value, void *cb)
>  		ignore_add_errors = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "add.silentignores") ||
> +	    !strcmp(var, "add.silent-ignores")) {

The second variant is unwarranted.  We may have a variable or two
that are accepted with '-' or '_' in their names, but they are
backward compatibility measures, only to cover previous mistakes
that named them in these letters in the first place.

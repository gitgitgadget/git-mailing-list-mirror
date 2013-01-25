From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add: warn when -u or -A is used without filepattern
Date: Fri, 25 Jan 2013 11:27:31 -0800
Message-ID: <7v8v7h3vx8.fsf@alter.siamese.dyndns.org>
References: <vpq1uddoedj.fsf@grenoble-inp.fr>
 <1359110978-20054-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:28:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyowQ-0005Mx-1M
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 20:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264Ab3AYT1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 14:27:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756561Ab3AYT1g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 14:27:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36C1CBB7B;
	Fri, 25 Jan 2013 14:27:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ClY6+n36icjF/0vz4UsnuZ4hzXc=; b=e5JICY
	8S19Q1yOIz2EsoiQSs4BHYPojnvyn95qJci5fVHbS3pSlEzxJUxDxd8VTmSaEcwT
	78XcwmWzBNPw+iB5MxNytC7qOf4R5f0eon5Gp3XPFv2TPJb6inGjkn/zCOSZfjU1
	W/kf8Po1KU42MDXN6SWo88iQw+s2HnzN4llvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ddGKINyPtE5PxJOl/pRDvDiBfYfAzALz
	Naex8kawrpIOY8MjoULX8bwxpicGWGF6+bq+J3JMY5CFhATVvrcpSBIojs0bAvsF
	3sOlo2ahd8YqUSKa0mmRvpS9ySgqMv+Rhn9ee9pFoIlsI+AooRzCW9LG3AFwOSQf
	zEPHGxw+LTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 224E7BB77;
	Fri, 25 Jan 2013 14:27:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73F37BB64; Fri, 25 Jan 2013
 14:27:33 -0500 (EST)
In-Reply-To: <1359110978-20054-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri, 25 Jan 2013 11:49:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45130334-6725-11E2-BDD0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214571>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Most git commands that can be used with our without a filepattern are
> tree-wide by default, the filepattern being used to restrict their scope.
> A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git add -A'.
>
> The inconsistancy of 'git add -u' and 'git add -A' are particularly

s/consistan/consisten/;

> diff --git a/builtin/add.c b/builtin/add.c
> index e664100..8252d19 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -363,6 +363,33 @@ static int add_files(struct dir_struct *dir, int flags)
>  	return exit_status;
>  }
>  
> +static void warn_pathless_add(const char *option_name) {
> +	/*
> +	 * To be consistant with "git add -p" and most Git

Likewise.

> +	warning(_("The behavior of 'git add %s' with no path argument from a subdirectory of the\n"
> ...
> +		option_name,
> +		option_name,
> +		option_name);
> +}
> +
>  int cmd_add(int argc, const char **argv, const char *prefix)
>  {
>  	int exit_status = 0;
> @@ -392,8 +420,14 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		die(_("-A and -u are mutually incompatible"));
>  	if (!show_only && ignore_missing)
>  		die(_("Option --ignore-missing can only be used together with --dry-run"));
> -	if ((addremove || take_worktree_changes) && !argc) {
> +	if (addremove)
> +		option_with_implicit_dot = "--all";
> +	if (take_worktree_changes)
> +		option_with_implicit_dot = "--update";

I wonder if we want to say in the message

	The behaviour of 'git add --all (or -A)'...

otherwise people who typed "git add -A" and got this message with
just "--all" may go "Huh?" for a brief moment.  I however do not
think replacing these strings to

	option_with_implicit_dot = "--all (-A)";

is a solution, given they are goven to _("l10n template %s").

Other than that the patch looks reasonable.

Thanks.

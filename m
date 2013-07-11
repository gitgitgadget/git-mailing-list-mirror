From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 12:04:42 -0700
Message-ID: <7vli5crk8l.fsf@alter.siamese.dyndns.org>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 21:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxMAe-0004oq-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 21:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab3GKTEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 15:04:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756578Ab3GKTEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 15:04:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B4272F1B2;
	Thu, 11 Jul 2013 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qs7sTQbN+IUbygIaLUsHrLWdPyU=; b=cG886f
	aA/YGS1TX+qfVXE/fzXrF3jZUhq0uAJsLy1gBo7nRsR6dFhuWVBlFB0ijAW1ZoDy
	WpQOb/eofqP99gHu+rV5uK8LDCKTDl6PXLObyNei9cwH3Z+Pu6rVj60nitovHrx1
	7bce2IBVNG03r0YSSsrIEpc/6wcT/zISDcTC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wH1YQEfStWJHe896W9HPhyBLfmZCbBKi
	SODj9eoml+8N0GjEVEDK1qdRU2HhZvwKei3ur2hI4hYN+kpBAX1XpPBJdfsBQEmQ
	/EaDKqLs8pmH/VHMFInnJposOj92eTHe70XtxwmG8rNFQ0GH3LfQ2KUkVxVWQOsq
	eGG4a1SvAdE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FEC62F1B1;
	Thu, 11 Jul 2013 19:04:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 648372F1A8;
	Thu, 11 Jul 2013 19:04:44 +0000 (UTC)
In-Reply-To: <1373554528-15775-2-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Thu, 11 Jul 2013 10:55:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF70339E-EA5C-11E2-8003-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230125>

Eric Sunshine <sunshine@sunshineco.com> writes:

> +DESCRIPTION
> +-----------
> +
> +For each ``Name $$<email@address>$$'' or ``$$<email@address>$$'' provided on
> +the command-line or standard input (when using `--stdin`), prints a line with
> +the canonical contact information for that person according to the 'mailmap'
> +(see "Mapping Authors" below). If no mapping exists for the person, echoes the
> +provided contact information.

OK.  The last part needed a reading and a half for me to realize the
"echoes the provided contact information" is the same thing as "the
"input string is printed as-is", especially because "contact
information" is not defined anywhere in the previous part of the
DESCRIPTION section, though.  I might be worth starting the
paragraph with:

	For each contact information (either in the form of ``Name
	<user@host>'' or ...)

in order to clarify that the two forms of input is what you call
"contact information".

> diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
> new file mode 100644
> index 0000000..c36a61c
> --- /dev/null
> +++ b/builtin/check-mailmap.c
> @@ -0,0 +1,69 @@
> +#include "builtin.h"
> +#include "mailmap.h"
> +#include "parse-options.h"
> +#include "string-list.h"
> +
> +static int use_stdin;
> +static int null_out;

Is there a reason why the variable name should not match that of the
corresponding variables in check-ignore and check-attr, which you
copied the bulk of the code from?

If there isn't, use "null_term_line" like they do.

> +static const char * const check_mailmap_usage[] = {
> +N_("git check-mailmap [options] <contact>..."),
> +NULL
> +};

This mis-indentation looks somewhat unfortunate, but they are shared
with other check-blah, and they are meant to contain a rather long
string, so let's keep it like so.

> +static void check_mailmap(struct string_list *mailmap, const char *contact)
> +{
> +	const char *name, *mail;
> +	size_t namelen, maillen;
> +	struct ident_split ident;
> +	char term = null_out ? '\0' : '\n';

Is there a reason why the variable name "term" should not match that
of the corresponding variables in check-ignore and check-attr, which
you copied the bulk of the code from?

If there isn't, use "line_termination" like they do.

> +	if (split_ident_line(&ident, contact, strlen(contact)))
> +		die(_("unable to parse contact: %s"), contact);
> +
> +	name = ident.name_begin;
> +	namelen = ident.name_end - ident.name_begin;
> +	mail = ident.mail_begin;
> +	maillen = ident.mail_end - ident.mail_begin;
> +
> +	map_user(mailmap, &mail, &maillen, &name, &namelen);
> +
> +	if (namelen)
> +		printf("%.*s ", (int)namelen, name);
> +	printf("<%.*s>%c", (int)maillen, mail, term);
> +}
> +
> +int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	struct string_list mailmap = STRING_LIST_INIT_NODUP;
> +
> +	git_config(git_default_config, NULL);
> +	argc = parse_options(argc, argv, prefix, check_mailmap_options,
> +		check_mailmap_usage, 0);

It is a bit distracting that the second line that is not indented
enough.  Either (1) with enough HT and with minimum number of SP,
align "argc" and "check_mailmap_usage", or (2) with minimum number
of HT and no SP, push "check_mailmap_usage" to the right of opening
parenthesis of "(argc".  Our code tend to prefer (1).

> +	if (argc == 0 && !use_stdin)
> +		die(_("no contacts specified"));
> +
> +	read_mailmap(&mailmap, NULL);
> +
> +	for (i = 0; i < argc; ++i)
> +		check_mailmap(&mailmap, argv[i]);
> +	maybe_flush_or_die(stdout, "stdout");
> +
> +	if (use_stdin) {
> +		struct strbuf buf = STRBUF_INIT;
> +		while (strbuf_getline(&buf, stdin, '\n') != EOF) {
> +			check_mailmap(&mailmap, buf.buf);
> +			maybe_flush_or_die(stdout, "stdout");
> +		}
> +		strbuf_release(&buf);
> +	}
> +
> +	clear_mailmap(&mailmap);
> +	return 0;
> +}
> diff --git a/command-list.txt b/command-list.txt
> index bf83303..08b04e2 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -13,6 +13,7 @@ git-bundle                              mainporcelain
>  git-cat-file                            plumbinginterrogators
>  git-check-attr                          purehelpers
>  git-check-ignore                        purehelpers
> +git-check-mailmap                       purehelpers
>  git-checkout                            mainporcelain common
>  git-checkout-index                      plumbingmanipulators
>  git-check-ref-format                    purehelpers
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ebc40d4..c118550 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -648,6 +648,7 @@ __git_list_porcelain_commands ()
>  		cat-file)         : plumbing;;
>  		check-attr)       : plumbing;;
>  		check-ignore)     : plumbing;;
> +		check-mailmap)    : plumbing;;
>  		check-ref-format) : plumbing;;
>  		checkout-index)   : plumbing;;
>  		commit-tree)      : plumbing;;
> diff --git a/git.c b/git.c
> index 4359086..02c3035 100644
> --- a/git.c
> +++ b/git.c
> @@ -324,6 +324,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "cat-file", cmd_cat_file, RUN_SETUP },
>  		{ "check-attr", cmd_check_attr, RUN_SETUP },
>  		{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
> +		{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },

As we can read from HEAD:.mailmap these days, the patch is correct
that it does not require NEED_WORK_TREE here.

Thanks.

>  		{ "check-ref-format", cmd_check_ref_format },
>  		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
>  		{ "checkout-index", cmd_checkout_index,

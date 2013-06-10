From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2]  rm: better error message on failure for multiple files
Date: Mon, 10 Jun 2013 10:17:47 -0700
Message-ID: <7v8v2hkhqc.fsf@alter.siamese.dyndns.org>
References: <1370879981-18937-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:18:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5jK-0007qt-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab3FJRRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 13:17:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941Ab3FJRRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 13:17:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 475AA27619;
	Mon, 10 Jun 2013 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JUmBSX7ise+1Ox/gmeapuIH3SJ8=; b=gxUKfp
	C29JztpjxoIFm4EcN8Qh1SeyxuDec2pRDLFL1HUlGbkKlV3/M2yHmuh21B0QV0vf
	uRymGf9LGedEqMyOiKyveeW4c+fZi0nlSFqeL9WzXqo/vOlRygCGYJhQPKLobkgV
	gviROjP/fP9K3HOjd3NL1RyUeX2X7dN0p3FCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PCRgAbxYegunb6xn1K+LT33vT4xf8dRW
	lZyGyHRfZuJV7Bq+Ai4o6YaxAi/7IJA2eCa8INyedMb1GwVpDv69tgXE15jEW1Sw
	p0PK65WoGu9iKcLE3MuAGaAmRhBlXLCOOL5GHwYk8/f5u9ZQu0RfWgM+J0xTOYlf
	v+Hm9xB6nPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B16C27618;
	Mon, 10 Jun 2013 17:17:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5662427614;
	Mon, 10 Jun 2013 17:17:49 +0000 (UTC)
In-Reply-To: <1370879981-18937-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	(Mathieu Lienard--Mayor's message of "Mon, 10 Jun 2013 17:59:40
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACF5B71C-D1F1-11E2-87CB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227325>

Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
writes:

> When 'git rm' fails, it now displays a single message
> with the list of files involved, instead of displaying
> a list of messages with one file each.
>
> As an example, the old message:
> 	error: 'foo.txt' has changes staged in the index
> 	(use --cached to keep the file, or -f to force removal)
> 	error: 'bar.txt' has changes staged in the index
> 	(use --cached to keep the file, or -f to force removal)
>
> would now be displayed as:
> 	error: the following files have changes staged in the index:
> 	    foo.txt
> 	    bar.txt
> 	(use --cached to keep the file, or -f to force removal)
>
> Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
>
> Changes since v2:
>  -couple typo in commit message and in code
>  -rename and redefinition of the intermediate function
>  -move the 4 "if(....nr)" inside the function
>
>  builtin/rm.c  |   71 +++++++++++++++++++++++++++++++++++++++++++++-----------
>  t/t3600-rm.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 7b91d52..07306eb 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -70,6 +70,24 @@ static int check_submodules_use_gitfiles(void)
>  	return errs;
>  }
>  
> +static void print_eventual_error_files(struct string_list *files_list,
> +				       const char *main_msg,
> +				       const char *hints_msg,
> +				       int *errs)

Hrm, I do not see the point of "eventual" there, by the way.  Are
there other kinds of error files?

> +{
> +	if (files_list->nr) {
> +		struct strbuf err_msg = STRBUF_INIT;
> +		int i;
> +		strbuf_addstr(&err_msg, main_msg);
> +		for (i = 0; i < files_list->nr; i++)
> +			strbuf_addf(&err_msg,
> +				    "\n    %s",

Is there an implication of having always 4 spaces here to l10n/i18n
here?  I am wondering if it should be _("\n    %s").

> +				    files_list->items[i].string);
> +		strbuf_addstr(&err_msg, hints_msg);
> +		*errs = error("%s", err_msg.buf);

There needs a strbuf_release(&err_msg) somewhere before leaving this
scope to avoid leaking its buffer, no?

> +	}
> +}
> +
>  static int check_local_mod(unsigned char *head, int index_only)
>  {
>  	/*
> @@ -82,6 +100,11 @@ static int check_local_mod(unsigned char *head, int index_only)
>  	int i, no_head;
>  	int errs = 0;
>  
> +	struct string_list files_staged = STRING_LIST_INIT_NODUP;
> +	struct string_list files_cached = STRING_LIST_INIT_NODUP;
> +	struct string_list files_submodule = STRING_LIST_INIT_NODUP;
> +	struct string_list files_local = STRING_LIST_INIT_NODUP;
> +
>  	no_head = is_null_sha1(head);
>  	for (i = 0; i < list.nr; i++) {
>  		struct stat st;
> @@ -171,29 +194,49 @@ static int check_local_mod(unsigned char *head, int index_only)
>  		 */
>  		if (local_changes && staged_changes) {
>  			if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD))
> +				string_list_append(&files_staged, name);
>  		}
>  		else if (!index_only) {
>  			if (staged_changes)
> -				errs = error(_("'%s' has changes staged in the index\n"
> -					     "(use --cached to keep the file, "
> -					     "or -f to force removal)"), name);
> +				string_list_append(&files_cached, name);
>  			if (local_changes) {
>  				if (S_ISGITLINK(ce->ce_mode) &&
>  				    !submodule_uses_gitfile(name)) {
> +					string_list_append(&files_submodule,
> +							   name);
> +				} else {
> +					string_list_append(&files_local, name);
> +				}

The innermost if/else no longer needs braces.  Also even though it
may push it slightly over 80-column, I think the files_submodule
side of string_list_append() is easier to read if it were on a
single line.

> +	print_eventual_error_files(&files_staged,
> +				   _("the following files have staged "
> +				     "content different from both the"
> +				     "\nfile and the HEAD:"),
> +				   _("\n(use -f to force removal)"),
> +				   &errs);

Hmph.  I wonder if we want to properly i18n plurals, depending on
the number of files, e.g.

        print_error_files(&files_staged,
                          Q_("the following file has staged "
                             "content different from both the\n"
                             "file and the HEAD:",
                             "the following files have staged "
                             "content different from both the\n"
                             "file and the HEAD:", files_staged.nr),
                           _("\n(use -f to force removal)"), &errs);

This was not a problem back when we showed one error message per one
path, but with this patch, it starts to matter.

> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 0c44e9f..10dd380 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -687,4 +687,71 @@ test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index)' '
>  	test_path_is_file e/f
>  '
>  
> +test_expect_success 'setup for testing rm messages' '
> +	>bar.txt &&
> +	>foo.txt &&
> +	git add bar.txt foo.txt
> +'
> +
> +test_expect_success 'rm files with different staged content' '
> +	cat >expect << EOF &&
> +error: the following files have staged content different from both the
> +file and the HEAD:
> +    bar.txt
> +    foo.txt
> +(use -f to force removal)
> +EOF
> +	echo content1 >foo.txt &&

It is easier to read if it is done this way:

        test_expect_success 'rm files with different staged content' '
                cat >expect <<\-EOF &&
                error: the following files have staged content different from both the
                file and the HEAD:
                    bar.txt
                    foo.txt
                (use -f to force removal)
                EOF
                echo content1 >foo.txt &&

Two and half points to note:

 (0) no whitespace between redirection << and its source
     (the end-of-here-text marker in this case).

 (1) by quoting the end-of-here-text marker with a backslash '\',
     you tell the readers that there is no variable substitution in
     it, which reduces the mental burden on them.

 (2) by using a dash '-' before the end-of-here-text marker, you can
     align the body of here text with a leading tab (HT).

> +	echo content1 >bar.txt &&
> +	test_must_fail git rm foo.txt bar.txt 2>actual &&
> +	test_cmp expect actual

This should be test_i18ncmp as the error messages are marked for
l10n.

Other than that, looks nicely done.

> +'
> +
> +
> +test_expect_success 'rm file with local modification' '
> +	cat >expect << EOF &&
> +error: the following files have local modifications:
> +    foo.txt
> +(use --cached to keep the file, or -f to force removal)
> +EOF
> +	git commit -m "testing rm 3" &&
> +	echo content3 >foo.txt &&
> +	test_must_fail git rm foo.txt 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +
> +test_expect_success 'rm file with changes in the index' '
> +    cat >expect << EOF &&
> +error: the following files have changes staged in the index:
> +    foo.txt
> +(use --cached to keep the file, or -f to force removal)
> +EOF
> +	git reset --hard &&
> +	echo content5 >foo.txt &&
> +	git add foo.txt &&
> +	test_must_fail git rm foo.txt 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +
> +test_expect_success 'rm files with two different errors' '
> +	cat >expect << EOF &&
> +error: the following files have staged content different from both the
> +file and the HEAD:
> +    foo1.txt
> +(use -f to force removal)
> +error: the following files have changes staged in the index:
> +    bar1.txt
> +(use --cached to keep the file, or -f to force removal)
> +EOF
> +	echo content >foo1.txt &&
> +	git add foo1.txt &&
> +	echo content6 >foo1.txt &&
> +	echo content6 >bar1.txt &&
> +	git add bar1.txt &&
> +	test_must_fail git rm bar1.txt foo1.txt 2>actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] rm: introduce advice.rmHints to shorten messages
Date: Mon, 10 Jun 2013 10:25:26 -0700
Message-ID: <7v4nd5khdl.fsf@alter.siamese.dyndns.org>
References: <1370879981-18937-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<1370879981-18937-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5qg-00052f-NB
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab3FJRZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 13:25:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab3FJRZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 13:25:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F07127ABD;
	Mon, 10 Jun 2013 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oZXCd/iNLs9C89lBlkENLdRmcIQ=; b=NrumFq
	hBUTM8pSnZmYAO7u3dyLogV9m3pcfeKNRUdXg88vIeRJDwDBsMV0W63pGLfp53WL
	DMleXqZfS7W2TcWo/CP1TGq3LJUQlYlNu9pqaQxuKfq5mZMv6zmFT7S2Alvrtw1d
	07dbdQEtog+AtT/ILb6a2tM0DK7kflyLkGQbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YyHFXz/yyPQKze8SFdHUDGu5/4xfUk/A
	jmTNsDM+mE9cIKr869SY5VamfXdLHWGB2tHKD6xJxYr0GuB/bxLR7053o/K9kqXe
	Cd2hUwWLM8kNh9l11Cnt4PIhKFfozUuCSu/fxXcJALYIV8nBG+sEaaQjh8c9jieK
	ytdtz5u39lc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55E0827ABC;
	Mon, 10 Jun 2013 17:25:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9604027ABA;
	Mon, 10 Jun 2013 17:25:27 +0000 (UTC)
In-Reply-To: <1370879981-18937-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	(Mathieu Lienard--Mayor's message of "Mon, 10 Jun 2013 17:59:41
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE1A883C-D1F2-11E2-915E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227329>

Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
writes:

> Introduce advice.rmHints to choose whether to display advice or not
> when git rm fails. Defaults to true, in order to preserve current behavior.
>
> As an example, the message:
> 	error: 'foo.txt' has changes staged in the index
> 	(use --cached to keep the file, or -f to force removal)
>
> would look like, with advice.rmHints=false:
> 	error: 'foo.txt' has changes staged in the index
>
> Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
>  Documentation/config.txt |    3 +++
>  advice.c                 |    2 ++
>  advice.h                 |    1 +
>  builtin/rm.c             |   11 +++++++----
>  t/t3600-rm.sh            |   29 +++++++++++++++++++++++++++++
>  5 files changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6e53fc5..eb04479 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -199,6 +199,9 @@ advice.*::
>  	amWorkDir::
>  		Advice that shows the location of the patch file when
>  		linkgit:git-am[1] fails to apply it.
> +	rmHints::
> +		In case of failure in the output of linkgit:git-rm[1],
> +		show directions on how to proceed from the current state.
>  --
>  
>  core.fileMode::
> diff --git a/advice.c b/advice.c
> index a8deee6..a4c169c 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -14,6 +14,7 @@ int advice_resolve_conflict = 1;
>  int advice_implicit_identity = 1;
>  int advice_detached_head = 1;
>  int advice_set_upstream_failure = 1;
> +int advice_rm_hints = 1;
>  
>  static struct {
>  	const char *name;
> @@ -33,6 +34,7 @@ static struct {
>  	{ "implicitidentity", &advice_implicit_identity },
>  	{ "detachedhead", &advice_detached_head },
>  	{ "setupstreamfailure", &advice_set_upstream_failure },
> +	{ "rmhints", &advice_rm_hints },
>  
>  	/* make this an alias for backward compatibility */
>  	{ "pushnonfastforward", &advice_push_update_rejected }
> diff --git a/advice.h b/advice.h
> index 94caa32..36104c4 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -17,6 +17,7 @@ extern int advice_resolve_conflict;
>  extern int advice_implicit_identity;
>  extern int advice_detached_head;
>  extern int advice_set_upstream_failure;
> +extern int advice_rm_hints;

The handling of a new advice variable (i.e. definition, declaration
and reading from configuration) looks correct in this patch.  Good
job.

>  int git_default_advice_config(const char *var, const char *value);
>  void advise(const char *advice, ...);
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 07306eb..c991fe6 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -62,9 +62,11 @@ static int check_submodules_use_gitfiles(void)
>  
>  		if (!submodule_uses_gitfile(name))
>  			errs = error(_("submodule '%s' (or one of its nested "
> +				       "submodules) uses a .git directory%s"), name,
> +				       advice_rm_hints
> +				       ? "\n(use 'rm -rf' if you really want to remove "
> +				       "it including all of its history)"
> +				       : "");

The advice part is not subject to i18n?

>  	}
>  
>  	return errs;

Interesting.

Is there a reason why this kind of errors are not collected together
into one "error message and then list of paths", like all the other
kinds of errors are done with print_eventual_error_files()?

> @@ -83,7 +85,8 @@ static void print_eventual_error_files(struct string_list *files_list,
>  			strbuf_addf(&err_msg,
>  				    "\n    %s",
>  				    files_list->items[i].string);
> -		strbuf_addstr(&err_msg, hints_msg);
> +		if (advice_rm_hints)
> +			strbuf_addstr(&err_msg, hints_msg);
>  		*errs = error("%s", err_msg.buf);
>  	}
>  }
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 10dd380..74f048c 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -707,6 +707,18 @@ EOF
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'rm files with different staged content without hints' '
> +	cat >expect << EOF &&
> +error: the following files have staged content different from both the
> +file and the HEAD:
> +    bar.txt
> +    foo.txt
> +EOF
> +	echo content2 >foo.txt &&
> +	echo content2 >bar.txt &&
> +	test_must_fail git -c advice.rmhints=false rm foo.txt bar.txt 2>actual &&
> +	test_cmp expect actual
> +'

Same comments as the ones for 1/2 applies to the tests in this patch.

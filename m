From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Tue, 07 Jan 2014 12:36:45 -0800
Message-ID: <xmqq8uurcyw2.fsf@gitster.dls.corp.google.com>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gister@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:36:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dOQ-0003zK-EF
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbaAGUgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:36:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64561 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326AbaAGUgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:36:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8D4D61584;
	Tue,  7 Jan 2014 15:36:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GWSLiDeksIg/nPgHgBkXcgMB5gY=; b=d1k4x0
	FuwZFTtJuD9So43SOtNR2sZpJAa0O61wkzAFErGqULJJIXKxTVQZip49BD7OwpGj
	LgtR6K8UDp7rPjitFt2VRlX/WQh+TCzxXFtIM40OPlGiyuHpldhA39dUMh5AGZsg
	7DHof1BOhtxwMLC61hfFT9/jYQ9sy2zzxAVSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JIoTuJLvl7EmkqdPYp2LGb0Q9Kha8XJ7
	QMotaiy3Rk1DIB7/Uvw588GFQLef6lZDblf8WI0G7PkEzOz7ixbiCV6KTIpPPeI9
	RMao+NAJb7SF4nKYHZFRFALK6GFHyXA6dzhwqbXd7EUSY2XYhDKXOmoxzmjHRCQZ
	Tq1B2Z1hNlE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA1F061583;
	Tue,  7 Jan 2014 15:36:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC5B461582;
	Tue,  7 Jan 2014 15:36:47 -0500 (EST)
In-Reply-To: <1389126588-3663-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 8 Jan 2014 01:59:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E02E5F8-77DB-11E3-A2AF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240147>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> A very common workflow for preparing patches involves working off a
> topic branch and generating patches against 'master' to send off to the
> maintainer. However, a plain
>
>   $ git format-patch -o outgoing
>
> is a no-op on a topic branch, and the user has to remember to specify
> 'master' explicitly everytime. This problem is not unique to
> format-patch; even a
>
>   $ git rebase -i
>
> is a no-op because the branch to rebase against isn't specified.
>
> To tackle this problem, introduce branch.*.forkedFrom which can specify
> the parent branch of a topic branch. Future patches will build
> functionality around this new configuration variable.
>

I do not mind allowing laziness by defaulting to something, but I am
not enthused by an approach that adds the new variable whose value
is questionable.  The description does not justify at all why
@{upstream} is not a good default (unless the workflow is screwed up
and @{upstream} is set to point at somewhere that is _not_ a true
upstream, that is).

> Cc: Jeff King <peff@peff.net>
> Cc: Junio C Hamano <gister@pobox.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Since -M, -C, -D are left in the argc, checking argc < 2 isn't
>  sufficient.
>
>  I wanted to get an early reaction before wiring up checkout and
>  rebase.
>
>  But I wanted to discuss the overall idea of the patch.
>  builtin/log.c           | 21 +++++++++++++++++++++
>  t/t4014-format-patch.sh | 20 ++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index b97373d..525e696 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -674,6 +674,7 @@ static int thread;
>  static int do_signoff;
>  static const char *signature = git_version_string;
>  static int config_cover_letter;
> +static const char *config_base_branch;
>  
>  enum {
>  	COVER_UNSET,
> @@ -750,6 +751,22 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
>  		return 0;
>  	}
> +	if (starts_with(var, "branch.")) {
> +		const char *name = var + 7;
> +		const char *subkey = strrchr(name, '.');
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		if (!subkey)
> +			return 0;
> +		strbuf_add(&buf, name, subkey - name);
> +		if (branch_get(buf.buf) != branch_get(NULL))
> +			return 0;
> +		strbuf_release(&buf);
> +		if (!strcmp(subkey, ".forkedfrom")) {
> +			if (git_config_string(&config_base_branch, var, value))
> +				return -1;
> +		}
> +	}
>  
>  	return git_log_config(var, value, cb);
>  }
> @@ -1324,6 +1341,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		die (_("--subject-prefix and -k are mutually exclusive."));
>  	rev.preserve_subject = keep_subject;
>  
> +	if (argc < 2 && config_base_branch) {
> +		argv[1] = config_base_branch;
> +		argc++;
> +	}
>  	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
>  	if (argc > 1)
>  		die (_("unrecognized argument: %s"), argv[1]);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 73194b2..2ea94af 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1370,4 +1370,24 @@ test_expect_success 'cover letter auto user override' '
>  	test_line_count = 2 list
>  '
>  
> +test_expect_success 'branch.*.forkedFrom matches' '
> +	mkdir -p tmp &&
> +	test_when_finished "rm -rf tmp;
> +		git config --unset branch.rebuild-1.forkedFrom" &&
> +
> +	git config branch.rebuild-1.forkedFrom master &&
> +	git format-patch -o tmp >list &&
> +	test_line_count = 2 list
> +'
> +
> +test_expect_success 'branch.*.forkedFrom does not match' '
> +	mkdir -p tmp &&
> +	test_when_finished "rm -rf tmp;
> +		git config --unset branch.foo.forkedFrom" &&
> +
> +	git config branch.foo.forkedFrom master &&
> +	git format-patch -o tmp >list &&
> +	test_line_count = 0 list
> +'
> +
>  test_done

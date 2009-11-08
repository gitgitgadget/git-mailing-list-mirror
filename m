From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach the --all option to 'git fetch'
Date: Sun, 08 Nov 2009 01:33:55 -0800
Message-ID: <7vaayxfji4.fsf@alter.siamese.dyndns.org>
References: <4AF682A5.5020500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 10:34:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N74A0-0006Ja-98
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 10:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbZKHJeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 04:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbZKHJeA
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 04:34:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbZKHJd7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2009 04:33:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6EC077973;
	Sun,  8 Nov 2009 04:34:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OKdzivQXdZR8
	qeJE9SjocclPn1w=; b=g1Zb5CZsPakEbrYdgqkwe/u7MEAefz7pJ/C9/2rKP098
	YiLU+LKIIsskCkLnRMikj5iCau1qF8eCUyQka71+9a6Ng1dvS6LytcrTaREhCO2T
	kbSa0UQRI9Dpqn2OHGyH8VNJ0kKkvhT81B0ewDSArwTYOxr4Cc8oRBWPwxgTjOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vZxLPv
	rYNj9OV9JYrfvlh+ZRE5YJ1wFndCVDH2m5y3sfSn9C9ri9v+3ck7N5fpFgfnT79C
	TNm/I3flJIgB8QmyTlAO7ZSDTgcmAcWrHHjDq99L1zO1YfWNXWVktRcv4iUWinS2
	9S6KKDIFXtllXp/jBY/mwQw4Pn04DNDJLgLt8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B706F77972;
	Sun,  8 Nov 2009 04:33:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F213C77971; Sun,  8 Nov
 2009 04:33:56 -0500 (EST)
In-Reply-To: <4AF682A5.5020500@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Sun\, 08 Nov 2009 09\:34\:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D80E762A-CC49-11DE-86DA-7C40EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132390>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> 'git remote' is meant for managing remotes and 'git fetch' is meant
> for actually fetching data from remote repositories. Therefore, it is
> not logical that you must use 'git remote update' to fetch from
> several repositories at once. (Junio called 'git remote update'
> a "half-baked UI experiment that failed" in topic 130891 in Gmane.)

Please drop the "because I said so" part, as I made myself clear in the
message I was speaking as mere one-of-participants to the project, not =
as
the maintainer.

> +static int get_one_remote_for_fetch(struct remote *remote, void *pri=
v)
> +{
> +	struct string_list *list =3D priv;
> +	string_list_append(remote->name, list);
> +	return 0;
> +}
> +
> +static int fetch_all(int argc)
> +{
> +...
> +	for (i =3D 0; i < list.nr; i++) {
> +		const char *name =3D list.items[i].string;
> +		argv[argc] =3D name;
> +		if (verbosity >=3D 0)
> +			printf("Fetching %s\n", name);
> +		if (run_command_v_opt(argv, RUN_GIT_CMD)) {
> +			error("Could not fetch %s", name);
> +			result =3D 1;
> +		}
> +	}
> +...
> +}
> +
> ...
> +int cmd_fetch(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +
> +	/* Record the command line for the reflog */
> +	strbuf_addstr(&default_rla, "fetch");
> +	for (i =3D 1; i < argc; i++)
> +		strbuf_addf(&default_rla, " %s", argv[i]);
> +
> +	argc =3D parse_options(argc, argv, prefix,
> +			     builtin_fetch_options, builtin_fetch_usage, 0);
> +
> +	if (all) {
> +		return fetch_all(argc);
> +	} else {
> +		return fetch_one(argc, argv);
> +	}
> +}

Very nice.  I like the simplicity of this.

Hopefully after the parse_options() we can inspect the "repo" argument =
to
see if it names remote groups and transplant the support for that from
"remote update" codepath into this, right?

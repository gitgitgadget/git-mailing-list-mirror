From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] clone: respect configured fetch respecs during initial fetch
Date: Thu, 31 Mar 2016 09:15:58 -0700
Message-ID: <xmqq1t6qr5c1.fsf@gitster.mtv.corp.google.com>
References: <20160307153304.GA23010@sigill.intra.peff.net>
	<1459349623-16443-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:16:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfGU-0003uU-So
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbcCaQQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 12:16:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751243AbcCaQQE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 12:16:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F2B2C507AC;
	Thu, 31 Mar 2016 12:16:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7YQ1qZisICjP
	JCgnmXrCgR3Zyks=; b=okhFitWnNEjgsYC9nZdQkDGGMWG18H0pvpviKKbNFLZB
	Qth8yj/i2VxKxAJnB66YU/swntVwC/xg5iNyEGOQf45NezU6MKRa4OtQNX6SQBNR
	lR52XCPJurr/i1s5O2MZaWcD8SoU6ifUF5Y04eZlDIxlQQTIg1fcMwHubCsFijM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=To5fOD
	4EM0rirfeHgrTVA3CAOScpgcBsiWfN+6yUSqFIVaeDzop5QA0PrDxFZOrADbO+rI
	UmMYuxvy65hdgmKobK5KyG836E/GUR0ATen2yrL4QmImgciybx/DIVJb72YO6L4e
	cVAa+dm5ERpNcJhyYqzrVYsnmfJBXMh/DDVcA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BAB1507AB;
	Thu, 31 Mar 2016 12:16:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 638F3507AA;
	Thu, 31 Mar 2016 12:16:00 -0400 (EDT)
In-Reply-To: <1459349623-16443-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 30 Mar 2016 16:53:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DBAC367A-F75B-11E5-9A3A-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290408>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Conceptually 'git clone' should behave as if the following commands
> were run:
>
>   git init
>   git config ... # set default configuration and origin remote
>   git fetch
>   git checkout   # unless '--bare' is given
>
> However, that initial 'git fetch' behaves differently from any
> subsequent fetches, because it takes only the default fetch refspec
> into account and ignores all other fetch refspecs that might have
> been explicitly specified on the command line (e.g. 'git -c
> remote.origin.fetch=3D<refspec> clone' or 'git clone -c ...').

Is it really 'git fetch' behaves differently?

What is missing in the above description is your expected behaviour
of "git -c var=3Dval clone", and without it we cannot tell if your
expectation is sane to begin with.

Is the expectation like this?

    git init
    git config ... # set default configuration and origin remote
    git config var val # update with what "-c var=3Dval" told us
    git fetch
    git checkout   # unless '--bare' is given

or is it something else?

Is "-c var=3Dval" adding to the config variables set by default, or is
it replacing them?  Does the choice depend on the nature of
individual variables, and if so what is the criteria?

Are all "-c var=3Dval" update the configuration of the resulting
repository?  Or are certain "var"s treated as special and placed in
the config but not other "var"s?  If the latter, what makes these
certain "var"s special?

These design decisions need to be explained so that they will serve
to guide people to decide what other variables to propagate and how
when they have to add new configuration variables in the future.
Otherwise we'd end up with an inconsistent mess.

> Check whether there are any fetch refspecs configured for the origin
> remote and take all of them into account during the initial fetch as
> well.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
> Changes since previous (RFC) version:
>  - new commit message
>  - additional configured fetch refspecs are taken into account with
>    '--single-branch' as well
>
>  builtin/clone.c         | 36 ++++++++++++++++++++++++++++--------
>  t/t5708-clone-config.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 661639255c56..5e2d2c21e456 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -515,7 +515,7 @@ static struct ref *find_remote_branch(const struc=
t ref *refs, const char *branch
>  }
> =20
>  static struct ref *wanted_peer_refs(const struct ref *refs,
> -		struct refspec *refspec)
> +		struct refspec *refspec, unsigned int refspec_count)
>  {
>  	struct ref *head =3D copy_ref(find_ref_by_name(refs, "HEAD"));
>  	struct ref *local_refs =3D head;
> @@ -536,13 +536,18 @@ static struct ref *wanted_peer_refs(const struc=
t ref *refs,
>  			warning(_("Could not find remote branch %s to clone."),
>  				option_branch);
>  		else {
> -			get_fetch_map(remote_head, refspec, &tail, 0);
> +			unsigned int i;
> +			for (i =3D 0; i < refspec_count; i++)
> +				get_fetch_map(remote_head, &refspec[i], &tail, 0);
> =20
>  			/* if --branch=3Dtag, pull the requested tag explicitly */
>  			get_fetch_map(remote_head, tag_refspec, &tail, 0);
>  		}
> -	} else
> -		get_fetch_map(refs, refspec, &tail, 0);
> +	} else {
> +		unsigned int i;
> +		for (i =3D 0; i < refspec_count; i++)
> +			get_fetch_map(refs, &refspec[i], &tail, 0);
> +	}
> =20
>  	if (!option_mirror && !option_single_branch)
>  		get_fetch_map(refs, tag_refspec, &tail, 0);
> @@ -840,7 +845,9 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
>  	int err =3D 0, complete_refs_before_fetch =3D 1;
> =20
>  	struct refspec *refspec;
> -	const char *fetch_pattern;
> +	unsigned int refspec_count =3D 1;
> +	const char **fetch_patterns;
> +	const struct string_list *config_fetch_patterns;
> =20
>  	packet_trace_identity("clone");
>  	argc =3D parse_options(argc, argv, prefix, builtin_clone_options,
> @@ -967,9 +974,21 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>  	if (option_reference.nr)
>  		setup_reference();
> =20
> -	fetch_pattern =3D value.buf;
> -	refspec =3D parse_fetch_refspec(1, &fetch_pattern);
> +	strbuf_addf(&key, "remote.%s.fetch", option_origin);
> +	config_fetch_patterns =3D git_config_get_value_multi(key.buf);
> +	if (config_fetch_patterns)
> +		refspec_count =3D 1 + config_fetch_patterns->nr;
> +	fetch_patterns =3D xcalloc(refspec_count, sizeof(*fetch_patterns));
> +	fetch_patterns[0] =3D value.buf;
> +	if (config_fetch_patterns) {
> +		struct string_list_item *fp;
> +		unsigned int i =3D 1;
> +		for_each_string_list_item(fp, config_fetch_patterns)
> +			fetch_patterns[i++] =3D fp->string;
> +	}
> +	refspec =3D parse_fetch_refspec(refspec_count, fetch_patterns);
> =20
> +	strbuf_reset(&key);
>  	strbuf_reset(&value);
> =20
>  	remote =3D remote_get(option_origin);
> @@ -1013,7 +1032,7 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
>  	refs =3D transport_get_remote_refs(transport);
> =20
>  	if (refs) {
> -		mapped_refs =3D wanted_peer_refs(refs, refspec);
> +		mapped_refs =3D wanted_peer_refs(refs, refspec, refspec_count);
>  		/*
>  		 * transport_get_remote_refs() may return refs with null sha-1
>  		 * in mapped_refs (see struct transport->get_refs_list
> @@ -1094,6 +1113,7 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
>  	strbuf_release(&value);
>  	junk_mode =3D JUNK_LEAVE_ALL;
> =20
> +	free(fetch_patterns);
>  	free(refspec);
>  	return err;
>  }
> diff --git a/t/t5708-clone-config.sh b/t/t5708-clone-config.sh
> index 27d730c0a720..136a8611c7f3 100755
> --- a/t/t5708-clone-config.sh
> +++ b/t/t5708-clone-config.sh
> @@ -37,4 +37,28 @@ test_expect_success 'clone -c config is available =
during clone' '
>  	test_cmp expect child/file
>  '
> =20
> +test_expect_success 'clone -c remote.origin.fetch=3D<refspec> works'=
 '
> +	rm -rf child &&
> +	git update-ref refs/grab/it refs/heads/master &&
> +	git update-ref refs/keep/out refs/heads/master &&
> +	git clone -c "remote.origin.fetch=3D+refs/grab/*:refs/grab/*" . chi=
ld &&
> +	(
> +		cd child &&
> +		git for-each-ref --format=3D"%(refname)" refs/grab/ >../actual
> +	) &&
> +	echo refs/grab/it >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git -c remote.origin.fetch=3D<refspec> clone wo=
rks' '
> +	rm -rf child &&
> +	git -c "remote.origin.fetch=3D+refs/grab/*:refs/grab/*" clone . chi=
ld &&
> +	(
> +		cd child &&
> +		git for-each-ref --format=3D"%(refname)" refs/grab/ >../actual
> +	) &&
> +	echo refs/grab/it >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done

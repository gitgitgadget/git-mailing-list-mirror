Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C08520281
	for <e@80x24.org>; Wed,  4 Oct 2017 07:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbdJDHOQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 03:14:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57899 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750797AbdJDHOP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 03:14:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCE31A2261;
        Wed,  4 Oct 2017 03:14:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XVO6AzBM4UxTCou451By/vFxaHg=; b=Vg529i
        li/CWBvIJRUboZezmTebssYVCllvnEKKFvOtpTqfGg01PNoNOlafZ5yYytYd8opz
        C4hh80BLFJ1/C/YNjlzZ5hM+GdJS5xmRgoZpGztjx33g5fcKvklJ0hmH7r8AdoUY
        UtPFU6j+AtGzOTdwkgwjkJuNbUGfpJeOXKBD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vBgn5CZgkACxaSbamt6gNCn83nobL/f1
        Z0FS9tR8s4AZMWqTlq5FfPx408mI/2/A5QuToauBlQykuYM1ztaIa9xC0POT8OID
        6Z9QJWswD1IVk0viLP9x7dsKT8aR6fRmoxFWMPlzhFPI8X4zlZK1Gd4Ilnltn9Bh
        4Q8FFigitDI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3719A2260;
        Wed,  4 Oct 2017 03:14:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19156A225E;
        Wed,  4 Oct 2017 03:14:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] for-each-ref: let upstream/push optionally report the remote name
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <0e03bf1e50e24a52f57be0f51d19f4657c68d2fa.1506952571.git.johannes.schindelin@gmx.de>
Date:   Wed, 04 Oct 2017 16:14:07 +0900
In-Reply-To: <0e03bf1e50e24a52f57be0f51d19f4657c68d2fa.1506952571.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 2 Oct 2017 15:56:37 +0200
        (CEST)")
Message-ID: <xmqq376zcrls.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D7311DC-A8D3-11E7-A353-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch offers the new suffix :remote for the upstream and for the
> push atoms, allowing to show exactly that.

Has the design changed since this description and examples were
written?  The documentation talks about ":remote-name".  I suspect
calling this ":remote" might be less hassle, as we do not have to
vet the current vocabulary to see if "remote-name" is the right way
to name a multi-word modifer (as opposed to "remotename", or
"remoteName", or "remote_name", or...).

> 	...
>
> 	$ git for-each-ref \
> 		--format='%(upstream) %(upstream:remote) %(push:remote)' \
> 		refs/heads/master

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 66b4e0a4050..776368ee531 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -140,17 +140,19 @@ upstream::

Aside from "':remote-name'?  Do we really want that?" issue I
already mentioned, the changes to this file look sensible.

> diff --git a/ref-filter.c b/ref-filter.c
> index bc591f4f3de..58d53c09390 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -76,7 +76,9 @@ static struct used_atom {
>  		char color[COLOR_MAXLEN];
>  		struct align align;
>  		struct {
> -			enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
> +			enum {
> +				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME
> +			} option;
>  			struct refname_atom refname;
>  			unsigned int nobracket : 1;
>  		} remote_ref;
> @@ -156,6 +158,8 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
>  			atom->u.remote_ref.option = RR_TRACKSHORT;
>  		else if (!strcmp(s, "nobracket"))
>  			atom->u.remote_ref.nobracket = 1;
> +		else if (!strcmp(s, "remote-name"))
> +			atom->u.remote_ref.option = RR_REMOTE_NAME;
>  		else {
>  			atom->u.remote_ref.option = RR_REF;
>  			refname_atom_parser_internal(&atom->u.remote_ref.refname,
> @@ -1247,6 +1251,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>  			*s = ">";
>  		else
>  			*s = "<>";
> +	} else if (atom->u.remote_ref.option == RR_REMOTE_NAME) {
> +		int explicit;
> +		const char *remote = starts_with(atom->name, "push") ?
> +			pushremote_for_branch(branch, &explicit) :
> +			remote_for_branch(branch, &explicit);

I think "int explicit = 0;" is needed, as pushremote_for_branch()
does seem to expect that the "explicit" return parameter is
initialized by the caller.

> +		if (explicit)
> +			*s = xstrdup(remote);
> +		else
> +			*s = "";

This one is debatable.  For the user of "push" who wants to learn
where the branch is pushed to, the choice this patch makes is not
useful (i.e. such a user does not care where the definition comes
from; s/he only wants to know where the push goes).  For the user of
"git config" who wants to know how pushremote is configured, and
does not want to accept the fallback to remote, the behaviour of
this patch is useful.  I have a mild suspicion that majority of
users who would want to use this feature would fall into the former
category, i.e. users of "push", rather than the latter, i.e.
debuggers of their config files, and if that is true, we can drop
the whole "explicit" business to simplify the code and get a more
useful behaviour at the same time ;-)

> @@ -1364,9 +1377,13 @@ static void populate_value(struct ref_array_item *ref)
>  				continue;
>  			branch = branch_get(branch_name);
>  
> -			refname = branch_get_push(branch, NULL);
> -			if (!refname)
> -				continue;
> +			if (starts_with(name, "push:remote-"))

I am not sure what is going on here.  

Are we expecting "push:remote-name" here, or anticipating
"push:remote-bar" can also be given or what?

> +				refname = NULL;
> +			else {
> +				refname = branch_get_push(branch, NULL);
> +				if (!refname)
> +					continue;
> +			}
>  			fill_remote_ref_details(atom, refname, branch, &v->s);
>  			continue;
>  		} else if (starts_with(name, "color:")) {

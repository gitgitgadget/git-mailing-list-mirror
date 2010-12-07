From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: =?utf-8?Q?Don=E2=80=99t?= look up commits with
 --exact-match
Date: Tue, 07 Dec 2010 10:39:51 -0800
Message-ID: <7vfwu9qvew.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
 <20101203084348.GD18202@burratino>
 <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
 <20101206073214.GA3745@burratino>
 <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:40:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2Sb-0005YT-Mc
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741Ab0LGSkM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 13:40:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab0LGSkK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 13:40:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9A1F29AA;
	Tue,  7 Dec 2010 13:40:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=khoYWqPbLEoe
	NFKhdiwIIQL3lUk=; b=vpLFrqserZPUr35jnfEWmZ3HNwBfm81Zr7JUwJxLwNV/
	rbemA25rO9DFkzlR0dmARFPwl+UFD2miaMFR2JiiLYH8KqzdFBAKIHcCIxqi7Y2O
	m6DSxcja6PxNOkc+C8AXFk6e55eSEGhBsZX0IrHjGrbAEBn5YIdtyQ+gpq6L7i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oITUjf
	spuiMgn6bMz1+Z9dG6gjOAN0tavCTQOSbvFBHR3T5d0jUnZZe8VybzN0VHtxRPTR
	/id/LnKJYgalzSljhBuafhZbVOfVNMFxvgzXzzyBnOakIKap4di4TuXhzJjTAkrK
	/JsXApxp6UDTeJTlzWyaUKk3uZpkZh1EOnEUM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7757929A7;
	Tue,  7 Dec 2010 13:40:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6FE6D29A5; Tue,  7 Dec 2010
 13:40:17 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu> (Anders
 Kaseorg's message of "Mon\, 6 Dec 2010 12\:28\:59 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74A13662-0231-11E0-A9B8-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163110>

Anders Kaseorg <andersk@ksplice.com> writes:

> From 2ad1e58b8f6e9c117c77748b6e8b85227d9d5412 Mon Sep 17 00:00:00 200=
1
> From: Anders Kaseorg <andersk@ksplice.com>
> Subject: [PATCH 1/2] describe: Use for_each_rawref
>
> Don=E2=80=99t waste time checking for dangling refs; they wouldn=E2=80=
=99t affect the
> output of =E2=80=98git describe=E2=80=99 anyway.  Although this doesn=
=E2=80=99t gain much
> performance by itself, it does in conjunction with the next commit.
>
> Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
> ---
>  builtin/describe.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 43caff2..700f740 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -418,7 +418,7 @@ int cmd_describe(int argc, const char **argv, con=
st char *prefix)
>  		return cmd_name_rev(i + argc, args, prefix);
>  	}
> =20
> -	for_each_ref(get_name, NULL);
> +	for_each_rawref(get_name, NULL);
>  	if (!found_names && !always)
>  		die("No names found, cannot describe anything.");

It is Ok during a review cycle that is not meant as the final submissio=
n,
but please follow Documentation/SubmittingPatches for the final round
(i.e. not multiple-changes in a single mail), as mentioned by Jonathan.

> From ce8a2ab9cf80247c2834d21f36f63cedb794e62f Mon Sep 17 00:00:00 200=
1
> From: Anders Kaseorg <andersk@ksplice.com>
> Subject: describe: Don=E2=80=99t look up commits with --exact-match
>
> This makes =E2=80=98git describe --exact-match HEAD=E2=80=99 about 15=
 times faster on
> a cold cache (2.3s instead of 35s) in a linux-2.6 repository with man=
y
> packed tags.  That=E2=80=99s a huge win for the interactivity of the =
__git_ps1
> shell prompt helper.

Good description of the motivation.  Care to describe how it is achieve=
d?

I may be misreading your intention, but my understanding of the thinkin=
g
behind what the new code does is...

 - When the object name given from the command line happens to match on=
e
   of the tags exactly (either a lightweight tag in which case we can j=
ust
   compare the object names to detect the match, or an annotated tag in
   which case we only need to parse the tag but not the underlying comm=
it
   to do the comparison), we do not have to parse any commit object.

 - Other cases we would need to parse commit objects and traverse the
   history.

 - Hence, the code can be optimized for the case to describe an exact
   match by trying exact object name match first and then loading commi=
t
   objects only when no exact matches found.

 - When we are only looking for exact matches (which is _not_ a rare
   corner case), we won't ever fall back to the "parse commit objects a=
nd
   traverse the history" codepath.  So it is important to lazily parse
   commit objects in order to optimize for this special case.

I however think this may hurt when more than one objects are asked to b=
e
described and there is no exact match.  The fallback codepath that lazi=
ly
runs lookup_commit_reference_gently() and uses replace_name() to comput=
e
the best name needs to run only once, but this part of the code seems t=
o
run it for the elements on the names list once per describe() invocatio=
n
that needs to fall back to this codepath.  Would it remove this regress=
ion
if we make it run only once?

I don't think this affects correctness, though.

> @@ -259,6 +255,12 @@ static void describe(const char *arg, int last_o=
ne)
>  	if (debug)
>  		fprintf(stderr, "searching to describe %s\n", arg);
> =20
> +	for (e =3D names; e; e =3D e->next) {
> +		struct commit *c =3D lookup_commit_reference_gently(e->peeled, 1);
> +		if (c && replace_name(c->util, e->prio, e->sha1, &e->tag))
> +			c->util =3D e;
> +	}
> +
>  	list =3D NULL;
>  	cmit->object.flags =3D SEEN;
>  	commit_list_insert(cmit, &list);

As you can see from its "if (!e->tag)" codepath, replace_name() is not
designed to be called excessively (e.g. we will end up running the
codepath for an annotated tag that we should know we won't find a tag).

Also, "struct tag *tag" does not need to exist in add_to_known_names()
anymore; a NULL is assigned to it and its only use is to get assigned
to e->tag.

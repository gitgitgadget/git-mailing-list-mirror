From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] list-files: show paths relative to cwd
Date: Thu, 12 Mar 2015 14:20:24 -0700
Message-ID: <xmqqsid929rb.fsf@gitster.dls.corp.google.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
	<1425896314-10941-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 22:20:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWAXA-000258-8Y
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 22:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbbCLVUc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2015 17:20:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751169AbbCLVUb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2015 17:20:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B33CE40398;
	Thu, 12 Mar 2015 17:20:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dNpR7/jeoRi6
	2pYqWhqRsj2ZUjg=; b=EmoXx91i5Ci/bZnf1fLjTZax4WfQonhcKXmkC7QHtc0v
	9gxVySWCJZGBzQgESJl6CdhB6dycTyf+bFwz0iBnj94xwLJsiMSzoy37pyxcTaAM
	cyL+NIocgSEQ+g8o+W1dYAu3jj9C8inBIebXIm1xOg0ToZpV9qyDcY6ixOemzF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hSx+oK
	14jcIh4U2kc8SgTjL5p7zaQcQ6dQx7D3PpjB4uFJscnY9snyblNyJjqm+6eZChTD
	aDDgjgvue7V9bvGYo5NIhiS+6M9chFborkWa6zT3iNcwNE6gREIelkynod70sTn+
	sBvnFZNtRPDbjBgprxQo4dCdJPB7wrF61RHp8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC89640397;
	Thu, 12 Mar 2015 17:20:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA2D84038D;
	Thu, 12 Mar 2015 17:20:25 -0400 (EDT)
In-Reply-To: <1425896314-10941-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Mar
 2015 17:18:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99987A60-C8FD-11E4-A402-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265372>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/list-files.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index b99f2b7..c444a53 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -3,6 +3,7 @@
>  #include "parse-options.h"
>  #include "pathspec.h"
>  #include "dir.h"
> +#include "quote.h"
> =20
>  static struct pathspec pathspec;
>  static const char *prefix;
> @@ -22,7 +23,7 @@ static void add_one(struct string_list *result, con=
st char *name)
>  	struct strbuf sb =3D STRBUF_INIT;
>  	struct string_list_item *item;
> =20
> -	strbuf_addstr(&sb, name);
> +	quote_path_relative(name, prefix_length ? prefix : NULL, &sb);
>  	item =3D string_list_append(result, strbuf_detach(&sb, NULL));
>  	item->util =3D (char *)name;
>  }

Hmph, wouldn't it make it more cumbersome and problematic to do
things like this here in add_one() phase?  I am imagining that the
endgame of this program will be

    - populate_cached_entries() reads from the data source (at this
      step, there is just "the index"), calling add_one() whose
      responsibility is to record the paths that are interesting
      to an in-core structure;

    - perform some interesting filtering, annotating, ordering,
      etc. (at this step, there is none) yet to come;

    - display() will iterate over the result and then format the
      result.

=46or example, if you do the "quote" thing too early, don't codepaths
in the later phases have to worry about item->string not matching
the original pathname anymore?  If you want to do something like
"/bin/ls -t", you may have to lstat() the paths for each item, but
if these store a path relative to the prefix, wouldn't you have to
prepend the prefix again before running lstat()?

I am just wondering if this prefix-stripping and quoting belongs to
the output phase, not the input phase.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 11/45] parse_pathspec: support stripping submodule
 trailing slashes
Date: Sun, 17 Mar 2013 14:55:29 -0700
Message-ID: <7vy5dlpu7i.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 22:56:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHLYd-0001WC-UN
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 22:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653Ab3CQVzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 17:55:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42182 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932587Ab3CQVzc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 17:55:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B96FEAB54;
	Sun, 17 Mar 2013 17:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T1Z+FvrX3rD1
	a/JUuTXROaiDJZA=; b=fhFW52o5BxNC/zRW9KUn1Z49TVAr5r9TnO5vx/EQOfv0
	TvdPfXvaUuCWqFYLT6D18tWwWP6nropehDkDSfTicYunOigsMV2CoStI7Tkkq90r
	sWIHazDBQ1QpHQH2RusiXveaSqA9MS5v537hsjeWJVaMYu+97ADHmJ4eXqIPb8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eex7d1
	+b2cVQae12zQWAEym0A1jq2IA+H9nmuMEiF9+DS2qY0y+4wlaMsLWp9mLt2JHFe/
	MD8iZ74x+gJhk7O7NIaB2OzNm29uMruVa3NB2JxGYmGktyflvhWVxwj27KhSuGqC
	nmBR4VBXQymVT9ahADs9IRG3SaEgAlBBHMmRQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADD51AB53;
	Sun, 17 Mar 2013 17:55:31 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC951AB50; Sun, 17 Mar 2013
 17:55:30 -0400 (EDT)
In-Reply-To: <1363327620-29017-12-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 15 Mar
 2013 13:06:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62F13268-8F4D-11E2-88A6-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218375>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This flag is equivalent to builtin/ls-files.c:strip_trailing_slashes(=
)
> and is intended to replace that function when ls-files is converted t=
o
> use parse_pathspec.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  pathspec.c | 9 +++++++++
>  pathspec.h | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/pathspec.c b/pathspec.c
> index b2446c3..2da8bc9 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -204,6 +204,15 @@ static unsigned prefix_pathspec(struct pathspec_=
item *item,
>  	*raw =3D item->match =3D match;
>  	item->original =3D elt;
>  	item->len =3D strlen(item->match);
> +
> +	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&

I see that having cheap and expensive variant at these steps is a
way to achieve a bug-for-bug compatible rewrite of the existing
code, but in the longer term should we lose one of them?  After all,
a path that points at the working tree of another repository that is
beyond a symlink cannot be added to us as a submodule, so CHEAP can
be used only when we know that any intermediate component on the
path is not a symlink pointing elsewhere, and the user in the
codepath of ls-files may know it.

To put it differently, shouldn't CHEAP and EXPENSIVE be accompanied
by in-code comment and updates to Documentation/technical/api-*.txt
to help users of the API to decide which one to use?

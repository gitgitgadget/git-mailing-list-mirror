From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff-files: mark i-t-a paths as "new"
Date: Sun, 15 Mar 2015 00:05:45 -0700
Message-ID: <xmqqioe2viye.fsf@gitster.dls.corp.google.com>
References: <1425910445-27383-1-git-send-email-pclouds@gmail.com>
	<1425910445-27383-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 08:06:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX2cd-00018J-MG
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 08:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbbCOHFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 03:05:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751054AbbCOHFr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 03:05:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB41338781;
	Sun, 15 Mar 2015 03:05:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WGlCNMAc1fnA
	N09gaYueYcVEpFo=; b=OhwYhhKwWUBdb7FGcSq4bBjZnPgBQ0ZcivUJPTG8tx5W
	4pV8Lw2HmXAHZWJtzbbvx1JS9FrLWVEkoIV45QLlB9Lp+fOXmE+nZs0Xdf/g0Heb
	A00CbQavFLOADk52+VdIHjr4bgAxe5JvgeyAjn9zrr8BLhU3S8xDtcR660b9Sfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yKcSMP
	FhjdYlLM/T2r5k/srZ7yrg/pGuHhMj6llulsUMcJDI7/yDFMUR9Z+EYTcrsDxs9l
	elEuzOJ/CNdxoRW87Fycs+H8lLBYCBgU/fCg7bY2+OCmbWnPRHVJmAaNgzrf/QLX
	ZedeqMn/OXvjRn0+GggimM1F2ej4nXvkOI9Nw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE67E3877F;
	Sun, 15 Mar 2015 03:05:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3755F3877E;
	Sun, 15 Mar 2015 03:05:46 -0400 (EDT)
In-Reply-To: <1425910445-27383-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Mar
 2015 21:14:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B3E2F4C8-CAE1-11E4-9946-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265482>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/add.c | 1 +
>  diff-lib.c    | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 3390933..ee370b0 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -63,6 +63,7 @@ static void update_callback(struct diff_queue_struc=
t *q,
>  		switch (fix_unmerged_status(p, data)) {
>  		default:
>  			die(_("unexpected diff status %c"), p->status);
> +		case DIFF_STATUS_ADDED:
>  		case DIFF_STATUS_MODIFIED:
>  		case DIFF_STATUS_TYPE_CHANGED:
>  			if (add_file_to_index(&the_index, path, data->flags)) {

Is this related to making "diff-files" show an i-t-a as "new", or
something else?

Ahh, "added" would have never appeared in diff-files output (because
by definition comparing index and working tree for only paths known
to the index would never produce "add"), and the point of this series
is to use that status to signal that the path is marked as i-t-a.

And an i-t-a path is "not yet exist in the index, known to the
system, and exists in the working tree", so catching that new case
here and calling add_file_to_index() would cause such a path to be
truly added to the index (this is "add -u" codepath, right?).

Makes sense.

> diff --git a/diff-lib.c b/diff-lib.c
> index db0e6f8..5f1afa4 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -212,6 +212,11 @@ int run_diff_files(struct rev_info *revs, unsign=
ed int option)
>  					       ce->sha1, !is_null_sha1(ce->sha1),
>  					       ce->name, 0);
>  				continue;
> +			} else if (ce->ce_flags & CE_INTENT_TO_ADD) {
> +				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
> +					       EMPTY_BLOB_SHA1_BIN, 0,
> +					       ce->name, 0);
> +				continue;
>  			}
> =20
>  			changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,

And this makes sense, of course.

The way "add -N" entries appear in "git status" has been disturbing
for quite a while to me, too.  Thanks for starting to look into it.

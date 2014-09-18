From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff --no-index: allow pathspec after --
Date: Thu, 18 Sep 2014 15:41:44 -0700
Message-ID: <xmqqha04o8k7.fsf@gitster.dls.corp.google.com>
References: <1410256584-19562-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 00:41:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUkOd-0002Y4-Gx
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 00:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478AbaIRWls convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2014 18:41:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56617 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbaIRWlr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Sep 2014 18:41:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B6DB3BA99;
	Thu, 18 Sep 2014 18:41:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1rKcG8reEjN5
	fvdpraAD0p8y85E=; b=A1c25EnAId/JzsEJLI549w2V4snjO7kjYXw3n62B34Kq
	gJUDQfi5z+CkWmlbywa8kP3xggm+6P3CXKsnKXBYs6cW8qR4Q2Qsslw9YuSICtrg
	gkAsCMn6EGz5ca1o/OU7hkJrDvDQz/TiXO1EtManJ1Z+UX1AzlP21ELORi87vp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iqH/gs
	7NUx8XETmenm1XD8nGw4XN5RGGFovA88t32g+p0spvopHoH7qqeW1z7mUrt4aVF2
	vx91NBxJOeBMllWuTyddKQmoLNSybcJL2GQxpm1q9tXEiyU9xXarRO2CA/60+qGy
	rcgtzVrKsZSvsbaby5bu60TUD6oZfi5PsZCsw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FF6B3BA97;
	Thu, 18 Sep 2014 18:41:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E69B73BA94;
	Thu, 18 Sep 2014 18:41:45 -0400 (EDT)
In-Reply-To: <1410256584-19562-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 9 Sep
 2014 16:56:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8278A38-3F84-11E4-B24C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257276>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Another patch to test the water before I put more effort into it.
>
> Commit d516c2d (Teach git-diff-files the new option `--no-index` -
> 2007-02-22) brings the bells and whistles of git-diff to the world
> outside a git repository. This patch continues that direction and add=
s
> a new syntax
>
>     git diff --no-index [--] <path> <path> -- <pathspec>
>
> It's easy to guess that the two directories will be filtered by
> pathspec,...

Ugh.  Nobody's diff works that way, and nowhere in our UI we use
double-dashes that way, either.

So while I like the idea of "I want to tell Git to compare these two
directories with these pathspec", I do not think we would want to
touch such a syntax with 10 foot pole X-<.

> @@ -194,19 +207,23 @@ void diff_no_index(struct rev_info *revs,
>  		int j;
>  		if (!strcmp(argv[i], "--no-index"))
>  			i++;
> -		else if (!strcmp(argv[i], "--"))
> +		else if (!strcmp(argv[i], "--")) {
>  			i++;
> -		else {
> +			break;
> +		} else {

I think this part is a good bugfix regardless of your new feature.

The general command line structure ought to be:

   $ git diff [--no-index] [--<diff options>...] [--] <path> <path>

but the existing code is too loose in that "--" is just ignored.
The caller in builtin/diff.c makes sure "--no-index" comes before
"--", the latter of which stops option processing, so it is not so
grave a bug, though.

Coming back to the command line syntax for the new feature, if I had
to choose, I would say

	git diff --no-index [-<options>] [--] <path> <path> <pathspec>

perhaps?  As we never compare anything other than two things, we can
do the following:

 * Implicit --no-index heuristics will kick in _ONLY_ when we have
   two things at the end after parsing options in builtin/diff.c, as
   before;

 * In diff_no_index() after parsing options at its beginning,

  - if we have only two things left, they may be

    . two files;
    . a file and "-" or "-" and a file; or
    . two directories (fully traversed without pathspecs)

    just as before.

  - if we have more than two things left, the first two of these
    _MUST_ be directories, and the remainder is pathspec to filter
    the result of directory traversal.

Wluldn't that be cleaner and easier to understand?

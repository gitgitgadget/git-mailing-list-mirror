From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9200 - Allow cvs version 1.12
Date: Mon, 15 Jul 2013 15:06:02 -0700
Message-ID: <7v1u6za379.fsf@alter.siamese.dyndns.org>
References: <1373920585-22370-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 00:06:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyquI-0005b0-Se
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 00:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126Ab3GOWGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 18:06:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132Ab3GOWGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 18:06:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6242A31ED7;
	Mon, 15 Jul 2013 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/BaNhqTOiuQFppsKPlmPMHhB04Q=; b=tR09U6
	8lodv/4xjT0OpQwaWlYCUxZdLIfhkChTcAAEfWeAQwU7lTbauLDiZnYdvq8b8Rdp
	008OFsYr2awSFQ/P3cqVAVH2AWlN/AQ0VA+V2qKI7fOdxZJeLIHspfN20Mo4psIt
	6If9Thd3uIFUW4O3g2DBAufJIc9PuddadKrCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cqK7T14442YaZo0vVO6qTsKM7UQ8we+s
	g3JzU0A5afrbOi0LRt3q8ZVUEz4p8/rWY9Y4hhrOrEjYNsQxfULocRdZCnIb+Enj
	ZprzY7ODVgO0vTOmMmh68DQQMMv4fr99lX5N8RmtZwsNiLlp3/2/nxo4kKhAWvFd
	ROiN7mN3v6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56DC131ED6;
	Mon, 15 Jul 2013 22:06:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0C4D31ED3;
	Mon, 15 Jul 2013 22:06:03 +0000 (UTC)
In-Reply-To: <1373920585-22370-1-git-send-email-mlevedahl@gmail.com> (Mark
	Levedahl's message of "Mon, 15 Jul 2013 16:36:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDAA5B2A-ED9A-11E2-8BE2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230530>

Mark Levedahl <mlevedahl@gmail.com> writes:

> cvs v1.12 does not correctly handle "cvs co -d $DIR", which is shorthand
> for "mkdir $DIR, cd $DIR, cvs co, cd -". So, use the latter form.

Hmph, I think I've been using 1.12.13 and without seeing such a
breakage.  Do you mean "exactly v1.12", not "v1.12.x series"?

> Also cvs v1.12 does not necessarily match cvs v1.11 in the format of
> CVS/Entries, and this causes a false failure in subtest 14. Eliminate
> checking CVS/Entries for this one test, but keep the test that the
> created file exists and is checked out.

Also I suspect this is not because we are expecting v1.11 format, as
v1.12.13 on my box seems to pass the test.  While your removal of
the "check_entries" step might be a valid workaround for whatever
version is shipped with Cygwin, the above problem description seems
somewhat inaccurate.

> With these changes, all tests in t9200 pass on Cygwin using its default
> cvs version 1.12.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  t/t9200-git-cvsexportcommit.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> index 3fb3368..17cb554 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -28,7 +28,8 @@ rm -rf "$CVSROOT" "$CVSWORK"
>  
>  cvs init &&
>  test -d "$CVSROOT" &&
> -cvs -Q co -d "$CVSWORK" . &&
> +mkdir -p "$CVSWORK" &&
> +(cd "$CVSWORK" && cvs -Q co .) &&
>  echo >empty &&
>  git add empty &&
>  git commit -q -a -m "Initial" 2>/dev/null ||
> @@ -313,7 +314,6 @@ test_expect_success 'commit a file with leading spaces in the name' '
>  	git commit -m "Add a file with a leading space" &&
>  	id=$(git rev-parse HEAD) &&
>  	git cvsexportcommit -w "$CVSWORK" -c $id &&
> -	check_entries "$CVSWORK" " space/1.1/|DS/1.1/|attic_gremlin/1.3/|release-notes/1.2/" &&
>  	test_cmp "$CVSWORK/ space" " space"
>  
>  '

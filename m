From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add testcase for ammending and fixing author in git commit.
Date: Fri, 02 Nov 2007 13:07:55 -0700
Message-ID: <7vy7dg1kdg.fsf@gitster.siamese.dyndns.org>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:08:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io2oU-00048X-6W
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723AbXKBUID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 16:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755416AbXKBUIC
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:08:02 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:46409 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbXKBUIB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 16:08:01 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4B3762EF;
	Fri,  2 Nov 2007 16:08:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CFFC4917AE;
	Fri,  2 Nov 2007 16:08:19 -0400 (EDT)
In-Reply-To: <1194017589-4669-1-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 2 Nov 2007 11:33:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63165>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> ---
>  t/t7501-commit.sh |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index b151b51..3f2112a 100644
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -163,4 +163,14 @@ test_expect_success 'partial commit that involve=
s removal (3)' '
> =20
>  '
> =20
> +author=3D"The Real Author <someguy@his.email.org>"
> +test_expect_success 'amend commit to fix author' '
> +
> +	git reset --hard
> +	git cat-file -p HEAD | sed -e "s/author.*>/author $author/" > expec=
ted &&
> +	git commit --amend --author=3D"$author" &&
> +	git cat-file -p HEAD > current &&
> +	diff expected current
> +=09
> +'
>  test_done

This can't be right.  How are you ignoring the differences in
committer dates?

By the way, I _think_ git-commit.sh allows fixing author name/email
without molesting the author timestamp (i.e. takes it from the
amended commit).  That should probably be checked with the test
as well.

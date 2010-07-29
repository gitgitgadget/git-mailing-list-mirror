From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/5] t/t4004-diff-rename-symlink.sh: use three-arg
	<prereq>
Date: Wed, 28 Jul 2010 20:09:03 -0500
Message-ID: <20100729010903.GF29156@dert.cs.uchicago.edu>
References: <1280313299-721-1-git-send-email-avarab@gmail.com> <1280313299-721-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 03:09:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeHcY-0004zB-PD
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 03:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab0G2BJL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 21:09:11 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:47479 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0G2BJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 21:09:08 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 24B0DA206;
	Wed, 28 Jul 2010 20:09:07 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id E363720DBC; Wed, 28 Jul 2010 20:09:06 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1280313299-721-3-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152138>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change the tests that skipped due to unavailable SYMLINKS support to
> use the three-arg prereq form of test_expect_success.
>=20
> This is like the "tests: implicitly skip SYMLINKS tests using
> <prereq>" change, but I needed to create an additional test for some
> setup code. It's in a separate change as suggested by Jonathan Nieder
> for ease of reviewing.

Hmm, I still don=E2=80=99t understand this.  Do you mean that there is
some setup that needs to be run before these commands, and so
the patch fails if that change is not included?

Or is it a matter of "while at it, fix this other problem
I noticed" (which would be fine, but it is clearer to
present it as such if so)?

> diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-sym=
link.sh
> index 1a09e8d..92a65f4 100755
> --- a/t/t4004-diff-rename-symlink.sh
> +++ b/t/t4004-diff-rename-symlink.sh
> @@ -40,8 +34,9 @@ test_expect_success \
>  # rezrov and nitfol are rename/copy of frotz and bozbar should be
>  # a new creation.
> =20
> -GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >current
> -cat >expected <<\EOF
> +test_expect_success SYMLINKS 'setup diff output' "
> +    GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >curren=
t &&
> +    cat >expected <<\EOF
>  diff --git a/bozbar b/bozbar
>  new file mode 120000
>  --- /dev/null
> @@ -65,8 +60,9 @@ deleted file mode 100644
>  -xyzzy
>  \ No newline at end of file
>  EOF
> +"

Tip for the future: if you use 'straight quotes', then readers
can avoid carefully scanning through for $ and similar oddities
(and the test script presented with the "expecting success:"
prompt will use the friendlier $tree instead of 76c98ds89).

The patch looks good; my only remaining concern is the log
message as mentioned above.

Thanks,
Jonathan

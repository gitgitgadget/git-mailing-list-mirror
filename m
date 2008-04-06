From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] merge, pull: introduce '--(no-)stat' option
Date: Sat, 05 Apr 2008 19:36:57 -0700
Message-ID: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
References: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
 <1207445027-3152-1-git-send-email-szeder@ira.uka.de>
 <1207445027-3152-2-git-send-email-szeder@ira.uka.de>
 <1207445027-3152-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Apr 06 04:38:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiKlh-0002SW-2t
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 04:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbYDFChO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 22:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbYDFChN
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 22:37:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbYDFChM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Apr 2008 22:37:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F1BA9DBA;
	Sat,  5 Apr 2008 22:37:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CDC009DB7; Sat,  5 Apr 2008 22:37:01 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78882>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> '--(no-)summary' options are still accepted, but are not advertised.

Given that...

> diff --git a/git-merge.sh b/git-merge.sh
> index 7dbbb1d..1b693ad 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -8,8 +8,8 @@ OPTIONS_SPEC=3D"\
>  git-merge [options] <remote>...
>  git-merge [options] <msg> HEAD <remote>
>  --
> -summary              show a diffstat at the end of the merge
> -n,no-summary         don't show a diffstat at the end of the merge
> +stat                 show a diffstat at the end of the merge
> +n,no-stat            don't show a diffstat at the end of the merge
>  squash               create a single commit instead of doing a merge
>  commit               perform a commit if the merge sucesses (default=
)
>  ff                   allow fast forward (default)

=2E..this hunk removes the original options from OPTIONS_SPEC, I suspec=
t you
would get "unknown option 'stat'" from underlying "git rev-parse --pars=
eopt".

You probably haven't noticed the breakage because you replaced all
existing --summary with --stat in the tests, though.  Oops.

We would want to take a three-stage approach where we (1) start accepti=
ng
both forms without changing the official names shown to the users, (2)
deprecate the old names and make the new ones official, and then (3)
finally remove the old ones.  Your 2 thru 5 roll (1) and (2) into one
step.

I would not have major problem with this "hasty deprecation" in "usage"
strings, but I find it somewhat problematic to stop mentioning the old
names in the documentation and bash completion from day one.  People le=
arn
old names elsewhere (e.g. in somebody's blog entry) and then try to fin=
d
the description in their manual and they are already removed from your
copy.  Oops.

So I pretty much prefer to have an explicit deprecation period where bo=
th
forms are not just accepted but described as equals, but with the older
ones marked clearly as deprecated and planned for removal, so that peop=
le
would know what is going on.

Other than that, the rest of the series looked Ok from my cursory revie=
w.

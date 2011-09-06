From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] State what commit to expect in request-pull
Date: Tue, 6 Sep 2011 14:58:27 -0700
Message-ID: <CAJo=hJsHsVGm1xo4PP416Ek5M+3cc-VZ9LcDBhePNgahcjzB=A@mail.gmail.com>
References: <7vwrdl749z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 23:58:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R13fV-00026g-Gx
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 23:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab1IFV6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Sep 2011 17:58:49 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58659 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab1IFV6s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 17:58:48 -0400
Received: by gwaa12 with SMTP id a12so3881868gwa.19
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 14:58:47 -0700 (PDT)
Received: by 10.42.62.66 with SMTP id x2mr495356ich.93.1315346327197; Tue, 06
 Sep 2011 14:58:47 -0700 (PDT)
Received: by 10.42.163.70 with HTTP; Tue, 6 Sep 2011 14:58:27 -0700 (PDT)
In-Reply-To: <7vwrdl749z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180842>

On Tue, Sep 6, 2011 at 14:24, Junio C Hamano <gitster@pobox.com> wrote:
> Interestingly, we did say what commit the requesters based their chan=
ges
> on, but did not give the person who performs a fetch & merge to make =
sure
> he fetched the right branch.
=2E..
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> @@ -71,6 +71,7 @@ git show -s --format=3D'The following changes since=
 commit %H:
>
> =A0are available in the git repository at:' $baserev &&
> =A0echo " =A0$url $branch" &&
> +echo "for you to fetch changes up to $headrev"
> =A0echo &&

Better than what we had before. I was sort of hoping for changing the
pull line slightly to include the SHA-1. E.g. suppose instead the line
was:

  echo "  $url $headrev"

and git pull passed the $headrev down to git fetch, which then found
any reference that points exactly at $headrev and fetches that. The
branch name is now lost for the merge summary, but could be guessed
from the advertisement similar to how HEAD is guessed. Git pull could
also then validate that the commit its merging in FETCH_HEAD is what
was passed on the command line.

Then verification of the SHA-1 is automatic by Git, and doesn't
require a human. If the pull request was sent by GPG signed email, and
the MUA checked the signature, the puller has pretty reasonable
assurance over the content they are bringing into their repository.

--=20
Shawn.

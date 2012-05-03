From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] git cherry-pick: Add NULL check to sequencer parsing of
 HEAD
Date: Thu, 3 May 2012 08:08:57 -0400
Message-ID: <20120503120857.GA3085@hmsreliant.think-freely.org>
References: <1336044026-16897-1-git-send-email-nhorman@tuxdriver.com>
 <4FA26FF2.2050607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mmueller@vigilantsw.com,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 03 14:09:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPuqM-0007ZB-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 14:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab2ECMJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 08:09:05 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:51801 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab2ECMJE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 08:09:04 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SPuqA-0004pV-K4; Thu, 03 May 2012 08:09:00 -0400
Content-Disposition: inline
In-Reply-To: <4FA26FF2.2050607@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -0.2 (/)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196901>

On Thu, May 03, 2012 at 01:45:54PM +0200, Ren=E9 Scharfe wrote:
> Am 03.05.2012 13:20, schrieb Neil Horman:
> >Michael Mueller noted that a feature I recently added failed to chec=
k the return
> >of lookup_commit to ensure that it was not NULL.  I don't think a NU=
LL can
> >actually happen in the this particular use case, but regardless it s=
eems a good
> >idea to check.
> >
> >Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> >---
> >  sequencer.c |   11 ++++++++++-
> >  1 files changed, 10 insertions(+), 1 deletions(-)
> >
> >diff --git a/sequencer.c b/sequencer.c
> >index f83cdfd..ad4d781 100644
> >--- a/sequencer.c
> >+++ b/sequencer.c
> >@@ -261,7 +261,16 @@ static int is_index_unchanged(void)
> >  		return error(_("Could not resolve HEAD commit\n"));
> >
> >  	head_commit =3D lookup_commit(head_sha1);
> >-	if (!head_commit || parse_commit(head_commit))
> >+
> >+	/*
> >+	 * If head_commit is NULL, just return, as check_commit,
> >+	 * called from lookup_commit, would have indicated that
> >+	 * head_commit is not a commit object already.
> >+	 */
> >+	if (!head_commit)
> >+		return;
>=20
> A return value is missing.  Perhaps -1?
>=20
Yeah, sorry, not sure how I missed the compiler warning.

> >+
> >+	if (parse_commit(head_commit))
> >  		return error(_("could not parse commit %s\n"),
> >  			     sha1_to_hex(head_commit->object.sha1));
>=20
> Note: parse_commit() can handle NULL, and it already reports error
> details itself.
No, it doesn't.  parse_commit checks NULL already, true, but it just re=
turns -1.
No error message is provided to the user
Neil

>=20
> Ren=E9
>=20

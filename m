From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: New NULL dereference in sequence.c
Date: Wed, 2 May 2012 13:34:36 -0400
Message-ID: <20120502173436.GA26732@hmsreliant.think-freely.org>
References: <CANV9Rr9PFR7SA_3jB-6PRF_V+4yB-FsYEuX5gs-LMpoTAxGDCQ@mail.gmail.com>
 <4FA12E42.201@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Mueller <mmueller@vigilantsw.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 02 19:34:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPdS4-0008Rt-0I
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 19:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab2EBReq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 13:34:46 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:41210 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844Ab2EBRep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 13:34:45 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SPdRl-00008l-Kk; Wed, 02 May 2012 13:34:39 -0400
Content-Disposition: inline
In-Reply-To: <4FA12E42.201@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -1.0 (-)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196846>

On Wed, May 02, 2012 at 02:53:22PM +0200, Ren=E9 Scharfe wrote:
> [cc:ing the author of this commit]
>=20
> Am 02.05.2012 10:45, schrieb Michael Mueller:
> >Hi all,
> >
> >The last defect Sentry picked up has been removed, yay!  At the same
> >time, a new NULL dereference bug appeared, in sequencer.c:
> >
> >     static int is_index_unchanged(void)
> >     {
> >         unsigned char head_sha1[20];
> >         struct commit *head_commit;
> >
> >         if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
> >             return error(_("Could not resolve HEAD commit\n"));
> >
> >         head_commit =3D lookup_commit(head_sha1);
> >         if (!head_commit || parse_commit(head_commit))
> >             return error(_("could not parse commit %s\n"),
> >                      sha1_to_hex(head_commit->object.sha1));
> >
> >In the last line quoted above, head_commit may be NULL, and it is
> >dereferenced in the call to sha1_to_hex.  Assuming lookup_commit(hea=
d_sha1)
> >can return NULL, this function will segfault.
> >
> >Introduced here:
> >https://github.com/gitster/git/commit/b27cfb0#sequencer.c
>=20
> Similar code in builtin/commit.c just reports "could not parse HEAD
> commit" without any hash and thus no pointer dereference.
>=20
> Ren=E9
>=20

Have you actually seen this problem occur? It seems to me that the only=
 way
head_commit could be NULL is in the event that HEAD wasn't a commit obj=
ect,
whcih I don't think can be the case unless something else is very wrong=
 with
your tree.

Neil

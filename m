From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git cat-file: Fix memory leak in batch mode
Date: Sun, 29 Jun 2008 13:54:17 +0200
Message-ID: <20080629115417.GA14806@atjola.homenet>
References: <20080629005858.GA2036@atjola.homenet> <20080629012125.GA1722@atjola.homenet> <7v1w2gkj3l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Adam Roben <aroben@apple.com>,
	Samuel Bronson <naesten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 13:55:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCvVI-00089i-2F
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 13:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbYF2LyW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 07:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbYF2LyW
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 07:54:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:50128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751810AbYF2LyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 07:54:21 -0400
Received: (qmail invoked by alias); 29 Jun 2008 11:54:19 -0000
Received: from i577BB248.versanet.de (EHLO atjola.local) [87.123.178.72]
  by mail.gmx.net (mp068) with SMTP; 29 Jun 2008 13:54:19 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/7lZRVBoX74V+Ljo+sOQcwo/RcxJSNOmYy0RCsQw
	irCNlBCN/Bhr5X
Content-Disposition: inline
In-Reply-To: <7v1w2gkj3l.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86795>

On 2008.06.28 20:36:46 -0700, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > When run in batch mode, git cat-file never frees the memory for the=
 blob
> > contents it is printing. This quickly adds up and causes git-svn to=
 be
> > hardly usable for imports of large svn repos, because it uses cat-f=
ile in
> > batch mode and cat-file's memory usage easily reaches several hundr=
ed MB
> > without any good reason.
> >
> > Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
> > ---
> >  builtin-cat-file.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> > index bd343ef..f966dcb 100644
> > --- a/builtin-cat-file.c
> > +++ b/builtin-cat-file.c
> > @@ -183,6 +183,7 @@ static int batch_one_object(const char *obj_nam=
e, int print_contents)
> >  		fflush(stdout);
> >  	}
> > =20
> > +	free(contents);
> >  	return 0;
> >  }
>=20
> Thanks, except that it should go inside the "if (print_contents =3D=3D=
 BATCH)"
> block to avoid freeing an uninitialized pointer.

Ah crap, I even wondered about the kill-a-warning initialization of
"contents", but my brain was already asleep.

Thanks,
Bj=F6rn

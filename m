From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: git push --no-mirror ?
Date: Tue, 9 Mar 2010 13:04:28 +0100
Message-ID: <20100309120428.GE4748@neumann>
References: <20100308123423.GA20486@neumann>
	<7vzl2ipmhn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:43:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyYQ-0001Do-Q6
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab0CIMEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 07:04:35 -0500
Received: from francis.fzi.de ([141.21.7.5]:56788 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751070Ab0CIMEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 07:04:34 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Mar 2010 13:04:28 +0100
Content-Disposition: inline
In-Reply-To: <7vzl2ipmhn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 09 Mar 2010 12:04:28.0571 (UTC) FILETIME=[AB64CEB0:01CABF80]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141821>

Hi,


On Mon, Mar 08, 2010 at 12:49:40PM -0800, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > I have a remote that I use mainly for backup with 'mirror =3D true'=
 in
> > gitconfig, but also for sharing my "bleeding-edge" code with a
> > student.  Now I came across the situation where I would liked to pu=
sh
> > only a single branch to that repo, only to discover that 'git push'
> > has no '--no-mirror' option to override the related configuration
> > setting.  Removing the 'mirror =3D true' line from the config, doin=
g the
> > push, restoring the config did the trick, of course, but I think th=
ere
> > should be a simpler way to do that.  Is there a fundamental reason =
why
> > there is no 'push --no-mirror', or just noone has noticed/bothered
> > before?
>=20
> I think that is the case.  How does this look (haven't thought it thr=
ough
> nor even compile tested yet)?
>=20
>  builtin-push.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/builtin-push.c b/builtin-push.c
> index f7bc2b2..89df1ff 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -145,7 +145,7 @@ static int do_push(const char *repo, int flags)
>  		die("No destination configured to push to.");
>  	}
> =20
> -	if (remote->mirror)
> +	if (!refspec && remote->mirror)
>  		flags |=3D (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
> =20
>  	if ((flags & TRANSPORT_PUSH_ALL) && refspec) {

thanks, this DWIMery seems to work just fine (i.e. solves my problem
and does not break any tests in the test suite).


Best,
G=E1bor

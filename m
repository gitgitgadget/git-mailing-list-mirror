From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH v2] git-svn: avoid filling up the disk with temp files.
Date: Sun, 29 Jun 2008 04:24:00 +0200
Message-ID: <20080629022400.GA12112@atjola.homenet>
References: <1214686673-28099-1-git-send-email-apenwarr@gmail.com> <1214696036-8294-1-git-send-email-apenwarr@gmail.com> <20080629005858.GA2036@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Adam Roben <aroben@apple.com>,
	Samuel Bronson <naesten@gmail.com>, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 04:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCmbA-0003zm-Ea
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 04:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbYF2CYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jun 2008 22:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbYF2CYG
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 22:24:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:57413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752792AbYF2CYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 22:24:05 -0400
Received: (qmail invoked by alias); 29 Jun 2008 02:24:02 -0000
Received: from i577BB248.versanet.de (EHLO atjola.local) [87.123.178.72]
  by mail.gmx.net (mp060) with SMTP; 29 Jun 2008 04:24:02 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/vVxYriejvu5YUNTmSL40kK7c17/tKSAZXcuEXTC
	nGPtNacmiJraI/
Content-Disposition: inline
In-Reply-To: <20080629005858.GA2036@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86754>

On 2008.06.29 02:58:58 +0200, Bj=F6rn Steinbrink wrote:
> On 2008.06.28 19:33:56 -0400, Avery Pennarun wrote:
> > Commit ffe256f9bac8a40ff751a9341a5869d98f72c285 ("git-svn: Speed up=
 fetch")
> > introduced changes that create a temporary file for each object fet=
ched by
> > svn.  These files should be deleted automatically, but perl apparen=
tly
> > doesn't do this until the process exits (or perhaps when its garbag=
e
> > collector runs).
> >=20
> > This means that on a large fetch, especially with lots of branches,=
 we
> > sometimes fill up /tmp completely, which prevents the next temp fil=
e from
> > being written completely.  This is aggravated by the fact that a ne=
w temp
> > file is created for each updated file, even if that update produces=
 a file
> > identical to one already in git.  Thus, it can happen even if there=
's lots
> > of disk space to store the finished repository.
> >=20
> > We weren't adequately checking for write errors, so this would resu=
lt in an
> > invalid file getting committed, which caused git-svn to fail later =
with an
> > invalid checksum.
> >=20
> > This patch adds a check to syswrite() so similar problems don't lea=
d to
> > corruption in the future.  It also unlink()'s each temp file explic=
itly
> > when we're done with it, so the disk doesn't need to fill up.
>=20
> I'm running another import of the coq repo that failed earlier, just =
to
> make sure, ...

Import completed successfully, so:

Tested-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>

Thanks,
Bj=F6rn

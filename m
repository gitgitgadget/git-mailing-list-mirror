From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-stash: use git rev-parse -q
Date: Mon, 8 Dec 2008 00:17:23 +0100
Message-ID: <20081207231723.GA5068@atjola.homenet>
References: <1228179369-3766-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 00:18:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9Sti-0004qb-O6
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 00:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbYLGXR2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2008 18:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbYLGXR2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 18:17:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:59842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752819AbYLGXR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 18:17:27 -0500
Received: (qmail invoked by alias); 07 Dec 2008 23:17:25 -0000
Received: from i577BAE33.versanet.de (EHLO atjola.local) [87.123.174.51]
  by mail.gmx.net (mp066) with SMTP; 08 Dec 2008 00:17:25 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19egm496B5e9tn8qFmB1DtQCRwKRnjer4b6mom2EE
	xXE55OBw1BARj2
Content-Disposition: inline
In-Reply-To: <1228179369-3766-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102511>

On 2008.12.02 01:56:09 +0100, Miklos Vajna wrote:
> Don't redirect stderr to /dev/null, use -q to suppress the output on
> stderr.
>=20
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> =20
>  	# clear_stash if we just dropped the last stash entry
> -	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_s=
tash
> +	git rev-parse -q --verify "$ref_stash@{0}" > /dev/null || clear_sta=
sh

This one causes an error message to pop up when the last stash entry is
dropped:

doener@atjola:git (master) $ echo 123 >> Makefile

doener@atjola:git (master) $ git stash
Saved working directory and index state "WIP on master: 2dd6202...
Update draft release notes to 1.6.1"
HEAD is now at 2dd6202 Update draft release notes to 1.6.1
(To restore them type "git stash apply")

doener@atjola:git (master) $ git stash drop
Dropped refs/stash@{0} (e692e43ce03fe0b5f0eb94123123ea61a0f2097a)
fatal: Log .git/logs/refs/stash is empty.

git version 1.6.1.rc1.56.g2dd62

After "git stash drop" finished the rev-parse won't complain anymore,
even if you recreate an empty .git/logs/refs/stash file, because
=2Egit/refs/stash is also gone, and then it doesn't seem to care anymor=
e.

But having a valid ref and an empty log makes it unhappy:

doener@atjola:git (master) $ git rev-parse HEAD > .git/refs/stash
doener@atjola:git (master) $ : > .git/logs/refs/stash
doener@atjola:git (master) $ git rev-parse -q --verify 'refs/stash@{1}'
fatal: Log .git/logs/refs/stash is empty.

Bj=F6rn

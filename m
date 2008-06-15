From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Sun, 15 Jun 2008 05:00:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806150457180.6439@racer>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer>
 <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
 <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
 <alpine.DEB.1.00.0806132239490.6439@racer> <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <200806142359.m5ENxsBL028758@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1579785999-1213502456=:6439"
Cc: Wincent Colaiuta <win@wincent.com>, Eric Raible <raible@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 06:03:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7jSi-0003pF-Qe
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 06:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbYFOECe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 00:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbYFOECe
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 00:02:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:45898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750707AbYFOECd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 00:02:33 -0400
Received: (qmail invoked by alias); 15 Jun 2008 04:02:29 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 15 Jun 2008 06:02:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AST5/+HNA1SNpn19eWWFhopeyyzV9hChMvj424K
	juiHAukNopirXQ
X-X-Sender: gene099@racer
In-Reply-To: <200806142359.m5ENxsBL028758@mi0.bluebottle.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85060>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1579785999-1213502456=:6439
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 15 Jun 2008, しらいしななこ wrote:

> The following is a trial patch to change how a stash is recorded.
> With this patch I do not think we will keep unnecessary commits
> behind H in the repository even when a stash is kept forever.
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index 4938ade..f4c4236 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -54,6 +54,9 @@ create_stash () {
>  	fi
>  	msg=$(printf '%s: %s' "$branch" "$head")
>  
> +	# create the base commit that is parentless
> +	b_commit=$(printf 'base of %s\n' "$msg" | git commit-tree "HEAD:")
> +

I think that this does not help the case of Wincent (which I do not agree 
with), as it does not prevent the stashes from expiring.

What your patch does, however, might be something people need to prevent 
unnecessary bloat of the object database, if they choose never to expire 
stashes.

However, it makes it harder to see where the stashed revision came from.

Besides, I think that your printf would look nicer as

	b_commit=$(echo "base of $msg" | git commit-tree HEAD^{tree})

Ciao,
Dscho

--8323329-1579785999-1213502456=:6439--

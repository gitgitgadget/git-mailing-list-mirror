From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] fatal error during merge
Date: Mon, 11 May 2009 01:10:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905110106370.27348@pacific.mpi-cbg.de>
References: <20090510163336.GA27241@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 01:10:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3IAA-0000aH-Ts
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 01:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZEJXKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 19:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbZEJXKX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 19:10:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:49484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751013AbZEJXKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 19:10:22 -0400
Received: (qmail invoked by alias); 10 May 2009 23:10:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 11 May 2009 01:10:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NMYd/IIbNORGr3Hwn6jg6mWJ6rYY8+M89cc4hvJ
	+Li5rBkGVTzn6U
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090510163336.GA27241@blimp.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118759>

Hi,

On Sun, 10 May 2009, Alex Riesen wrote:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index a3721ef..d5c43d1 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -980,14 +980,15 @@ static int process_renames(struct merge_options *o,
>  
>  				if (mfi.clean &&
>  				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
> -				    mfi.mode == ren1->pair->two->mode)
> +				    mfi.mode == ren1->pair->two->mode) {
>  					/*
>  					 * This messaged is part of
>  					 * t6022 test. If you change
>  					 * it update the test too.
>  					 */
>  					output(o, 3, "Skipped %s (merged same as existing)", ren1_dst);
> -				else {
> +					add_cacheinfo(mfi.mode, mfi.sha, ren1_dst, 0, 0, ADD_CACHE_OK_TO_ADD);
> +				} else {
>  					if (mfi.merge || !mfi.clean)

If I read the message right, the file revision is supposed not to be 
changed from HEAD.  Is unpack_trees() invalidating the "cleanness" of that 
file?  (I would really love to have a better idea what's going on than 
what I get from both the commit message and the patch before giving my 
ACK.)

Ciao,
Dscho

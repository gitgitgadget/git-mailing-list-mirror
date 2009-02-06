From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when file is open
Date: Fri, 6 Feb 2009 12:26:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902061221150.7377@intel-tinevez-2-302>
References: <cover.1233751281.git.barvik@broadpark.no> <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no> <49899FA4.2020003@viscovery.net> <7vfxiut57t.fsf@gitster.siamese.dyndns.org> <86tz7ayo51.fsf_-_@broadpark.no>
 <498A9FD3.2020601@viscovery.net> <alpine.DEB.1.00.0902051202440.7491@intel-tinevez-2-302> <868wojq0xa.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:27:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOs0-0000AO-DK
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbZBFL0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbZBFL0N
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:26:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:56187 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751245AbZBFL0M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:26:12 -0500
Received: (qmail invoked by alias); 06 Feb 2009 11:26:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp025) with SMTP; 06 Feb 2009 12:26:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19j1yF12c9jWzoTy2wJFrYw1regIx2p+GNLALyRKW
	Rw00o2k34JCPLC
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <868wojq0xa.fsf@broadpark.no>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108688>

Hi,

On Fri, 6 Feb 2009, Kjetil Barvik wrote:

> * Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> | Of course, what we _really_ would do is to provide a flag, say, 
> | FSTAT_UNRELIABLE and test for _that_ (after defining it in the Makefile 
> | for the appropriate platforms).
> 
>   Or, maybe
> 
>      #define FSTAT_RELIABLE 1
> 
>   for Linux only?

No, I think that would be wrong.  Especially after Junio's remarks that 
fstat() is actually required to behave as you expected it, and only 
Windows (surprise, surprise) has problems following the standard.

> Then we can change the if-test inside this patch to the following:
> 
> -  if (state->refresh_cache && !to_tempfile && !state->base_dir_len) {
> +  if (state->refresh_cache && !to_tempfile && !state->base_dir_len && 
> +      FSTAT_RELIABLE) {
> 
>   Then we do not have to have #if-defines inside the source code, only
>   in one header file.

In the spirit of consistency, I would not do that.

>   But, question: is this patch worth the extra lines added to the source
>   code?

You seemed to get a nice speedup on Linux.  If Windows cannot follow suit, 
too bad.  But I do not want to be punished because other people's OS is 
not as good as mine, so I _want_ fstat().

And those few lines will not hurt, they'll be readable enough.

Ciao,
Dscho

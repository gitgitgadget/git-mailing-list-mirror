From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Wed, 14 Nov 2007 21:47:32 +0100
Message-ID: <20071114204732.GE3973@steel.home>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:48:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsP9M-00018g-SW
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbXKNUrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 15:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbXKNUrg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:47:36 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:36059 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbXKNUrf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 15:47:35 -0500
Received: from tigra.home (Fad5d.f.strato-dslnet.de [195.4.173.93])
	by post.webmailer.de (fruni mo58) (RZmta 14.0)
	with ESMTP id p02252jAEGhEsp ; Wed, 14 Nov 2007 21:47:33 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A8F04277AE;
	Wed, 14 Nov 2007 21:47:32 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 762D256D22; Wed, 14 Nov 2007 21:47:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyCll4dQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65014>

Guido Ostkamp, Wed, Nov 14, 2007 21:31:13 +0100:
> Hello,
>
> please find below a patch that solves an error when compiling with the 
> original Sun Solaris Compiler. When compiling out of the box, the following 
> happens:
>
>     CC diff-delta.o
> "diff-delta.c", line 314: identifier redeclared: create_delta
> 	current : function(pointer to const struct delta_index {unsigned long 
> memsize, pointer to const void src_buf, unsigned long src_size, unsigned 
> int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, 
> pointer to const void, unsigned long, pointer to unsigned long, unsigned 
> long) returning pointer to void
> 	previous: function(pointer to const struct delta_index {unsigned long 
> memsize, pointer to const void src_buf, unsigned long src_size, unsigned 
> int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, 
> pointer to const void, unsigned long, pointer to unsigned long, unsigned 
> long) returning pointer to void : "delta.h", line 44

The both prototypes listed are *exactly* the same. And both are wrong.
Looks like you're dealing with typically broken Sun compiler.

Try defining const to nothing or removing it from this prototype.
I suspect the thing is just so old and broken that it does not even
know anything of const.

> cc: acomp failed for diff-delta.c
> make: *** [diff-delta.o] Error 2
>
> This is because 'struct delta_index' is declared with no size in delta.h 
> and with size in diff-delta.c which does not fit.

Huh?! Ever heard of forward declaration?

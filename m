From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use configurable zlib compression level everywhere.
Date: Sat, 8 Jul 2006 04:10:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607080406370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <loom.20060703T124601-969@post.gmane.org><81b0412b0607030503p63b
 4ee31v7776bd155d3dab29@mail.gmail.com><44A91C7A.6090902@fys.uio.no><Pine.LN
 X.4.64.0607031030150.1213@localhost.localdomain><Pine.LNX.4.64.060703092949
 0.12404@g5.osdl.org><8564ie8qbe.fsf_-_@lupus.ig3.net>
 <7v4pxyscdt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607071451430.1836@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Joachim B Haga <cjhaga@fys.uio.no>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 04:11:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz2HY-00073E-CK
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 04:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWGHCKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 22:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWGHCKs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 22:10:48 -0400
Received: from mail.gmx.de ([213.165.64.21]:14291 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932479AbWGHCKs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 22:10:48 -0400
Received: (qmail invoked by alias); 08 Jul 2006 02:10:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 08 Jul 2006 04:10:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.63.0607071451430.1836@qynat.qvtvafvgr.pbz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23473>

Hi,

On Fri, 7 Jul 2006, David Lang wrote:

> On Mon, 3 Jul 2006, Junio C Hamano wrote:
> 
> > * sha1write_compressed() in csum-file.c is for producing packs
> >   and most of the things we compress there are deltas and less
> >   compressible, so even when core.compression is set to high we
> >   might be better off using faster compression.
> 
> why would deltas have poor compression? I'd expect them to have about the same
> as the files they are deltas of (or slightly better due to the fact that the
> deta metainfo is highly repetitive)

Deltas should have poor compression by definition, because compression 
tries to encode those parts of the file more efficiently, which do not 
bear much information (think entropy).

If you have deltas which really make sense, they are almost _pure_ 
information, i.e. they do not contain much redundancy, as compared to real 
files. So, the compression (which does not know anything about the 
characteristics of deltas in particular) cannot take much redundancy out 
of the delta. Therefore, the entropy is very high, and the compression 
rate is low.

Hope this makes sense to you,
Dscho

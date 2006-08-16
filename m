From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] git-mv: succeed even if source is a prefix of destination
Date: Wed, 16 Aug 2006 07:49:44 +0200
Message-ID: <20060816054944.GA5218@c165.ib.student.liu.se>
References: <20060815205150.GA467@c165.ib.student.liu.se> <Pine.LNX.4.63.0608151401510.3965@chino.corp.google.com> <Pine.LNX.4.63.0608160209150.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rientjes <rientjes@google.com>,
	Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 07:49:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDEHq-0006pY-E8
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 07:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWHPFtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 01:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWHPFtq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 01:49:46 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:6132 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750748AbWHPFtq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 01:49:46 -0400
Received: from c165 ([213.114.27.99] [213.114.27.99])
          by mxfep02.bredband.com with ESMTP
          id <20060816054944.STOG11843.mxfep02.bredband.com@c165>;
          Wed, 16 Aug 2006 07:49:44 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GDEHg-0001wS-00; Wed, 16 Aug 2006 07:49:44 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608160209150.28360@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25497>

On Wed, Aug 16, 2006 at 02:20:32AM +0200, Johannes Schindelin wrote:
> 
> As noted by Fredrik Kuivinen, without this patch, git-mv fails on
> 
> 	git-mv README README-renamed
> 
> because "README" is a prefix of "README-renamed".
> 

Thank you. 'git-mv README README-renamed' works for me too now.

However, there still seems to be some minor problem with git-mv.

    $ git mv t t
    fatal: renaming t failed: Invalid argument
    $ git mv t t/
    fatal: renaming t failed: Invalid argument
    $ git mv t/ t/
    fatal: cannot move directory over file, source=t/, destination=t/
    $ git mv t/ t 
    fatal: cannot move directory over file, source=t/, destination=t/

I kind of expected to get 'can not move directory into itself' in all
of those cases. At least the same error messages should be given in
all cases.

It looks like we need some kind of path normalization before we do
those tests.

- Fredrik

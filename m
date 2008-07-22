From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix update-index --refresh for submodules if stat(2)
	returns st_size 0
Date: Tue, 22 Jul 2008 18:46:04 +0200
Message-ID: <20080722164604.GA3766@blimp.local>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:52:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLL5X-00032o-52
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 18:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbYGVQuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYGVQuk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:50:40 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:24183 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYGVQuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:50:39 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jepV
Received: from tigra.home (Fa955.f.strato-dslnet.de [195.4.169.85])
	by post.webmailer.de (fruni mo3) (RZmta 16.47)
	with ESMTP id g02554k6MEjfNM ; Tue, 22 Jul 2008 18:50:32 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id EB09D277BD;
	Tue, 22 Jul 2008 18:50:31 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 8C9F136D18; Tue, 22 Jul 2008 18:46:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4885897C.8010401@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89499>

Johannes Sixt, Tue, Jul 22, 2008 09:17:16 +0200:
> Alex Riesen schrieb:
> > Can MSys folks please try it? I noticed it when the test
> > t2103-update-index-ignore-missing.sh (the 5th case) started failing.
> 
> I tested it. mingw.git does suffer from the problem, and this fixes it.
> 

Yes, I did too (at work).

> > +	if ((changed & DATA_CHANGED) && (ce->ce_size != 0 || S_ISGITLINK(ce->ce_mode)))
> 
> Does this mean that ce->ce_size is non-zero for gitlinks, at least on
> Unix?

It is non-zero for directories (which is what gitlinks are in working
directories) on UNIX operating systems I met.

> Is this value useful in anyway?

Sometimes it is (the size a directory takes on storage)

> I don't think so. Then it shouldn't be a random value that lstat()
> happens to return.

The problem is: it is not random. I even suspect that Windows is the
ONLY system which has st_size 0 for directories.

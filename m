From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] xdl_merge(): fix a segmentation fault when refining conflicts
Date: Tue, 2 Jan 2007 14:18:47 +0100
Message-ID: <200701021418.48624.jnareb@gmail.com>
References: <20061227041644.GA22449@spearce.org> <en6fj1$ji5$1@sea.gmane.org> <Pine.LNX.4.63.0612310208460.25709@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 14:16:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1jUf-00073I-BL
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 14:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbXABNPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 08:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbXABNPu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 08:15:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:16290 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964897AbXABNPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 08:15:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4895102uga
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 05:15:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HKogL4yp2adbiP4H4NaCq8M35/GBZ8+XTFhpcU2E1H+xtqTXtDOcxMO6NQsKRpKvXSl3o6h9Dck+fFnKhs+xFcr9pDMPEJZU7WU/zBb8Lfuw8nrDc2n+loWy3Sly6vnIMpSuFJOdN7I24htEHSjFAx9ChFGIBuAWeNbPIjIIa7c=
Received: by 10.67.97.7 with SMTP id z7mr13902128ugl.1167743746975;
        Tue, 02 Jan 2007 05:15:46 -0800 (PST)
Received: from host-81-190-20-195.torun.mm.pl ( [81.190.20.195])
        by mx.google.com with ESMTP id e33sm12854049ugd.2007.01.02.05.15.46;
        Tue, 02 Jan 2007 05:15:46 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612310208460.25709@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35786>

On Sun, 31 Dec 2006, Johannes Schindelin wrote:

> On Sat, 30 Dec 2006, Jakub Narebski wrote:
> 
>> Johannes Schindelin wrote:
>> 
>>> Of course, you can hit mismerges like the illustrated one _without_ 
>>> being marked as conflict (e.g. if the chunk of identical code is _not_ 
>>> added, but only the increments), but we should at least avoid them 
>>> where possible.
>> 
>> Perhaps you could make it even more conservating merge conflicts option 
>> (to tighten merge conflicts even more) to xdl_merge, but not used by 
>> default because as it removes accidental conflicts it increases 
>> mismerges (falsely not conflicted).
> 
> There is no way to do this sanely. If you want to catch these mismerges, 
> you have to mark _all_ modifications as conflicting.

Currently you have:
 - a level value of 0 means that all overlapping changes are treated
   as conflicts,
 - a value of 1 means that if the overlapping changes are identical,
   it is not treated as a conflict.
 - If you set level to 2, overlapping changes will be analyzed, so that
   almost identical changes will not result in huge conflicts. Rather,
   only the conflicting lines will be shown inside conflict markers.

I was thinking about:
 - If you set level to 3, if one part after overlapping changes analysis
   in level 2 has empty conflict region, resolve this conflict as second
   side. WARNING: this reduces number of merge conflicts, but might give
   mismerges!

Or something like that.
-- 
Jakub Narebski
Poland

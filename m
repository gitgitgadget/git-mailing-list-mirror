From: Michael Smith <msmith@cbnco.com>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Tue, 13 Nov 2007 16:37:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711131617580.4038@juice.ott.cti.com>
References: <11949569992214-git-send-email-msmith@cbnco.com>
 <7vtznqrlrb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:38:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3SG-0002o3-Jk
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbXKMVhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbXKMVhg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:37:36 -0500
Received: from smtp.cbnco.com ([207.164.182.72]:35853 "EHLO smtp.cbnco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763440AbXKMVhe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:37:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.cbnco.com (Postfix) with ESMTP id 1775B21474D;
	Tue, 13 Nov 2007 16:37:33 -0500 (EST)
Received: from smtp.cbnco.com ([127.0.0.1])
 by localhost (mail.cbnco.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28732-03; Tue, 13 Nov 2007 16:37:33 -0500 (EST)
Received: from juice.ott.cti.com (auriga-dmzgw.cbnco.com [207.164.182.65])
	by smtp.cbnco.com (Postfix) with ESMTP id ED6C9212BED;
	Tue, 13 Nov 2007 16:37:32 -0500 (EST)
X-X-Sender: michael@juice.ott.cti.com
In-Reply-To: <7vtznqrlrb.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: amavisd-new at cbnco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64875>

On Tue, 13 Nov 2007, Junio C Hamano wrote:

> > +$ git checkout master
> > +$ git merge --strategy=ours \
> > +    -m "Tie old v1.1 into our history by merging with strategy=ours." \
> > +    v1.1

> This would work only when your 'master' happens to be at v1.1
> (and identical to it) isn't it?
> 
> People would want to know "But my 'master' is _not_ at v1.1 but
> is _based_ on v1.1.  How would I handle that case?"

That was actually my case - my master was based on v1.1. The command 
worked for me - I was able to merge in v1.2 from Git afterward - but maybe 
I just got lucky, so I'd be interested to know the right thing to do.

I think --strategy=ours just leaves the files as is on master and creates 
a merge commit with two parents: master and v1.1. So anything between v1.1 
and v1.2, on the upstream branch, is fair game to be merged next time.

So, say I started with this:

---------------
old snapshot branch: snap-v1.0---snap-v1.1
                       \           \
master:                 o---o---o---o--o-o

new Git upstream: o--o-v1.0-o-o-o-o-o-o-v1.1-o-o-v1.2
---------------

I could make the merge with --strategy=ours:
---------------
old snapshot branch: snap-v1.0---snap-v1.1
                       \           \
master:                 o---o---o---o--o-o--o
                                           /
new Git upstream: o--o-v1.0-o-o-o-o-o-o-v1.1-o-o-v1.2
---------------


Then I'd free to merge in v1.2:
---------------
master:                 o---o---o---o--o-o--o------o
                                           /      /
new Git upstream: o--o-v1.0-o-o-o-o-o-o-v1.1-o-o-v1.2
---------------

Hmm, looks like a toothbrush. But is it right?

Mike

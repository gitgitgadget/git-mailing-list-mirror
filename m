From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git no longer reads attributes from the index properly
Date: Fri, 20 Mar 2009 10:45:06 +0100
Message-ID: <49C365A2.5070607@drmicha.warpmail.net>
References: <20090320073527.GC1037@lavos.net> <7vab7gk39o.fsf@gitster.siamese.dyndns.org> <20090320084031.GD1037@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	msysgit@googlegroups.com
To: bdowning@lavos.net
X-From: git-owner@vger.kernel.org Fri Mar 20 10:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkbJn-00036E-AV
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 10:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbZCTJpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 05:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZCTJpZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 05:45:25 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35839 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751058AbZCTJpX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 05:45:23 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 687942F4D4F;
	Fri, 20 Mar 2009 05:45:21 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 20 Mar 2009 05:45:21 -0400
X-Sasl-enc: zZyPznBLKvBDdsrc6pxn11QgxJtErkLlp1dK0kqg9kTy 1237542321
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 50CB72855F;
	Fri, 20 Mar 2009 05:45:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090320 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090320084031.GD1037@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113926>

Brian Downing venit, vidit, dixit 20.03.2009 09:40:
> 
> On Fri, Mar 20, 2009 at 01:27:31AM -0700, Junio C Hamano wrote:
>> bdowning@lavos.net (Brian Downing) writes:
>>> As of 34110cd4e394e3f92c01a4709689b384c34645d8, (2008-03-06, just over a
>>> year ago), Git no longer reads attributes from the index properly in all
>>> cases....
>>
>> Perhaps you would want to try it on 06f33c1 (Read attributes from the
>> index that is being checked out, 2009-03-13) that is part of 'pu'?
> 
> I only tried it on next, groan.  Yes, it works there, thanks.
> 
> However, that commit looks like it's solving a different problem
> entirely (supporting changing between two branches where .gitattributes
> exists in both cases) and happens to fix the no .gitattributes -> read
> from index regression at the same time.  I don't know enough about the
> guts to tell, but does this also fix the core problem of the regression
> (I assume something about trying to read from the wrong index, given the
> commit that broke it), or does it just happen to work around it?
> 
> Specifically, it would be nice to have a fix for the regression that
> could land on maint relatively soon, as the initial checkout case is
> breaking a real repository I use, whereas the switching branches case is
> something I don't care about as much at the moment.
> 
> Of course, I don't know how to fix it at the moment, and beggars can't
> be choosers.  :)

You're testing whether a checkout without index and with empty work tree
works, right?

In that case, the checkout needs to make sure that .gitattributes is
checked out (or at least respected) before all other files, and that is
exactly what the patch in pu does. [If I remember right that great
simplification patch you bisected as bad played a role there, unless I'm
mixing up threads...]

Michael

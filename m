From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/2] match_refs: search ref list tail internally
Date: Thu, 28 May 2009 11:26:24 +0200
Message-ID: <20090528092624.GA8787@localhost>
References: <76718490905260727v7261391uab169167978e4522@mail.gmail.com> <1243455224-3463-1-git-send-email-drizzd@aon.at> <1243455224-3463-2-git-send-email-drizzd@aon.at> <7vtz35hfk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 11:26:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9bsj-00062r-Ji
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 11:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758921AbZE1J0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 05:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756306AbZE1J0X
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 05:26:23 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:46970 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186AbZE1J0W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 05:26:22 -0400
Received: from darc.dnsalias.org ([84.154.120.211]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 May 2009 11:26:23 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M9bsW-0002K8-3l; Thu, 28 May 2009 11:26:24 +0200
Content-Disposition: inline
In-Reply-To: <7vtz35hfk7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 28 May 2009 09:26:24.0014 (UTC) FILETIME=[5E6D82E0:01C9DF76]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120174>

On Thu, May 28, 2009 at 12:06:32AM -0700, Junio C Hamano wrote:
> It so happens that http-push.c never looked at remote_tail to do further
> processing on the list after match_refs() returned, and that is why your
> patch does not break http-push.c.
> 
> Any third-party patch to http-push.c
> that relied on the old guarantee will textually merge cleanly but will
> subtly break with this change.
> 
> Other parts of this patch removes the local "remote_tail" variables, and
> it is very clear that they do not have this problem; any third-parth patch
> will break if they used remote_tail after match_refs() returned, so this
> change is a safe one for them.

Yes, I tried to get rid of remote_tail entirely, but I could not come up
with a solution immediately. We could insert to the front of the list
instead. I'll try that.

> I wonder what interaction this change will have with the http-push
> clean-up Ray Chuan has been working on...

For me, t5540 currently segfaults on pu. I'm looking into it.

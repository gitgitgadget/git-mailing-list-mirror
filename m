From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 02 Jun 2008 11:13:18 -0700
Message-ID: <7vej7f7lj5.fsf@gitster.siamese.dyndns.org>
References: <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806021545340.13507@racer.site.net>
 <20080602154320.GK12896@spearce.org>
 <alpine.DEB.1.00.0806021659480.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:14:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3EYJ-0000KZ-KI
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 20:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYFBSNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 14:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbYFBSNq
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 14:13:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbYFBSNp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 14:13:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC01D3A50;
	Mon,  2 Jun 2008 14:13:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3172C3A4F; Mon,  2 Jun 2008 14:13:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806021659480.13507@racer.site.net> (Johannes
 Schindelin's message of "Mon, 2 Jun 2008 17:14:18 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A2DA072E-30CF-11DD-BBD2-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83550>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> After sending the mail, I actually got an idea:
>
> 	.git/logs/attic/<timestamp>/<refname>
>
> I think this should work without problems.  In that case, git-gc also 
> handles the garbage collection.

I do not like that particular color of the bikeshed, but I'd agree that it
certainly is the easiest route from both the implementation and the design
point of view.  All of the "hard stuff" Shawn mentions goes away, and you 
are left with only one new "hard stuff", which is much easier to solve:

 - Should there be a way to really remove the archived reflog?

And my answer is "yes, a new subcommand to 'git-reflog' to list and
another subcommand to remove one".

As to default behaviour, probably we would by default archive any local
branches, and _not_ archive other things like remote trackers and tags.  A
new configuration variable reflog.archive = {none,heads,all} would be
honored and absense of it defaults to reflog.archive = heads.

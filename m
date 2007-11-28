From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 17:50:33 +0100
Message-ID: <20071128165033.GA31218@elte.hu>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> <7vmyszb39s.fsf@gitster.siamese.dyndns.org> <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com> <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com> <ee77f5c20711271757h724d5fcep38f3c2354c54f20b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:51:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQ84-0004Vx-15
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759799AbXK1Qu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759688AbXK1Qu5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:50:57 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:40530 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758714AbXK1Qu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:50:56 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IxQ7X-0000eI-3C
	from <mingo@elte.hu>; Wed, 28 Nov 2007 17:50:53 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 857243E2164; Wed, 28 Nov 2007 17:50:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ee77f5c20711271757h724d5fcep38f3c2354c54f20b@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66379>


* David Symonds <dsymonds@gmail.com> wrote:

> On Nov 28, 2007 12:49 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> > Rollback is too strong of name for this. Checkpoints would be better.
> > The idea is to record the total system state at convenient moments and
> > then allow moving back to the checkpointed state. The object store
> > supports this, but the rest of the state in .git/* isn't being
> > recorded.
> 
> rsync -a .git /somewhere/safe
> 
> I fear that what you ask becomes a chicken-and-egg scenario: where/how 
> is this checkpointing information going to be stored? If it's tightly 
> integrated with Git, what happens when you want to roll-back a 
> checkpoint-restore?

well, it would/could be the normal undo/redo semantics of editors: you 
can undo-redo in a linear history fashion, in an unlimited way, but the 
moment you modify any past point of history then the redo future is 
overriden. (but the 'past' up to that point is still recorded and 
available)

and this could all be driven via .git/logs - as long as all other 
metadata is imported into the object store and the root of this git tree 
would be represented in a single file. The logs are append-only as well, 
the loss of them means the loss of undo/redo information, nothing else. 
Figuring out the linear history from the logs would be computationally 
expensive, but that's not a big issue as 'undo/redo' would be a rare 
operation anyway.

But i guess i must be missing some obvious complication?

	Ingo

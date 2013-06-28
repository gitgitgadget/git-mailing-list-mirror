From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Fri, 28 Jun 2013 18:42:53 +0100
Message-ID: <20130628174252.GF2232@serenity.lan>
References: <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
 <20130628080953.GD2232@serenity.lan>
 <7vli5up2tq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 19:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uschc-0007sc-8r
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 19:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab3F1RnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 13:43:09 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:38087 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab3F1RnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 13:43:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 30943CDA5C3;
	Fri, 28 Jun 2013 18:43:07 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNI9CN8xw5hO; Fri, 28 Jun 2013 18:43:06 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 8AF61CDA560;
	Fri, 28 Jun 2013 18:43:05 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7A8E0161E1A5;
	Fri, 28 Jun 2013 18:43:05 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLRKwPX0sj91; Fri, 28 Jun 2013 18:43:03 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 45A29161E18E;
	Fri, 28 Jun 2013 18:42:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vli5up2tq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229221>

On Fri, Jun 28, 2013 at 10:22:57AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> >>  test_expect_success \
> >>      'merge-setup part 3' \
> >> -    'git pull . branch1'
> >> +    'git pull --merge . branch1'
> >
> > I think the "--merge" should be implied here because the suer has
> > specified an explicit remote and branch.
> 
> The whole point of the topic is "It used to be that when you said
> 'git pull' and did not tell us your preferred way to integrate your
> work and work by the others', we default to merging, but we no
> longer do so---you have to choose."
> 
> Here, "git pull . branch1" is merely saying "I want to integrate
> the work on my current branch with that of branch1" without saying
> how that integration wants to happen.

The change that I think is important is that the "bring my branch
up-to-date" operation should force the user to choose what to do if the
branch does not fast-forward to its upstream.  If that was spelled "git
update" then having "git pull" perform a merge would be fine, but we
spell this operation as "git pull" so the change needs to happen there.

I don't think "git pull remote branch" falls into the same category as
plain "git pull" so I'm not convinced that defaulting to merge there is
unreasonable.  The original message about this [1] did talk about only
"git pull" with no arguments.

> Even though, as an old timer, I find it mildly irritating that we
> now have to be explicit in these tests, this change is in line with
> the spirit of the topic.  If we didn't have to change this example
> and the pull silently succeeded without complaining, we achieved
> nothing.

I disagree that we would have achieved nothing.  New users will not be
using explicit arguments to git-pull when just trying to bring a branch
up-to-date.

[1] http://article.gmane.org/gmane.comp.version-control.git/225240

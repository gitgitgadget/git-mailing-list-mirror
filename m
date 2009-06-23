From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 10:59:33 -0700
Message-ID: <7vljni96gq.fsf@alter.siamese.dyndns.org>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org>
	<4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org>
	<4A40D864.8040208@gmail.com> <20090623144805.GB24974@pvv.org>
	<f865508f0906230932n4a2f2b54s1e76ab1d70d95073@mail.gmail.com>
	<7vprcu96td.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org, Finn Arne Gangstad <finnag@pvv.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJAHW-0007VJ-Tv
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 19:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbZFWR7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 13:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZFWR7c
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 13:59:32 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41426 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbZFWR7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 13:59:31 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090623175935.GIIL20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Tue, 23 Jun 2009 13:59:35 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 7VzZ1c00b4aMwMQ04VzZBn; Tue, 23 Jun 2009 13:59:33 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ybZZDoGAAAAA:8 a=EiHZbgFeaRtGog0RfQIA:9
 a=u2VVTE7JzQ9umZsFbSUA:7 a=KlFwoi0UMjkeQXL3-gsLOodSVyIA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7vprcu96td.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 23 Jun 2009 10\:51\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122107>

Junio C Hamano <gitster@pobox.com> writes:

> One glitch I can think of is what would happen if you do not want to merge
> your feature for final testing to master, but instead rebase your feature
> on top of master (let's not discuss why you should or should not rebase at
> this point; some projects seem to insist you rebase and there may be no
> good technical reason but that is not the topic here).  There currently is
> no easy UI other than:
>
>       $ git checkout master
>       $ git pull --rebase . feature
>       $ test test test
>       $ git push origin master
> ...
> to tell git to integrate your local work done in 'feature' to 'master' by
> rebasing, instead of merging.

Sorry, but I screwed up.  The above rebases 'master', so it does not do
what we want to do.  The only way I can think of is:

> or even worse:
>
>       $ git checkout feature
>       $ git rebase master
>       $ git checkout master
>       $ git merge feature
>       $ test test test
>       $ git push origin master

which is too much typing.  That makes my suspicion that the conclusion of
my previous message is correct even stronger.

> Could it be possible that this desire to push "tracking" is not a cure for
> anything real, but merely a kludge to work around a misfeature of "rebase"
> UI that does not allow "integrate that branch here but do not merge it but
> by first rebasing it"?  In other words, if we had "git merge --rebase" (I
> know, I know, it is a terrible name.  The word "merge" in this context
> means "to integrate"), the above can be done more naturally:
>
>       $ git checkout master
>       $ git merge --rebase feature
>       $ test test test
>       $ git push origin master
>
> and the matching push (or "git push origin HEAD") becomes the right thing
> to do, eliminating the need for "put my 'feature' into their 'master'".
>
> For a group that sets up a shared public branch to be used for working
> together on some feature, replace 'master' with 'some feature' above, and
> 'feature' with 'your part of the work on the feature'; the story is the
> same.

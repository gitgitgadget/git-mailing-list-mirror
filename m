From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 06 Apr 2009 22:49:54 +0200
Message-ID: <vpqiqlh1p8t.fsf@bauges.imag.fr>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	<200904052358.53028.markus.heidelberg@web.de>
	<94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
	<200904060117.24810.markus.heidelberg@web.de>
	<fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
	<20090406032457.GA14758@gmail.com>
	<7v63hie4yh.fsf@gitster.siamese.dyndns.org>
	<871vs5kjfw.fsf@krank.kagedal.org>
	<7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 22:54:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqvps-0008V1-HO
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 22:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbZDFUw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 16:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbZDFUw4
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 16:52:56 -0400
Received: from imag.imag.fr ([129.88.30.1]:36831 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbZDFUwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 16:52:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n36KnvDu017803
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Apr 2009 22:49:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LqvlS-0001vG-74; Mon, 06 Apr 2009 22:49:54 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LqvlS-0000LK-4o; Mon, 06 Apr 2009 22:49:54 +0200
In-Reply-To: <7vy6ud4otd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 06 Apr 2009 11\:30\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 06 Apr 2009 22:49:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115880>

Junio C Hamano <gitster@pobox.com> writes:

>  - there are three distinct kinds of states: a committed state, the state
>    in the index (aka "what you have staged so far to the index"), and the
>    state in your work tree.
>
>  - many commands understand that you want to operate on and/or inspect
>    states in one or more of these states.  They default to what is often
>    used (e.g. "git diff" compares the index and the work tree, "git grep"
>    looks in the work tree, "git apply" patches the work tree [*1*]), but
>    you can tell them to use different entities via options and arguments.
>
> How does it help understanding any of the above to introduce STAGE?

For the first, if there are three kinds of states, I would find it
natural to have three kinds of ways to talk about these states.

Sure, it doesn't change the second, since it makes things more
explicit, it doesn't make them more concise.

>    - when you want to work with the index, you say --cached;

But that doesn't apply to "git diff". Both "git diff" and "git diff
--cached" work with the index. "git diff" works with the index and work
tree, while "git diff --cached" work with the index and HEAD.

>    - when you want to work with both the index and the work tree at the
>      same time, you say --index.

... which is everything but intuitive. The option name doesn't tell
the user what the command is doing. First thing is that with Git, the
user has to learn 3 words for one concept (index, cache, staging
area). And then, he has to learn that although people use "index" and
"cache" as synomyms, --index and --cached have different meanings.
And that one can also have a --cache, and that it's possible to have a
--stage too, but with different meaning.

I can understand the historical reasons, but I think finding a way to
get rid of this historical terminology mess should be encourraged.

>    - for all commands, working with work tree is the default, so there is
>      no --work-tree option (we could add one, if you really want).

Except "git checkout", which takes the index by default, and
a commit if specified. It makes sense since checking-out from the
working tree doesn't make sense, but it is a special case, and
learning the general rules you give doesn't tell the user what "git
checkout" does.

Except "git ls-files", too. And I may have missed some.

See, you complain about special cases with the proposal, but the
current UI _has_ tons of special cases like this.

> and the STAGE would work something like this:
>
>    - when you want to work with a committed state (or more in general,
>      with a tree-ish), you give the name of the commit;

It's not just "I want to work with". It's also about the role of the
things you want to work with.

"git diff WORKTREE STAGE" would mean "diff from the worktree to the
staging area", while "git diff STAGE WORKTREE" would mean the other
way around.

> Think.  What does "git log STAGE" mean?  Can you explain why it does not
> make any sense?

It could make sense. Actually, gitk does show the work-tree and the
index in a way similar to commits. Fundamentally, I don't see a
difference between "git log" and "gitk" except that gitk is graphical.

Sure, STAGE and WORKTREE cannot have a commit message, and hardly have
an author, but I could very well imagine "git log --stat WORKTREE"
showing roughly what "git diff --stat; git diff --stat --cached; git
log --stat HEAD" does today. I don't know how usefull this would be,
but I wouldn't say it doesn't make sense either.

-- 
Matthieu

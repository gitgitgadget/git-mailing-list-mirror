From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [PATCH 3/7] Documentation: rework SHA1 description in git push
Date: Sun, 02 Nov 2008 21:13:21 +0100
Message-ID: <873ai9opi6.fsf@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
	<1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
	<1225311945-17100-3-git-send-email-mail@cup.kalibalik.dk>
	<1225311945-17100-4-git-send-email-mail@cup.kalibalik.dk>
	<7v1vxxba2c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 21:14:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwjLK-0001Tr-VO
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 21:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYKBUNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 15:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbYKBUNY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 15:13:24 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:38651 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbYKBUNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 15:13:23 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 077E714062;
	Sun,  2 Nov 2008 21:13:24 +0100 (CET)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id D857C1405A;
	Sun,  2 Nov 2008 21:13:23 +0100 (CET)
In-Reply-To: <7v1vxxba2c.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 30 Oct 2008 22\:36\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99872>

Junio C Hamano <gitster@pobox.com> writes:

> Anders Melchiorsen <mail@cup.kalibalik.dk> writes:
>
>> Get rid of a double pair of parentheses. The arbitrary SHA1 is a
>> special case, so it can be postponed a bit.
>
> Hmmm...
>
> Strictly speaking, arbitrary SHA-1 is the general case, and branch name is
> a special case of it, but in practice, branch name is the most frequently
> used form, and that is why it has the short-hand convention that allows it
> to to be pushed to the same name.

Right, that was poor wording. When I said "special case", I meant it
as "rare use case".


>> Also mention HEAD, which is possibly the most useful SHA1 in this
>> situation.
>
> HEAD is indeed useful, but it falls into the special case of "branch
> name", not "arbitrary SHA-1 expression".  This distinction is important
> because you can push "HEAD" without colon and it will act as if you said
> master:master (or whatever branch you are currently on).  This is already
> described in the existing doc:
>
>     The local ref that matches <src> is used
>     to fast forward the remote ref that matches <dst> (or, if no <dst> was
>     specified, the same ref that <src> referred to locally).

Oh, I did (obviously) not realize that you can use HEAD in that way,
and actually I cannot read that from the quoted paragraph even now
that I know about it.

It seems to me that HEAD is a special-special case, and that it is not
even mentioned in the current documentation. With my current
understanding, I would say that HEAD can work both as a "branch name"
(that discovers its own name automatically) and as an "arbitrary
SHA-1" (with a detached head).


>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -38,9 +38,7 @@ OPTIONS
>>  	by the source ref, followed by a colon `:`, followed by
>>  	the destination ref.
>>  +
>> -The <src> side represents the source branch (or arbitrary
>> -"SHA1 expression", such as `master~4` (four parents before the
>> -tip of `master` branch); see linkgit:git-rev-parse[1]) that you
>> +The <src> side represents the source branch that you
>>  want to push.  The <dst> side represents the destination location.
>
> The <src> is often the name of the branch you would want to push, but it
> can be any arbitrary "SHA-1 expression", such as `master~4` (four parents
> before the tip of `master` branch -- see linkgit:git-rev-parse[1]), or
> `HEAD` (the tip of the current branch).  The <dst> tells which ref on the
> remote side is updated with this push.
>
> The object referenced by <src> is used to fast forward the ref <dst> on
> the remote side.  You can omit <dst> to update the same ref on the remote
> side as <src> (<src> is often the name of a branch you push, and often you
> push to the same branch on the remote side; `git push HEAD` is a handy way
> to push only the current branch to the remote side under the same name).
> If the optional leading plus `{plus}` is used, the remote ref is updated
> even if it does not result in a fast forward update.

I find those paragraphs hard to read. The shorter sentences and lack
of parentheses in my patch series was more to my taste. I actually
think that the examples, like explaining master~4, detracts from the
main topic and makes it harder to find the information.



>> @@ -193,6 +195,10 @@ git push origin master::
>>  	with it.  If `master` did not exist remotely, it would be
>>  	created.
>>  
>> +git push origin HEAD:master::
>> +	Push the current head to the remote ref matching `master` in
>> +	the `origin` repository.
>> +
>
> Additional example is good, but you would want to tell readers that this
> would be useful when your current branch is _not_ 'master'.

Right.



Cheers,
Anders.

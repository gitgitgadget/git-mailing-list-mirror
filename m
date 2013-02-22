From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: allow users to silence Git 2.0 warnings about "add
 -u"
Date: Fri, 22 Feb 2013 09:30:24 -0800
Message-ID: <7v621ks1cf.fsf@alter.siamese.dyndns.org>
References: <1361513224-34550-1-git-send-email-davvid@gmail.com>
 <7vtxp4sw8e.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4dCJ3p9QBGr09kW4_0BsVJcpE7s83=eNxKE15pMznWCw@mail.gmail.com>
 <vpqd2vssnh7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:31:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8wSU-0004e2-6G
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 18:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758171Ab3BVRa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 12:30:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44648 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757971Ab3BVRa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 12:30:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 370D9B7BA;
	Fri, 22 Feb 2013 12:30:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+dtgin635RfJG95+yeSFQdKRsfY=; b=Zt2Oye
	mSPlkJypas99bwCyPZ4cCO53So1T9SGUNQThrDKqEk47sMjg8fe04BFuOBU4HgJ4
	BiOTPO9Q0L8Fd0NP+5XA0JF6roRPmKp6LFNc92Qrg9UeFIBvnxfhAJ1+m96R02v9
	J98J3LqUD8MmxwXP9TkfWEh/YIHLpn2Np9eyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DXKBeXKBVmUOKSxffEhm8f3FFLOemXwe
	fgt4vkz7WhAP6VjgzTdHtMOkx0wwS/+4rbsmpjXzVpqCUuwPXPmJf36FcipTQJTC
	TsyrThMRxr8SMYSb66otzQvs0YNDT2bEsGCqE7aTAOricNxfXYalG7Y9G3x4a0ka
	2mdYQq0GoLw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC48B7B8;
	Fri, 22 Feb 2013 12:30:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 721CAB7B7; Fri, 22 Feb 2013
 12:30:26 -0500 (EST)
In-Reply-To: <vpqd2vssnh7.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Fri, 22 Feb 2013 10:32:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B9EBF4A-7D15-11E2-A69E-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216846>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Yes, but push.default is really different: there is a config variable,
> and we want the behavior to be configurable. In the case of "git add",
> I don't think adding a configuration option would be the right thing.
> That would mean typing "git add -u" on an account which isn't yours will
> be unpredictable *forever*.

Exactly.

>> $ git grep 'stuff' :/
>>
>> would it be too much to teach it to do:
>>
>> $ git grep -u 'stuff'
>
> "git grep" is out of the scope of this change. Yes, it is inconsistant
> with the rest of Git, but doesn't seem to surprise users as much as "git
> add -u" (for which the inconsistancy appears within the "add" command).

It is consistent with "grep", and the reason "git grep" behaves that
way is because consistency with "grep" matters more. I do not think
it is going to change.

Another is "clean", which I do not personally care too deeply about;
it being a destructive operation that is only used interactively and
occasionally), the current behaviour to limit it to the cwd is much
more sensible than making it go and touch parts of the tree that is
unrelated to cwd.

> I don't understand what you mean by "git grep -u".

I think he meant to add "git grep --full-tree" or something, and I
do not think it is going to happen when we have ":/" magic pathspec.

> As I said, I think adding a configuration option that would remain after
> 2.0 would do more harm than good. But after thinking about it, I'm not
> against an option like a boolean add.use2dot0Behavior that would:
>
> * Right now, adopt the future behavior and kill the warning
>
> * From 2.0, kill the warning without changing the bevavior
>
> * When we stop warning, disapear.

It is marginally better than David's "set once without thinking
because I read it on stackoverflow without fully understanding the
ramifications, and forget about it only to suffer when Git 2.0
happens" configuration variable, but by not much.  You can easily
imagine

	Q. Help, Git 1.8.2 is giving me this warning. What to do?
	A. Set this configuration variable. period.

and many users setting it without realizing that they are making the
operation tree-wide at the same time.  We'd want to see this answer
instead:

	A. Say "git add -u ."; you want to add changed paths in the
 	   current directory.

Another problem with use2dot0 configuration is that it would invite
people to imagine that setting it to false will keep the old
behaviour forever, which is against what you set out to do with the
patch under discussion.

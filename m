From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 16:01:24 -0700
Message-ID: <7vk424s52z.fsf@alter.siamese.dyndns.org>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
 <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr>
 <4F73632E.1060408@ira.uka.de> <vpqk424zfb1.fsf@bauges.imag.fr>
 <4F737027.5020503@ira.uka.de> <7vvclotpp7.fsf@alter.siamese.dyndns.org>
 <4F7395B6.1020506@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 29 01:01:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD1sM-0001m6-JK
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 01:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243Ab2C1XBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 19:01:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61042 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933233Ab2C1XB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 19:01:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CEE16105;
	Wed, 28 Mar 2012 19:01:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FMJz2J4y8yorhjCUUwYqHuCzM4Q=; b=RFoyIb
	97Nf81LLDLu9CUhedz6ykzyJp+66X1ICwBSWrk7qgcYtPToi2eZObtVHs9w3932u
	FWfWRtTbW7x/+vB2v4o4+XI784+svpg5fbfOH24RJEo4CEu0lTi9GQ42bbblaz4A
	bN+kLYbMQbzhh3fGwexEWa9xW0yRPwNVTe48I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D67+hJNP5spNMBYfuGw5LYFnU1bGt2O/
	7XUKN0HahO2o+iujkL4gSnLBK77uxQn49FHZ/ae2thTQxeW1cYjZSLwDVfSNZTh2
	Zs47vhxx+3uVm4Dz1UTVswpfEscXxoKYjkFyqBZatWQsvF8I/6PHwE3P8KXvz70A
	GbFcECJt4n4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 343726104;
	Wed, 28 Mar 2012 19:01:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B38386103; Wed, 28 Mar 2012
 19:01:25 -0400 (EDT)
In-Reply-To: <4F7395B6.1020506@ira.uka.de> (Holger Hellmuth's message of
 "Thu, 29 Mar 2012 00:50:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1EFA9F8-7929-11E1-9126-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194215>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> Am 28.03.2012 22:50, schrieb Junio C Hamano:
>> I think Matthieu is not thinking about the "resolve conflicted merge (or
>> rebase, am) and make a single commit" use case, for which your "pick one
>> of the sides" makes sense.  His is more about "I like some change in that
>> unrelated commit---while I have no intention to replay that change as a
>> whole, I want to use "cherry-pick --no-commit" and pick only the bits out
>> of the change that are useful for what I am doing" use case.
>>
>> In such a context, after resolving conflicts in the working tree, "add -p"
>> would be a good tool to pick hunks in the diff between the HEAD and the
>> working tree.
>
> Ok. Something like this (which is not really that different from Eriks
> example, so I might still be missing something) ?

After re-reading what I wrote, I find that I misspoke.

There is a crucial step missing.  After running "cherry-pick --no-commit",
you would eyeball the result, and typically edit the file.  The conflict
may not be in the part of the file you are interested in picking, in which
case you may even leave that part as-is.  And then, you would pick what
you want to apply to the index during per-hunk interactive patching
session.

In other words,...

> git init .
> echo "foo" > bar.txt
> git add bar.txt
> git commit -m.
> git checkout -b new
> echo "bar" >> bar.txt
> git commit -am.
> git checkout master
> git reset --hard
> echo "baz" >> bar.txt
> git commit -am.
> git cherry-pick --no-commit new

Here, there *will* be "edit bar.txt" before "add -p".  Which makes...

> git add -p bar.txt
>
> So he would be interested in keeping his previous working tree version
> (identical to HEAD commit, otherwise cherry-pick fails)...

...this part of your analysys (and your conclusion that he can take '<')
invalid.

Now I am not Matthieu, so he may have a different use case in mind when he
said "I want to take the version from my working tree", but the sequence
"cherry-pick --no-commit ; edit ; add ; commit" is a natural way to pick
only a part relevant to your current work from unrelated commit, and I
would understand why "Taking the version from my working tree" can be
useful in such a scenario.

In short, these two are totally different workflows and call for two
different semantics.

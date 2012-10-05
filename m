From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Fri, 05 Oct 2012 15:29:10 -0700
Message-ID: <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
 <op.wlp1lws70aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Jeff King <peff@peff.net>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: "Frans Klaver" <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 00:29:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKGOa-0005lI-4s
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 00:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727Ab2JEW3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 18:29:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757513Ab2JEW3N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 18:29:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D8D38084;
	Fri,  5 Oct 2012 18:29:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oDONEWKLfo9ZTPLgZMMB9tcEfxY=; b=Kn34TT
	vX7KjTkWMc5vAJ/1Suwuiiy+vlYchsSmBmOiIWik0b2T+t15WPX3q4pAQ3CkA6/m
	7QJn/Lr2uZ2dXc5Qmk7sWJNzWWsjecs/K0GLG8i7CNVR4hu/HeHlXQQY9NCdI83Z
	6BtjgJzgQlgTtJHGd3xvj8sQ28X7aOWi994wA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eeVtGqMXWaV28L3okGmzADDck77ZuNA2
	GcIqC6X4MQQ2RtBsRDRn0OYfqj3UTTNg5HhNMpWGR7QLZpbVmJcu1MCLZnKxItN1
	JM+XQvNgr4n1YnT+2lVx59pqMSA0eUmzrP3V2XCj/aMLgU9ZOboWMGsXT1ZOFx/i
	WVp3guMymvI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AC9D8081;
	Fri,  5 Oct 2012 18:29:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1F598080; Fri,  5 Oct 2012
 18:29:11 -0400 (EDT)
In-Reply-To: <op.wlp1lws70aolir@keputer> (Frans Klaver's message of "Fri, 05
 Oct 2012 21:55:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 161DAB7E-0F3C-11E2-90BD-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207124>

"Frans Klaver" <fransklaver@gmail.com> writes:

> On Fri, 05 Oct 2012 16:20:45 +0200, Horst H. von Brand
> <vonbrand@inf.utfsm.cl> wrote:
>
>> What I did:
>>
>> - New file images/coins.asy ~~-> 'git add images/coins.asy'
>> - Started adding new stuff to fg.tex
>> - Noticed a old bug in fg.tex, fixed that one
>> - Did 'git -pm "Some message"' and selected just the bugfix
>>
>> But git created a commit _including_ the new file. Tried to go back:
>
> Exactly what's supposed to happen. "git add" tells git you want to add
> the file to the index. The index is what you're going to commit later
> on.

Assuming that the last step of what Horst did was "git commit -pm",
I think Git is wrong in this case.  When you tell "git commit" what
to commit, unless you give "-i" (aka "also") option, the command
makes a commit to record changes only from what you tell "git
commit" to commit, regardless of what you earlier did to the index.

And choosing what to add via the interactive interface is in the
same spirit as telling what to commit to "git commit", so it should
behave the same.

This is one of the times I wish I said "No, you cannot have a pony".
The change was done without thinking things through, and reviewers
including me did not realize this particular downside.  My accepting
this misfeature (or a poorly implemented feature that has a
potential to be useful) was essentially me saying:

    When making a commit that does not match my working tree state,
    I always check with "diff --cached" to make sure what I think I
    am committing matches what I am committing, so I won't use such
    a lazy option myself.  I am not excited to think things through
    to see what possible pitfalls the feature may have for you; I'll
    let you guys hang yourself with that long rope.

And we are seeing a backfire from that "not bothering to think
things thorough".

I think the right thing to do is to fix "git commit -p" so that it
starts from the HEAD (on a temporary index), just like how partial
commits are made with "git commit file1 file2".   Or just forbid it
when the index does not match HEAD.

Cf. 

  http://thread.gmane.org/gmane.comp.version-control.git/173033/focus=173246

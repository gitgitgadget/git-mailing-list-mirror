From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 07 Oct 2011 14:14:49 +0200
Message-ID: <4E8EED39.1060607@drmicha.warpmail.net>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org> <4E8EBDA7.2040007@drmicha.warpmail.net> <20111007091636.GA22822@elie.hsd1.il.comcast.net> <4E8ECA25.205@drmicha.warpmail.net> <20111007100646.GA23193@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 14:14:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC9KL-0000yA-6B
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 14:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759904Ab1JGMOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 08:14:52 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58815 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752288Ab1JGMOv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 08:14:51 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 09F6320CB9;
	Fri,  7 Oct 2011 08:14:51 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 07 Oct 2011 08:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LrqJCetkFQ/P74quE3lQNh
	yLfLc=; b=qovnqbVnn2wKNybxe8UYA6wCo1TGT4EM7dsl8OYEYskSeGVdcfvbwo
	6exhcjIPLg3Gtb6p3HencwHC7G5ClEZsRRueo1OLrJo/cQfp0bTKuRCGIxfZZTQj
	P+a/BciMAFjajd8tcfWQkJJMKG6YQid8aRdqjv20T8z7PusKF98GQ=
X-Sasl-enc: T4B1fWc7o99xoy16WzLUMfj9syHatmwMLfg3PmnnrXOa 1317989690
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 40A8FCA048C;
	Fri,  7 Oct 2011 08:14:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111007100646.GA23193@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183075>

Jonathan Nieder venit, vidit, dixit 07.10.2011 12:06:
> Michael J Gruber wrote:
> 
>> But my main point here is that we should discuss the pros and cons of
>> each approach in context (the context of the original thread), and I
>> haven't heard many pros and cons for either.
> 
> Ok, here are some thoughts (you can file them under the "pro" or "con"
> column according to your taste):
> 
> Branch names are local.

You can pull a branch only if you know its name, or using a wildcard
refspec. In both cases you know the translation from what is local on
the other side to your side. In the vast majority it will be the simple
refs/heads/foo -> refs/remotes/bar/foo mapping.

> The same tip commit can belong to multiple branches, which would make
> using the tip commit as a key for the branch description problematic.

Sure, tip commit is a no-go.

That's why I propose notes tacked onto refnames.

> I don't think git notes are a good fit for this purpose.

Why not?

I really haven't seen any convincing argument against yet. The details
(note attached to refname object, or literal refanmes in the notes tree
as per Jeff) should be discussed further, of course, but if branch
descriptions aren't "notesy" then I don't know what is.

Alternatively, one could store the description in a blob and refer to
that directly, of course. I.e., have

refs/description/foo

point to a blob whose content is the description of the ref

ref/foo

That would be unversioned, and one could decide more easily which
descriptions to share. (A notes tree you either push or don't.)

But it still has the advantage of being easily pushable and shareable.
Heck, config is config and not metadata ;)

> I personally would prefer my branch descriptions to be non-versioned,
> though I realize that is a matter of taste.

Do you prefer you commit notes to be non-versioned? Probably, but still
they are, and you don't need to care. Just don't run log on your notes ref.

> Some other information about a branch (such as which upstream branch
> it pulls from) is stored in the [branch "<branchname>"] section of the
> git configuration, so it makes a certain kind of sense to put the
> branch description there, too.  On the other hand, the possibility of
> a [branch "<branchname>"] section in ~/.gitconfig has always been
> strange, and this is no exception.

Note that most use cases for branch descriptions that have been
described so far (format-patch cover-letter, merge-msg, pull-request
message) are about distributing that information. Not very local.

>> I'd be surprised if we changed the protocol just to be able to share
>> some descriptions, when we have everything we need for sharing refs.
> 
> The impact of such a protocol change would not have to be as dramatic
> as you seem to be suggesting.  Virtual hosts and peeled ref values
> were added as backward-compatible extensions to the reference
> discovery protocol (see Documentation/technical/pack-protocol.txt)
> which can be taken as examples for inspiration.

I don't see how a protocol change could solve the perceived issue with
localality of name, and indeed what it could solve that can't be solved
with existing methods.

> Here's some discussion of the implementation based on branchname-keyed
> notes that you mentioned [1].  It is nice to have multiple designs
> available for trying out, and I hope experience using each reveals
> potential improvements in the other.
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/181953/focus=182000

Funny to point me at a thread I participated in, when I'm saying this
thread should have continued there ;)

Michael

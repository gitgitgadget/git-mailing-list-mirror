From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/6] A handful of "branch description" patches
Date: Sat, 24 Sep 2011 16:42:18 +0200
Message-ID: <4E7DEC4A.3050900@drmicha.warpmail.net>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> <1316729362-7714-1-git-send-email-gitster@pobox.com> <4E7C49CF.60508@drmicha.warpmail.net> <20110923201824.GA27999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 24 16:42:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7TRC-0006AO-Si
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 16:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab1IXOmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 10:42:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51564 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751091Ab1IXOmV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2011 10:42:21 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5BDEA25B1E;
	Sat, 24 Sep 2011 10:42:21 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Sat, 24 Sep 2011 10:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=MBYV5QX5zjMk0C/BX9peDc
	BO9FU=; b=jNfRm6VG9mvBCtTt+5foLqSGP+KFiAA2sKGrBH66sQ1kQ3tdY8qjHl
	8Nj00SjhRDnSgPP/oNUfU2GELiWmJg27qIBGc39gc/RMk6Gf15MQXpz18ku56wwi
	2IqWW+3w7sT6Oiq+8GwW4vYai0+4JbjK8hOkg2zXTWKpRnl3SiUVU=
X-Sasl-enc: sd0YZD47Br3rI2B2MSfsPle2YMY/6G8qdj86UlAvwA+n 1316875340
Received: from localhost.localdomain (p54858437.dip0.t-ipconnect.de [84.133.132.55])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 89A27A008BD;
	Sat, 24 Sep 2011 10:42:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <20110923201824.GA27999@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182027>

Jeff King venit, vidit, dixit 23.09.2011 22:18:
> On Fri, Sep 23, 2011 at 10:56:47AM +0200, Michael J Gruber wrote:
> 
>>   mjg/vob/refrev-pretend [mjg/vob/virtual-objects: ahead 1]
>>     Pseudo revs for refnames
>>     
>>     An alternative implementation using pretend_sha1...
>>     Currently unused.
>>
>>   mjg/vob/virtual-objects [origin/next: ahead 2, behind 10]
>>     Virtual refname objects
>>     
>>     For each existing refname, introduce virtual objects corresponding to a blob
>>     with the refname as the content. "virtual" refers to the fact that these
>>     objects are not written out but exist for all other purposes, such as
>>     attaching notes and keeping them from being pruned.
> 
> Eww. :)
> 
> This seems like a clever solution to making git-notes store a ref as a
> key instead of an arbitrary sha1. But I wonder if the end result is
> really waht the user wants. The resulting notes tree is good for doing
> lookups, but the entries are completely obfuscated. So I can't easily do
> something like "list all of the refs which have descriptions". I can
> only list the _hashes_ of the refs which have descriptions. And if I am
> lucky, I can hash the refs I have and correlate them. But unknown ones
> will simply be a mystery.

[mjg@localhost git]$ git rev-parse ref:mjg/vob/virtual-objects
3f8aa9bb80fe241306aafd3d76af50739ba88268
[mjg@localhost git]$ git show 3f8aa9bb80fe241306aafd3d76af50739ba88268
refs/heads/mjg/vob/virtual-objects

:)

The only problem is with notes for non-existing refs. [You only have to
invoke the inverse mapping to sha1, of course... Uhm.]

> Wouldn't it be much more friendly to have a separate tree of refnames
> that stores:
> 
>   refs/heads/foo -> (some blob with the "foo" description)
>   refs/heads/bar -> (some blob with the "bar" description)

Given the above, I don't think it's more friendly.

In fact, in my first attempt, I wrote out the blobs, and referenced them
just like above from a different subtree within the notes tree, in order
to keep them from being pruned. So the virtual approach is pretty
equivalent, though leaner.

> Yeah, you have to build another git-notes-like interface around it. But
> the data structure is pleasant and flexible. You could even "git
> checkout" the whole tree and edit the notes with your editor, without
> having to deal with some obfuscated name.

Well, "git branch --edit-description" and such should be the way to edit
them, shouldn't it?

I really think the only issue is remote refnames. As Junio points out,
they are local by nature. OTOH, you typically use a non-renaming refspec
which puts them under refs/remotes/foo/bar with "bar" being the same
name as the local one on the remote, foo something you have chosen. So,
teaching the code that the note for

refs/remotes/foo/bar

is in the notes tree

refs/remotes/foo/notes/commits (or .../refames, or whatever we do with
the namespaces)

as a note attached to sha1("refs/bar")

is really a non-issue. It's not done yet, in part because of the
possible namespace restructuring.

Michael

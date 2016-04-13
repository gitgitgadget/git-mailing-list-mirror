From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFD/BUG?] git show with tree/commit
Date: Wed, 13 Apr 2016 10:02:49 +0200
Message-ID: <570DFD29.9090100@drmicha.warpmail.net>
References: <570D154D.6090006@drmicha.warpmail.net>
 <xmqq4mb6sshz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 10:03:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqFlV-0001LQ-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 10:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbcDMIC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 04:02:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51736 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751021AbcDMICv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2016 04:02:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 55B1C2037D
	for <git@vger.kernel.org>; Wed, 13 Apr 2016 04:02:50 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 13 Apr 2016 04:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=SR1nCIdnhljGg/WfJFq5qj5Dl9w=; b=dokd97
	2c76t1AA3VY2NSmWIu4jr+I0wceor5dnsf29M7HOX6gZpYLAI+GijQJINLS9xr1A
	YCDEy41aN6bYZveIawZiUgH6ocOKHPTW0/T5KU3KfAi0p281b+aFrUDjbutyYW7I
	2yINFq+LMwTxhcU9KAoRfDiVhwiXNS+/RICl0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=SR1nCIdnhljGg/W
	fJFq5qj5Dl9w=; b=Crk0fYEtp6VYigha1LtXqDtn/hgoXZwndkWM8cfrUF6YzFJ
	eFsYMWWBNo02GD9cJXLheULKDbPX0LspQ+PzT+ADfOSyAhPKOBA/vNKOSmY9qBMG
	iXkD9LxU7JYbjw0ej5Al5UIb0kwriBrUdNawkJ47toVXX4zoVrgp+A9z+3ZE=
X-Sasl-enc: v+c3+gh5AeHw53/fBHakYhBu079AYdiO8ToSTStfSRJt 1460534570
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id B92ED68019B;
	Wed, 13 Apr 2016 04:02:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <xmqq4mb6sshz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291379>

Junio C Hamano venit, vidit, dixit 12.04.2016 18:26:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> $ git show cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
>> tree cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
>>
>> .gitattributes
>> .gitignore
>> .mailmap
>> ...
>>
>> While it's clear to me what's going on, I'm wondering whether it's a
>> good idea that "git show" says "tree" in front of the unresolved
>> treeish, whether it's a tree, a commit or something else. I think it's
>> pretty confusing.
> 
> There is no "unresolved treeish" on the line that begins with
> "tree", but I suspect it wasn't very clear to you because of the way
> you gave the command its input; notice the line in question ends
> with a colon, which is unfortunate, but it turns out that it is your
> fault ;-).  Read on.

Guess what, I know the difference between "git show <commit>" and git
show <commit>:"...

>> Alternatives would be:
>>
>> tree <resolved tree id> # here: 040...
>> treeish <treeish>	# here: "treeish cab2c..."
>> tree <treeish>^{tree} 	# here: "tree cab2c^{tree}"
> 
> So, the three choices are
> 
>  (1) resolve the tree object name to 40-hex and show it as
>      "tree <object name in hex>"
> 
>  (2) given an object that is not a tree, show it as "treeish <object
>      name>" 
> 
>  (3) do not do anything fancy, just show it as "tree <object name>"
>      using what the user gave us.

(3) ist not quite what I'm after, but I guess when "git show" receives
"<commit>:" there is no way it could trace back that tree reference to
the commit. In fact, (3) is what we have now.

> I think the current output is doing the third one (notice the colon
> at the end of the line).
> 
>     $ git show master: | head -n 1
>     $ git show master^{tree} | head -n 1
>     $ git show cab2cdadf: | head -n 1
> 

I confess that I failed to copy the trailing ":" from the original
output... So that one is my fault.

In fact, while specifying "<commit>:" knowingly to show the tree, I
interpreted the ":" in the output as a simple colon introducing the
following output, at least at first glance.

I guess (1) would be the only option that would help (because
"<commit>:" is a tree, not a non-tree treeish).

Michael

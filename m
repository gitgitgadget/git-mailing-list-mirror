From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref
 only
Date: Tue, 29 Mar 2011 21:48:34 +0200
Message-ID: <4D923792.9010101@drmicha.warpmail.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net> <20110329143547.GB10771@sigill.intra.peff.net> <20110329190138.GA23599@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:48:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4eu6-00040D-9i
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 21:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287Ab1C2Tsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 15:48:33 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56143 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754191Ab1C2Tsc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 15:48:32 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D89AF2097D;
	Tue, 29 Mar 2011 15:48:31 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 29 Mar 2011 15:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=H/WK5JQVoLPRku+SCFNk9HE4Ego=; b=DkASWd57nmg1hp59dXd4e7btx4Rg92pxPD1XofoWTY8oj8a7UFGYfKuzP9P4xcLzgWZXjXp19gkxPDGEYPtj/3yom5Zt84R3g5D96vYOBiOim1knV4ldokUIwu2S6hjWzE/7ntTpNIHvIUv0OFQL9AnMbNZbY1p13zHkB5yw+m0=
X-Sasl-enc: ylNS3m08GlYgXJGHRO7Nk5EzwkuWodJjbkICtCZtneCw 1301428111
Received: from localhost.localdomain (p54858F1A.dip0.t-ipconnect.de [84.133.143.26])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E6E904041DB;
	Tue, 29 Mar 2011 15:48:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110329190138.GA23599@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170313>

Jeff King venit, vidit, dixit 29.03.2011 21:01:
> On Tue, Mar 29, 2011 at 10:35:47AM -0400, Jeff King wrote:
> 
>> On Tue, Mar 29, 2011 at 12:05:09PM +0200, Michael J Gruber wrote:
>>
>>> -		if (!prefixcmp(arg+13, "refs/"))
>>> +		if (!prefixcmp(arg+offset, "refs/"))
>>>  			/* happy */;
>>> -		else if (!prefixcmp(arg+13, "notes/"))
>>> +		else if (!prefixcmp(arg+offset, "notes/"))
>>>  			strbuf_addstr(&buf, "refs/");
>>>  		else
>>>  			strbuf_addstr(&buf, "refs/notes/");
>>> -		strbuf_addstr(&buf, arg+13);
>>> +		strbuf_addstr(&buf, arg+offset);
>>>  		string_list_append(revs->notes_opt.extra_notes_refs,
>>>  				   strbuf_detach(&buf, NULL));
>>
>> This issue is not introduced by your patch, but maybe it is a good
>> opportunity to refactor this to use expand_notes_ref from notes.c?
> 
> Oops, I just realized this is in builtin/notes.c in master. I had
> already written a patch for another topic that made it globally
> accessible. :)

Yeah, I (figured and) factored it out myself meanwhile, and rebased. I'm
wondering though where we are going. Junio seems to be in a mood for
major changes to the notes ui, so maybe I should hold on until we
decided about a ui restructuring.

I think, though, that any notes ui revamp is correlated with our
(stalled?) discussions about the layout of refs/. It affects not only
the default notes ref ("commits" for all notes?) but also the question
what a standard notes ref is, and where to store (and how to specify)
upstream notes refs.

Michael

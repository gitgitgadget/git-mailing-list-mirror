From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/28] clean-ups of static functions and returns
Date: Mon, 14 Aug 2006 18:04:24 -0700
Message-ID: <7vsljyajxj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608141314350.19383@chino.corp.google.com>
	<7vlkpqdikx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608141618470.21705@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 03:04:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCnM4-0000LI-SW
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 03:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbWHOBE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 21:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbWHOBE0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 21:04:26 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16265 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932742AbWHOBEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 21:04:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815010424.FECJ6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 21:04:24 -0400
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608141618470.21705@chino.corp.google.com> (David
	Rientjes's message of "Mon, 14 Aug 2006 16:30:51 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25433>

David Rientjes <rientjes@google.com> writes:

> On Mon, 14 Aug 2006, Junio C Hamano wrote:
>
>> Interesting.  Did you use some automated tool to spot them?
>> 
>
> No, these changes are from my own personal tree that optimizes everything for 
> speed since I am working with terabytes of data.  I only submitted changes that 
> I thought would be beneficial for your project as well.
>
>>  * Making stricter error checking in the future harder.  There
>>    are three classes, but the lines between them are fuzzy.
>> 
>>         [PATCH 04/28] builtin-diff.c cleanup
>>...
>>         [PATCH 23/28] makes peek_remote void
>> 
>>    The callers of the first group check their return values, so
>>    we could make error checking of these functions stricter in
>>    the future without affecting the rest of the code.  The ones
>>    that currently die() (or usage()) could be made into more
>>    libified form to return error codes.
>> 
>>    So I do not think it is worth doing these.
>
> I disagree.  Having static functions return ints that are the
> same for _every_ code path and are checked against upon return
> is never good style.  It implies that error checking is
> already done and the return value is of importance.

I would agree with your above statement about the second group,
but not the ones listed in the first group, whose callers are
prepared to receive error returns.  It just happens that these
callees do not currently detect errors, but some of them
certainly could be improved to return errors, instead of just
calling die().

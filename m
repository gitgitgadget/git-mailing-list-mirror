From: Junio C Hamano <junkio@cox.net>
Subject: Re: [REGRESSION] Interrupted clone/fetch leaves .lock files around
Date: Tue, 06 Jun 2006 14:58:46 -0700
Message-ID: <7v1wu2ndyh.fsf@assigned-by-dhcp.cox.net>
References: <20060606185148.GA15521@diku.dk>
	<7vmzcqp0cn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 23:59:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnjZl-0007NM-AE
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 23:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWFFV6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 17:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWFFV6s
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 17:58:48 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:32972 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751084AbWFFV6r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 17:58:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606215847.RPPX19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 17:58:47 -0400
To: Jonas Fonseca <fonseca@diku.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21406>

Junio C Hamano <junkio@cox.net> writes:

> Jonas Fonseca <fonseca@diku.dk> writes:
>
>> Below is my feeble attempt at a (tested) fix.
>>
>> diff --git a/fetch.c b/fetch.c
>> index e040ef9..861dc60 100644
>> --- a/fetch.c
>> +++ b/fetch.c
>> @@ -1,3 +1,5 @@
>> +#include <signal.h>
>> +
>>  #include "fetch.h"
>
> I suspect you could do something similar to what we already do
> for index updates using atexit().  Let me take a look.

Indeed it turns out that the signal work Pasky did in index.c is
exactly suitable for this.  I've pushed out three patches in
"next" -- a few more eyeballs are appreciated on this one.

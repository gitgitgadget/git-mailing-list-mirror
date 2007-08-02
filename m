From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle the errors from chdir in set_work_tree
Date: Thu, 02 Aug 2007 15:18:47 -0700
Message-ID: <7v4pjhtwag.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0708020827p174515b7tc05fefde77f7d7c4@mail.gmail.com>
	<7v8x8ttx7y.fsf@assigned-by-dhcp.cox.net>
	<20070802221518.GC2829@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGj0P-0005PY-LA
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbXHBWSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbXHBWSu
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:18:50 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41634 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbXHBWSt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:18:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802221849.VUZS7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 18:18:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XAJo1X00K1kojtg0000000; Thu, 02 Aug 2007 18:18:48 -0400
In-Reply-To: <20070802221518.GC2829@steel.home> (Alex Riesen's message of
	"Fri, 3 Aug 2007 00:15:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54629>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Thu, Aug 02, 2007 23:58:41 +0200:
>> "Alex Riesen" <raa.lkml@gmail.com> writes:
>> > +		if (chdir(dir))
>> > +			rel = NULL;
> ...
>> 
>> Shouldn't it die() instead, though?
>
> Dunno. Don't like dying.

I do not understand your reasoning.  Why is it better to use
mysteriously truncated path, which may result in doing something
the user did not ask you to, rather than saying "No, my
temporary buffer is not equipped to handle such an insanely long
pathname"?

>> Consolidating two of your patches, would this be Ok?
>
> Yes, but you may consider replacing strncpy with strlcpy:
>
>> +		memcpy(dir_buffer, dir, len - suffix_len);
>> +		dir_buffer[len - suffix_len] = '\0';
>
> strlcpy(dir_buffer, dir, len - suffix_len + 1);

Does that buy us that much?  Before going to that codepath, we
have made sure the result fits, haven't we?

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix cg-commit -p to not touch the working tree
Date: Mon, 12 Feb 2007 14:01:57 -0800
Message-ID: <7vtzxr6nmy.fsf@assigned-by-dhcp.cox.net>
References: <20070212031923.D20B913A382@magnus.utsl.gen.nz>
	<7v8xf4atoe.fsf@assigned-by-dhcp.cox.net>
	<45D0CC74.9020606@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 23:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGjFU-0005bk-FZ
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 23:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965436AbXBLWB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 17:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965437AbXBLWB7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 17:01:59 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61448 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965436AbXBLWB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 17:01:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212220158.WMXG1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 17:01:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nm1y1W0021kojtg0000000; Mon, 12 Feb 2007 17:01:58 -0500
In-Reply-To: <45D0CC74.9020606@vilain.net> (Sam Vilain's message of "Tue, 13
	Feb 2007 09:22:12 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39445>

Sam Vilain <sam@vilain.net> writes:

> Junio C Hamano wrote:
>>> Previously, the working tree state was modified with `patch', which
>>> was a fragile operation.  Do everything with `git-apply --cached
>>> --index' instead.
>>>     
>> I do not use Cogito so I do not know what behaviour is wanted
>> here, but '--cached --index' is same as saying just '--cached'
>> as far as I know.  It will patch against the index and should
>> not touch working tree.  If the original used 'patch' to apply,
>> I suspect it wanted to touch the working tree (and possibly, it
>> wanted to leave the index alone?), so --cached might be
>> completely wrong thing to use here?
>>   
>
> The context is that "cg-commit -p", a kind of poor man's interactive
> commit that lets you preview changes that are to be committed in 'diff'
> form, and edit the patch to be applied. Many users expect this command
> to behave this way; they're quite surprised and sometimes even miffed
> when the changes they deleted from the patch are gone from their working
> copy.

Ah, I see that's why you do want to leave the working tree
untouched.  I think '--cached' alone is the right way to spell
it (strictly speaking, giving --index and --cached should error
out, although the current implementation does not).

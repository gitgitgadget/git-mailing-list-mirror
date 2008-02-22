From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 22 Feb 2008 14:26:18 -0800
Message-ID: <7vhcg07hmd.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <7v8x1fymei.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802211024200.17164@racer.site>
 <47BF18DF.6050100@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:27:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSgMn-0004JF-IM
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 23:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936790AbYBVW0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 17:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936784AbYBVW0k
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 17:26:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936933AbYBVW0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 17:26:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CF7EA52D8;
	Fri, 22 Feb 2008 17:26:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CCF4B52D7; Fri, 22 Feb 2008 17:26:26 -0500 (EST)
In-Reply-To: <47BF18DF.6050100@nrlssc.navy.mil> (Brandon Casey's message of
 "Fri, 22 Feb 2008 12:47:59 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74764>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Johannes Schindelin wrote:
>> Hi,
>> 
>> On Wed, 20 Feb 2008, Junio C Hamano wrote:
>
>>> * js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
>>>  + builtin-reflog.c: fix typo that accesses an unset variable
>>>  + Teach "git reflog" a subcommand to delete single entries
>>>
>>> There was a patch that uses this to implement "git-stash drop",
>>> which I didn't queue, as the command name and the UI was
>>> undecided yet.  Dscho was in favor of "pop" without "drop".
>> 
>> Maybe it is time to "drop" this topic?
>
> The issue with drop or pop (for me) was that deleting a reflog
> entry was causing error messages to be printed.

I agree with your analysis, and I am tempted to suggest just the
simplest option.

The thing is, unless it is a reflog used to implement stash,
removing an entry in the middle and adjusting an entry before
and after it, just to fool and squelch the consistency mechanism
we explicitly have for safety, feels quite wrong.  Especially
given that the whole point of the reflog is to allow you to
recover your branch to a particular point in time safely.

So I'd rather see us remove "reflog delete" and add "reflog pop"
which resets the ref itself to the previous point and deletes
the last reflog entry.  Then "stash pop" would become simply
"stash apply" followed by "reflog pop".

We might need to introduce "stash push" which would be a synonym
for "stash pop" for symmetry.  Also we may want to introduce a
stash per branch if we do this.

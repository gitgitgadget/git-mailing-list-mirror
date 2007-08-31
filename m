From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk from subdirectory
Date: Thu, 30 Aug 2007 22:29:44 -0700
Message-ID: <7vsl6046gn.fsf@gitster.siamese.dyndns.org>
References: <7vabs85ntg.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708302200160.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 07:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQz4w-0007hr-6y
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 07:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759332AbXHaF3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 01:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757938AbXHaF3u
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 01:29:50 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758527AbXHaF3t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 01:29:49 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E196E12B1D0;
	Fri, 31 Aug 2007 01:30:07 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708302200160.25853@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 30 Aug 2007 22:08:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57114>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 30 Aug 2007, Junio C Hamano wrote:
>> 
>> I am wondering if this was intended behaviour change.  I think
>> it makes sense to want an easy way to say "what changed stuff in
>> the directory I am in?" because presumably you are there because
>> you are interested in stuff in there.  But if you hard code "--"
>> it is not easy to disable that and get the global log.
>
> Hmm. My reaction to this would be that it was a mistake to have a 
> difference between 
>
> 	git log --
>
> and
>
> 	git log
>
> and that we should instead fix this at the argument parsing level. 
>
> And then anybody who depended on the old "--" behaviour can just add a "." 
> at the end.
>
> That way there are no special cases.
>
> I realize that the "--" behaviour of git log was intentional, but seeing 
> what it results in I think the intention was good, but stupid.

I haven't finished analysis yet, but I was reaching the same
conclusion.

v1.2.0 used to limit "git rev-list" to the current working
directory, v1.3.0 and newer does not.  But they do when "--" is
given.  This makes it impossible to do:

	cd Documentation
	echo >master
	git rev-list master
        ... get "ambiguous -- which do you mean?  rev, or
	... limited to path?" error message
        git rev-list master --
        ... I do mean unlimited and dig from 'master'

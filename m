From: Junio C Hamano <gitster@pobox.com>
Subject: Re: hosting git on a nfs
Date: Fri, 14 Nov 2008 12:14:23 -0800
Message-ID: <7v63mq9iao.fsf@gitster.siamese.dyndns.org>
References: <200811121029.34841.thomas@koch.ro>
 <20081112173651.GA9127@linode.davidb.org>
 <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
 <loom.20081113T174625-994@post.gmane.org>
 <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org> <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:16:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1562-0007T6-Io
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 21:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbYKNUPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 15:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYKNUPf
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 15:15:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbYKNUPf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 15:15:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C8AD316A8B;
	Fri, 14 Nov 2008 15:15:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6A34816ADF; Fri, 14 Nov 2008 15:14:25 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Fri, 14 Nov 2008 11:23:01 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE060216-B288-11DD-9719-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101013>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I also think the thread cost was wrong: it did
>
> 	threads = index->cache_nr / 100;
>
> to give a first-order "how many threads do we want", but the thread 
> startup is likely to be higher than 100 lstat calls, so we probably want 
> fewer threads than that. It doesn't much matter for something like the 
> Linux kernel, where there are so many files that we'll end up maxing out 
> the threads anyway, but for smaller projects, I suspect a thread cost of 
> "one thread per 500 files" is more reasonable. You almost certainly don't 
> want to thread anything at all for fewer than a few hundred files.

If you have 1000 files in a single directory, do you still want 2 threads
following the "1/500" rule, or they would compete reading the same
directory and using a single thread is better off?

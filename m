From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Tue, 11 Dec 2007 10:24:46 +0100
Message-ID: <20071211092446.GA4703@elte.hu>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 10:25:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J21Mf-0001E8-Ty
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 10:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbXLKJY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 04:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbXLKJY7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 04:24:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:50582 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbXLKJY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 04:24:58 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1J21M9-0005X2-Vg
	from <mingo@elte.hu>; Tue, 11 Dec 2007 10:24:56 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 6BCC63E2193; Tue, 11 Dec 2007 10:24:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712080636.12982.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67831>


* Christian Couder <chriscool@tuxfamily.org> wrote:

> Tell us if you have other scripts or suggestions related to 
> git-bisect.

not strictly git-bisect related, but i've got the git-authors oneliner 
script below that i find very useful when figuring out whom to mail to 
related to a bug in any given kernel subsystem. For example when i see 
some USB problem i can do:

  git-authors v2.6.23.. drivers/usb/

which gives me the most active (and hence most relevant) developers in 
an area:

      9  Pete Zaitcev <zaitcev@redhat.com>
     10  Inaky Perez-Gonzalez <inaky@linux.intel.com>
     12  David Brownell <david-b@pacbell.net>
     12  Oliver Neukum <oliver@neukum.org>
     23  Alan Cox <alan@lxorguk.ukuu.org.uk>
     49  Alan Stern <stern@rowland.harvard.edu>

with an email to pick up. In terms of accuracy this beats the 
MAINTAINERS file most of the time. And even when MAINTAINERS is accurate 
- in this particular case there are 48 'USB' related entries in the 
MAINTAINERS file - totally hard to sort out for a newbie.

git-authors is also much easier and more natural to use - when i find 
problems it's usually related to a file, and i can run this:

$ git-authors v2.6.23.. kernel/pid.c
      1  Eric W. Biederman <ebiederm@xmission.com>
      1  Pavel Emelianov <xemul@openvz.org>
      1  Serge E. Hallyn <serue@us.ibm.com>
      3  Sukadev Bhattiprolu <sukadev@us.ibm.com>
     10  Pavel Emelyanov <xemul@openvz.org>

which works on a very finegrained level and gives a better "overview" 
than a pure git-log. Perhaps this could be a --authorstats option of 
git-log perhaps?

	Ingo

---------{ git-authors }--------->
#!/bin/bash

git-log $@ | grep Author: | cut -d: -f2 | sort | uniq -c | sort -n

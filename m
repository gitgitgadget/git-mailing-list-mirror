From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed
 repositories
Date: Fri, 18 Jul 2008 02:00:23 -0700
Message-ID: <7vwsjj8t3s.fsf@gitster.siamese.dyndns.org>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
 <alpine.DEB.1.00.0807171311010.8986@racer>
 <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>
 <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com>
 <alpine.DEB.1.00.0807171351380.8986@racer>
 <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com>
 <alpine.DEB.1.00.0807171513560.8986@racer>
 <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com>
 <20080717182253.GZ32184@machine.or.cz>
 <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
 <m363r3y42v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nigel Magnay" <nigel.magnay@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:01:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJlqO-0003hE-Qa
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYGRJAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbYGRJAh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:00:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbYGRJAg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:00:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D338831254;
	Fri, 18 Jul 2008 05:00:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B0F7A31253; Fri, 18 Jul 2008 05:00:26 -0400 (EDT)
In-Reply-To: <m363r3y42v.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 18 Jul 2008 01:45:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB9B8602-54A7-11DD-82C0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89011>

Jakub Narebski <jnareb@gmail.com> writes:

> "Nigel Magnay" <nigel.magnay@gmail.com> writes:
>
>> Fred is a person (and != origin). His tree(s) are entirely correct and
>> consistent, and he doesn't yet wish to push to origin (and perhaps he
>> cannot, because he does not have permission to do so).
>> ...
> I _think_ that you can currently work around this problem by using
> URL rewriting (url.<base>.insteadOf).

Doesn't it also involve config modification?

I think the right thing to do for this kind of "trial merge" should be the
same as cases that do not involve submodules.  You *DO NOT* give a handy
way to muck with your configuration to make "origin" point at fred.
Instead, you would do something like:

	$ git fetch ../fred master
        $ git checkout FETCH_HEAD
        ... review test fix ...
	... when you are done, go back, discarding the state from Fred
        $ git checkout master

What submodule changes from the above workflow would be what happens after
you switch to the trial state (the above example detaches HEAD temporarily
while peeking into Fred's history).  It is understandable that you would
want to script something that recurses into the submodules that you have
checked out (or submodules that Fred wants you to look at), do the
equivalent of "git fetch ../fred" you did at the toplevel to automate that
step, but I very much agree with Pasky here in that it feels very wrong to
hijack "submodule update" for it.

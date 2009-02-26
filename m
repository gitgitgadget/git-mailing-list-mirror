From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Thu, 26 Feb 2009 09:09:33 -0800
Message-ID: <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>
 <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net>
 <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org>
 <49A66057.1050501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 18:11:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcjlM-0001oJ-Ll
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 18:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702AbZBZRJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 12:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755423AbZBZRJl
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 12:09:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbZBZRJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 12:09:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A3D291555;
	Fri, 27 Feb 2009 12:09:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E09491551; Fri,
 27 Feb 2009 12:09:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A69768A-04F1-11DE-AA03-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111582>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> First of all: I define good/bad as matching the documentation.

Ok, I was primarily working from this:

commit bcc785f611dc6084be75999a3b6bafcc950e21d6
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Mon Oct 30 08:28:59 2006 -0800

    git push: add verbose flag and allow overriding of default target repository
    
    This adds a command line flag "-v" to enable a more verbose mode, and
    "--repo=" to override the default target repository for "git push" (which
    otherwise always defaults to "origin").
    
    This, together with the patch to allow dashes in config variable names,
    allows me to do
    
    	[alias]
    		push-all = push -v --repo=all
    
    in my user-global config file, and then I can (for any project I maintain)
    add to the project-local config file
    
    	[remote "all"]
    		url=one.target.repo:/directory
    		url=another.target:/pub/somewhere/else
    
    and now "git push-all" just updates all the target repositories, and shows
    me what it does - regardless of which repo I am in.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

If documentation does not match it, we need to figure out why J6t with
bf07cc5 (git-push.txt: Describe --repo option in more detail, 2008-10-07)
needed to update the documentation.

It could be that the behaviour changed (perhaps by accident, perhaps by
design) after Linus introduced --repo with bcc785f (git push: add verbose
flag and allow overriding of default target repository, 2006-10-30) and
J6t documented that updated behaviour.  And since then there was another
behaviour change (again, perhaps by accident, perhaps by design) that made
you notice the description does not match the behaviour.

You will see that:

 (1) bf07cc5 (i.e. J6t's documentation) passes your tests;

 (2) somewhere between that and v1.6.2-rc2, there is a regression to make
     your test fail.

if the above conjecture is true, and we may want to fix that regression to
match the documentation.

On the other hand, if bf07cc5 does not pass your tests, it means that the
documentation update was the cause of the confusion, and it is not the
behaviour that needs to be fixed.

Sorry, but I do not have time today to look into this.  Could you help?

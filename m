From: Junio C Hamano <gitster@pobox.com>
Subject: Re: testsuite failures in mainline...
Date: Fri, 14 Dec 2007 11:15:01 -0800
Message-ID: <7vfxy5rsui.fsf@gitster.siamese.dyndns.org>
References: <20071214.104312.103638776.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3G0g-0005bt-1c
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 20:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbXLNTPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbXLNTPS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 14:15:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbXLNTPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 14:15:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B4AE99503;
	Fri, 14 Dec 2007 14:15:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FFC19500;
	Fri, 14 Dec 2007 14:15:03 -0500 (EST)
In-Reply-To: <20071214.104312.103638776.davem@davemloft.net> (David Miller's
	message of "Fri, 14 Dec 2007 10:43:12 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68327>

David Miller <davem@davemloft.net> writes:

> I've been seeing this for I think a week or two, and I can't figure
> out if it's some local problem of mine.  I even reran the testsuite
> with "PATH=$(pwd):$PATH" just in case it was picking up my existing
> 1.5.3.7 installation for some reason, but it still fails even in that
> case.
>
> Is the following a known issue?

No, you are the first to report it here.  I do not push out the tip of
'master' and 'next' unless all tests pass in my primary repository on my
private machine and in a repository under my k.org account, so you can
at least assume all tests has passed for _some_ people.  It of course
does not guarantee there isn't timing related bugs I am not catching. 

> *** t3200-branch.sh ***
> ...
> * FAIL 20: test tracking setup via config
>         git config branch.autosetupmerge true &&
>              git config remote.local.url . &&
>              git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>              (git show-ref -q refs/remotes/local/master || git-fetch local) &&
>              git branch my3 local/master &&
>              test $(git config branch.my3.remote) = local &&
>              test $(git config branch.my3.merge) = refs/heads/master

When I can reproduce a breakage, in our tests, I'd run

	cd t && sh -x t3200-branch.sh -i -v

(replace "t3200-*" with the failing test) and see which one of the steps
chained with && is breaking first.

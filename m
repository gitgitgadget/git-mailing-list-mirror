From: Junio C Hamano <junkio@cox.net>
Subject: Re: specifying "fast-forward" only in git-pull
Date: Wed, 28 Mar 2007 14:26:39 -0700
Message-ID: <7vbqidf4a8.fsf@assigned-by-dhcp.cox.net>
References: <e1dab3980703281412m78c2481bj9b9f7ec885dbbe4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWffJ-0003rB-BY
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 23:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbXC1V0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 17:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXC1V0l
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 17:26:41 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:56939 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbXC1V0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 17:26:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070328212640.DBRB28126.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 28 Mar 2007 17:26:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gMSf1W00d1kojtg0000000; Wed, 28 Mar 2007 17:26:40 -0400
In-Reply-To: <e1dab3980703281412m78c2481bj9b9f7ec885dbbe4f@mail.gmail.com>
	(David Tweed's message of "Wed, 28 Mar 2007 22:12:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43390>

"David Tweed" <david.tweed@gmail.com> writes:

> Hi, I'm looking through the documentation on git-pull and
> I see that I can specify a particular (sequence of) merge
> strategies, but I can't see a way to say "only do a fast
> forward, stopping if a fast forward doesn't apply".
> (Fast-forward doesn't appear to be a named strategy,
> which is why I can't use it with -s). Is there a way to
> do this?
>
> Rationale: I have a repository on several machines that
> are synchronised via usb-stick. 99.9% of the time a fast
> forward is all that is needed, and for scripting the
> synchronisation I'd like to restrict it so that only
> fast-forwards can happen automatically and everything
> else I have to do by invoking git myself.

Presumably you are scripting around "git pull" and wondering
if there is a way to let you say "git pull -s ffonly $stick".

Why don't you script around "git fetch" instead?

	#!/bin/sh
 	stick=$1
       
	git fetch "$stick"
        not_in_stick=$(git rev-list FETCH_HEAD..HEAD)
        if test -z "$not_in_stick"
        then
        	: stick fast forwards
                git merge FETCH_HEAD
	else
        	echo >&2 "Our HEAD has things the stick does not."
		exit 1
	fi

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add test case for git-config-set
Date: Thu, 17 Nov 2005 22:32:01 -0800
Message-ID: <7vsltuo49q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511172249410.18285@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd5kypjv2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Nov 18 07:55:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcznI-0003da-9j
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 07:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVKRGcG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 01:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVKRGcF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 01:32:05 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62110 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932489AbVKRGcD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 01:32:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118063047.QBCV20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 01:30:47 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vd5kypjv2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 17 Nov 2005 22:09:53 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12204>

Junio C Hamano <junkio@cox.net> writes:

> 	git-config-set section.key
>
> confusingly enough is --unset (we probably would want to require
> an explicit command line noise-word "--unset" in this case).

This is too confusing, so I think we should require --unset.  I
think the C-interface I suggested in the previous message can
stay the same, but from the command line perspective, we should
have a bit easier syntax.

A revised suggestion is:

	;# remove all
	git-config-set --unset section.key

	;# remove values that match rx and then append zero or more values
	git-config-set --remove rx section.key [value...]

	;# append one or more values (equivalent to specifying --remove
        ;# with rx that never matches anything).  To reduce
        ;# confusion, we always require at least one value here.
	git-config-set section.key value [value...]

	;# Additionally, purely as a syntax sugar, replace the
	;# entire multivalue with one or more values
	;# (equivalent to saying --remove '^').
	git-config-set --replace section.key value [value...]


I think (aside from "*-set" now becomes confusing), showing the
value of the specified key to stdout with

	git-config-set section.key

would be a nice addition to complete the suite; has anybody
noticed that git-var is cumbersome to use for this?

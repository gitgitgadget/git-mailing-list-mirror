From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and
 arguments
Date: Fri, 14 Feb 2014 22:41:33 +0100 (CET)
Message-ID: <20140214.224133.484636406629780362.chriscool@tuxfamily.org>
References: <xmqq38jqsnc2.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Nq-LkE=FW5dnBZKKd7-ORJPo1BFs3sY+MLGxuXEWuTw@mail.gmail.com>
	<xmqqa9dxr09k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	sunshine@sunshineco.com, dan.carpenter@oracle.com, greg@kroah.com,
	peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 14 22:42:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEQWH-0006CQ-Nj
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 22:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbaBNVl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 16:41:57 -0500
Received: from [194.158.98.45] ([194.158.98.45]:39682 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752643AbaBNVl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 16:41:57 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id A5EAC50;
	Fri, 14 Feb 2014 22:41:34 +0100 (CET)
In-Reply-To: <xmqqa9dxr09k.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242149>

From: Junio C Hamano <gitster@pobox.com>
>
> These numerous questions you have to ask are indications why
> choosing "this condition goes to the left hand side of the equal
> sign (e.g. exists)" and "this condition goes to the right hand side
> (e.g. do-this-if_neighbor)" is not working well.  The user has to
> remember which conditions go to the variable name and which
> conditions go to the action part.

If we limit it to "if_exists" and "if_missing", the user can remember
that without things becoming too complex.

> That is, not splitting the logic into two parts like you did,
> i.e. "if_X = do_Y_if_Z", which invites "why is it not if_true =
> do_Y_if_X_and_Z, if_X_and_Z = do_Y, if_Z = do_Y_if_X"?

It perhaps invite it, but there are reasons why splitting the logic
too much is not a good idea and why limiting the split to "if_exists"
and "if_missing" is a good tradeoff.

> One possible way to avoid the confusion is to say "do_Y_if_X_and_Z"
> without making the rule split into conditions and actions---I am
> NOT saying that is _better_, there may be other solutions to avoid
> this two-part logic in a cleaner way.

This has been discussed first last November and I don't think that a
solution better than what I implemented has been suggested.

The problem is we not only want to say:

    action = do_Y_if_X_and_Z

but we also want to say:

    action = do_Y_if_X_and_Z AND do_U_if_V

For example some people might want:

    if_exists = overwrite
    if_missing = add

while others might want:

    if_exists = overwrite
    if_missing = do_nothing

and I don't see how we can say that with just:

    action = do_Y_if_X_and_Z

Thanks,
Christian.

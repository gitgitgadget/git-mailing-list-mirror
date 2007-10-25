From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] walk PATH to generate list of commands for "help -a"
Date: Wed, 24 Oct 2007 21:42:42 -0700
Message-ID: <7vve8v24al.fsf@gitster.siamese.dyndns.org>
References: <1193283437-1706-1-git-send-email-srp@srparish.net>
	<1193283437-1706-2-git-send-email-srp@srparish.net>
	<1193283437-1706-3-git-send-email-srp@srparish.net>
	<1193283437-1706-4-git-send-email-srp@srparish.net>
	<1193283437-1706-5-git-send-email-srp@srparish.net>
	<1193283437-1706-6-git-send-email-srp@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 06:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkuYk-0000CP-Hq
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 06:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbXJYEms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 00:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbXJYEms
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 00:42:48 -0400
Received: from rune.pobox.com ([208.210.124.79]:45240 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922AbXJYEmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 00:42:47 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 09AB614BA6C;
	Thu, 25 Oct 2007 00:43:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 66039147DF1;
	Thu, 25 Oct 2007 00:43:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62271>

Scott R Parish <srp@srparish.net> writes:

> Signed-off-by: Scott R Parish <srp@srparish.net>

Rationale?

There are two cases execv_git_cmd() runs "git-that" from a non
standard place, if we take your [PATCH 4/7].

 - If there is a directory that contains a location that used to
   hold an old installation of git-* commands (some of which may
   have been removed in the latest git) and if the user has that
   directory on PATH, we would run obsolete git subcommand from
   there.

 - If the user has a custom command "git-that" in $HOME/bin/
   that is outside GIT_EXEC_PATH, the new subcommand "that" can
   be used as if it is part of the official git.  This is an
   improvement [PATCH 4/7] would bring in.  We allow this
   already for scripts anyway, and the patch is merely making
   the behaviour of the execv_git_cmd() consistent with it.

It may be nicer if the user can somehow tell from the output if
each of the command is from the standard set (i.e. on
GIT_EXEC_PATH or built-in), or from a non standard place (either
custom command as intended, or an unintended obsolete leftover).

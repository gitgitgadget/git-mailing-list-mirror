From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: set gitexecdir = $(bindir)
Date: Fri, 18 Jul 2008 17:32:33 -0700
Message-ID: <7vej5q67dq.fsf@gitster.siamese.dyndns.org>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-2-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-3-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-4-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-5-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jul 19 02:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK0ON-0003tz-7G
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 02:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYGSAcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 20:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbYGSAck
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 20:32:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYGSAcj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 20:32:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D000532C21;
	Fri, 18 Jul 2008 20:32:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 77ADA32C1E; Fri, 18 Jul 2008 20:32:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 30E6F954-552A-11DD-AA4E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89090>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> The "dash-less" change aims to remove git commands from $PATH. It does so
> by defining a GIT_EXEC_PATH that is different from $(bindir). On Windows
> we want a relocatable installation of the git tool, so we cannot use an
> absolute GIT_EXEC_PATH.  Therefore, the implementation of
> builtin_exec_path() on Windows derives the exec-path from the command
> invocation,...

Sorry, I am not sure if I understand what you are trying to solve.  If you
have ../libexec/git-core/ in GIT_EXEC_PATH (or have builtin_exec_path()
use it), then your installation would look like this:

	[[some random place]]
        	bin/git
                libexec/git-core/git-add
                libexec/git-core/git-del
                libexec/git-core/git-dir
                ...

and if "git" can figure out it is "[[some random place]]/bin/git",
it can find its subcommands from neighbouring directory, that is still
inside the random place the user told the installer to use, can't it?

> This counteracts the aims of the "dash-less" change on Windows, but better
> this way than having no working git at all.

I'd agree to the extent that anything is better than having no working
git, but this somewhat feels backwards.

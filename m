From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsimport bug with dates
Date: Thu, 15 Nov 2007 22:06:44 -0800
Message-ID: <7vr6iq207f.fsf@gitster.siamese.dyndns.org>
References: <51419b2c0711152059q55ced86gd224310c8c4a1851@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 07:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsuM9-0000qr-9k
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 07:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbXKPGGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 01:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbXKPGGw
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 01:06:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40529 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbXKPGGv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 01:06:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 108A72F2;
	Fri, 16 Nov 2007 01:07:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 836759403D;
	Fri, 16 Nov 2007 01:07:08 -0500 (EST)
In-Reply-To: <51419b2c0711152059q55ced86gd224310c8c4a1851@mail.gmail.com>
	(Elijah Newren's message of "Thu, 15 Nov 2007 21:59:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65194>

"Elijah Newren" <newren@gmail.com> writes:

> $ git diff @{2007-10-01}
> warning: Log for '' only goes back to Wed, 24 Oct 2007 19:31:38 +0000.
> fatal: bad object @{2007-10-01}
>
>
> It appears that passing a date to git diff on any repository imported
> by git-cvsimport will show this error, as long as the date is prior to
> when the repository was imported.

That is not a cvsimport specific issue.

When you use "branch@{date}" notation, you are not asking a
question on the project history, but a question on the local
view from _your_ repository on that project.

	$ git log --since=3.days.ago master

asks "go back from the master tip and show commits until you hit
the commit made earlier than that date and stop traversing".

On the other hand,

	$ git show master@{3.days.ago}

asks "show the commit that was the tip of 'master' branch in my
repository three days ago."  Maybe you pulled from your upstream
5 minutes ago, and the last time before that, you pulled three
weeks ago and did not do any development on the branch.  In such
a case, the latter question will give you the tip of your
'master' as of three weeks ago which is the same as of three
days ago.

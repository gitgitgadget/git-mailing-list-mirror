From: John Keeping <john@keeping.me.uk>
Subject: Different diff strategies in add --interactive
Date: Mon, 10 Jun 2013 15:28:25 +0100
Message-ID: <20130610142825.GI22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 16:29:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um35p-0007mA-Ai
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab3FJO3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 10:29:04 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:57944 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab3FJO3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:29:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 7597D6064F3
	for <git@vger.kernel.org>; Mon, 10 Jun 2013 15:29:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tT2sez7svJa9 for <git@vger.kernel.org>;
	Mon, 10 Jun 2013 15:29:02 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C41586064FC
	for <git@vger.kernel.org>; Mon, 10 Jun 2013 15:28:58 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227291>

I've just been trying to use "add -p" to stage some changes which happen
to be textually entangled with other changes that I do not want to
stage.

It turns out that "git diff --patience" does a really good job
splitting this into exactly the hunks I want, but "add --interactive"
doesn't let me change the diff algorithm it uses.  I tried setting
"diff.algorithm" to "patience", but of course add--interactive uses
plumbing diff commands that ignore configuration settings.

As a one off, I locally modified add--interactive to unconditionally use
patience diff and it has worked perfectly in this case, but I don't want
to have to apply a patch if I ever want this behaviour in the future.

I think the first thing to do is read the "diff.algorithm" setting in
git-add--interactive and pass its value to the underlying diff-index and
diff-files commands, but should we also have a command line parameter to
git-add to specify the diff algorithm in interactive mode?  And if so,
can we simply add "--diff-algorithm" to git-add, or is that too
confusing?

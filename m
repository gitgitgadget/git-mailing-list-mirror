From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 21:49:30 +0200
Message-ID: <vpqodmfss39.fsf@olympe.imag.fr>
References: <1174825838.12540.5.camel@localhost>
	<1174930688.5662.20.camel@localhost>
	<20070326183523.GG22773@admingilde.org>
	<200703262133.44520.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 21:49:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVvCH-0007Kl-OI
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 21:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbXCZTti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754AbXCZTti
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 15:49:38 -0400
Received: from imag.imag.fr ([129.88.30.1]:48725 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbXCZTth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 15:49:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2QJnUcY028599
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 26 Mar 2007 21:49:30 +0200 (CEST)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HVvC6-0007z7-8G
	for git@vger.kernel.org; Mon, 26 Mar 2007 21:49:30 +0200
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HVvC6-00019M-5l
	for git@vger.kernel.org; Mon, 26 Mar 2007 21:49:30 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <200703262133.44520.Josef.Weidendorfer@gmx.de> (Josef Weidendorfer's message of "Mon\, 26 Mar 2007 21\:33\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 26 Mar 2007 21:49:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43179>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> This would work. However, you can not clone from an almost empty .git
> directory with current git.

Of course not. If you say "have .git/ <=> is a repository", then your
lightweight checkout should not have a .git/. But why should anything
that have a .git/ directory be a repository??

> The original proposal was to have a standard .git directory for every
> light-weight checkout inside of the base .git directory, e.g.
> in <base>/.git/ext/<name>.git where <name> is some identifier for the
> lightweight checkout, either provided in the .gitlink file or
> automatically determined.

That seems really weird. That implies for example:

* Deleting a checkout means deleting both your local tree _and_ a part
  of the .git/ directory of the repository. Have you ever imagined
  having to do more than "rm -fr working-tree" even with an inferior
  VCS such as CVS?

* It makes it impossible to have a checkout of a read-only location.
  For example, if one of my colleague has a repository in
  /home/otheruser/repo/, if I want to get a working tree of it, I need
  to get a complete clone of his repo to be able to do it. Assuming
  someone ever implements a "lightweight checkout of a remote
  location" (bzr has this for example. You can run 
  "bzr checkout --lightweigth http://whatever.com/), this would mean
  creating a directory on the server for each of the potential
  clients, not to mention the impossibility to do it over http.

* You have to manage a name for each lightweight checkout. What would
  be such name? User-provided? uuidgen-like?


I find the way bzr deals with this pretty elegant: a repository with a
working tree is just a working tree and a repository located in the
same directory. The repository stores its files (content of each
revisions in history, ...) in .bzr/repository/, and the working tree
stores them (the index, pending merges, ... and pointer to the
corresponding branch) in .bzr/checkout/.

-- 
Matthieu

From: Bill Lear <rael@zopyra.com>
Subject: Git push failure with update hook success
Date: Wed, 7 Mar 2007 10:29:29 -0600
Message-ID: <17902.59497.831409.218529@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 17:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOz1H-0005q8-RG
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 17:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbXCGQ3g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 11:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbXCGQ3g
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 11:29:36 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60754 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbXCGQ3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 11:29:35 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l27GTXO13831;
	Wed, 7 Mar 2007 10:29:33 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41673>

We seem to have a few permission problems using git through ssh that
we hopefully will resolve.  However, in the course of this, we have
noticed that our update hook runs with no errors, sends out a
confirmation email, but the push to our repo fails (we found that the
log file had improper permissions due to umask botchitude).

So, I surmised that the rough order of things is on our git company
repo is:

o receive the git "package" from the person who is pushing it
o call the update hook, telling it the package that is coming in
o the update hook examines things, forms an email, and sends it out
o the rest of the git machinery then actually applies the changes,
  logs them, etc., but fails (after the email is long gone), and
  on the remote (client) side, the push fails.
o the user gets a confirmation email that the push went ok

So, I was wondering if this is correct (more or less) and if so
whether it might be better to call the update hook after everything
had actually been written, including the log file.


Bill

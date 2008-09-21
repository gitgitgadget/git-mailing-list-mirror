From: Junio C Hamano <gitster@pobox.com>
Subject: [funny] "git checkout -t origin/xyzzy" seems to misbehave
Date: Sun, 21 Sep 2008 01:23:00 -0700
Message-ID: <7v1vzd29i3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 10:32:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhKMu-0000Ng-T7
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 10:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbYIUIXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 04:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbYIUIXQ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 04:23:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbYIUIXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 04:23:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 762F463B4E;
	Sun, 21 Sep 2008 04:23:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DD60963B4D; Sun, 21 Sep 2008 04:23:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 87D545A4-87B6-11DD-A068-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96385>

When you

 * are on a branch "foo" that is not "bar",
 * have "origin/bar",
 * and already have a local branch "bar",

"git checkout -t origin/bar" seems to misbehave.

    $ git clone -s git.junio victim-002
    $ cd victim-002
    $ git branch
    * master
    $ git checkout -t origin/next
    Branch next set up to track remote branch refs/remotes/origin/next.
    Switched to a new branch "next"
    $ git checkout -t origin/master
    fatal: A branch named 'master' already exists.
    $ git branch
      master
    * next
    $ git diff --cached --shortstat
     60 files changed, 2378 insertions(+), 3412 deletions(-)
    $ git diff --cached master
    $ exit

The first "checkout -t" is fine.  The failed one seems to have already
updated the index and the work tree when it notices that it cannot create
a new branch.

I suspect "-t" does not have to be in effect to trigger this; in other
words, "git checkout -b master origin/master" would have the same issue.

I'm reporting this before digging it further myself, because I may not be
able to diagnose this before I leave for a vacation.

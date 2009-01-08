From: jidanni@jidanni.org
Subject: fetch branch blacklist
Date: Thu, 08 Jan 2009 08:07:43 +0800
Message-ID: <87r63ek6cw.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 01:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKiSg-0005Tn-RX
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbZAHAHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755662AbZAHAHs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:07:48 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:38421 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756193AbZAHAHr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 19:07:47 -0500
Received: from jidanni.org (122-127-36-81.dynamic.hinet.net [122.127.36.81])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id B6A729C4E6
	for <git@vger.kernel.org>; Wed,  7 Jan 2009 16:07:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104853>

If one wants to always fetch all except one remote branch, one cannot
just blacklist it, but must instead whitelist all the rest.
$ git branch -rd origin/man origin/html
Deleted remote branch origin/man.
Deleted remote branch origin/html.
Plus I edited them out of FETCH_HEAD. Nonetheless, back from the dead:
$ git pull
From git://git.kernel.org/pub/scm/git/git
 * [new branch]      html       -> origin/html
 * [new branch]      man        -> origin/man
The only solution is to change .git/config:
[remote "origin"]
	url = git://git.kernel.org/pub/scm/git/git.git
#	fetch = +refs/heads/*:refs/remotes/origin/*
	fetch = +refs/heads/maint:refs/remotes/origin/maint
	fetch = +refs/heads/master:refs/remotes/origin/master
	fetch = +refs/heads/next:refs/remotes/origin/next
	fetch = +refs/heads/pu:refs/remotes/origin/pu
	fetch = +refs/heads/todo:refs/remotes/origin/todo
(Such explicit whitelisting will also sacrifice automatic addition or
even notification, if desired, of future new branches too.)
There is a remote.<name>.skipDefaultUpdate variable, but it probably
isn't fine grained enough.

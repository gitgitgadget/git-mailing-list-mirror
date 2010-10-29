From: Mischa POSLAWSKY <shiar@shiar.nl>
Subject: conflict merging directory replaced by symlink
Date: Fri, 29 Oct 2010 19:32:32 +0200
Message-ID: <20101029173232.GA9869@pearl.mediadesign.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 19:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBsvA-0000OK-Pq
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 19:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934194Ab0J2RjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 13:39:15 -0400
Received: from pearl.mediadesign.nl ([195.177.242.41]:46704 "HELO
	pearl.mediadesign.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932294Ab0J2RjO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 13:39:14 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Oct 2010 13:39:14 EDT
Received: (qmail 18431 invoked by uid 1007); 29 Oct 2010 19:32:32 +0200
Content-Disposition: inline
User-Agent: Mutt 1.5.18 + Vim 7.1 (Debian 5.0.6 GNU/Linux 2.6.27.39)
X-URL: http://shiar.nl/
X-Accept-Language: nl, eo, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160347>

Hello list,

After replacing a directory by a symlink, branches without that change will
conflict whenever they change something unrelated in the link target.
To illustrate:

	git init &&
	mkdir common &&
	touch common/test &&
	git add common/test &&
	mkdir dupe &&
	touch dupe/test &&
	git add dupe/test && 
	git commit -m 'initial setup' &&

	git rm -r dupe &&
	ln -s common dupe &&
	git add dupe &&
	git commit -m 'replace dir by symlink' &&

	git checkout -b prelink HEAD^ &&
	touch common/irrelevant &&
	git add common/irrelevant &&
	git commit -m 'additional common file' &&

	git checkout - &&
	git merge prelink

fails in git v1.7.2.3 with:
> CONFLICT (file/directory): There is a directory with name dupe in prelink.
> Adding dupe as dupe~HEAD
> Automatic merge failed; fix conflicts and then commit the result.

I'd expect the same resolution as when adding a symlink from a different
name, without replacing the directory, but this happily merges without
raising a fuss.

Does anyone recognise or know a reason for this behaviour?

Thanks!
-- 
Mischa

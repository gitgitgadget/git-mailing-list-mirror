From: Sergei Organov <osv@javad.com>
Subject: Slight inconsistency between ref delete commands.
Date: Wed, 21 May 2014 14:35:46 +0400
Message-ID: <871tvn5shp.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 12:35:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3sH-0002Xa-Jh
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbaEUKfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:35:50 -0400
Received: from mail.javad.com ([54.86.164.124]:58960 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbaEUKft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:35:49 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 38BF860C03
	for <git@vger.kernel.org>; Wed, 21 May 2014 10:35:48 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1Wn3sA-0003Yv-B2
	for git@vger.kernel.org; Wed, 21 May 2014 14:35:46 +0400
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249791>

Hello,

Was writing conversion script from CVS to git for my repo and noticed
slight inconsistency in git-tag, git-branch, and git-update-ref behavior:

$ git --version
git version 1.9.3
$ git tag -d && echo success
success
$ git branch -d && echo success
fatal: branch name required
$ git update-ref -d && echo success
usage: git update-ref [options] -d <refname> [<oldval>]
   or: git update-ref [options]    <refname> <newval> [<oldval>]
   or: git update-ref [options] --stdin [-z]

    -m <reason>           reason of the update
    -d                    delete the reference
    --no-deref            update <refname> not the one it points to
    -z                    stdin has NUL-terminated arguments
    --stdin               read updates from stdin


Noticed when used xargs without -r switch, like this:

git for-each-ref --format="%(refname)" "refs/tags/*-merge" | xargs -n 1 git update-ref -d

-- Sergey.

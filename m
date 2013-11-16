From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: submodule update and core.askpass
Date: Sat, 16 Nov 2013 22:42:38 +0100
Message-ID: <87eh6gkoq9.fsf@linux-k42r.v.cablecom.net>
References: <m28uwoxcoh.fsf@nds-macbook-air.labs.intellij.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Dmitry Neverov <dmitry.neverov@jetbrains.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 22:43:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhndr-0001ap-D1
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 22:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab3KPVm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 16:42:56 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38759 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab3KPVmy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 16:42:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 971034D6570;
	Sat, 16 Nov 2013 22:42:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2EWRre4BBQyy; Sat, 16 Nov 2013 22:42:40 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A1F854D6414;
	Sat, 16 Nov 2013 22:42:39 +0100 (CET)
In-Reply-To: <m28uwoxcoh.fsf@nds-macbook-air.labs.intellij.net> (Dmitry
	Neverov's message of "Sun, 17 Nov 2013 01:24:30 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237941>

+cc Daniel and Jens

Dmitry Neverov <dmitry.neverov@jetbrains.com> writes:

> git -c core.askpass=pass.sh clone main-repo
> cd main-repo
> git submodule init
> git submodule sync
> git -c core.askpass=pass.sh submodule update
>
> The last command asks for a password interactively. 
>
> I've run bisect, it seems like it started failing from commit
> be8779f7ac9a3be9aa783df008d59082f4054f67. I've checked: submodule update
> works fine in 1.8.5.rc2 with removed call to clear_local_git_env.

Aside from GIT_CONFIG_PARAMETERS, which this needs, I wonder if we
should also let other variables pass through.  For example, if the user
went out of their way to set GIT_ALTERNATE_OBJECT_DIRECTORIES, shouldn't
we also respect that?

The list of variables that is unset by clear_local_git_env is $(git
rev-parse --local-env-vars), currently

  GIT_ALTERNATE_OBJECT_DIRECTORIES
  GIT_CONFIG
  GIT_CONFIG_PARAMETERS
  GIT_OBJECT_DIRECTORY
  GIT_DIR
  GIT_WORK_TREE
  GIT_IMPLICIT_WORK_TREE
  GIT_GRAFT_FILE
  GIT_INDEX_FILE
  GIT_NO_REPLACE_OBJECTS
  GIT_PREFIX

-- 
Thomas Rast
tr@thomasrast.ch

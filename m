From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH 0/2] better handle .gitmodules merge conflicts
Date: Thu, 12 May 2011 23:01:17 +0200
Message-ID: <4DCC4A9D.3060007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 23:01:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKd0f-0004e5-TV
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 23:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698Ab1ELVBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 17:01:20 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:50351 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758634Ab1ELVBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 17:01:19 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4014618EC6E16;
	Thu, 12 May 2011 23:01:18 +0200 (CEST)
Received: from [93.240.105.8] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QKd0Y-0004cY-00; Thu, 12 May 2011 23:01:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/J1RZr/oQ6y8UzRgnklo8GtA8Bagqx2+/uglOQ
	XfBB76PiKuG7sU0le19jJDFSsw2pIcLZSwSQxJf8NB6N2oFyXd
	YqYenTp5HS8J489KD/LQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173497>

This series contains a test to reproduce and a first attempt to fix the
problem that "git diff", "git status" and "git fetch" die early when the
.gitmodules file contains merge conflict markers. As I am not aware of any
bug reports yet it looks like that either doesn't happen very often in the
wild ("git diff" parses the .gitmodules file since 1.7.3, but even as
heavy submodule users we only hit this once just recently) or the users
encountering this problem just know what to do: resolve the conflict and
carry on.

But that is no excuse to behave so unfriendly, especially as this can
happen in a completely normal workflow, when e.g. two users are adding
different submodules in separate branches and they get merged. So this
RFC patch is my first attempt to avoid those commands dying.

In a second step a merge helper capable of merging inifiles would make
sense. This should be enabled for the .gitmodules file by default and
avoid most of the merge conflicts, e.g. when two users add different
submodules in separate branches. But that is a different patch ...


Heiko Voigt (1):
  test that git status works with merge conflict in .gitmodules

Jens Lehmann (1):
  Submodules: Don't parse .gitmodules when it contains merge conflicts

 submodule.c                 |   23 +++++++++-
 t/t7506-status-submodule.sh |  100 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 117 insertions(+), 6 deletions(-)

-- 
1.7.5.1.251.ga75dd

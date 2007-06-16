From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 0/9] Refactoring of command handling
Date: Sun, 17 Jun 2007 00:00:28 +0200
Message-ID: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzgJm-00007H-4h
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbXFPWAW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576AbXFPWAW
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:00:22 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45500 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbXFPWAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:00:21 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BDC735A0AF;
	Sun, 17 Jun 2007 00:00:19 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 1BD431F08A;
	Sun, 17 Jun 2007 00:00:29 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50311>

While working on hydra support, I've hit a couple of issues which I
have handled with a set of relatively large patches: nearly every line
of code under stgit/commands/ gets reindented, because of functions
being changed to instance methods.

I submit this patchset early, despite it being very young, because of
the high risk of conflict with other work and the large amount work it
would require to maintain in parallel - also, since the testsuite does
not cover everything, it is likely that I left a couple of errors
somewhere, and I'd be grateful to have other people shake the code as
well.  Now this set of patches would be a great candidate for a "pu"
branch :)

The next refactoring pass (already in the works but with no
stabilized design yet) will tackle git_id(), which should be
available at generic level, not at the command level.  I'm heading
towards changing it to be a method of a new stgit.Repository class,
pointed to by Commands and PatchSets.

Here is a quick summary:

      Refactor command definition with a Command class.
      Promote more common functions to Command methods.
      Replace crt_series uses with a method call.
	=> those are the heart of the refactoring: we suppress the
	   crt_series global and only create the Series object when
	   needed.  This is a step towards a PatchSet factory which
	   will be able to instantiate a Series or an Hydra from a
	   head name, without a need for the called to be aware of the
	   existence of PatchSet subclasses.

      Fixed thinko in error message.
      Add a constructor to PatchSet.
      Cleanup the use of the Series class.
      Changed sync not to use -b which has other semantics.
	=> cleanup needs discovered while refactoring

      Fix contrib/stg-whatchanged way of identifying a conflict.
	=> fixing the tools that help getting the patches done :)
      Revert part of the reverted commit that we want to keep.
	=> mostly here so we don't loose it, and limit the conflicts
	  when I pulled from you :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH] An option parser for the sequencer
Date: Sat,  9 Jul 2011 15:41:57 +0000
Message-ID: <1310226118-10201-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 09 17:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfZfj-00089Y-80
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 17:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab1GIPmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jul 2011 11:42:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48202 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab1GIPmB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2011 11:42:01 -0400
Received: by vws1 with SMTP id 1so1974456vws.19
        for <git@vger.kernel.org>; Sat, 09 Jul 2011 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=qLCUh+rmo1Y0z9nvd5Cvt4thUZemRAYTpVoDDitLnPg=;
        b=Eq4iLmDHxZJs3AUQIOcoajnjoCBU/DaZBgOqlFYdC2FlDTfoZXzLdft30gvG60fxbb
         xe2D4mC3BIyEzI+Lw5OkvLJo63tgCMvsMatQAuOxTOZp0tv+WGF2ielZRCxJxNA9IPWJ
         KeshPvO4N8Co53CMyD4vwii9DjGIL3iQoXUos=
Received: by 10.52.175.132 with SMTP id ca4mr3920810vdc.98.1310226120571;
        Sat, 09 Jul 2011 08:42:00 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id fm10sm3000306vbb.6.2011.07.09.08.41.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Jul 2011 08:41:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176816>

Hi,

I've decided not to support arbitrary command-line options in the
instruction sheet.  A typical instruction sheet will looks like this
(inspired heavily by the rebase -i instruction sheet format):

pick 3b36854 t: add tests for cloning remotes with detached HEAD
pick 61adfd3 consider only branches in guess_remote_head
pick 8537f0e submodule add: test failure when url is not configured in superproject
pick 4d68932 submodule add: allow relative repository path even when no url is set
pick f22a17e submodule add: clean up duplicated code
pick 59a5775 make copy_ref globally available
pick c1921c1 clone: always fetch remote HEAD

For persisting one set of options for every "git cherry-pick"/ "git
revert" invocation, I've decided to use a simple "key = value" format
and put it in .git/sequencer/opts (to sit beside .git/sequencer/head
and .git/sequencer/todo).  For strategy-option, I thought it would be
cute to separate the various options using ' | '.  So, it'll look
something like this in the end:

signoff = true
mainline = 1
strategy-option = recursive | ours

The implementation is a little rough around the edges, but I'm pretty
happy with the overall design: it looks like a scaled-down version of
parse-options.  Quite a lot of context is missing (where did
sequencer.h come from?!), but I hope it's clear enough to convey the
idea.

Thanks for reading.

Ramkumar Ramachandra (1):
  revert: Persist per-session opts

 builtin/revert.c |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |    8 +++
 2 files changed, 151 insertions(+), 0 deletions(-)

-- 
1.7.5.GIT

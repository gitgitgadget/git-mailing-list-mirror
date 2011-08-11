From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] Towards a generalized sequencer
Date: Fri, 12 Aug 2011 00:21:39 +0530
Message-ID: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 11 20:54:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QraOz-0002wl-NG
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 20:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab1HKSyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 14:54:41 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63951 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab1HKSyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 14:54:40 -0400
Received: by pzk37 with SMTP id 37so4115440pzk.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wiq0BqVYe6rwTwWMD48rb97cAVdzoM489vGChR912DU=;
        b=M3jMrpILfNI6lN15zM9OrpsrGJQKgklB5iFpozXq2CJUJA9ohTh1k9WN/sg5tcxaNV
         a5u19bXyH9HpaL1ntO1RapWi8/kvzNo9JCzBswyd+O4iFXjQqh3bTCzQ/PrO9aSBQXIT
         FC+mtqXOf6aPYgntLc9XCIJjValaVqnnp+m1o=
Received: by 10.142.213.9 with SMTP id l9mr1632484wfg.233.1313088880190;
        Thu, 11 Aug 2011 11:54:40 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id t7sm1117355wfl.2.2011.08.11.11.54.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 11:54:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179128>

Hi,

I've prepared a nicer series after Jonathan's feedback on the previous
one.  No new ideas; just the same ideas implemented in a more sane
way.  The first three patches fix some minor annoyances and don't
dontribute much to the series in general.  The fourth patch implements
a very important idea: the ability to parse a general (action,
operand) pair in the instruction sheet.  The fifth patch may come as a
real shocker; I was shocked myself, but I'm now convinced that this is
the right way forward.  Since it's only code movement, it should be
very easy to review.  The final patch solves a long-standing problem
by introducing tighter coupling between 'git commit' and the
sequencer.

Thanks for lending a ear.  Enjoy reading the rest!

Note: I didn't know what to do with the license header in the fifth
patch.  I just assumed that it was some historical cruft and removed
it.

Ramkumar Ramachandra (6):
  revert: Don't remove the sequencer state on error
  revert: Free memory after get_message call
  revert: Parse instruction sheet more cautiously
  revert: Allow mixed pick and revert instructions
  sequencer: Expose API to cherry-picking machinery
  sequencer: Remove sequencer state after final commit

 builtin/commit.c                |    7 +-
 builtin/revert.c                | 1012 +--------------------------------------
 sequencer.c                     |  962 +++++++++++++++++++++++++++++++++++++-
 sequencer.h                     |   37 ++
 t/t3510-cherry-pick-sequence.sh |   91 ++++-
 5 files changed, 1099 insertions(+), 1010 deletions(-)

-- 
1.7.6.351.gb35ac.dirty

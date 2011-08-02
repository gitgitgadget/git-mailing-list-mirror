From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Iterating over a stable series
Date: Tue,  2 Aug 2011 10:24:43 +0530
Message-ID: <1312260884-5087-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 02 06:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo73F-0004f6-QV
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 06:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab1HBE5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 00:57:53 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34635 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1HBE5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 00:57:52 -0400
Received: by pzk37 with SMTP id 37so12781727pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 21:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+0ec0hyLxLLTBzxni7trE4uyLToMD+lmGXydw08o9wI=;
        b=m5/EvC9dxR+wduOIskqFHoVnGmc9wMe/9auQ8MblHVyoYC9wbDHEwNAVC1y0KEpO/n
         U/iojVDzygSTWbzy1I87dtcf1YK7ya6dGu9IgFMtnolV6XwZsG00y1gCGQ4KbYwHTNTp
         LswKE9wDCEVkNlv3I3+seignlLOEJlcZ3Ufi0=
Received: by 10.68.12.36 with SMTP id v4mr1358134pbb.165.1312261071980;
        Mon, 01 Aug 2011 21:57:51 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id k3sm6324675pbj.77.2011.08.01.21.57.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 21:57:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178440>

Hi,

The post midterm work is suffering because I'm constantly rewriting
the sequencer-stable series: I often resort to throwing away big
patches that move functions from builtin/revert.c to sequencer.c.
Hopefully, the latest iteration [1] will not require rewriting.

I'd like some early feedback for one of the "design patches" in my new
series: I've chosen to use a commit + action to represent a todo_list.
I'd initially tried a commit + opts keeping future expantion in mind
(allowing instruction-specific command-line options), but the result
is quite inelegant.  Although commit message/ tests are missing, I'd
like to describe the intent in detail:

This patch is a prerequisite for decoupling todo parsing from opts
parsing.  I want to decouple them so that I can achieve tighter
coupling between "git commit" and the sequencer [2].  After that, I
want to craft a nice API and move/ expose various functions in
builtin/revert.c starting with the parsing functions.

Thanks for reading.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/178372
[2]: http://mid.gmane.org/CALkWK0=9kwgtZB-BA12tOQrQXS8XRbhTg6K=Ak00o2nurX16Fg@mail.gmail.com

Ramkumar Ramachandra (1):
  revert: Allow arbitrary sequencer instructions

 builtin/revert.c |  101 +++++++++++++++++++++++++++++-------------------------
 sequencer.h      |   10 +++++
 2 files changed, 64 insertions(+), 47 deletions(-)

-- 
1.7.6.351.gb35ac.dirty

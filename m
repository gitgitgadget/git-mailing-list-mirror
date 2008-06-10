From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Tue, 10 Jun 2008 10:10:27 +0200
Message-ID: <cover.1213084587.git.marius@trolltech.com>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 10:14:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5yzf-0006ET-KA
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 10:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbYFJIM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 04:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbYFJIM5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 04:12:57 -0400
Received: from hoat.troll.no ([62.70.27.150]:34167 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860AbYFJIMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 04:12:55 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id AA76620A90;
	Tue, 10 Jun 2008 10:12:49 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 934932045A;
	Tue, 10 Jun 2008 10:12:49 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84480>

When you use 'git show <rev>:<file>' or 'git show :<stage>:<file>',
the objects are shows as they are in the object store, ignoring the
core.autocrlf configuration.

This series adds testcases which checks the stage files in a merge
conflict, and a fix for the problem.

Running all testcases before and after the fix reveals no regressions:

Before patch series:
    ./aggregate-results.sh test-results/t*-*
    fixed   1
    success 3374
    failed  0
    broken  2
    total   3377
    
After patch series:    
    ./aggregate-results.sh test-results/t*-*
    fixed   1
    success 3377
    failed  0
    broken  2
    total   3380
    rm -f -r 'trash directory' test-results

Marius Storm-Olsen (2):
  Add testcases for verifying that staged files in a conflict are CRLF,
    when core.autocrlf = true
  Ensure that objects shown in a core.autocrlf = true repo have CRLF
    EOLs

 builtin-log.c         |   19 ++++++++++++++-----
 t/t6033-merge-crlf.sh |   18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

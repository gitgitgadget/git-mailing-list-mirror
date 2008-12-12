From: Charles Bailey <charles@hashpling.org>
Subject: Updates to the previous mergetool patches
Date: Fri, 12 Dec 2008 21:48:39 +0000
Message-ID: <1229118521-22923-1-git-send-email-charles@hashpling.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 22:50:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBFtp-00072z-Tw
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 22:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbYLLVtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 16:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbYLLVtA
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 16:49:00 -0500
Received: from ptb-relay02.plus.net ([212.159.14.146]:34032 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbYLLVs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 16:48:59 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1LBFsM-0007cB-6Z; Fri, 12 Dec 2008 21:48:46 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mBCLmjXt022982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Dec 2008 21:48:45 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id mBCLmfei022981;
	Fri, 12 Dec 2008 21:48:41 GMT
X-Mailer: git-send-email 1.6.1.rc1.342.g83b24d
X-Plusnet-Relay: b5bb64cb6ee1c1c7a99eb460aa60105e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102944>

These two patches go on top of 682b451f and replace the 'DONTMERGE'
commit: 09b511016. If it would be easier if I cooked these in a
different way then let me know.

I've implemented a replacement for the "keep going" option which is now
to prompt after a failed merge to see if the user wants to continue
merging the remaining paths. This gets rid of a need for an option of
configuration option.

I haven't implemented any change to the logic as to whether to pause
before invoking the merge tool based on which merge tool is being used.

The added tests for the return status of the merge are slightly less
neat than I would have liked, but I think are necessary. I test after
invoking the merge tool to make sure that the "roll-up" status is
correct, and before invoking the next tool to see if the user wants to
continue despite the failure of the previous merge.

Only testing after the merge tool invocation can end up with a "do you
want to continue" before mergetool has determined that there are, in
fact, no more files to merge. Only testing before the merge means that
the status of the last merge doesn't contribute to the script's return
value. I don't know how many people rely on the return value of git
mergetool, but why not keep it consistent?

The second patch makes optional the retention of temporary files on a
failed merge optional. It seperates out the behaviour change that I'd
forgotten I'd left in the previous version of the "-k" patch.

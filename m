From: David Greene <greened@obbligato.org>
Subject: [PATCH] Teach cherry-pick and rebase to ignore redundant commits
Date: Sun, 10 Jan 2016 23:00:16 -0600
Message-ID: <1452488421-26823-1-git-send-email-greened@obbligato.org>
Cc: gitster@pobox.com, peff@peff.net, chris@arachsys.com,
	nhorman@tuxdriver.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 06:01:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIUbz-0005cL-UE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 06:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbcAKFBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 00:01:07 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53956 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751035AbcAKFAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 00:00:38 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aIUbu-0005H8-K5; Sun, 10 Jan 2016 23:01:42 -0600
X-Mailer: git-send-email 2.6.1
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283638>

This patch set adds a --skip-redundant-commits option to both
cherry-pick and rebase.  Currently, if cherry-pick applies a
commit that happens to become empty after conflict resolution,
it will abort and ask the user what to do.  This behavior
propagates to rebase when rebase is forced to fall back to
cherry-pick in certain situations.

This abort failure mode makes it difficult to script certain
types of operations that users might expect to work: for example
cherry-picking a commit on top of itself or rebasing a set of
commits back onto its own history.

With --skip-redundant commits users and/or scripts can choose
to have cherry-pick/rebase simply ignore the redundant commit
and move on.  There is already a --keep-redundant-commits flag
so this is really just supplying the natural counter-behavior
users might way.

                     -Davod

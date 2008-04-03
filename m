From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Blame in reverse
Date: Thu, 03 Apr 2008 02:08:45 -0700
Message-ID: <7v4paj486a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 11:09:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhLRx-0005eb-Se
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 11:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286AbYDCJIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 05:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756406AbYDCJIv
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 05:08:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756261AbYDCJIv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 05:08:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9684C22E9;
	Thu,  3 Apr 2008 05:08:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1D9A622E6; Thu,  3 Apr 2008 05:08:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78734>

This is still rough, but I think it would be a good foundation to build
interesting archaeology tools on.

Usual "git blame" starts from the latest revision and finds where each
line came from (i.e. who came up with that brilliant idea, or more often
who introduced that bug).  This new mode starts from an old revision, and
annotates in reverse --- up to which point each line survived, before it
got replaced with something else.  A line that began its life in one file
can be removed from the original file but migrate to another, and we will
find its final resting place when you use the usual -C -C option.

 [1/4] "log" and friends: --children option
 [2/4] builtin-blame.c: move prepare_final() into a separate function.
 [3/4]  builtin-blame.c: allow more than 16 parents
 [4/4] git-blame --reverse

 builtin-blame.c |  206 +++++++++++++++++++++++++++++++++++++++----------------
 log-tree.c      |   20 ++++++
 revision.c      |   28 ++++++++
 revision.h      |    1 +
 4 files changed, 196 insertions(+), 59 deletions(-)

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] Allow tags as upstreams for --track
Date: Mon, 11 May 2009 16:42:52 +0200
Message-ID: <1242052974-28184-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 16:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3WjA-0003qm-ID
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 16:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbZEKOnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 10:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756748AbZEKOnE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 10:43:04 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39749 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756758AbZEKOnD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 10:43:03 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id CF87A342189;
	Mon, 11 May 2009 10:43:03 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 11 May 2009 10:43:03 -0400
X-Sasl-enc: 7lBbji06NmuTI5CI8RZJUEUctMbqCUqGvyvadFQISpXp 1242052983
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 45A044FA40;
	Mon, 11 May 2009 10:43:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.195.gad816
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118804>

I sent this patch during rc without a test and it received the
appropriate reaction ;)

Now, comes with test and all that...

This is about using tags as the upstream for --track (checkout,
branch). Currently, git allows to do that but all status generating
commands (status, checkout, branch -v) barf when the upstream is not a
commit, such as an annotated tag. So, either we should disallow this or
deal with it. The latter is actually easier, sometimes useful and does
not harm any living creatures.

The first patch exposes the issue by 2 tests: lightweight tags are OK,
annotated tags are not.

The second patch teaches stat_tracking_info() to resolve a reference to
a commit before using it.

Tags as upstreams can be useful because then branch -vv gives you concise
information about how much work you have done say on top of a released
version, in case where the "behind" information with respect to a branch
would be less informative (Where did I fork?) and confusing (Behind?
What do you mean behind for a branch on top of a released version?).

Michael J Gruber (2):
  Test tracking of non-commit upstreams
  Fix behavior with non-committish upstream references

 remote.c                 |    4 ++--
 t/t6040-tracking-info.sh |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hg-to-git: handle an empty dir in hg by combining git commits
Date: Sat, 01 Dec 2007 12:02:46 -0800
Message-ID: <7vd4tq41zt.fsf@gitster.siamese.dyndns.org>
References: <4751A0FB.6090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stelian@popies.net, git@vger.kernel.org
To: Mark Drago <markdrago@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 21:03:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyYYp-0004gs-5o
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 21:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbXLAUCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 15:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbXLAUCy
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 15:02:54 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37637 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbXLAUCx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 15:02:53 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9C8132F0;
	Sat,  1 Dec 2007 15:03:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 37F879BCCF;
	Sat,  1 Dec 2007 15:03:10 -0500 (EST)
In-Reply-To: <4751A0FB.6090705@gmail.com> (Mark Drago's message of "Sat, 01
	Dec 2007 12:59:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66736>

Mark Drago <markdrago@gmail.com> writes:

> This patch will detect that there are no changes to commit (using git-status),
> and will not perform the commit, but will instead combine the log messages of
> that (non-)commit with the next commit.

I think a better approach would be to implement --no-tree-change-is-ok
option to git-commit, strictly for use by foreign scm interface scripts
like yours.  It does not usually make sense to record a commit that has
the exact same tree as its sole parent commit and that is why git-commit
prevents you from making that mistake, but when data from foreign scm is
involved, it is a different story.  We are equipped to represent such a
(perhaps insane, perhaps by mistake, or perhaps done on purpose) change
and it is better to represent it bypassing the safety valve for native
use.

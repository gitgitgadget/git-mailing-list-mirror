From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] fsck_commit: remove duplicate tests
Date: Sun, 03 Feb 2008 15:58:57 -0800
Message-ID: <7v3as9r3r2.fsf@gitster.siamese.dyndns.org>
References: <12020737593747-git-send-email-mkoegler@auto.tuwien.ac.at>
	<12020737601683-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 04 00:59:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLokU-0008Q8-SB
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 00:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbYBCX7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 18:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbYBCX7N
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 18:59:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbYBCX7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 18:59:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 57C667860;
	Sun,  3 Feb 2008 18:59:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DBC7B785F;
	Sun,  3 Feb 2008 18:59:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72425>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> All tests on the commit buffer in fsck_cmd are ready done by
> parse_commit_buffer.
>
> This patch rips out all redundant tests.

As I believe in belt-and-suspenders when it comes to validation,
I am somewhat uneasy with this change.  If it ever turns out
that we would need to make parse_commit_buffer() more lenient
during the normal operation, some of this would need to be
reverted (for example, you may not need to have a valid "tree"
to salvage the log messages from a corrupt history by running
"git log"), and forgetting to do so will result in fsck that
does not validate enough.

The validation done by parse_commit_buffer() and fsck serve two
different purposes, and they can have different leniency
requirements.  I do not necessarily agree that it is a good idea
to tie them together like this patch.

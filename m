X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git: how to produce context diffs?
Date: Mon, 27 Nov 2006 11:18:32 -0800
Message-ID: <7v8xhwhf5j.fsf@assigned-by-dhcp.cox.net>
References: <200611271516.30425.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 19:19:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32439>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Golzy-0004gu-4V for gcvg-git@gmane.org; Mon, 27 Nov
 2006 20:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933320AbWK0TSe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 14:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbWK0TSe
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 14:18:34 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44269 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S933320AbWK0TSd
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 14:18:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127191833.DWEZ27894.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 14:18:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rvJ11V00F1kojtg0000000; Mon, 27 Nov 2006
 14:18:01 -0500
To: Bruno Haible <bruno@clisp.org>
Sender: git-owner@vger.kernel.org

There are a few things to note:

 * Obviously diff.c::builtin_diff() needs to be taught to
   generate the new format, both in the patch text and also in
   the patch and hunk header part.

 * Corresponding changes to builtin-apply.c need to be made;
   most of the functions in the callchain that starts at
   apply_patch() down to apply_one_fragment() need to be taught
   about the copied context format.  Also code to count diffstat
   in builtin-apply.c needs to be adjusted.  This part should be
   done first before diff.c if we were to support copied context
   diff, because we should not be generating what we cannot
   apply.

 * I do not think of a sane way to show a combined diff from
   multiple preimages in copied context format; combine-diff.c
   can probably be left as it is.

I too find larger hunks easier to read with copied context than
with unified context, but what needs to be done listed above is
a nontrivial amount of work.  Since the beginning, git has only
supported unified context format and not copied context format,
and apparently people who lived with git for the last 18 months
have survived without copied context format, so it is of very
low priority even for me right now.

I am not opposed to adding the copied context format as long as
somebody else does the work ;-).

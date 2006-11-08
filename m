X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: New improved formatting of chunk header in diff
Date: Wed, 08 Nov 2006 12:41:33 -0800
Message-ID: <7vfyctsmbm.fsf@assigned-by-dhcp.cox.net>
References: <200611081147.52952.jnareb@gmail.com>
	<200611081150.07469.jnareb@gmail.com>
	<200611081758.57597.jnareb@gmail.com>
	<200611081800.16001.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 20:41:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31156>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhuEt-0004mu-1j for gcvg-git@gmane.org; Wed, 08 Nov
 2006 21:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423660AbWKHUlf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 15:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423679AbWKHUlf
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 15:41:35 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49819 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1423660AbWKHUle
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 15:41:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061108204134.RNKJ7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 15:41:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kLhf1V00J1kojtg0000000; Wed, 08 Nov 2006
 15:41:39 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

This regresses on hunks of form "@@ -n +m,l @@" and friends, so
I dropped it for now.

I've applied other three patches but with manual tweaks while I
demangled the linewrap, so please sanity check the result after
it mirrors out.  I also noticed that we unconditionally give
blame link in "diff-tree --name-status" part of commitdiff, so
I've fixed it up as well.

I think you still leak control characters in commit messages and
htmlized blob text view; and perhaps others like blame.  I have
made quot_cec into a separate sub that is callable from outside
esc_path, so these places should be able to reuse it to make
control characters "visible and safe" and keep the presentation
consistent.  The non-path callers would not feed tabs into the
function (I haven't looked at the code but I suspect you would
replace them into runs of spaces to the next tab stop by hand),
but other controls need to be quoted.



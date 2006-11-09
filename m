X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Wed, 08 Nov 2006 16:15:18 -0800
Message-ID: <7v1wodqxux.fsf@assigned-by-dhcp.cox.net>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net>
	<200611090104.32247.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 00:15:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611090104.32247.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 9 Nov 2006 01:04:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31170>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhxZj-0006bz-ES for gcvg-git@gmane.org; Thu, 09 Nov
 2006 01:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161754AbWKIAPU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 19:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161767AbWKIAPU
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 19:15:20 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:60864 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1161754AbWKIAPT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 19:15:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109001518.ZOBX4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 19:15:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kQFP1V00p1kojtg0000000; Wed, 08 Nov 2006
 19:15:24 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> 1. First, esc_path should _not_ use subroutine which does it's own 
> contol characters escaping. That was also a mistake I made in my patch.
> Perhaps we should have some quot_html or to_html subroutine which does 
> _only_ to_utf8 (decode from Encode module), escapeHTML and optionally 
> s/ /&nbsp;/g conversion.

I hated that original arrangement, but I do not see anything
obviously wrong in the output with the patch you are responding
to.  Except that git_blame2 is missing a chomp() on "my $data"
after finishing the metainfo loop, that is.

> 2. In my opinion CS is better than CEC for quoting/escaping control 
> characters in the "bulk" output, namely "blob" output and "text 
> diff" (patchset body) output. CEC is better for pathnames (which must 
> fit in one line), and perhaps other one-liners; perhaps not.

I am more for code reuse and consistency.  If "^L" is more
readable then we should consistently use it for both contents
and pathnames.  One of my tests were a symlink that points at a
funny filename ;-).

> BTW. what had happened with to_qtext post?

Sorry, I don't recall.

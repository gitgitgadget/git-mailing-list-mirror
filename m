X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x  proxying
Date: Thu, 23 Nov 2006 14:01:37 -0800
Message-ID: <7v64d5keke.fsf@assigned-by-dhcp.cox.net>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 22:01:49 +0000 (UTC)
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>
	(Inaki Arenaza's message of "Wed, 22 Nov 2006 23:26:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32160>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnMda-0002AJ-JJ for gcvg-git@gmane.org; Thu, 23 Nov
 2006 23:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934138AbWKWWBj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 17:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934147AbWKWWBj
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 17:01:39 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57311 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S934138AbWKWWBj
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 17:01:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123220138.HFMK5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 17:01:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qN1m1V0081kojtg0000000; Thu, 23 Nov 2006
 17:01:46 -0500
To: Inaki Arenaza <iarenuno@eteo.mondragon.edu>
Sender: git-owner@vger.kernel.org

Thanks.  The patch looks very sane, isolated to be safe enough,
and useful.

Except that this statement made me go "huh?" wondering what it
would do to the $filehandle to evaluate <$filehandle> in a void
context:

+			# Skip the empty line of the proxy server output
+			<$s>;

and I ended up looking in perlop.pod and came up empty.

The "I/O Operators" section talks about evaluating <$s> in a
scalar context (i.e. "$rep = <$s>"), which we all know would
return a single line, and in list context, which swallows
everything up to EOF, an obvious disaster for this particular
use.  I couldn't find how it is defined to behave in a void
context.  By experiments I know this returns only one line, but
it leaves me feeling somewhat uneasy.

Also it has a style inconsistency between "if(expression) {" and
"if(expression){", and I do not like either of them, but fixing
that should be left to a separate patch.

I'll apply this unless Martin or other people on the list who
have stake in cvsimport objects.

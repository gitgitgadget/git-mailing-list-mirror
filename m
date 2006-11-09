X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Thu, 09 Nov 2006 01:55:27 -0800
Message-ID: <7vlkmlkkq8.fsf@assigned-by-dhcp.cox.net>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net>
	<200611090104.32247.jnareb@gmail.com>
	<200611091024.35019.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 09:55:34 +0000 (UTC)
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Luben Tuikov <ltuikov@yahoo.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611091024.35019.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 9 Nov 2006 10:24:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31188>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi6dA-0006YF-Mq for gcvg-git@gmane.org; Thu, 09 Nov
 2006 10:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754770AbWKIJz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 04:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754814AbWKIJz3
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 04:55:29 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64713 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1754770AbWKIJz2
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 04:55:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109095527.WLAT5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Thu, 9
 Nov 2006 04:55:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kZvY1V00K1kojtg0000000; Thu, 09 Nov 2006
 04:55:33 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>> I'm not sure what quoting to choose for esc_attr, but there we could
>> use even --no-control-chars quoting (replacing any control character
>> by '?');  but perhaps in some cases like git_print_page_path
>> subroutine CEC is better.

To be honest, I do not have strong preference between the
escaping style.  If the gitweb cabal feel it is more natural to
see "^L" in blobs and "\f" in path, I will very happily accept
such a patch.

> I'm rambling. esc_attr is special case, because CGI does escapeHTML
> (and I hope also to_utf8) for us. Using <span class="cntrl">...</span>
> has also no sense. So there should be separate esc_attr_path subroutine
> I think.

Yes.  It is unfortunate that there needs different types of
quoting.  I think the first step would be to stop calling
esc_html in esc_path.  I think it was a mistake, and I did not
correct it when I started touching it.

Somehow I ended up spending sizeable part of my git day this
week on fixing up blob/blame/tag/commit message view regarding
this "make controls visible and safe" issues on the 'master'
branch, but I have been consciously staying out of gitweb/ part
of the system, primarily because there are many other people who
are more interested and qualified in it than myself.

I'll step aside and try not to get in the way.  There is another
thing I noticed while testing it with an artifitial test that I
haven't fixed, but I think you already know about it (when the
commitdiff is completely empty except mode changes, we end up
with unbalanced div).  My test's tip can be found at
'gitweb-test-funny-char' branch temporarily in the git.git
repository.

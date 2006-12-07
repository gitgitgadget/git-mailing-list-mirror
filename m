X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Commit f84871 breaks build on OS X
Date: Thu, 07 Dec 2006 14:55:18 -0800
Message-ID: <7virgnqpt5.fsf@assigned-by-dhcp.cox.net>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
	<81b0412b0612070633i7aec43dse7a8beda64437103@mail.gmail.com>
	<86ejrbihnr.fsf@blue.stonehenge.com>
	<7vmz5zqqo7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 22:55:45 +0000 (UTC)
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vmz5zqqo7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 07 Dec 2006 14:36:40 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33645>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsS9R-0002lB-4u for gcvg-git@gmane.org; Thu, 07 Dec
 2006 23:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163566AbWLGWzW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 17:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163563AbWLGWzW
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 17:55:22 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62003 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163567AbWLGWzU (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 17:55:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207225519.VGFA18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 17:55:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vyvV1V00c1kojtg0000000; Thu, 07 Dec 2006
 17:55:30 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>>>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:
>>
>> Alex> Strange. You seem to have the old, generated Makefile you perl/
>> Alex> directory. Haven't your pull failed? If so, I suspect that
>>
>> Alex>  rm perl/Makefile
>> Alex>  git reset --hard
>> Alex>  git pull git...
>>
>> I ended up having to do another reset afterward.
>>
>> Definitely something went weird when Makefile was removed
>> from .gitignore.
>
> Yes, perl/Makefile is getting overwritten by what Makefile.PL
> generates.  I thought the point of Alex's patch was to have it
> muck with perl.mak and leave the tracked Makefile alone?

Now, I am CLUELESS about what MakeMaker does, but would this
help?

--- 
diff --git a/perl/Makefile b/perl/Makefile
index bd483b0..099beda 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -29,7 +29,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
-	'$(PERL_PATH_SQ)' $< FIRST_MAKEFILE='$@' PREFIX='$(prefix_SQ)'
+	'$(PERL_PATH_SQ)' $< PREFIX='$(prefix_SQ)'
 endif
 
 # this is just added comfort for calling make directly in perl dir
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index de73235..4168775 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -24,5 +24,6 @@ WriteMakefile(
 	NAME            => 'Git',
 	VERSION_FROM    => 'Git.pm',
 	PM		=> \%pm,
+	MAKEFILE	=> 'perl.mak',
 	%extra
 );


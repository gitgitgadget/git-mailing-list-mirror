X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Thu, 09 Nov 2006 02:34:50 -0800
Message-ID: <7v8xiklxh1.fsf@assigned-by-dhcp.cox.net>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net>
	<200611091024.35019.jnareb@gmail.com>
	<7vlkmlkkq8.fsf@assigned-by-dhcp.cox.net>
	<200611091102.56565.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 9 Nov 2006 10:35:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611091102.56565.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 9 Nov 2006 11:02:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31193>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi7Fb-00056d-ME for gcvg-git@gmane.org; Thu, 09 Nov
 2006 11:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754806AbWKIKex convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006 05:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbWKIKew
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 05:34:52 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59583 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1754806AbWKIKew
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006
 05:34:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109103451.WJHV97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Thu, 9 Nov
 2006 05:34:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kaaw1V00E1kojtg0000000; Thu, 09 Nov 2006
 05:34:57 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> [...] =A0There is another
>> thing I noticed while testing it with an artifitial test that I
>> haven't fixed, but I think you already know about it (when the
>> commitdiff is completely empty except mode changes, we end up
>> with unbalanced div). =A0My test's tip can be found at
>> 'gitweb-test-funny-char' branch temporarily in the git.git
>> repository.
>
> Damn. I thought I corrected this on resend...

I think you need this, otherwise when the last filepair changes
only metainfo you fail to close the extended header div.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1a757cc..e54a29e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2338,6 +2338,8 @@ sub git_patchset_body {
=20
 		print format_diff_line($patch_line);
 	}
+	print "</div>\n" if $in_header; # extended header
+
 	print "</div>\n" if $patch_found; # class=3D"patch"
=20
 	print "</div>\n"; # class=3D"patchset"

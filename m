Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6337207D2
	for <e@80x24.org>; Sun, 25 Jun 2017 09:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdFYJfH (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 05:35:07 -0400
Received: from oker.escape.de ([194.120.234.254]:37721 "EHLO oker.escape.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751321AbdFYJfH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 05:35:07 -0400
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.14.4/8.14.4/$Revision: 1.86 $) with ESMTP id v5P9Z37h009734;
        Sun, 25 Jun 2017 11:35:03 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.14.4/8.14.4/Submit) with UUCP id v5P9Z3Yb009727;
        Sun, 25 Jun 2017 11:35:03 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id v5P9UdTN020357;
        Sun, 25 Jun 2017 11:30:39 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id v5P9UcHH020354;
        Sun, 25 Jun 2017 11:30:38 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     git@vger.kernel.org
Cc:     Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Migration from CVS to Git looses merges
References: <ygfd19stua3.fsf@tehran.isnogud.escape.de>
        <87a84web83.fsf@linux-m68k.org>
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   25 Jun 2017 11:30:38 +0200
In-Reply-To: <87a84web83.fsf@linux-m68k.org>; from Andreas Schwab on Sun, 25 Jun 2017 10:13:32 +0200
Message-ID: <ygf7f00tnwh.fsf@tehran.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> Merges are recognized purely by matching the commit message, and the
> regexp must capture the branch name in the first subexpr.  The -m option
> enables some default regexps but won't match your example.  You can use
> -M 'Merge branch ([-\w]+)' to match it.

Thanks, I tried again and now it works.  I misread the man page and
also tried enclosing the regexp in //, also tried to escape the
parentheses (as in BRE), and I thought I also tried 'Merge branch (.*)'.
Obviously, I missed that one since it now works.

BTW, I now looked up the regexes for -m in git-cvsimport.perl.  Should
probably in the man page.

I also suggest the following patch, so that -m would work with my not
so uncommon merge commit message:

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1e4e65a..1f8044b 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -207,7 +207,7 @@ if ($#ARGV == 0) {
 
 our @mergerx = ();
 if ($opt_m) {
-	@mergerx = ( qr/\b(?:from|of|merge|merging|merged) ([-\w]+)/i );
+	@mergerx = ( qr/\b(?:from|of|merge|merging|merged) (?:branch )?([-\w]+)/i );
 }
 if (@opt_M) {
 	push (@mergerx, map { qr/$_/ } @opt_M);


urs

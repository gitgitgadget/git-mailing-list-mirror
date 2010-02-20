From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH squash] Simplify test-terminal.perl
Date: Sat, 20 Feb 2010 03:48:20 -0600
Message-ID: <20100220094820.GA32456@progeny.tock>
References: <20100219080819.GA13691@coredump.intra.peff.net>
 <20100219081947.GA12975@progeny.tock>
 <20100219083440.GC13691@coredump.intra.peff.net>
 <28d--OB9y5MtIy1nJel2Km6d5sqJ3yX6fVUhecDU5ehJUYJmZlE0-A@cipher.nrlssc.navy.mil>
 <setkR9a6yaRMOU11ekUmlY6ty8nNSPCcidBKotdDxpQsZLCxc54hKw@cipher.nrlssc.navy.mil>
 <20100220003950.GA18550@progeny.tock>
 <ee63ef31002191942h7fbbb6bt627cd36ea343e606@mail.gmail.com>
 <20100220052504.GA24697@progeny.tock>
 <7vaav42ya1.fsf@alter.siamese.dyndns.org>
 <20100220085025.GA26788@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 10:48:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nilwb-0000ZS-SZ
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 10:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab0BTJsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 04:48:08 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:35519 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab0BTJsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 04:48:06 -0500
Received: by ywh35 with SMTP id 35so884006ywh.4
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2biWOHQftax4z1JrbpvOrmLPJqhDtSAzsGHPM8KNWbI=;
        b=XDFkjihSmsjgyqL0pETOAkeIOGJuIqiCFudljtyoD0fF2MEKewMFWfOmru2jMyAuPP
         YGzvg1Z8VgjGjLqexipx1/tpFaOfMnjM5xT4UYEjm/ZgFFQe82sa2QVKI/8iPEK3SURl
         tiwtIwGsQ8J6ZWng36yKHcn9n9sqm81ekOifs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BJ7XlB7PM2+H11/bHtEPPimqULV83h3y8qAJpaQKghOpIbJmRDUIBudV0lgzknylIa
         KmL8NSp8HcdLi3qTVdmrlSlr9jz0Cb4hhr5KB5DIfc5XUlbM21BJI/kAW3r1AaM0MxJL
         d7J0MoiQk7EbWbVsiylym5kxNIbNBvWJP+MKw=
Received: by 10.101.189.30 with SMTP id r30mr5645109anp.70.1266659282957;
        Sat, 20 Feb 2010 01:48:02 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 5sm489593yxd.71.2010.02.20.01.48.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 01:48:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100220085025.GA26788@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140522>

The File::Copy module is included with perl (since version 5.002,
1995), so this simplification comes for free.  It does not make the
test noticeably faster or slower.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:
> it is much slower than the C version.

I take that back.  The perl version takes roughly 3.7 s and the
C version 3.4 s here (both with hot cache).  Noticeable alone, but a
tiny blip in the context of a full test run.

Sorry to mislead.

 t/t7006/test-terminal.perl |   26 +++++++-------------------
 1 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/t/t7006/test-terminal.perl b/t/t7006/test-terminal.perl
index b51cfc6..73ff809 100755
--- a/t/t7006/test-terminal.perl
+++ b/t/t7006/test-terminal.perl
@@ -2,8 +2,9 @@
 use strict;
 use warnings;
 use IO::Pty;
+use File::Copy;
 
-# Fork and execute @$argv with stdout redirected to $out.
+# Run @$argv in the background with stdout redirected to $out.
 sub start_child {
 	my ($argv, $out) = @_;
 	my $pid = fork;
@@ -37,26 +38,13 @@ sub finish_child {
 sub xsendfile {
 	my ($out, $in) = @_;
 
-	my $buf;
-
 	# Note: the real sendfile() cannot read from a terminal.
-	for (;;) {
-		my $n = sysread $in, $buf, 4096;
 
-		# It is unspecified by POSIX whether reads
-		# from a disconnected terminal will return
-		# EIO (as in AIX 4.x, IRIX, and Linux) or
-		# end-of-file.  Either is fine.
-		if (!defined($n) && $!{EIO}) {
-			return;
-		} elsif (!defined($n)) {
-			die "cannot read from child: $!";
-		} elsif ($n == 0) {
-			return;
-		} else {
-			print $out $buf or die "write error: $!";
-		}
-	}
+	# It is unspecified by POSIX whether reads
+	# from a disconnected terminal will return
+	# EIO (as in AIX 4.x, IRIX, and Linux) or
+	# end-of-file.  Either is fine.
+	copy($in, $out, 4096) or $!{EIO} or die "cannot copy from child: $!";
 }
 
 if ($#ARGV < 1) {
-- 
1.7.0

From: William Pursell <bill.pursell@gmail.com>
Subject: Re: summaries in git add --patch[PATCH 2/2]
Date: Wed, 03 Dec 2008 20:39:04 +0000
Message-ID: <4936EE68.6030009@gmail.com>
References: <492F0CAD.3010101@gmail.com> <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com> <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com> <7vskp6j95x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:42:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7yXj-00042d-Lj
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 21:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758529AbYLCUjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 15:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759394AbYLCUjM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 15:39:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:13316 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758529AbYLCUjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 15:39:09 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1943931nfc.21
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 12:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PJ3MFfyhaweTet7FAakxopTEHoWzWi7ZPzw2PWGVTCU=;
        b=w+GXA/M8zBzvldCO3UlVcfaF2l6QgNxCqu3TVv1jjAkFHoZnDFgrdDXvuOmakDio8j
         uRAPfpEeXcdERzMzL4JGrNdoKZQ9JATvp/NQEJy0UbYU8S/ZAMuNrB9mgTGweRnmuQsm
         2IECrd7tcGimxIme4IDHifbtkGo4pU3Rqdp/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=DC13iLqggdaY673sMwItoqjdsVX98LdbwISbL3CbU+S+niVq9igrcuru0MqM1b+bmZ
         Es6mVIqHVv+BAipE4NVSLbCgvHCQARS3TpCPQheDzCjE6CaZREoyNrHMq8eyytY40GED
         +G7Hs5wSBsHQ58iWhXRWNFJz9ImR51ay9Pkas=
Received: by 10.210.90.10 with SMTP id n10mr5254147ebb.199.1228336748330;
        Wed, 03 Dec 2008 12:39:08 -0800 (PST)
Received: from clam.local (5ace1311.bb.sky.com [90.206.19.17])
        by mx.google.com with ESMTPS id f13sm783664gvd.32.2008.12.03.12.39.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 12:39:07 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7vskp6j95x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102283>


 From 57b5eab3f64a40ebe9aca122b5c6db1ab5c26116 Mon Sep 17 00:00:00 2001
From: William Pursell <bill.pursell@gmail.com>
Date: Wed, 3 Dec 2008 20:26:36 +0000
Subject: [PATCH 2/2] Implemented 'g' command to goto a hunk.

When a minor change is made while the working directory
is in a bit of a mess (and the user should have done a
stash before making the minor edit, but didn't) it is
somewhat difficult to wade through all of the hunks using
git add --patch.  This allows one to jump to the hunk
that needs to be staged without having to respond 'n' to
each preceding hunk.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
  git-add--interactive.perl |   25 +++++++++++++++++++++++++
  1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index daf8d5d..98ce8e3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -800,6 +800,7 @@ y - stage this hunk
  n - do not stage this hunk
  a - stage this and all the remaining hunks in the file
  d - do not stage this hunk nor any of the remaining hunks in the file
+g - select a hunk to goto
  j - leave this hunk undecided, see next undecided hunk
  J - leave this hunk undecided, see next hunk
  k - leave this hunk undecided, see previous undecided hunk
@@ -943,6 +944,9 @@ sub patch_update_file {
  		if ($ix < $num - 1) {
  			$other .= '/J';
  		}
+		if ($num > 1) {
+			$other .= '/g';
+		}
  		for ($i = 0; $i < $num; $i++) {
  			if (!defined $hunk[$i]{USE}) {
  				$undecided = 1;
@@ -976,6 +980,27 @@ sub patch_update_file {
  				}
  				next;
  			}
+			elsif ($other =~ 'g' && $line =~ /^g(.*)/) {
+				my $response = $1;
+				my $i = 0;
+				chomp $response;
+				while (not $response) {
+					my $extra = "";
+					$i = display_hunks (\@hunk, $i);
+					$extra = "(<ret> to see more): " if ($i != $num);
+					print "goto which hunk? $extra";
+					$response = <STDIN>;
+					chomp $response;
+				}
+				if ($response !~ /^\s*\d+$/) {
+					print STDERR "Invalid number: '$response'\n";
+				} elsif (0 < $response && $response <= $num) {
+					$ix = $response - 1;
+				} else {
+					print STDERR "Sorry, only $num hunks available.\n";
+				}
+				next;
+			}
  			elsif ($line =~ /^d/i) {
  				while ($ix < $num) {
  					if (!defined $hunk[$ix]{USE}) {
-- 
1.6.1.rc1.37.g83daf.dirty



-- 
William Pursell

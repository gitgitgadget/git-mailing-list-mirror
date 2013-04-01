From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] send-email: drop misleading function prototype
Date: Sun, 31 Mar 2013 19:20:24 -0700
Message-ID: <20130401022024.GC11704@elie.Belkin>
References: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
 <1364780442-6015-1-git-send-email-gitster@pobox.com>
 <1364780442-6015-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 04:21:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMUMm-0006RP-OF
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 04:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab3DACUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 22:20:32 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:51057 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab3DACUc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 22:20:32 -0400
Received: by mail-pd0-f180.google.com with SMTP id g10so978575pdj.25
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 19:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bohvrhRiIWLglio+A5V3+eaSM5hkbARD/otaQ33ymZA=;
        b=NMEMC7GN3amMtP3/aT0/oGmE+lRCeRFA6JgB7umdR/6AALH8eWf+YE1+c9MqHvJIx9
         vZsZ8Wu1WS5z9dpFWQlW0eXJSXaTIJnEbcuwJKCu/Ef8KU3aOj3qVPNRqUxx77kL0i1+
         eMPl/nm1946nWpvYGiiq5a15MraZtlZziEnAG3C7bTIxzOkRha2dgHSxxrevqi35XPe1
         NRonNL0M0gjzWI+b0QmJ0ruEZPOnsRTIblfttcDOOGbWtCsaHGDh3VLRh4lq3ZWdMA3u
         nOI965sbwU4qrqeiagUh4NLHcCCuWQ70kFUiUL+IRtpnRYoowwENjFkO8gpUvQzy4l7/
         VSpQ==
X-Received: by 10.66.232.97 with SMTP id tn1mr16520204pac.121.1364782831719;
        Sun, 31 Mar 2013 19:20:31 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id i9sm13201483paa.7.2013.03.31.19.20.29
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 19:20:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364780442-6015-2-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219657>

Junio C Hamano wrote:

> From: Ramkumar Ramachandra <artagnon@gmail.com>
>
> The subroutine check_file_rev_conflict() is called from two places,
> both of which expects to pass a single scaler variable and see if
> that can be interpreted as a pathname or a revision name.  It is
> defined with a function prototype ($) to force a scaler context
> while evaluating the arguments at the calling site but it does not
> help the current calling sites.  The only effect it has is to hurt
> future calling sites that may want to build an argument list in an
> array variable and call it as check_file_rev_confict(@args).
>
> Drop the misleading prototype, as Perlcritic suggests.

Nice explanation.  Here's a similar patch I wrote before I noticed
your patch, with commit message stolen from the above.

-- >8 --
Subject: send-email: drop misleading function prototype

The subroutine check_file_rev_conflict() is called from two places,
both of which expects to pass a single scaler variable and see if
that can be interpreted as a pathname or a revision name.  It is
defined with a function prototype ($) to force a scaler context
while evaluating the arguments at the calling site but it does not
help the current calling sites.  The only effect it has is to hurt
future calling sites that may want to build an argument list in an
array variable and call it as check_file_rev_confict(@args).

Drop the misleading prototype, as Perlcritic suggests.

While at it, rename the function to avoid new call sites unaware of
this change arising and add a comment clarifying what this function
is for.

Reported-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-send-email.perl | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c3501d98..d6b3c32b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -512,8 +512,9 @@ sub split_addrs {
 
 ($sender) = expand_aliases($sender) if defined $sender;
 
-# returns 1 if the conflict must be solved using it as a format-patch argument
-sub check_file_rev_conflict($) {
+# is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
+# $f is a revision list specification to be passed to format-patch.
+sub is_format_patch_arg {
 	return unless $repo;
 	my $f = shift;
 	try {
@@ -529,6 +530,7 @@ ($)
     * Giving --format-patch option if you mean a range.
 EOF
 	} catch Git::Error::Command with {
+		# Not a valid revision.  Treat it as a filename.
 		return 0;
 	}
 }
@@ -540,14 +542,14 @@ ($)
 	if ($f eq "--") {
 		push @rev_list_opts, "--", @ARGV;
 		@ARGV = ();
-	} elsif (-d $f and !check_file_rev_conflict($f)) {
+	} elsif (-d $f and !is_format_patch_arg($f)) {
 		opendir my $dh, $f
 			or die "Failed to opendir $f: $!";
 
 		push @files, grep { -f $_ } map { catfile($f, $_) }
 				sort readdir $dh;
 		closedir $dh;
-	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
+	} elsif ((-f $f or -p $f) and !is_format_patch_arg($f)) {
 		push @files, $f;
 	} else {
 		push @rev_list_opts, $f;
-- 
1.8.2

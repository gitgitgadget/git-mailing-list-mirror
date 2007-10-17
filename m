From: Dan Zwell <dzwell@gmail.com>
Subject: Re: revised: [PATCH] Color support added to git-add--interactive.
Date: Tue, 16 Oct 2007 19:47:09 -0500
Message-ID: <20071016194709.3c1cb3a8@danzwell.com>
References: <471045DA.5050902@gmail.com>
 <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
 <20071013172745.GA2624@coredump.intra.peff.net>
 <20071013175127.GA3183@coredump.intra.peff.net>
 <47112491.8070309@gmail.com>
 <20071015034338.GA4844@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/TeEbOPut6I.5.LC2hA5.U9z"
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 02:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihx5z-0002O1-AM
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762308AbXJQAsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761797AbXJQAsh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:48:37 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:9801 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXJQAsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 20:48:35 -0400
Received: by py-out-1112.google.com with SMTP id u77so4015271pyb
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 17:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type;
        bh=lwilha8PcG3ufd7yYzozJTkemh3LxGK9peSVj9ODrgY=;
        b=rS/1MD4u4Qj1jWVnu/wygvRzaX7LpxGEsjgZjp+C1s4QPsx2mcbOK8eqeV5UIco5voEhmKJRNMaPwBRczqqxOCh8pgwWUT8aCf/jJOUcIc9qFl/rQtSwUqkkLN69pp+VWlMWdd3DkRrNB0fEdnrH/xxIGDfqTwbkw9JpXHyO0JU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type;
        b=SDpbKx7qisJjHXKed/XQ7MlKiYjKlzac9x8Yy1aRBweTkl0c90acUejX9OvSJq8M9JRDYexsy0WkeQooyJ9/5M7QTCuDnflz3415Z9WQZKMo7r3Wr8I8MPyoSjoK9fyqojiRrXZ5KtfRTCG3gam6QisnIEGLvRtao+NW19rCSGY=
Received: by 10.65.133.8 with SMTP id k8mr14432597qbn.1192582113150;
        Tue, 16 Oct 2007 17:48:33 -0700 (PDT)
Received: from danzwell.com ( [143.44.70.185])
        by mx.google.com with ESMTPS id 15sm2139557nzp.2007.10.16.17.48.28
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Oct 2007 17:48:31 -0700 (PDT)
In-Reply-To: <20071015034338.GA4844@coredump.intra.peff.net>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.10.14; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61294>

--MP_/TeEbOPut6I.5.LC2hA5.U9z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Adds color to the prompts and output of git-add--interactive.

-Reads config color.interactive, respects "auto", "true",
"always", and anything else.
-Uses the library Term::ANSIColor, which is included with modern
 versions of perl. This is optional, and should not need to be
 present if color.interactive is not on.
-Reads color.interactive.<slot>, where slot is "header", "prompt",
 or "help", colorizing output accordingly.

Documentation/config.txt is updated to reflect the new keys.
I cannot test this or see how it looks in manpages, however,
as I cannot install the documentation build tools.

Unfortunately, I think the default colors are ugly, but all colors that
are readable on both black and white backgrounds are probably ugly.

This patch does not colorize the diffs, because that is a larger
job, and very distinct from this (simple) task.

Dan

gzipped patch is also attached, just in case.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 971fd9f..17e29e4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -381,6 +381,27 @@ color.diff.<slot>::
 	whitespace).  The values of these variables may be specified as
 	in color.branch.<slot>.

+color.interactive::
+	When true (or `always`), always use colors in add--interactive.
+	When false (or `never`), never.  When set to `auto`, use
+	colors only when the output is to the terminal. Defaults to
+        false.
+
+color.interactive.<slot>::
+        Use customized color for add--interactive output. `<slot>`
+        may be `prompt`, `header`, or `help`, for three distinct types
+        of common output from interactive programs. The values may be a
+        space-delimited combination of up to three of the following:
++
+(optional attribute, optional foreground color, and optional
background) ++
+dark, bold, underline, underscore, blink, reverse, concealed,
+black, red, green, yellow, blue, magenta, cyan, white, on_black,
+on_red, on_green, on_yellow, on_blue, on_magenta, on_cyan, on_white
++
+Note: these are not the same colors/attributes that the
+rest of git supports, but are specific to git-add--interactive.
+
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index be68814..125655b 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,33 @@

 use strict;

+my ($use_color, $prompt_color, $header_color, $help_color);
+my $color_config = qx(git config --get color.interactive);
+if ($color_config=~/true|always/ || -t STDOUT &&
$color_config=~/auto/) {
+	$use_color = "true";
+	chomp( $prompt_color = qx(git config --get
color.interactive.prompt) );
+	chomp( $header_color = qx(git config --get
color.interactive.header) );
+	chomp( $help_color = qx(git config --get
color.interactive.help) );
+	$prompt_color ||= "red bold";
+	$header_color ||= "bold";
+	$help_color ||= "blue bold";
+
+	require Term::ANSIColor;
+}
+
+sub print_colored {
+	my $color = shift;
+	my @strings = @_;
+
+	if ($use_color) {
+		print Term::ANSIColor::color($color);
+		print(@strings);
+		print Term::ANSIColor::color("reset");
+	} else {
+		print @strings;
+	}
+}
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
 		my @invalid = grep {m/[":*]/} @_;
@@ -175,7 +202,7 @@ sub list_and_choose {
 			if (!$opts->{LIST_FLAT}) {
 				print "     ";
 			}
-			print "$opts->{HEADER}\n";
+			print_colored $header_color,
"$opts->{HEADER}\n"; }
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
@@ -205,7 +232,7 @@ sub list_and_choose {

 		return if ($opts->{LIST_ONLY});

-		print $opts->{PROMPT};
+		print_colored $prompt_color, $opts->{PROMPT};
 		if ($opts->{SINGLETON}) {
 			print "> ";
 		}
@@ -544,7 +571,7 @@ sub coalesce_overlapping_hunks {
 }

 sub help_patch_cmd {
-	print <<\EOF ;
+	print_colored $help_color, <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks
@@ -619,7 +646,7 @@ sub patch_update_cmd {
 		for (@{$hunk[$ix]{TEXT}}) {
 			print;
 		}
-		print "Stage this hunk [y/n/a/d$other/?]? ";
+		print_colored $prompt_color, "Stage this hunk
[y/n/a/d$other/?]? "; my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -673,7 +700,7 @@ sub patch_update_cmd {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split =
split_hunk($hunk[$ix]{TEXT}); if (1 < @split) {
-					print "Split into ",
+					print_colored "$header_color",
"Split into ", scalar(@split), " hunks.\n";
 				}
 				splice(@hunk, $ix, 1,
@@ -769,7 +796,7 @@ sub quit_cmd {
 }

 sub help_cmd {
-	print <<\EOF ;
+	print_colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
--
1.5.3.4.207.gc0ee


--MP_/TeEbOPut6I.5.LC2hA5.U9z
Content-Type: application/x-gzip; name=color-add--interactive.patch.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=color-add--interactive.patch.gz

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

--MP_/TeEbOPut6I.5.LC2hA5.U9z--

From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix support for legacy gitweb config for snapshots
Date: Sun, 22 Jul 2007 23:41:20 +0200
Message-ID: <200707222341.21538.jnareb@gmail.com>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com> <7vd4ylt3eh.fsf@assigned-by-dhcp.cox.net> <3bbc18d20707220805hd95c4ccsc48f140888403391@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Matt McCutchen" <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjg6-0001Bz-3c
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761881AbXGVWNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbXGVWNR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:13:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:49345 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbXGVWNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:13:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1034702ugf
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 15:13:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VPeI4G9Gw4Z7pq2r7oj658SnwUFJ01La5Jr8ULBFJ8Ct0OLY2QR+HV3f4fOOgISA7MSMBBDqEaEPvGQg+H3yGzDuo8LQ1wmTlWMEhP7/DJOJGQyox5s+Gjajxa7HTg9hY/iasK7cxqDPC/0DTnYBncGxJ92q4JPyOGb+N5bOzUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=s8qum8TxKC8iXR2juHjmdoemgswQ0Bqqw0kz/v3HrvKkuzm8TEPxsu0W51I2p0BmON0NqJs4kfQwLBrdVCuztM4iZfNlLwgsNmXHbVnsyKNPXXnC+MNb5dLuJqmD2197HW4jhiJCJVPXwNSAjXa7GqE+LDXHtGr/8FBO4dCLTp0=
Received: by 10.86.81.8 with SMTP id e8mr2020125fgb.1185142393748;
        Sun, 22 Jul 2007 15:13:13 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id k29sm12532549fkk.2007.07.22.15.13.11
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 15:13:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <3bbc18d20707220805hd95c4ccsc48f140888403391@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53344>

Earlier commit which cleaned up snapshot support and introduced
support for multiple snapshot formats changed the format of
$feature{'snapshot'}{'default'} (gitweb configuration) and
gitweb.snapshot configuration variable (repository configuration).
It supported old gitweb.snapshot values of 'gzip', 'bzip2' and 'zip'
and tried to support, but failed to do that, old values of
$feature{'snapshot'}{'default'}; at least those corresponding to
old gitweb.snapshot values of 'gzip', 'bzip2' and 'zip', i.e.
  ['x-gzip', 'gz', 'gzip']
  ['x-bzip2', 'bz2', 'bzip2']
  ['x-zip', 'zip', '']

This commit moves legacy configuration support out of feature_snapshot
subroutine to separate filter_snapshot_fmts subroutine. The
filter_snapshot_fmts is used on result on result of
gitweb_check_feature('snapshot').  This way feature_snapshot deals
_only_ with repository config.

As a byproduct you can now use 'gzip' and 'bzip2' as aliases to 'tgz'
and 'tbz2' also in $feature{'snapshot'}{'default'}, not only in
gitweb.snapshot.


While at it do some whitespace cleanup: use tabs for indent, but
spaces for align.

Noticed-by: Matt McCutchen <hashproduct@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Sun, 22 July 2007, Matt McCutchen wrote:

> That said: the backward compatibility code for gitweb _site_
> configuration is broken because it is inside an if statement that only
> runs for gitweb _repository_ configuration.

Sorry for sending not fully tested code. This should fix that.
This commit _is_ rudimentally tested.

 gitweb/gitweb.perl |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c4f8824..fdfce31 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -307,10 +307,6 @@ sub feature_snapshot {
 
 	if ($val) {
 		@fmts = ($val eq 'none' ? () : split /\s*[,\s]\s*/, $val);
-		@fmts = grep { defined } map {
-			exists $known_snapshot_format_aliases{$_} ?
-				$known_snapshot_format_aliases{$_} : $_ } @fmts;
-		@fmts = grep(exists $known_snapshot_formats{$_}, @fmts);
 	}
 
 	return @fmts;
@@ -356,6 +352,18 @@ sub check_export_ok {
 		(!$export_ok || -e "$dir/$export_ok"));
 }
 
+# process alternate names for backward compatibility
+# filter out unsupported (unknown) snapshot formats
+sub filter_snapshot_fmts {
+	my @fmts = @_;
+
+	@fmts = map {
+		exists $known_snapshot_format_aliases{$_} ?
+		       $known_snapshot_format_aliases{$_} : $_} @fmts;
+	@fmts = grep(exists $known_snapshot_formats{$_}, @fmts);
+
+}
+
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
@@ -1299,9 +1307,11 @@ sub format_diff_line {
 sub format_snapshot_links {
 	my ($hash) = @_;
 	my @snapshot_fmts = gitweb_check_feature('snapshot');
+	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 	my $num_fmts = @snapshot_fmts;
 	if ($num_fmts > 1) {
 		# A parenthesized list of links bearing format names.
+		# e.g. "snapshot (_tar.gz_ _zip_)"
 		return "snapshot (" . join(' ', map
 			$cgi->a({
 				-href => href(
@@ -1313,8 +1323,10 @@ sub format_snapshot_links {
 		, @snapshot_fmts) . ")";
 	} elsif ($num_fmts == 1) {
 		# A single "snapshot" link whose tooltip bears the format name.
+		# i.e. "_snapshot_"
 		my ($fmt) = @snapshot_fmts;
-		return $cgi->a({
+		return
+			$cgi->a({
 				-href => href(
 					action=>"snapshot",
 					hash=>$hash,
@@ -4302,11 +4314,12 @@ sub git_tree {
 
 sub git_snapshot {
 	my @supported_fmts = gitweb_check_feature('snapshot');
+	@supported_fmts = filter_snapshot_fmts(@supported_fmts);
 
 	my $format = $cgi->param('sf');
 	unless ($format =~ m/[a-z0-9]+/
-		&& exists($known_snapshot_formats{$format})
-		&& grep($_ eq $format, @supported_fmts)) {
+	        && exists($known_snapshot_formats{$format})
+	        && grep($_ eq $format, @supported_fmts)) {
 		die_error(undef, "Unsupported snapshot format");
 	}
 
-- 
1.5.2.4

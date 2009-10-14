From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2] gitweb: linkify author/committer names with search
Date: Wed, 14 Oct 2009 13:24:46 -0700
Message-ID: <1255551886-15496-1-git-send-email-bebarino@gmail.com>
References: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyAQy-0003gz-Mc
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835AbZJNU0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933724AbZJNU0l
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:26:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:30042 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933662AbZJNU0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:26:40 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1574957fga.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=9Ml6xpZJQiN/ApHzW1q+TPHKm+5kAYdJfSQobw0Tj24=;
        b=FYwM850a2wVyrMaYDvWY1H2TozZWSllewGZ0HjzK78+IcUL+XzQky6RzoTOXAHhv9K
         ICaFunUqVMkflSgxHMfMT3tFy+/Q+L85bFZ3yTgVjV0ptdpn+40dSWv1a8RjjTxnZgg9
         5gZ33IQj2R/B7wQT/LVi0zTPI7UW+VVxK3sLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FtDx+4/bPue6UN/agrI4b4h9vWWH9WIG5NOCjxmWra0j1GGhF+wN1Ddf016HNlnhNX
         d67DGNyZwqO2dH45WV2/aTtmsyH3/FISisdBCTmsiKQtGc7UMmOnxYNoFZF2wK8RzWLY
         pJpWl5oGpB+iVptSiiluUMp7THwE6k/3Ya3mE=
Received: by 10.86.192.34 with SMTP id p34mr8120731fgf.28.1255551891854;
        Wed, 14 Oct 2009 13:24:51 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 4sm126016fgg.13.2009.10.14.13.24.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 13:24:50 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 14 Oct 2009 13:24:46 -0700
X-Mailer: git-send-email 1.6.5.94.gcd2f3
In-Reply-To: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130333>

It's nice to search for an author by merely clicking on their name in
gitweb. This is usually faster than selecting the name, copying the
selection, pasting it into the search box, selecting between
author/committer and then hitting enter.

Linkify the avatar icon in log/shortlog view because the icon is directly
adjacent to the name and thus more related. The same is not true
when in commit/tag view where the icon is farther away.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This is based off next now that Giuseppe's patch is there.

Changes since v1:

 * CSS hack has been cleaned up to only remove the link border from
   avatar icons when actually linked.

 * Checking for search capability to avoid generating search links (Wincent)

 * Linking of name and email are separate in commit/commitdiff/tag views

The last one I figured I'd throw in because I'm doing it again.

 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |   33 ++++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 8faa94e..50067f2 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -32,6 +32,10 @@ img.avatar {
 	vertical-align: middle;
 }
 
+a.list img.avatar {
+	border-style: none;
+}
+
 div.page_header {
 	height: 25px;
 	padding: 8px;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0c71ee8..6325b97 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1625,6 +1625,22 @@ sub git_get_avatar {
 	}
 }
 
+sub format_search_author {
+	my $searchtext = shift;
+	my $searchtype = shift;
+	my $displaytext = shift;
+	my $have_search = gitweb_check_feature('search');
+	if ($have_search) {
+		return $cgi->a({-href => href(action=>"search", hash=>$hash,
+				searchtext=>$searchtext,
+				searchtype=>$searchtype), class=>"list"},
+				$displaytext);
+
+	} else {
+		return $displaytext;
+	}
+}
+
 # format the author name of the given commit with the given tag
 # the author name is chopped and escaped according to the other
 # optional parameters (see chop_str).
@@ -1633,8 +1649,10 @@ sub format_author_html {
 	my $co = shift;
 	my $author = chop_and_escape_str($co->{'author_name'}, @_);
 	return "<$tag class=\"author\">" .
-	       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
-	       $author . "</$tag>";
+	       format_search_author($co->{'author_name'}, "author",
+		       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
+		       $author) .
+	       "</$tag>";
 }
 
 # format git diff header line, i.e. "diff --(git|combined|cc) ..."
@@ -3433,10 +3451,11 @@ sub git_print_authorship {
 	my $co = shift;
 	my %opts = @_;
 	my $tag = $opts{-tag} || 'div';
+	my $author = $co->{'author_name'};
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
 	print "<$tag class=\"author_date\">" .
-	      esc_html($co->{'author_name'}) .
+	      format_search_author($author, "author", esc_html($author)) .
 	      " [$ad{'rfc2822'}";
 	print_local_time(%ad) if ($opts{-localtime});
 	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
@@ -3455,8 +3474,12 @@ sub git_print_authorship_rows {
 	@people = ('author', 'committer') unless @people;
 	foreach my $who (@people) {
 		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
-		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td>" .
-		      "<td rowspan=\"2\">" .
+		print "<tr><td>$who</td><td>" .
+		      format_search_author($co->{"${who}_name"}, $who,
+			       esc_html($co->{"${who}_name"})) . " " .
+		      format_search_author($co->{"${who}_email"}, $who,
+			       esc_html("<" . $co->{"${who}_email"} . ">")) .
+		      "</td><td rowspan=\"2\">" .
 		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
 		      "</td></tr>\n" .
 		      "<tr>" .
-- 
1.6.5.94.gcd2f3

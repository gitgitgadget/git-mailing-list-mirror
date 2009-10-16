From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3] gitweb: linkify author/committer names with search
Date: Thu, 15 Oct 2009 21:14:59 -0700
Message-ID: <1255666499-14098-1-git-send-email-bebarino@gmail.com>
References: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 06:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyeI5-0007qR-Sa
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 06:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbZJPEPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 00:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZJPEPl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 00:15:41 -0400
Received: from mail-qy0-f172.google.com ([209.85.221.172]:45398 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZJPEPk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 00:15:40 -0400
Received: by qyk2 with SMTP id 2so1244204qyk.21
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 21:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=T4nHIixPOxoqSV0+2XYRDZ4xsecb7rCfYQ1rGM7odSk=;
        b=jU+hfroAv0N9uyQUhmhcppnEOtBQ05RsUGlsQOsE74CHbt/ict27KdLLw7HIQahfYa
         ojU3pAwvQHxBh6/X+0mlJjHsfC7P7e19SzmjEWDTGvqnIP3nIV6ZMdwk92A87xRXsvFc
         /lFt68VHeRQ+A4Drrfc6yobnZvEMcxyK3L/mA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TSO8LmHXp5uvbYVTgCykYGk97pk0sWgqJkhmSRJ/sxQbarcUqqvwJr+SEyjYLY+xAl
         O56xgaNCMUgIxC1jxP2GZF65np3M+herbeiLxZS4tMD+qq7yHHlWNgkLTyXn6UfMI+lw
         BwxQvZbCs+QfaIrR+ybDOlQSdUaxaZbuGO+eA=
Received: by 10.224.7.133 with SMTP id d5mr746186qad.45.1255666503758;
        Thu, 15 Oct 2009 21:15:03 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 5sm1708205qwg.50.2009.10.15.21.15.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 21:15:02 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 15 Oct 2009 21:14:59 -0700
X-Mailer: git-send-email 1.6.5.94.gb6c65
In-Reply-To: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130451>

It's nice to search for an author by merely clicking on their name in
gitweb. This is usually faster than selecting the name, copying the
selection, pasting it into the search box, selecting between
author/committer and then hitting enter.

Linkify the avatar icon in log/shortlog view because the icon is directly
adjacent to the name and thus more related. The same is not true
when in commit/tag view where the icon is farther away.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Changes since v2:

 * Add a title to make it not so suprising before you click (Jakub)

Changes since v1:

 * CSS hack has been cleaned up to only remove the link border from
    avatar icons when actually linked.

 * Checking for search capability to avoid generating search links (Wincent)

 * Linking of name and email are separate in commit/commitdiff/tag views

 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |   40 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

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
index 0c71ee8..63e18f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1625,6 +1625,29 @@ sub git_get_avatar {
 	}
 }
 
+sub format_search_author {
+	my ($author, $searchtype, $displaytext) = @_;
+	my $have_search = gitweb_check_feature('search');
+
+	if ($have_search) {
+		my $performed = "";
+		if ($searchtype eq 'author') {
+			$performed = "authored";
+		} elsif ($searchtype eq 'committer') {
+			$performed = "committed";
+		}
+
+		return $cgi->a({-href => href(action=>"search", hash=>$hash,
+				searchtext=>$author,
+				searchtype=>$searchtype), class=>"list",
+				title=>"Search for commits $performed by $author"},
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
@@ -1633,8 +1656,10 @@ sub format_author_html {
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
@@ -3433,10 +3458,11 @@ sub git_print_authorship {
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
@@ -3455,8 +3481,12 @@ sub git_print_authorship_rows {
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
1.6.5.94.gb6c65

From: Florian La Roche <laroche@redhat.com>
Subject: [laroche@redhat.com: gitweb.cgi]
Date: Mon, 25 Sep 2006 18:19:34 +0200
Message-ID: <20060925161934.GA18951@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 18:20:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRtBh-00080I-AH
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 18:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWIYQUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 12:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWIYQUF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 12:20:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45443 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751149AbWIYQUE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 12:20:04 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8PGK3we013034
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 12:20:03 -0400
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8PGJwqR002241
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 12:19:58 -0400
Received: from dudweiler.stuttgart.redhat.com (dudweiler.stuttgart.redhat.com [10.32.5.60])
	by pobox.stuttgart.redhat.com (8.12.8/8.12.8) with ESMTP id k8PGJvbT007126
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 18:19:57 +0200
Received: from dudweiler.stuttgart.redhat.com (localhost [127.0.0.1])
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.7) with ESMTP id k8PGJYBM019006
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 18:19:34 +0200
Received: (from laroche@localhost)
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.8/Submit) id k8PGJYho019002
	for git@vger.kernel.org; Mon, 25 Sep 2006 18:19:34 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27740>

Hello git crew,

I'm not a big perl prorammer, but the following removes perl
warnings about accessing undefined vars.

regards,

Florian La Roche


--- gitweb/gitweb.perl
+++ gitweb/gitweb.perl
@@ -427,7 +427,9 @@ sub esc_html {
 	my $str = shift;
 	$str = decode("utf8", $str, Encode::FB_DEFAULT);
 	$str = escapeHTML($str);
-	$str =~ s/\014/^L/g; # escape FORM FEED (FF) character (e.g. in COPYING file)
+	if (defined $str) {
+		$str =~ s/\014/^L/g; # escape FORM FEED (FF) character (e.g. in COPYING file)
+	}
 	return $str;
 }
 
@@ -2860,10 +2819,14 @@ sub git_log {
 		my $ref = format_ref_marker($refs, $commit);
 		my %co = parse_commit($commit);
 		next if !%co;
+		my $esc_title = $co{'title'};
+		if (defined $esc_title) {
+			$esc_title = esc_html($esc_title);
+		}
 		my %ad = parse_date($co{'author_epoch'});
 		git_print_header_div('commit',
 		               "<span class=\"age\">$co{'age_string'}</span>" .
-		               esc_html($co{'title'}) . $ref,
+		               $esc_title . $ref,
 		               $commit);
 		print "<div class=\"title_text\">\n" .
 		      "<div class=\"log_link\">\n" .

From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 04/10] gitweb: Mark commits with no "previous" in 'blame' view
Date: Sat, 25 Jul 2009 00:44:04 +0200
Message-ID: <1248475450-5668-5-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:43:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTUb-0007Nz-5N
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbZGXWnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbZGXWnl
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:43:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:21236 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZGXWnk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:43:40 -0400
Received: by fg-out-1718.google.com with SMTP id e12so186754fga.17
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=V8Nazv3qmVDuDp5vauIAmgeXwPRpn0vXZhCt6YZrBoo=;
        b=kahCzKMhCMA+TJUmtdIY+2hiSUnkSTqeYsLv8IgjcvRG488MevA6KSmNp9yMtzxqur
         dCIfzpwaXfeMEGB8di6+Dfg+62J62axVIGDljpRcjcd/dLXNhV4liE0hwKZIudmM5Iaj
         UlRqKqJqH2Jv0K8lT1HZSiw3txVNQnEXb43+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jqiGEfvXIfR09rl0rUxphHjcEXOwlfwhoHZtrj7qDLAWubOWWrDzvHuBTEWQoiu0qQ
         QO5J9+srmxIYdlmvNGJZOFzMOG+Q0phbkypYbSqlFjhucCYCfvfhBAcQleYykeUZ8wQR
         8iCmmvauFDt7H1fS44VunsaNmo3qr2zi0tWsw=
Received: by 10.86.74.15 with SMTP id w15mr185325fga.26.1248475420183;
        Fri, 24 Jul 2009 15:43:40 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id d6sm9208903fga.10.2009.07.24.15.43.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:43:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMn6Wc005771;
	Sat, 25 Jul 2009 00:49:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMmUNb005764;
	Sat, 25 Jul 2009 00:48:30 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123962>

Use "no-previous" class to mark blamed commits which do not have
"previous" header.  Those are commits in which blamed file was created
(added); this includes boundary commits.  This means that 'linenr'
link leads to blamed commit, not (one of) parent of blamed commit.
Therefore currently line number for such commit uses bold weight font
to denote this situation; the effect is subtle.

Use "multiple-previous" class in the opposite situation, where blamed
commit has multiple "previous" headers (is an evil merge).  Currently
this class is not used for styling.  In this situation 'linenr' link
leads to first of "previous" commits (first parent).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is new commit, which didn't appear in v1 of this series.

It does what marking "boundary" commit meant to do: it marks (via
admittedly quite subtle change of style) "linenr" links which lead to
'blame' view at blamed commit, not at parent commit (because there is
no parent commit).

This patch is after one using "previous" header for finding parents
for "linenr" links, because it also uses (still undocumented)
"previous" header.

 gitweb/gitweb.css  |    3 ++-
 gitweb/gitweb.perl |    7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index f47709b..4763337 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -242,7 +242,8 @@ tr.dark:hover {
 	background-color: #edece6;
 }
 
-tr.boundary td.sha1 {
+tr.boundary td.sha1,
+tr.no-previous td.linenr {
 	font-weight: bold;
 }
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b8a121b..128bddd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4819,7 +4819,7 @@ HTML
 		my ($full_rev, $orig_lineno, $lineno, $group_size) =
 		   ($line =~ /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/);
 		if (!exists $metainfo{$full_rev}) {
-			$metainfo{$full_rev} = {};
+			$metainfo{$full_rev} = { 'nprevious' => 0 };
 		}
 		my $meta = $metainfo{$full_rev};
 		my $data;
@@ -4829,6 +4829,9 @@ HTML
 			if ($data =~ /^(\S+)(?: (.*))?$/) {
 				$meta->{$1} = $2 unless exists $meta->{$1};
 			}
+			if ($data =~ /^previous /) {
+				$meta->{'nprevious'}++;
+			}
 		}
 		my $short_rev = substr($full_rev, 0, 8);
 		my $author = $meta->{'author'};
@@ -4840,6 +4843,8 @@ HTML
 		}
 		my $tr_class = $rev_color[$current_color];
 		$tr_class .= ' boundary' if (exists $meta->{'boundary'});
+		$tr_class .= ' no-previous' if ($meta->{'nprevious'} == 0);
+		$tr_class .= ' multiple-previous' if ($meta->{'nprevious'} > 1);
 		print "<tr id=\"l$lineno\" class=\"$tr_class\">\n";
 		if ($group_size) {
 			print "<td class=\"sha1\"";
-- 
1.6.3.3

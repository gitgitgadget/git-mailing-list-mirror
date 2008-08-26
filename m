From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v7] gitweb: ref markers link to named shortlogs
Date: Tue, 26 Aug 2008 15:09:22 +0200
Message-ID: <1219756162-31492-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <200808252042.29171.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Lea Wiemann <lewiemann@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 15:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXyJP-0002dA-3C
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 15:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbYHZNJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 09:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756086AbYHZNJO
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 09:09:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:36804 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032AbYHZNJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 09:09:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1258327fgg.17
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=y6/vKXQ7JbaZCcXpdaUi7dOkj2UoG11tkMpZv1UXEIU=;
        b=azfOCN6xGtYyhdQhGSjbldYrgmkOY3hZmqLSCqV+gCPOHjDsOgrxXp9bIC6o+0DckB
         fuhFAg632zOBsZogueLeUsMCBcxT5or7+O1fEf/KpDjmdUD9txSZLEHXB0a34BVsJvBV
         iw2GBPx2mzqCe60tZZqFipB0r0hsWwSV7jXT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JOJDHzHKoMT6/li2vDv4Zuhrc8DWriHrdWa+DGu3DOoCdGqzdHfxtFjuYgUnbzLqGQ
         IW4jCgV4/lqjC8Tw3dutmBB5coY+XMTDftMwdTi4S//1DnDaJD9Xnmj9Itx090IDrpE1
         8WzqXPUHfbLt54ktKbqxk099QgOzql32xFVPg=
Received: by 10.86.29.8 with SMTP id c8mr4329147fgc.30.1219756151208;
        Tue, 26 Aug 2008 06:09:11 -0700 (PDT)
Received: from localhost ( [78.13.54.201])
        by mx.google.com with ESMTPS id d4sm6963607fga.5.2008.08.26.06.09.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 06:09:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <200808252042.29171.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93745>

This patch turns ref markers for tags and heads into links to
appropriate views for the ref name, depending on current context.

For annotated tags, we link to the tag view, unless that's the current
view, in which case we switch to shortlog. For other refs, we prefer the
current view if it's history or (short)log, and default to shortlog
otherwise.

Appropriate changes are made in the CSS to prevent ref markers from
being annoyingly blue and underlined, unless hovered. A visual
indication of the target view difference is also implemented by making
annotated tags show up in italic.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Famous last words. Version 6 of this patch had a horrible typo, so I'm taking
advantage of the need for a resend to implement a feature
suggested by Jakub: context-sensitive destination action.

See patch description and code comment for details.

 gitweb/gitweb.css  |   13 +++++++++++++
 gitweb/gitweb.perl |   37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 5f4a4b8..3e50060 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -491,6 +491,19 @@ span.refs span {
 	border-color: #ffccff #ff00ee #ff00ee #ffccff;
 }
 
+span.refs span a {
+	text-decoration: none;
+	color: inherit;
+}
+
+span.refs span a:hover {
+	text-decoration: underline;
+}
+
+span.refs span.indirect {
+	font-style: italic;
+}
+
 span.refs span.ref {
 	background-color: #aaaaff;
 	border-color: #ccccff #0033cc #0033cc #ccccff;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a0d9272..7536fc8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1196,13 +1196,23 @@ sub format_log_line_html {
 }
 
 # format marker of refs pointing to given object
+
+# the destination action is chosen based on object type and current context:
+# - for annotated tags, we choose the tag view unless it's the current view
+#   already, in which case we go to shortlog view
+# - for other refs, we keep the current view if we're in history, shortlog or
+#   log view, and select shortlog otherwise
 sub format_ref_marker {
 	my ($refs, $id) = @_;
 	my $markers = '';
 
 	if (defined $refs->{$id}) {
 		foreach my $ref (@{$refs->{$id}}) {
+			# this code exploits the fact that non-lightweight tags are the
+			# only indirect objects, and that they are the only objects for which
+			# we want to use tag instead of shortlog as action
 			my ($type, $name) = qw();
+			my $indirect = ($ref =~ s/\^\{\}$//);
 			# e.g. tags/v2.6.11 or heads/next
 			if ($ref =~ m!^(.*?)s?/(.*)$!) {
 				$type = $1;
@@ -1212,8 +1222,29 @@ sub format_ref_marker {
 				$name = $ref;
 			}
 
-			$markers .= " <span class=\"$type\" title=\"$ref\">" .
-			            esc_html($name) . "</span>";
+			my $class = $type;
+			$class .= " indirect" if $indirect;
+
+			my $dest_action = "shortlog";
+
+			if ($indirect) {
+				$dest_action = "tag" unless $action eq "tag";
+			} elsif ($action =~ /^(history|(short)?log)$/) {
+				$dest_action = $action;
+			}
+
+			my $dest = "";
+			$dest .= "refs/" unless $ref =~ m!^refs/!;
+			$dest .= $ref;
+
+			my $link = $cgi->a({
+				-href => href(
+					action=>$dest_action,
+					hash=>$dest
+				)}, $name);
+
+			$markers .= " <span class=\"$class\" title=\"$ref\">" .
+				$link . "</span>";
 		}
 	}
 
@@ -2035,7 +2066,7 @@ sub git_get_references {
 
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)!) {
+		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type.*)$!) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
 			} else {
-- 
1.5.6.3

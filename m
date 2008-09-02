From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v7, resend] gitweb: ref markers link to named shortlogs
Date: Tue,  2 Sep 2008 21:47:05 +0200
Message-ID: <1220384825-19824-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 21:48:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KabrO-0006jX-CX
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 21:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYIBTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 15:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbYIBTrM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 15:47:12 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:18371 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYIBTrL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 15:47:11 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1150705ika.5
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DTSurVudRXxtsFWDLLnI+GbT/evS6NTV1x3/wVdJVkk=;
        b=uh+/67iAcAF0lhl7/U2IaJL+47gnUAPHSflg6aTUf89Md/G9X0ndmHf00KQkzeBTja
         /GaiUt6WeN9ZkyX6TE9goQ98PY+Bg++5TVizjF0Fcxoiw1Ntqn6luANO0dpSRD9uROcZ
         hXpGjGLr5Cyy3pz9och8zWBsqhVVqk5+jRo0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=U0c0wMkNh/mwAsyHVIvN1DCYxfILjZc7tTvZ2vgMw/8+QorDh4SSZM20PXyNNkGQaK
         zgaKAFNso1OhtpP2yILDuVahTLNKiUM8JKq/BjPxAeonV1mytT3p7X/H7W4lNykggz9T
         e9G12mtaaU2TBWJKkjCEm5ByldV0k2SE8NLvA=
Received: by 10.210.46.14 with SMTP id t14mr8820881ebt.0.1220384829695;
        Tue, 02 Sep 2008 12:47:09 -0700 (PDT)
Received: from localhost ( [78.15.13.249])
        by mx.google.com with ESMTPS id 34sm43355735nfu.24.2008.09.02.12.47.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Sep 2008 12:47:08 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94697>

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

This is a resend of v7 of the refmark patch, since it seems to
have falled again below the gitweb maintainers' radar, despite
their interest in it ;)

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
1.5.6.5

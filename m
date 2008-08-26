From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v6] gitweb: ref markers link to named shortlogs
Date: Tue, 26 Aug 2008 14:16:36 +0200
Message-ID: <1219752996-28431-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <200808252042.29171.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Lea Wiemann <lewiemann@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 14:20:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXxUL-0003kC-C8
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 14:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbYHZMQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 08:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbYHZMQ2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 08:16:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:26514 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbYHZMQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 08:16:27 -0400
Received: by ug-out-1314.google.com with SMTP id c2so723628ugf.37
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8r5MV5nOSwvAOYRc8dgM0+2/cbXjFkYaAZx5rHJHWrg=;
        b=Cn15mdgoSCbG8UGE3z9tKpGbGN0i2QLfcPXSPu2+Ob0T5wK62FOqrzZEIoETNny+Yt
         fKNSg5XaUQVoulvfHn6s/BPThZhv6Wv8xEpmHyEOvXhbf7hVwlxYoTH0wsplw0+xPGZi
         d5HgpLN5OF6cZC/ip1/RrybhEKvzF4hLJ90fU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EQhR4GWHq25WoTENeoT7qMY6uu9H2z4JoWv05tmJ9HzMicu4y/7Hupx3OBIm/e0Bru
         MS4mVAO3U5lkuvuyzH/OIF7u2eZ6ZaaYYIgab7Tvf5Oz0r25Hm3APc704ww7b3lPkb4h
         dv6mAQ9i9w7rgrKLom2W0uzmiTjIVn2u4wbTw=
Received: by 10.66.241.13 with SMTP id o13mr485427ugh.78.1219752985934;
        Tue, 26 Aug 2008 05:16:25 -0700 (PDT)
Received: from localhost ( [78.13.54.201])
        by mx.google.com with ESMTPS id 2sm35996823nfv.5.2008.08.26.05.16.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 05:16:25 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <200808252042.29171.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93742>

This patch turns ref markers for tags and heads into links to
appropriate views for the ref name. For annotated tags, we link to the
tag view, while shortlog is used for anything else.

Appropriate changes are made in the CSS to prevent ref markers from
being annoyingly blue and underlined, unless hovered. A visual
indication of the target view difference is also implemented by making
annotated tags show up in italic.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

This (hopefully final) version of the refmark link patch for
gitweb uses canonical refnames for the links by prepending
'refs/' to the refname unless it's already present.

It's also slightly reworked to reduce line length.

 gitweb/gitweb.css  |   13 +++++++++++++
 gitweb/gitweb.perl |   23 ++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

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
index a0d9272..028cb4b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1202,7 +1202,11 @@ sub format_ref_marker {
 
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
@@ -1212,8 +1216,21 @@ sub format_ref_marker {
 				$name = $ref;
 			}
 
-			$markers .= " <span class=\"$type\" title=\"$ref\">" .
-			            esc_html($name) . "</span>";
+			my $class = $type;
+			$class .= " indirect" if $indirect;
+
+			my $dest = "";
+			$dest .= "refs/" unless $ref =~ s!^refs/!;
+			$dest .= $ref;
+
+			my $link = $cgi->a({
+				-href => href(
+					action=>($indirect ? "tag" : "shortlog"),
+					hash=>$dest
+				)}, $name);
+
+			$markers .= " <span class=\"$class\" title=\"$ref\">" .
+				$link . "</span>";
 		}
 	}
 
@@ -2035,7 +2052,7 @@ sub git_get_references {
 
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)!) {
+		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type.*)$!) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
 			} else {
-- 
1.5.6.3

From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] gitweb: Add support for cloneurl.
Date: Tue, 15 Aug 2006 19:58:28 +0530
Message-ID: <44E1DA0C.80602@gmail.com>
References: <ebrpfs$grn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020501030006010207080500"
X-From: git-owner@vger.kernel.org Tue Aug 15 16:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCzvS-0003Lr-0O
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 16:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWHOO3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 10:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWHOO3n
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 10:29:43 -0400
Received: from main.gmane.org ([80.91.229.2]:34708 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030307AbWHOO3m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 10:29:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCzuf-000395-Ll
	for git@vger.kernel.org; Tue, 15 Aug 2006 16:29:01 +0200
Received: from 59.92.163.89 ([59.92.163.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 16:29:01 +0200
Received: from aneesh.kumar by 59.92.163.89 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 16:29:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.163.89
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <ebrpfs$grn$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25457>

This is a multi-part message in MIME format.
--------------020501030006010207080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Aneesh Kumar K.V wrote:
> http://gitweb.freedesktop.org/?p=PolicyKit.git;a=summary
> 
> This shows it in the URL part of each project.
> -aneesh


The below patch implements the same. I am not sure whether the approach is the right one.
To see the results you can see 

http://git.openssi.org/~kvaneesh/gitweb.cgi

-aneesh

--------------020501030006010207080500
Content-Type: text/plain;
 name="0001-gitweb-Add-support-for-cloneurl.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-gitweb-Add-support-for-cloneurl.txt"

>From 87503bfc92210ab6791f7a15eba72682d60f74ca Mon Sep 17 00:00:00 2001
Subject: [PATCH] gitweb: Add support for cloneurl.

A new file cloneurl is added below .git directory for each project.
The contents of the file is displayed by gitweb as the url which
need to be used for git clone.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 gitweb/gitweb.perl |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b5b89de..869c53e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -503,6 +503,16 @@ sub git_get_project_description {
 	return $descr;
 }
 
+sub git_get_project_cloneurl {
+	my $path = shift;
+
+	open my $fd, "$projectroot/$path/cloneurl" or return undef;
+	my $descr = <$fd>;
+	close $fd;
+	chomp $descr;
+	return $descr;
+}
+
 sub git_get_projects_list {
 	my @list;
 
@@ -1655,6 +1665,7 @@ sub git_project_list {
 sub git_summary {
 	my $descr = git_get_project_description($project) || "none";
 	my $head = git_get_head_hash($project);
+	my $cloneurl = git_get_project_cloneurl($project) || "none";
 	my %co = parse_commit($head);
 	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
@@ -1669,6 +1680,7 @@ sub git_summary {
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
+	      "<tr><td>URL</td><td>$cloneurl</td></tr>\n" .
 	      "</table>\n";
 
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_get_head_hash($project)
-- 
1.4.2.rc1.g83e1-dirty


--------------020501030006010207080500--

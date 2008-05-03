From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Allow project description in project_index file
Date: Sat, 3 May 2008 11:03:13 +0200
Message-ID: <200805031103.14960.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <200805021230.05907.jnareb@gmail.com> <20080502130456.GN23672@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat May 03 11:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsDfS-0004VP-6J
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 11:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382AbYECJDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 05:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbYECJDY
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 05:03:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:64845 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475AbYECJDW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 05:03:22 -0400
Received: by ug-out-1314.google.com with SMTP id h3so253781ugf.16
        for <git@vger.kernel.org>; Sat, 03 May 2008 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=3DPzQWWtCJeHlptm4TNK5kMXvzdqsAzb19mLZhsWryw=;
        b=F8sjvt0CtgzijzufBPIjPv7uTC0MFIFr9lhh9qxbxku3IEGEWoBwPjKX0DGSAGL2zat36vfKlYbZ1nc0zNqIoR35sH6G573dZHdUGJSSykt9wAZrI9vc62wat4m12+nKag6sLcanJU9hQ5fI7rg9G45pWIClZwpb4WM9jp2xzFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JemmaCi9s+FxvTqlIE9gkya3V54Y2iOcgx327SCIfHTKN1E4+1jvf5HcsrBDogZD9fcYZU4372n+pnxKEylVD34G146SWLDxA0wSQs09+DgFzjC+HjFmsDulcFLN4/CH9Zoq/Usatum8tceTHva4GCiQV6ItwUgutDLni/HACBE=
Received: by 10.67.102.6 with SMTP id e6mr1231215ugm.25.1209805400016;
        Sat, 03 May 2008 02:03:20 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.203.227])
        by mx.google.com with ESMTPS id z33sm7085569ikz.0.2008.05.03.02.03.17
        (version=SSLv3 cipher=OTHER);
        Sat, 03 May 2008 02:03:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080502130456.GN23672@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81063>

Change format of $projects_list file from
  <URI-encoded path> SPC <URI-encoded owner> LF
to
  <URI-encoded path> SPC
  <URI-encoded owner> [SPC <URI-encoded description>] LF
with optional project description.  Please remember that only single
line of repository (project) description is supported.  Note that SPC
can be replaced by any whitespace character.

This change required modifying git_get_projects_list() subroutine
(part when $projects_list is a file, not a directory to be scanned),
and git_get_project_description() subroutine.

The 'project_index' action creates projects list index file in the new
format, with project description.  Also, it now does only minial level
of escaping / encoding.


While at it some comments describing changes and changed subroutines
were added, and information about $projects_list format was updated in
gitweb/README and in gitweb/INSTALL.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Fri, 2 May 2008, Miklos Vajna wrote:
> On Fri, May 02, 2008 at 12:30:04PM +0200, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> The reason why it is an RFC is the decision to _not_ URI-decode (to not
>> force URI-encoding of e.g. spaces) in the project (repository)
>> description part of projects list page.  It makes projects index file
>> easier to read and to edit, but it closes possibility of extending this
>> format further.  And there is another thing that could be reasonably put
>> in this file: future project *categories* support.  So should I try to
>> add categories support first?
> 
> Just my two cents, I don't think that encoded strings are so unreadable.
> Also, having the ability to extend the file later as well would be nice.

This version uses URI-encoded 'description' field in $projects_list
file, thus allowing to extend it (e.g. by adding categories support)
in a backward compatibile way.

Also, the format is described in more elaborate way; please comment...

 gitweb/INSTALL     |   10 +++++--
 gitweb/README      |    9 ++++--
 gitweb/gitweb.perl |   74 ++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index f7194db..7e25a7f 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -140,9 +140,13 @@ Gitweb repositories
 
   Each line of the projects list file should consist of the url-encoded path
   to the project repository database (relative to projectroot), followed
-  by the url-encoded project owner on the same line (separated by a space).
-  Spaces in both project path and project owner have to be encoded as either
-  '%20' or '+'.
+  by the url-encoded project owner on the same line (separated by a space),
+  and optionally followed by the url-encoded project description (spearated
+  by space).  Spaces in project path, project owner and project description
+  have to be encoded as either '%20' or '+'.  Other whitespace (separator),
+  plus sign '+' (used as replacement for spaces), and percent sign '%' (used
+  for encoding / escaping) have to be url-encoded, i.e. replaced by '%'
+  followed by two-digit character number in octal.
 
   You can generate the projects list index file using the project_index
   action (the 'TXT' link on projects list page) directly from gitweb.
diff --git a/gitweb/README b/gitweb/README
index 8f7ea36..130449c 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -157,9 +157,12 @@ not include variables usually directly set during build):
  * $projects_list
    Source of projects list, either directory to scan, or text file
    with list of repositories (in the "<URI-encoded repository path> SPC
-   <URI-encoded repository owner>" format).  Set to $GITWEB_LIST
-   during installation.  If empty, $projectroot is used to scan for
-   repositories.
+   <URI-encoded repository owner>" line format, or optionally with
+   project description in "<URI-encoded repository path> SPC
+   <URI-encoded repository owner> SPC <URI-encoded description>";
+   actually there can be any sequence of whitespace in place of SPC).
+   Set to $GITWEB_LIST during installation.  If empty, $projectroot is
+   used to scan for repositories.
  * $my_url, $my_uri
    URL and absolute URL of gitweb script; you might need to set those
    variables if you are using 'pathinfo' feature: see also below.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6a28dca..296bfaa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1702,13 +1702,44 @@ sub git_get_path_by_hash {
 ## ......................................................................
 ## git utility functions, directly accessing git repository
 
+# this is helper function for git_get_project_description()
+sub git_get_project_description_from_list {
+	my $path = shift;
+
+	open(my $fd, $projects_list)
+		or return;
+	while (my $line = <$fd>) {
+		chomp $line;
+		my ($proj, undef, $descr) = split ' ', $line;
+		$proj = unescape($pr);
+		$descr = unescape($descr);
+		if ($proj eq $path) {
+			close $fd;
+			return $descr;
+		}
+	}
+	close $fd;
+	return;
+}
+
+# sources for project description are
+#  * project_list, if $project_list is a file, and it uses new format:
+#    <encoded path> SPC <encoded owner> SPC <encoded description> LF
+#  * $GIT_DIR/description file in project repository, if it exists
+#  * gitweb.description configuration variable for a project
 sub git_get_project_description {
 	my $path = shift;
+	my $descr;
+
+	if (-f $projects_list) {
+		$descr = git_get_project_description_from_list($path);
+		return $descr if (defined $descr); # try other sources if needed
+	}
 
 	$git_dir = "$projectroot/$path";
 	open my $fd, "$git_dir/description"
 		or return git_get_project_config('description');
-	my $descr = <$fd>;
+	$descr = <$fd>;
 	close $fd;
 	if (defined $descr) {
 		chomp $descr;
@@ -1774,20 +1805,25 @@ sub git_get_projects_list {
 		}, "$dir");
 
 	} elsif (-f $projects_list) {
-		# read from file(url-encoded):
+		# read from file (whitespace separated, url-encoded):
 		# 'git%2Fgit.git Linus+Torvalds'
 		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
+		# optionally with description
+		# 'git/git.git Junio+C+Hamano The+core+git+plumbing'
+		# 'libs/klibc/klibc.git H.+Peter+Anvin klibc+main+development+tree'
+		# 'linux/hotplug/udev.git Kay+Sievers udev+development+tree'
 		my %paths;
 		open my ($fd), $projects_list or return;
 	PROJECT:
 		while (my $line = <$fd>) {
 			chomp $line;
-			my ($path, $owner) = split ' ', $line;
+			my ($path, $owner, $descr) = split ' ', $line;
 			$path = unescape($path);
 			$owner = unescape($owner);
+			$descr = unescape($descr);
 			if (!defined $path) {
-				next;
+				next PROJECT;
 			}
 			if ($filter ne '') {
 				# looking for forks;
@@ -1818,9 +1854,14 @@ sub git_get_projects_list {
 			}
 			if (check_export_ok("$projectroot/$path")) {
 				my $pr = {
-					path => $path,
+					path =>  to_utf8($path),
 					owner => to_utf8($owner),
 				};
+				if (defined $descr) {
+					$descr = to_utf8($descr);
+					$pr->{'descr_long'} = $descr;
+					$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
+				}
 				push @list, $pr;
 				(my $forks_path = $path) =~ s/\.git$//;
 				$paths{$forks_path}++;
@@ -4006,21 +4047,28 @@ sub git_project_index {
 	print $cgi->header(
 		-type => 'text/plain',
 		-charset => 'utf-8',
-		-content_disposition => 'inline; filename="index.aux"');
+		-content_disposition => 'inline; filename="projects_index.aux"');
 
 	foreach my $pr (@projects) {
 		if (!exists $pr->{'owner'}) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}");
+			$pr->{'owner'} = to_utf8($pr->{'owner'});
+		}
+		if (!exists $pr->{'descr_long'}) {
+			$pr->{'descr_long'} = git_get_project_description($pr->{'path'}) || "";
+			$pr->{'descr_long'} = to_utf8($pr->{'descr_long'});
 		}
 
-		my ($path, $owner) = ($pr->{'path'}, $pr->{'owner'});
-		# quote as in CGI::Util::encode, but keep the slash, and use '+' for ' '
-		$path  =~ s/([^a-zA-Z0-9_.\-\/ ])/sprintf("%%%02X", ord($1))/eg;
-		$owner =~ s/([^a-zA-Z0-9_.\-\/ ])/sprintf("%%%02X", ord($1))/eg;
-		$path  =~ s/ /\+/g;
-		$owner =~ s/ /\+/g;
+		my @pr_info = 
+			($pr->{'path'}, $pr->{'owner'}, $pr->{'descr_long'});
+		foreach (@pr_info) {
+			# quote only minimal set, only what has to be quoted
+			s/([+%])/sprintf("%%%02X", ord($1))/eg;
+			s/ /\+/g;
+			s/([[:space:]])/sprintf("%%%02X", ord($1))/eg;
+		}
 
-		print "$path $owner\n";
+		print join(' ', @pr_info)."\n";
 	}
 }
 
-- 
1.5.5

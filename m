From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCH 2/2] gitweb: support to globally enable/disable a snapshot format
Date: Sat, 1 Aug 2009 13:46:41 -0400
Message-ID: <8E0889CB-8A0A-45A5-AF34-9643D4EEFCEF@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 19:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXIfb-0006Qr-2R
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 19:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbZHARqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 13:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbZHARqv
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 13:46:51 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:51429 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751440AbZHARqm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 13:46:42 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n71HkbgY009844
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 1 Aug 2009 13:46:42 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sat, 01 Aug 2009 13:46:42 -0400 (EDT)
X-Miltered: at minos with ID 4A747F7D.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on localhost
X-Virus-Status: Clean
X-UUID: a219e7df-f1eb-4f7c-b782-5ecf2f66fc5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124641>

On 1-Aug-09, at 4:14 AM, Jakub Narebski wrote:

> "J.H." <warthog19@eaglescrag.net> writes:
>
>> Well you can always call xz with -[1-9] to change the compression
>> level (same as gzip and bzip2) though I think a full disabling would
>> be 'more' preferable, though I'm not sure I like Jakub's suggestion  
>> of
>> just deleting it after the fact, it would work.
> [...]
>
> The problem is that 'keys %known_snapshot_formats' serves also as list
> of allowed snapshot formats, if project specific override is enabled.
> We can add another optional flag ('disabled' => 1) if you don't want
> to delete from %known_snapshot_formats in $GITWEB_CONFIG, though I
> don't know if it is worth it.  Anyway such mechanism can be added, and
> IMHO should be added, in a separate commit.


Is this correct?


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


----------->8--------------
From: Mark Rada <marada@uwaterloo.ca>
Date: Sat, 1 Aug 2009 13:24:03 -0400
Subject: [PATCH 2/2] gitweb: support to globally enable/disable a  
snapshot format

I added an 'enabled' variable to to the $known_snapshot_format keys so
that a Gitweb administrator can globally enable or disable a specific
format for snapshots.

All formats are enabled by default because project specific overriding
is disabled by default.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/gitweb.perl |   14 ++++++++++----
  1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3398163..0a9cec6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -167,27 +167,31 @@ our %known_snapshot_formats = (
  		'type' => 'application/x-gzip',
  		'suffix' => '.tar.gz',
  		'format' => 'tar',
-		'compressor' => ['gzip']},
+		'compressor' => ['gzip'],
+		'enabled' => 1},

  	'tbz2' => {
  		'display' => 'tar.bz2',
  		'type' => 'application/x-bzip2',
  		'suffix' => '.tar.bz2',
  		'format' => 'tar',
-		'compressor' => ['bzip2']},
+		'compressor' => ['bzip2'],
+		'enabled' => 1},

  	'txz' => {
  		'display' => 'tar.xz',
  		'type' => 'application/x-xz',
  		'suffix' => '.tar.xz',
  		'format' => 'tar',
-		'compressor' => ['xz']},
+		'compressor' => ['xz'],
+		'enabled' => 1},

  	'zip' => {
  		'display' => 'zip',
  		'type' => 'application/x-zip',
  		'suffix' => '.zip',
-		'format' => 'zip'},
+		'format' => 'zip',
+		'enabled' => 1},
  );

  # Aliases so we understand old gitweb.snapshot values in repository
@@ -5171,6 +5175,8 @@ sub git_snapshot {
  		die_error(400, "Unknown snapshot format");
  	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
  		die_error(403, "Unsupported snapshot format");
+	} elsif (!$known_snapshot_formats{$format}{'enabled'}) {
+		die_error(403, "Snapshot format not allowed");
  	}

  	if (!defined $hash) {
-- 
1.6.4

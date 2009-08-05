From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv4 1/3] gitweb: add support for XZ compressed snapshots
Date: Wed, 5 Aug 2009 09:19:37 -0400
Message-ID: <8937EF50-9C24-4176-B277-1DB30B27A7E7@uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 15:20:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYgPM-0004MM-UA
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 15:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934259AbZHENTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 09:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933716AbZHENTq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 09:19:46 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:34570 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933639AbZHENTp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 09:19:45 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n75DJggZ011477
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 5 Aug 2009 09:19:45 -0400 (EDT)
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Wed, 05 Aug 2009 09:19:45 -0400 (EDT)
X-Miltered: at psyche with ID 4A7986EE.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on localhost
X-Virus-Status: Clean
X-UUID: abf8cd13-57c8-4c89-bd0e-88f6fa466cd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124903>

I think I am getting some mixed signals from you guys, but I think  
this is
what you meant.

I updated the first patches commit message to add a little more to the
conclusion, based on other e-mails in previous threads.


--
Mark A Rada (ferrous26)
marada@uwaterloo.ca

-------->8-------------
From: Mark Rada <marada@uwaterloo.ca>
Date: Thu, 30 Jul 2009 08:56:42 -0400
Subject: [PATCH 1/3] gitweb: add support for XZ compressed snapshots

The XZ compression format uses the LZMA2 compression algorithm, which
often yields higher compression ratios than both GZip and BZip2 at the
cost of using more CPU time and RAM. Though, while XZ is the slowest
for compression, it is much faster than BZip2 for decompression, almost
comparable to GZip (see benchmarks below).

You can enable XZ compressed snapshots by adding 'txz' to the list of
default options for snapshots in your $GITWEB_CONFIG.

I did some simple benchmarks, starting with an already tarballed
archive of the repos listed below. Memory usage seemed to be consistent
for any given algorithm at their default compression level. Timings were
gathered using the `time' command.

CPU: AMD Sempron 3400+ (1 core @ 1.8GHz with 256K L2 cache)
Virtual Memory Usage
         GZip: 4152K        BZip2: 13352K        XZ: 102M

Linux 2.6 series (f5886c7f96f2542382d3a983c5f13e03d7fc5259)   349M
gzip    23.70s user   0.47s system  99% cpu   24.227 total    76M
gunzip  3.74s user    0.74s system  94% cpu   4.741 total
bzip2   130.96s user  0.53s system  99% cpu   2:11.97 total   59M
bunzip2 31.05s user   1.02s system  99% cpu   32.355 total
xz      448.78s user  0.91s system  99% cpu   7:31.28 total   51M
unxz    7.67s user    0.80s system  98% cpu   8.607 total

Git (0a53e9ddeaddad63ad106860237bbf53411d11a7)                11M
gzip    0.77s user    0.03s system  99% cpu   0.792 total     2.5M
gunzip  0.12s user    0.02s system  98% cpu   0.142 total
bzip2   3.42s user    0.02s system  99% cpu   3.454 total     2.1M
bunzip2 0.95s user    0.03s system  99% cpu   0.984 total
xz      12.88s user   0.14s system  98% cpu   13.239 total    1.9M
unxz    0.27s user    0.03s system  99% cpu   0.298 total

XZ (669413bb2db954bbfde3c4542fddbbab53891eb4)                 1.8M
gzip    0.12s user    0.00s system  95% cpu   0.132 total     442K
gunzip  0.02s user    0.00s system  97% cpu   0.027 total
bzip2   1.28s user    0.01s system  99% cpu   1.298 total     363K
bunzip2 0.15s user    0.01s system  100% cpu  0.157 total
xz      1.62s user    0.03s system  99% cpu   1.652 total     347K
unxz    0.05s user    0.00s system  99% cpu   0.058 total

Purely from a time and memory perspective, nothing compares to GZip in
each of the three tests. Though, if you have an average upload speed of
20KB/s, it would take ~400 seconds longer to transfer the BZip2
compressed kernel snapshot than it would the XZ compressed snapshot,
the transfer time difference between GZip and XZ is even greater. The
wall clock time savings are relatively the same for all test cases, but
less dramatic for the smaller repositories.

It is also clear that XZ decompresses about 2x slower than GZip for
smaller snapshots only about 1.8x slower for the kernel snapshot. When
compared to BZip2, XZ is actually at least 2.7x faster, and gets
comparatively faster as the size of the snapshots increase (3.75x faster
than BZip2 for the kernel snapshot). However, this trend seems to
reverse itself for compression, it takes comparatively longer to
compress as snapshots get larger.

The obvious downside for XZ compressed snapshots is the large CPU and
memory load put on the server to actually generate a compressed
snapshot. Though XZ will eventually have good threading support, and I
suspect then that the wall clock time for making an XZ compressed
snapshot would go down considerably if the server had a beefy
multi-core CPU.

I have not enabled XZ compression by default because the current default
is GZip, and XZ is only really competitive with BZip2. XZ also requires
a lot of memory which could potentially lock up high load servers or
servers with little memory (until caching is available). Also, the XZ
format is still fairly new (the format was declared stable about 6
months ago), and there have been no "stable" releases of the utils yet.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  gitweb/gitweb.perl |    8 ++++++++
  1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fbd5ff..3398163 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -176,6 +176,13 @@ our %known_snapshot_formats = (
  		'format' => 'tar',
  		'compressor' => ['bzip2']},

+	'txz' => {
+		'display' => 'tar.xz',
+		'type' => 'application/x-xz',
+		'suffix' => '.tar.xz',
+		'format' => 'tar',
+		'compressor' => ['xz']},
+
  	'zip' => {
  		'display' => 'zip',
  		'type' => 'application/x-zip',
@@ -188,6 +195,7 @@ our %known_snapshot_formats = (
  our %known_snapshot_format_aliases = (
  	'gzip'  => 'tgz',
  	'bzip2' => 'tbz2',
+	'xz'    => 'txz',

  	# backward compatibility: legacy gitweb config support
  	'x-gzip' => undef, 'gz' => undef,
-- 
1.6.4

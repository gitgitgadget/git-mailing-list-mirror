From: James Cloos <cloos@jhcloos.com>
Subject: Commit performance, or lack thereof
Date: Sat, 22 Aug 2009 19:42:32 -0400
Message-ID: <m3r5v39zzz.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 01:52:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf0Nc-00081C-Er
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 01:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933314AbZHVXwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2009 19:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933265AbZHVXwG
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 19:52:06 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:4759 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933254AbZHVXwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 19:52:05 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Aug 2009 19:52:04 EDT
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 595C24014C; Sat, 22 Aug 2009 23:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1250984588;
	bh=hN1+LXSIgr+URF3VBi0AJIuxft7e6q/0XMmjwrZbyR4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=RrbYCapn4hQ7sr/jZy3C4P0cEV1/Ti+CXy3xrjSOs50Qnmfvb6fxwqyTRuoWLqmFz
	 zrYSVVnsV1EjbTI98NL4numabz8zZOrxIgOtPoWJW5BKrq8LdNKyXYl3/9fk0NYBFa
	 3Y7sw45imPIdGU7QCN3NWPxI8z/GQe2kgzPvsNtA=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id A8AFE684FC; Sat, 22 Aug 2009 23:42:57 +0000 (UTC)
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1.50 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126827>

Starting in the kernel tree, if one edits and adds a single file and
then commits it w/o specifying the file name as an argument to commit,
git uses 10 or so Megs of VM and one sees performace akin to this:

,----=AB gtime -v git commit -m 'make oldconfig' =BB
| [master 53d6af1] make oldconfig
|  1 files changed, 5 insertions(+), 2 deletions(-)
| 	Command being timed: "git commit -m make oldconfig"
| 	User time (seconds): 0.26
| 	System time (seconds): 1.06
| 	Percent of CPU this job got: 2%
| 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:47.04
| 	Average shared text size (kbytes): 0
| 	Average unshared data size (kbytes): 0
| 	Average stack size (kbytes): 0
| 	Average total size (kbytes): 0
| 	Maximum resident set size (kbytes): 0
| 	Average resident set size (kbytes): 0
| 	Major (requiring I/O) page faults: 86
| 	Minor (reclaiming a frame) page faults: 4703
| 	Voluntary context switches: 4805
| 	Involuntary context switches: 274
| 	Swaps: 0
| 	File system inputs: 48384
| 	File system outputs: 5680
| 	Socket messages sent: 0
| 	Socket messages received: 0
| 	Signals delivered: 0
| 	Page size (bytes): 4096
| 	Exit status: 0
`----

OTOH, if one does specify the filename as an argument to commit, git
uses almost 300 Megs of VM and the numbers look more like:

,----=AB gtime -v git commit -m 'make oldconfig' .config =BB
| [master 4db1e8b] make oldconfig
|  1 files changed, 1 insertions(+), 1 deletions(-)
| 	Command being timed: "git commit -m make oldconfig .config"
| 	User time (seconds): 1.82
| 	System time (seconds): 1.80
| 	Percent of CPU this job got: 3%
| 	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:45.72
| 	Average shared text size (kbytes): 0
| 	Average unshared data size (kbytes): 0
| 	Average stack size (kbytes): 0
| 	Average total size (kbytes): 0
| 	Maximum resident set size (kbytes): 0
| 	Average resident set size (kbytes): 0
| 	Major (requiring I/O) page faults: 1609
| 	Minor (reclaiming a frame) page faults: 21363
| 	Voluntary context switches: 10707
| 	Involuntary context switches: 620
| 	Swaps: 0
| 	File system inputs: 361192
| 	File system outputs: 11296
| 	Socket messages sent: 0
| 	Socket messages received: 0
| 	Signals delivered: 0
| 	Page size (bytes): 4096
| 	Exit status: 0
`----

Git should be able to do the latter operation as efficiently as it can
do the former operation.

-JimC
--=20
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

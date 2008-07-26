From: Stephan Beyer <s-beyer@gmx.net>
Subject: git sequencer prototype
Date: Sat, 26 Jul 2008 07:20:39 +0200
Message-ID: <1217049644-8874-1-git-send-email-s-beyer@gmx.net>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 07:22:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMcEG-0007zr-Lu
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 07:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYGZFU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 01:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbYGZFU5
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 01:20:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:39494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751642AbYGZFU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 01:20:56 -0400
Received: (qmail invoked by alias); 26 Jul 2008 05:20:54 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp060) with SMTP; 26 Jul 2008 07:20:54 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/LU71bDTrLy75oM7HJvHLqX2ls4Y7GZQU2ayu+Zh
	QqM3UDdrqZspKI
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMcCy-0002JV-BC; Sat, 26 Jul 2008 07:20:44 +0200
X-Mailer: git-send-email 1.6.0.rc0.49.gd39f
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90175>

Hi,

for those who are interested in git-sequencer: here's the latest
prototype, that should be able to apply to master.

An outline of the differences to the last sequencer prototype patchset:
 - typofixes, minor bugfixes
 - simplifications (seen due to builtin-ification)
 - introduced --allow-dirty
   that is used by the git-am migration, to allow
   usage of git-am on dirty index
 - set ("keep") ORIG_HEAD; somehow experimental


In the last patchset I mentioned the issue, that the prototype is slow
as hell.  I know some bottlenecks, but I have not even tried to change
that, because this is no issue for the builtin.

I paste the experiments that I did on my test machine some time ago:

git-am: Apply 100 (trivial) patches
        original: 5.1s
 prototype-based: 17s  (wtf!)
   builtin-based: 2.8s

git-rebase--interactive: Pick 100 (trivial) commits
        original: 4.8s
 prototype-based: 10.1s
   builtin-based: 1.7s

Those times don't have any methodic value, it's just to get an impression.
Nevertheless some information about that:
 - performance was only tested one or two times
 - /proc/cpuinfo says my machine is an AMD 64 X2 with 4013 BogoMIPS
 - /bin/sh is dash (if the propaganda is true, bash is even slower)
 - the changes of the patches are equivalent to those of the commits

Regards,
  Stephan


Stephan Beyer (5):
  Add git-sequencer shell prototype
  Add git-sequencer documentation
  Add git-sequencer test suite (t3350)
  Migrate git-am to use git-sequencer
  Migrate rebase-i to sequencer

 .gitignore                      |    1 +
 Documentation/git-sequencer.txt |  676 +++++++++++++
 Makefile                        |    1 +
 command-list.txt                |    1 +
 git-am.sh                       |  632 +++++--------
 git-rebase--interactive.sh      |  436 ++-------
 git-rebase.sh                   |    7 +-
 git-sequencer.sh                | 2042 +++++++++++++++++++++++++++++++++++++++
 t/t3350-sequencer.sh            |  838 ++++++++++++++++
 t/t3404-rebase-interactive.sh   |    8 +-
 t/t4150-am.sh                   |    4 +-
 11 files changed, 3889 insertions(+), 757 deletions(-)
 create mode 100644 Documentation/git-sequencer.txt
 create mode 100755 git-sequencer.sh
 create mode 100755 t/t3350-sequencer.sh

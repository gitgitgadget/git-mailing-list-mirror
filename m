From: Alex Riesen <raa.lkml@gmail.com>
Subject: use binmode(STDOUT) in git-status
Date: Mon, 28 Nov 2005 08:34:50 +0100
Message-ID: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30040_22273221.1133163290137"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 08:35:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgdXM-000657-M2
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 08:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVK1Hex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 02:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVK1Hex
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 02:34:53 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:29360 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751252AbVK1Hex (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 02:34:53 -0500
Received: by nproxy.gmail.com with SMTP id q29so473481nfc
        for <git@vger.kernel.org>; Sun, 27 Nov 2005 23:34:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=cpv7r61NYk2OF/QmxUSS6dTDs+07qU5QLwb5FLlsXzz6dGNpFhT6Gj8MY+FfbAIXDvVjiDJ81h5w04F0PMUqQ01aU2z6PiOJNrwKLk62GHK6u5rRLLvIwW8IO9EDwZt+Ac4lfA//N4+Cxs0TX2H+yHcBfzBdNQNAo/7+BcEPYrY=
Received: by 10.48.142.6 with SMTP id p6mr420132nfd;
        Sun, 27 Nov 2005 23:34:50 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Sun, 27 Nov 2005 23:34:50 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12857>

------=_Part_30040_22273221.1133163290137
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Activision's Perl generates CRLF unless STDOUT is binmoded, which is
inconsistent with other output of git-status.

---
I assume none _sane_ can want CRLF as line-ending...

------=_Part_30040_22273221.1133163290137
Content-Type: text/plain; 
	name=0001-use-binmode-on-STDOUT-to-avoid-generation-of-CRLF-by-activision-perl.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-use-binmode-on-STDOUT-to-avoid-generation-of-CRLF-by-activision-perl.txt"

Subject: [PATCH] use binmode on STDOUT to avoid generation of CRLF by activision perl

Signed-off-by: Alex Riesen <fork0@gmail.com>


---

 git-status.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

applies-to: c64901fa1a7f5fa19d025a315bcd1e5d5eae5d93
0fc9f4bdb41725d2b2b54e70ff4740bdb826bdea
diff --git a/git-status.sh b/git-status.sh
index b90ffc1..2fc7595 100755
--- a/git-status.sh
+++ b/git-status.sh
@@ -82,13 +82,14 @@ else
         --exclude-per-directory=.gitignore
 fi |
 perl -e '$/ = "\0";
+	binmode(STDOUT);
 	my $shown = 0;
 	while (<>) {
 		chomp;
 		s|\\|\\\\|g;
 		s|\t|\\t|g;
 		s|\n|\\n|g;
-		s/^/#	/;
+		s/^/#\t/;
 		if (!$shown) {
 			print "#\n# Untracked files:\n";
 			print "#   (use \"git add\" to add to commit)\n#\n";
---
0.99.9.GIT

------=_Part_30040_22273221.1133163290137--

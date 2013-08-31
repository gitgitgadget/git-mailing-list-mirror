From: Christoph Mallon <christoph.mallon@gmx.de>
Subject: Bug in git rebase --continue in v1.8.4
Date: Sat, 31 Aug 2013 14:49:37 +0200
Message-ID: <5221E661.1070200@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070504030409040504070500"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 31 14:49:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFkcl-0006Z5-Ue
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 14:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab3HaMtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 08:49:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:63921 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383Ab3HaMtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 08:49:41 -0400
Received: from rotluchs.lokal ([91.19.55.94]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LdHLB-1Vfhha0VH7-00iVpz for <git@vger.kernel.org>; Sat,
 31 Aug 2013 14:49:39 +0200
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:17.0) Gecko/20130812 Thunderbird/17.0.8
X-Provags-ID: V03:K0:G99F539/JmLlFh3R7id7CQV9bjoghfxA6kCURHgLiVNTPrUsGqQ
 k/vTGrvllyGsxWeSiDSIWcbg0ODeopfHNfbbtwEpyAewuay0Kdmpro2Cl9+bmnCLsYFaR9J
 EHb32eshOagWWTYIf+0MFXjOiUFD+gJ2QQEFmDJuBEVa9ODYOiEfmqinXZKnarF+gFYMuyR
 i2HowIKP64yny+zWhhY4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233516>

This is a multi-part message in MIME format.
--------------070504030409040504070500
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

if I run rebase --continue (e.g. after a conflict resolution), then the rebase always ends with this error message:
	It seems that there is already a rebase-apply directory, and
	I wonder if you are in the middle of another rebase.  If that is the
	case, please try
        	git rebase (--continue | --abort | --skip)
	If that is not the case, please
        	rm -fr "/home/tron/gitRebaseTest/test/.git/rebase-apply"
	and run me again.  I am stopping in case you still have something
	valuable there.

This happens on git v1.8.4 on FreeBSD. It is fine with v1.8.3.4. It seems to be caused by a1549e1049439386b9fd643fae236ad3ba649650, specifically this hunk:
	--- a/git-rebase--am.sh
	+++ b/git-rebase--am.sh
	@@ -7,12 +7,12 @@ case "$action" in
	 continue)
	  git am --resolved --resolvemsg="$resolvemsg" &&
	  move_to_original_branch
	- exit
	+ return
	  ;;
	 skip)
	  git am --skip --resolvemsg="$resolvemsg" &&

Attached is a test script for this problem.

Regards
	Christoph

--------------070504030409040504070500
Content-Type: text/plain; charset=UTF-8;
 name="gitRebaseTest"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gitRebaseTest"

IyEgL2Jpbi9zaApzZXQgLWV1eAoKZ2l0IGluaXQgdGVzdApjZCB0ZXN0CgplY2hvIGEgPiBm
aWxlCmdpdCBhZGQgLgpnaXQgY29tbWl0IC1tIGEKCmdpdCBicmFuY2ggLXQgdGVzdAoKZWNo
byBiID4gZmlsZQpnaXQgYWRkIC4KZ2l0IGNvbW1pdCAtbSBiCgpnaXQgY2hlY2tvdXQgdGVz
dAplY2hvIGMgPiBmaWxlCmdpdCBhZGQgLgpnaXQgY29tbWl0IC1tIGMKCiEgZ2l0IHJlYmFz
ZQpnaXQgY2hlY2tvdXQgLS10aGVpcnMgLgpnaXQgYWRkIC4KZ2l0IHJlYmFzZSAtLWNvbnRp
bnVlCg==
--------------070504030409040504070500--

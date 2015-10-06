From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/4] Fix locking issues on Windows with `git clone
 --dissociate`
Date: Tue, 06 Oct 2015 15:17:36 +0200
Organization: gmx
Message-ID: <cover.1444131898.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:17:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjS7s-0004Du-Hd
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbbJFNRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:17:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:55811 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbbJFNRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:17:47 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MaIw0-1a3Apl00ka-00JvLk; Tue, 06 Oct 2015 15:17:37
 +0200
In-Reply-To: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:Y+W/+D46P2waP4XLUZWnp9SeKxFeUeD53Ra74YTJDrYows8Ja56
 Pq0E0gL22V2JaGfQYwDMSjw3oEtxt5qI3W/leqgyh1ygGRFcO4XW2p92oExTHH36SzovROl
 qONaPjQ4mzWxSpbMNbRDUV/uGbaCAw1wPNKzWLrddtnx0oFT4gFhwkekwKlEy6bW5Ll08Z4
 fD98PppIgAVE8SONtPayw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/mlodPRYZ5g=:CbW8j8p2PPWGoySX67S7G4
 33Z490etEnwwyZobxvKjC2ZHDVdc3WaEW8tq+0ktlItVYhlj8dT/U1gq2U7jb81R6X5Jn5Ahu
 B7BCQru+KDLdp1tFICqMUNv19tYSyS1cKRxesWgcBhQzGLOL6dWpe6DUm/FM2nDn0x7pxfYQY
 vAdtHbsiuw2FZkS1Bs6TUyWJgptYT3FuRlAQzajd5zZEGPqrNSo6dnjSGynBcPHhB5SjdU/5h
 xManwwi85F/gmcaj2q9xH8YlOBicT9gxzJ1AOyAa1pvNTil2FqXjWcFBWuxRQs0+6FcrO/oif
 kAFpQHSD5rfRaDaOFs6QYYJUfD7cEJdu+Epu7tYbwRN1r5eKHF4h+8EPfCZbHEfR6tyrCCbxv
 KSCa1qT/5PP12z8QO6jR+aovM12Q5m3cWQTNCx3vcEoXvMYO6MktOtnEJ/ZcyaSn0kFCyMW3L
 zKeAASCj4UCwUCy8JQJdh4gp11ohMXNk9OjOCcHMzf5+3Xelv8K6uvr4sKtttdUu5LxR1koRW
 qiIwWpEsnaFCmTvzaHMRgivTHd6Aebz0PwcA0d/zrkz6iSMWMkU1Rq6XU7PSGcEMW+JRWEQW+
 q5KYPfF4RzVwqMsaWG5bj2JTjSCSuGhfTgHuzmbiUIyM1JZjH5YWTT7Sq3GKQ+pRGwNC00Oqv
 BTh0eKgP6AgC++IPz6xvcciyR7qYSigM53DKH7AYfOQndIQUN+tizsugsnuKWctuQyZ2/zZTV
 zRHPuWsfjrtnhTdnxP6FHAEpNHMhhClPvk6ezCJixfX6cuFwEbqWyebQoSGesdZgk4zfZLS4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279135>

This is version 3, adding that BUG! message if do_not_close was set.

Max, I still hope that this patch series helps also your use case!

Interdiff below the diffstat.

Johannes Schindelin (4):
  Demonstrate a Windows file locking issue with `git clone --dissociate`
  Consolidate code to close a pack's file descriptor
  Add a function to release all packs
  clone --dissociate: avoid locking pack files

 builtin/clone.c            |  4 +++-
 cache.h                    |  1 +
 sha1_file.c                | 59 +++++++++++++++++++++++++++++-----------------
 t/t5700-clone-reference.sh | 21 +++++++++++++++++
 4 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fe823fe..ca699d7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -810,7 +810,10 @@ void close_all_packs(void)
 	struct packed_git *p;
 
 	for (p = packed_git; p; p = p->next)
-		close_pack(p);
+		if (p->do_not_close)
+			die("BUG! Want to close pack marked 'do-not-close'");
+		else
+			close_pack(p);
 }
 
 
-- 
2.6.1.windows.1

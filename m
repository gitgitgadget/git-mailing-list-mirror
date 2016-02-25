From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] refs: mark a file-local symbol as static
Date: Thu, 25 Feb 2016 19:28:45 +0000
Message-ID: <56CF55ED.9040906@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 20:29:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ1bB-0005dN-Oo
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 20:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbcBYT3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 14:29:15 -0500
Received: from avasout01.plus.net ([84.93.230.227]:45945 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933401AbcBYT2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 14:28:54 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout01 with smtp
	id NjUq1s0014mu3xa01jUr0V; Thu, 25 Feb 2016 19:28:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=pesYDFqypsnUEVfczIQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287420>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi David,

No, you are not having flashbacks - you forgot to make the
register_ref_storage_backend() function static. ;-)

BTW, I still have two symbols showing as exported but not used, namely:

    $ diff nsc psc1
    ...
    32a35,36
    > refs.o	- resolve_ref_unsafe_submodule
    > refs/files-backend.o	- do_for_each_per_worktree_ref
    $ 

Both of these symbols are used by the lmdb backend, so I'm assuming that
they are part of the 'refs API' and will (may?) be used by other alternate
reference backends. Is that the case?

(I don't have the time right now to look at the code!)

Thanks!

ATB,
Ramsay Jones


 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1c1d3ac..e448434 100644
--- a/refs.c
+++ b/refs.c
@@ -46,7 +46,7 @@ int ref_storage_backend_exists(const char *name)
 	return 0;
 }
 
-void register_ref_storage_backend(struct ref_storage_be *be)
+static void register_ref_storage_backend(struct ref_storage_be *be)
 {
 	be->next = refs_backends;
 	refs_backends = be;
-- 
2.7.0

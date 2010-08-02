From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix typo in run() subroutine
Date: Mon, 02 Aug 2010 22:21:47 +0200
Message-ID: <20100802202047.20307.73672.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 02 22:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og1Xf-00028w-1l
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 22:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab0HBUXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 16:23:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54779 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab0HBUXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 16:23:16 -0400
Received: by fxm14 with SMTP id 14so1788829fxm.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=rpTBro60lDQqpIyXUMgi55OPp8DHp376YG/cRnl7HiY=;
        b=bJSVlhYJR0bmWFuL6IjBTz35jibc1yI8zqajl/yQbvYmpeoNkxAaaWntyU99pN9KAD
         M+FKLoZELwJWY4cjp9hMeMby9Bsd/HLGeV6txAbm+rZgMSEhn1zlZK0W7ZiiSgea1a63
         TjHbTszNvi2KfAydoSjTnlrhyEkPXR/ao8tGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=wcnn+E6HDd4Xuz1Nq2ROy07gUmoQnTizIlPufp2NIQ7piXHe78Pcs4Hdh6J3JJo8Kq
         6fJGZ9Ld0tGiTq/7lOPXqlKDBiALUGnPbVA1tLgayp7Xgtvus4Lz1EMU2ox7MDFHmvM5
         kDKp95BtdeXctjvY3mvbCV6SyueJPaZVRvZGE=
Received: by 10.223.108.137 with SMTP id f9mr6413048fap.3.1280780530279;
        Mon, 02 Aug 2010 13:22:10 -0700 (PDT)
Received: from localhost.localdomain (aeho67.neoplus.adsl.tpnet.pl [79.186.196.67])
        by mx.google.com with ESMTPS id h8sm2174426faj.38.2010.08.02.13.22.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 13:22:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o72KLmHZ020348
	for <git@vger.kernel.org>; Mon, 2 Aug 2010 22:21:58 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152451>

Run $post_dispatch_hook->() not $pre_dispatch_hook->() after each
request.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Probably nobody is using pre/post dispatch (request) hooks anyway...
by default they are no-op (empty).

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e0e9532..8b02767 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1125,7 +1125,7 @@ sub run {
 
 		run_request();
 
-		$pre_dispatch_hook->()
+		$post_dispatch_hook->()
 			if $post_dispatch_hook;
 
 		last REQUEST if ($is_last_request->());

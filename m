From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] read-tree: convert unhelpful usage()'s to helpful die()'s
Date: Tue, 23 Jun 2009 21:27:51 -0700
Message-ID: <1245817672-25483-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 06:30:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJK7U-0001On-IJ
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 06:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbZFXE1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 00:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbZFXE1z
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 00:27:55 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:39591 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZFXE1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 00:27:54 -0400
Received: by pxi28 with SMTP id 28so130579pxi.33
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 21:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=eUWcanATRpf172t0ykT32O6OtwV0KFjiBoD9xKj+3zw=;
        b=F6FmygJm016c+u3hi64bv0fQb8Ya8LEqrqZaLUhJ3uOaWein/9j0gsyEhh0e34nD3e
         HJNfuHfgSkRkrApEyunGPeEjN2k383rHkTgsXkttCNVHivZqv7L8mcTDl1bJXqCalcem
         9zCeRP9rbH2mM94xULWExmnNsSSnge2CMaMwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NQiO1jeqCDYBpnuAKb5xSF9aLygx1EC1D+ycgUzbTpz4Dp989kqN2ewRRmDTzeS0lJ
         eoqkee7fUtXkvkbHvhcL59HOcMj2fS6GBzEIJkAZzlpnrFcCf9XDpwHDj09dRhvG3p75
         OMFjidoGnXViRRySPzWXMqTo+H9wTIUNh3HG0=
Received: by 10.114.149.2 with SMTP id w2mr1256344wad.182.1245817677201;
        Tue, 23 Jun 2009 21:27:57 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id j39sm1084585waf.10.2009.06.23.21.27.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Jun 2009 21:27:56 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 23 Jun 2009 21:27:52 -0700
X-Mailer: git-send-email 1.6.3.3.334.g916e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122120>

Printing the usage message when encountering bad option combinations is
not very helpful. Instead, die with a message which tells the user
exactly what combination is invalid.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-read-tree.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 82e25ea..887e177 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -145,9 +145,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 
-		/* using -u and -i at the same time makes no sense */
 		if (1 < opts.index_only + opts.update)
-			usage(read_tree_usage);
+			die("-u and -i at the same time makes no sense");
 
 		if (get_sha1(arg, sha1))
 			die("Not a valid object name %s", arg);
@@ -156,7 +155,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		stage++;
 	}
 	if ((opts.update||opts.index_only) && !opts.merge)
-		usage(read_tree_usage);
+		die("%s is meaningless without -m",
+		    opts.update ? "-u" : "-i");
 	if ((opts.dir && !opts.update))
 		die("--exclude-per-directory is meaningless unless -u");
 	if (opts.merge && !opts.index_only)
-- 
1.6.3.3.334.g916e1

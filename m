From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Bugfix: grep: Do not colorize output when -O is set
Date: Fri,  2 Jul 2010 18:02:21 +0800
Message-ID: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
Cc: johannes.schindelin@gmx.de, jrnieder@gmail.com,
	Nazri Ramliy <ayiehere@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 12:02:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUd54-0000Ty-Mb
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 12:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab0GBKCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 06:02:41 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50757 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab0GBKCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 06:02:40 -0400
Received: by pvc7 with SMTP id 7so1206563pvc.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+ep1BlV7gYSINlAeLHdauCTDqb5pfrvnF66hdxAm3fs=;
        b=aitITIAlAc1IQRzlp8hi6XcTzFfdKDdc5U3IqNockstp11k1+wmXf7Dw0CuOSvLOC8
         4TuVibY1oTXVEcNHxGPexrROYXsTMwWxQWVICHz/TAKChmWDJGeqpgoMNKgoC6HPTQY/
         5w+8Pj01oDbamX34Uzck0ZjDFwJE+ouoDz6so=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sy0jGuswXDEHo+yw2LCXEN9Q3kzvopbjtqNT7uIcupG65+iklDF0aoLw2DOtl0Cifu
         aeBydbqvIarjMmnao8oqO6/E7ePoj5MNqAwShPAKfuGgPFwHK/BNf7AGr81kwCIu2ihW
         Vleqm10OVQYPwffwiOfgKn8s/S22j4UGJ9LsU=
Received: by 10.114.88.14 with SMTP id l14mr682139wab.76.1278064959173;
        Fri, 02 Jul 2010 03:02:39 -0700 (PDT)
Received: from localhost.localdomain ([115.134.69.17])
        by mx.google.com with ESMTPS id x9sm7997164waj.3.2010.07.02.03.02.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 03:02:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.363.gac4b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150121>

When color.ui is set to auto, "git grep -Ovi foo" breaks due to the
presence of color escape sequences.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
Breakage aside, 'git grep -Ovi' really rocks!

 builtin/grep.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 232cd1c..597f76b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1001,6 +1001,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (show_in_pager == default_pager)
 		show_in_pager = git_pager(1);
 	if (show_in_pager) {
+		opt.color = 0;
 		opt.name_only = 1;
 		opt.null_following_name = 1;
 		opt.output_priv = &path_list;
-- 
1.7.1.245.g7c42e.dirty

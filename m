From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] format-patch: page output with --stdout
Date: Sat, 20 Nov 2010 13:05:42 +0800
Message-ID: <1290229542-3116-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 20 06:06:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJfeL-0004rp-L0
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 06:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752Ab0KTFFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 00:05:52 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43835 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0KTFFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 00:05:51 -0500
Received: by pwj1 with SMTP id 1so854046pwj.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 21:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oYMu0zgQ93WYSqomI/Lu6fRVE451j3KjZVlQ1Lc3by8=;
        b=v1WiUudGlVlR0zL+PeVmHXO+iOYyRb0kl1ZzllwSWL1qcQTGXDZ/6vCrmnk/pbNuWw
         bx4w8hNVen6NlvU/TJJyJhMw3BhAb22iN5WcwHUtNPCAKVWWxsVdSLhVP6VI44fxvDPl
         xtfnCCt3OSrgK9sthJh6XOOsXwxdYDkHRxIvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vangvdqDmEMqRdygn54bDxVMTid7AvuqY9tL2+TYKUNt38s/H0DInq4eakty2Aszgk
         dz1ARu1JJ8OZD4FLbHES97aI15RQoIX9MJXr37Ir9jPErh85kQ2uisOjpsbyR/0oKiKM
         bW57wd5WJsNnVyGatK2zajUFJr/e15QDOB1E4=
Received: by 10.142.43.10 with SMTP id q10mr2540104wfq.106.1290229551169;
        Fri, 19 Nov 2010 21:05:51 -0800 (PST)
Received: from localhost.localdomain (cm69.zeta153.maxonline.com.sg [116.87.153.69])
        by mx.google.com with ESMTPS id v19sm2789240wfh.12.2010.11.19.21.05.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 21:05:50 -0800 (PST)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161824>

Pass output through the pager if format-patch is run with --stdout. This
saves the user the trouble of running git with '-p' or piping through a
pager.

setup_pager() already checks if stdout is a tty, so we don't have to
worry about behaviour if the user redirects/pipes stdout.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/log.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d0297a1..c631950 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1159,6 +1159,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	if (!use_stdout)
 		output_directory = set_outdir(prefix, output_directory);
+	else
+		setup_pager();
 
 	if (output_directory) {
 		if (use_stdout)
-- 
1.7.3.2.492.gfc3d1.dirty

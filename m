From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/3] format-patch: fix dashdash usage
Date: Sat, 28 Nov 2009 13:40:27 +0200
Message-ID: <1259408429-5685-2-git-send-email-felipe.contreras@gmail.com>
References: <1259408429-5685-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 12:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELfb-0006w7-Fo
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbZK1Lkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 06:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbZK1Lkl
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:40:41 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38892 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbZK1Lkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:40:40 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so1602122bwz.21
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MoVLwMCD8yorSSDFKp2uwkzhbC9nzMo5OelM9SeGGN0=;
        b=mpQtF650qgG83x/AnSuInbj5N8yhTtXFYOK3971DQVt5fEzgJjly580XUGtxFL908H
         aTYK5Pc4Wc3B+mA5CIKg9g/Fin7blo4G2ReqE9wpptFzd5wewkT+jRw68DtNG2Nve5TG
         xe8G0xRsMQmwRVxQZqRvw5sAnoXgL+pFTYamg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GvsXbEPdBvgT7cmvXTttBXcskZ7Evb5ZX/403kbk39hNT2Iao13HNid2CBLCFQbisu
         YKnSvzI5BDDEGdfplZ0KP5NODgthpdQ2VrXSnJCOk23s2ntyD8P7s/AP44U0OJelW5yr
         Ua1vyYQmOYZOcJQp5n/0NZAuA47MGzpHQyjGA=
Received: by 10.204.155.92 with SMTP id r28mr2202315bkw.121.1259408446619;
        Sat, 28 Nov 2009 03:40:46 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 16sm615082bwz.15.2009.11.28.03.40.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:40:45 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.61.geeb75
In-Reply-To: <1259408429-5685-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133957>

$ git format-patch <committish> -- <path-not-in-working-dir>

Doesn't work otherwise. The current code would complain that the path is
not in the working tree and that "--" must be specified, even if the
user _did_ specify it. This happens because "--" is removed from the
arguments, so we need to pass PARSE_OPT_KEEP_DASHDASH to parse_options
to avoid that.

Comments by Junio C Hamano.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-log.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 33fa6ea..1766349 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -976,7 +976,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	 */
 	argc = parse_options(argc, argv, prefix, builtin_format_patch_options,
 			     builtin_format_patch_usage,
-			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (do_signoff) {
 		const char *committer;
-- 
1.6.6.rc0.59.g5117f7.dirty

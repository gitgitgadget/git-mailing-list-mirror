From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/24] Show usage string for 'git cherry -h'
Date: Mon,  9 Nov 2009 09:04:43 -0600
Message-ID: <1257779104-23884-3-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Vfl-000393-6O
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551AbZKIOzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZKIOzL
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:11 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64393 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbZKIOzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:07 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179582ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TI9mHScFcC2ihT3RuKC4Uv6rtfIjMEncifEWk3MkETU=;
        b=scJuABln6umqb5DHP01gIrngzCDCHGQCb1chErO0snsId0MnqdPYjy/Je89vhWEXYD
         LETNX3BfesSMbOgojxbwdUEcNRLOkOvWJiFtUFVuJQei8bF4D92suZxGPYwAJ3XjfsTv
         KPkvpBKJhS0WktmwpkdXY+MBqnoXw20nxtfcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a8d2mkpjtEumSAmJ/Zoq/fP+OmgzdaUozMhU5POho5r/cEEOVphM2tUfSBF/hP7btS
         KvO8uBEy167MdbDaYviEQJYiQ1S9CaRNu7GfMv5QPNzMQM0wtG4M5BClTTxre7trD0PJ
         5os8A6sEjfNICVFrmRKP+dEiWZ6aNW9hZ2bcg=
Received: by 10.216.87.12 with SMTP id x12mr2530387wee.48.1257778512884;
        Mon, 09 Nov 2009 06:55:12 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:12 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132483>

Treat an "-h" option as a request for help, rather than an
"Unknown commit -h" error.

"cherry -h" could be asking to compare histories that leads to
our HEAD and a commit that can be named as "-h".  Strictly
speaking, that may be a valid refname, but the user would have to
say something like "tags/-h" to name such a pathological ref
already, so it is not such a big deal.

The "-h" option keeps its meaning even if preceded by other
options or followed by other arguments.  This keeps the
command-line syntax closer to what parse_options would give and
supports shell aliases like 'alias cherry="git cherry -v"' a
little better.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-log.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 207a361..5248507 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1237,6 +1237,9 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		argv++;
 	}
 
+	if (argc > 1 && !strcmp(argv[1], "-h"))
+		usage(cherry_usage);
+
 	switch (argc) {
 	case 4:
 		limit = argv[3];
-- 
1.6.5.2

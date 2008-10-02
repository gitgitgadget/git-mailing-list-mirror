From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] format-patch: autonumber by default
Date: Thu,  2 Oct 2008 19:58:11 +0200
Message-ID: <1222970291-5337-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <48E4D73B.9090508@op5.se>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 20:00:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlSTZ-0008A9-1S
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 20:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbYJBR6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 13:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbYJBR6L
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 13:58:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:2057 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbYJBR6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 13:58:10 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1081851ugf.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6AjuNI49Wb+jmOJ8L+UH47GxaxnlCp/ykN6aJV3TNx0=;
        b=phpzhjRuBfDV16omJ6G8DEry0ztUy5rAbzelSHicKJ1H9S+9NcjIrvJ7mQxIm5nJMV
         vZXLE05z1fHqFTecA9ScoI3GBAOYxCvO0Dl8fXRpJOCOgfWjdYAezPnq4MZvBpUEM0xK
         M4JgIq0PBTFO+WGa+KZskFmIjKdFj5kuLcxcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lNc47ye48F+fSQ/zWvmu+1gF/rkwQ8eLoUi1MFly0LW3zoBx9OkiqzGJU/aSbGcojN
         p/s5qGtQDqBCiBeOfdsjLbLs7yi2MHwT3g3sYyzWXJMpCfSlxWPC0RO5tTZWut47lMTY
         EvzOFZMeMsmSRWohHH92xIiYHzViFM9lUFPSA=
Received: by 10.66.218.15 with SMTP id q15mr4226534ugg.77.1222970288769;
        Thu, 02 Oct 2008 10:58:08 -0700 (PDT)
Received: from localhost ([94.37.5.114])
        by mx.google.com with ESMTPS id s7sm12718164uge.24.2008.10.02.10.58.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 10:58:07 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <48E4D73B.9090508@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97362>

format-patch is often used for multiple patches at once when sending a
patchset, in which case we want to number the patches; on the other
hand, single-patches are not usually expected to be numbered.

The typical behavior expected by format-patch is therefore the one
obtained by enabling autonumber, which should thus be the default.

Users that want to disable numbering for a particular patchset can do
so with the existing -N command-line switch. For users that want to
change the default behavior we provide a 'noauto' option for the
format.numbering config key.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 builtin-log.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index fc5e4da..5187dc2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -426,7 +426,7 @@ static int istitlechar(char c)
 
 static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
-static int auto_number = 0;
+static int auto_number = 1;
 
 static char **extra_hdr;
 static int extra_hdr_nr;
@@ -484,6 +484,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			auto_number = 1;
 			return 0;
 		}
+		if (value && !strcasecmp(value, "noauto")) {
+			auto_number = 0;
+			return 0;
+		}
 		numbered = git_config_bool(var, value);
 		return 0;
 	}
-- 
1.5.6.5

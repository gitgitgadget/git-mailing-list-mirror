From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] format-patch: autonumber by default
Date: Thu,  2 Oct 2008 15:47:58 +0200
Message-ID: <1222955278-16908-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <alpine.DEB.1.00.0810021541470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:48:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOXl-0003BX-T0
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbYJBNrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 09:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754626AbYJBNrX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 09:47:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:8402 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbYJBNrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 09:47:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so760689fgg.17
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lnPnEQwPt3DmdWyYLYtNIABclFntFc+WwDQdKv75h/c=;
        b=fHffrnQpvut75gDmOpowywsbPyulMeo0Jhn5rElkCKlaz9tSBcWNrBG6Eajghl36Cb
         BWa4zN6gpqTaG6GrgzHnUC8UYpmh2fhDzMzMT4FWuvc1l6XhdB0l627Bo74uv5bGW6fP
         jtWjHh10JS0oKP+W+uCucPQ3tEr10rXVNWL78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=t+azLm1m23HfDkYfEHy+MSRGQk70Z2/lLCKt7izsO+/cPmjC0TaNZuQva9Ta0Dtk9H
         UHRcA1PsjUmw1i1uyybKyeseBBEc/nhfj1LPNSybqu/O4BYyogl+gFQcLed5M+LrYa3x
         vWdwvdsNFtl7UzMbARnA+qxo5uZiB2EuuoQn8=
Received: by 10.181.33.8 with SMTP id l8mr5627215bkj.28.1222955238998;
        Thu, 02 Oct 2008 06:47:18 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 34sm7255982nfu.24.2008.10.02.06.47.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 06:47:18 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <alpine.DEB.1.00.0810021541470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97328>

format-patch is most commoly used for multiple patches at once when
sending a patchset, in which case we want to number the patches; on the
other hand, single-patches are not usually expected to be numbered.

The typical behavior expected by format-patch is therefore the one
obtained by enabling autonumber, which should therefore be the default.

Users that want to disable numbering for a particular patchset can do so
with the existing -N command-line switch. For users that want to change
the default behavior we provide a 'noauto' option for the
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

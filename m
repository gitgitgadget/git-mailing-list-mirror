From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 3/7] imap-send: fix compilation-error on Windows
Date: Sat,  3 Oct 2009 00:39:41 +0000
Message-ID: <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sat Oct 03 02:40:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtsfP-0004Pj-1k
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 02:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbZJCAj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 20:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbZJCAj6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 20:39:58 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:43951 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZJCAj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 20:39:57 -0400
Received: by qw-out-2122.google.com with SMTP id 3so587565qwe.37
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 17:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HVhVIk+gsdIZwaVoBcodaDEJD8vM9A4ZndCrsSr3iGE=;
        b=bSaZldgbNZI7Frqr4CVfr4e1Fa61CxZlNO2v950qlQ1e7vfvkxDn6ZTJEG5GvSff9D
         Wr6spTdA2ioOQmbLCQ4TZhr/78OKwxBzkeTzEqceJlA2U9AsuuFvHcs0zvgrZzg3u+KI
         vTS40S4R8X5/1nC9zmnrKdcUMQxO0kLwOQVbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uYQ1IfeefM8ylgkF43GK6FBPu6Q+wZI7kGS3CbgSLYyJv2W/pxdE84Kbi3CgOc7sq4
         x3tXS4TmgRo0VIwA3lXHEp03mEIhWtqeYNLSs1uRgrjS9tuUJW/EvOsLtD/9gTu2lyfS
         6Gon9HpkT3S6Kdnzu96gSUwd4paRn2BqnbVhg=
Received: by 10.224.66.211 with SMTP id o19mr1589489qai.342.1254530401489;
        Fri, 02 Oct 2009 17:40:01 -0700 (PDT)
Received: from localhost ([75.35.230.210])
        by mx.google.com with ESMTPS id 20sm160602qyk.1.2009.10.02.17.39.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 17:40:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129473>

mmsystem.h (included from windows.h) defines DRV_OK to 1. To avoid
an error due to DRV_OK redefenition, this patch undefines the old
definition (i.e the one from mmsystem.h) before defining DRV_OK.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 55a663a..8338717 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -94,6 +94,10 @@ struct msg_data {
 	unsigned int crlf:1;
 };
 
+#ifdef DRV_OK
+#undef DRV_OK
+#endif
+
 #define DRV_OK          0
 #define DRV_MSG_BAD     -1
 #define DRV_BOX_BAD     -2
-- 
1.6.5.rc2.7.g4f8d3

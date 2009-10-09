From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 4/8] imap-send: fix compilation-error on Windows
Date: Fri,  9 Oct 2009 17:04:38 +0200
Message-ID: <1255100682-13952-4-git-send-email-kusmabite@gmail.com>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-2-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-3-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 17:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwH8B-0007fT-9J
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761062AbZJIPGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761057AbZJIPGX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:06:23 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:54300 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761052AbZJIPGW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:06:22 -0400
Received: by ewy4 with SMTP id 4so697708ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZIxnqbFToKrirRizMtynhco6WgypESc8774ETGsGDAo=;
        b=G/iy2jVHe0RtFQkQAE8IvfT0iuUaCrwg9Uiq8Ydlp9ptZZPhtTFkHBlKMTV5NsrMIs
         y0fNn0KZt8w3L5OjR0OLQa4RdnrJ/p4wxYiAM4sU6PCxb/DUsQjXPzgFOpmJwvmYrRp2
         nprJy4ntNDsbOgLNnkUvRBxxBX5lujeZc+780=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nvENIJz4JjPneQ+EMnfPQUQ+zO4v0gjqmTDss3koxvY72S7dj2JKHTErmKBYbFCCPq
         GsgEnZpstvKdVNRDU3nwyjQn7HTcLS9cGkTcJbNs+SQ/ZFuUDdhPWAJNwAjRlkNSkCH0
         ramA6B7gZkaVkqBSssJdgbWQt5JdyUtAc6ndc=
Received: by 10.216.86.4 with SMTP id v4mr934082wee.200.1255100745908;
        Fri, 09 Oct 2009 08:05:45 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 24sm162013eyx.17.2009.10.09.08.05.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 08:05:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255100682-13952-3-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129812>

mmsystem.h (included from windows.h) defines DRV_OK to 1. To avoid
an error due to DRV_OK redefenition, this patch undefines the old
definition (i.e the one from mmsystem.h) before defining DRV_OK.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index dc3da98..ed51dbf 100644
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
1.6.5.rc1.60.g41795

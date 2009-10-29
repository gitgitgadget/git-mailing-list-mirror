From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 4/7] Allow both url and foreign vcs in remote config
Date: Wed, 28 Oct 2009 23:40:23 -0700
Message-ID: <1256798426-21816-5-git-send-email-srabbelier@gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:49:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Oor-0005Sk-GK
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501AbZJ2GtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 02:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756498AbZJ2GtC
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:49:02 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63668 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756497AbZJ2GtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 02:49:00 -0400
Received: by mail-pw0-f42.google.com with SMTP id 9so1254429pwj.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BoytinywbMS4001QgflTxqHjTZaexOQe1E3totQ/bUg=;
        b=fgBUv+R+JtQIpyIyTEMDi2SS7y6wYqvISaPPZn8tOqn8e6osC6INjfytt3QlTWEJF3
         wnkh27zHXz96zUW37KkDp3kiDAnKTRXhljyVOwmWY7Ri1OOMxdYCSlo9hy9ellfRAyYT
         PUamTU6D+nTQon0R9fp9dnzgi5Ps8L4vpGcjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mDfiOcEB4l1T7apxNhR+qggnjV5KR+p2hzWT/NiQ/7V2d3pSd6jrPIpYBmJc9vDxZ9
         KEhfEEzHreGAkCMMnqka6NbXn1bXQIciSiasJ6P9o+q97pIi6nmQbQpixYKP/pQ/Ybze
         iD3hjAU1EQDd0O1g7i20sPGxsPNqIPbVKo71I=
Received: by 10.115.66.10 with SMTP id t10mr6669307wak.20.1256798492694;
        Wed, 28 Oct 2009 23:41:32 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm401242pxi.1.2009.10.28.23.41.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:41:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131563>

The current logic prevents both 'remote.url' and 'remote.vcs' from
being set, while that might be useful.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	This way I can do:

	remote.hgremote.url = /path/to/hg/repo
	remote.hgremote.vcs = hg

	As well as:

	remote.hgremote.url = hg::/path/to/hg/repo

 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index f0441c4..29365de 100644
--- a/remote.c
+++ b/remote.c
@@ -50,7 +50,7 @@ static char buffer[BUF_SIZE];
 
 static int valid_remote(const struct remote *remote)
 {
-	return !remote->url != !remote->foreign_vcs;
+	return (!!remote->url) || (!!remote->foreign_vcs);
 }
 
 static const char *alias_url(const char *url)
-- 
1.6.5.2.291.gf76a3

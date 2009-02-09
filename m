From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 3/3] git-gui: define correct GIT_DIR for gitk
Date: Mon,  9 Feb 2009 03:00:50 +0100
Message-ID: <1234144850-2903-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 03:02:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWLTo-0004WI-5s
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 03:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbZBICBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 21:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbZBICBL
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 21:01:11 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:41523 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbZBICBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 21:01:06 -0500
Received: by fxm13 with SMTP id 13so2320164fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 18:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tpNRZ/zjXLPBBBCR9aIqUSMud5PrNqROcerudWbK6VU=;
        b=psPFYlifyfbTAdc/JSD0pYVF3U/hg1z4XzKzj+YD6qsWoAc0Eeakj1TpAUtTPZp7TQ
         p8pcDvm3UyKVYYZRHPhyWt8ZRn6PbT6XbdOQc28YzqDPlV6WsDMdPohLfYV73eLQp3gi
         IafGZaWBuKj6JMaDWvP/CiVCN6bgFhW0Gpuhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=owItz5FZEoixhdAIa/n3kJeR1vQQVbKmyC1yHn6Cpeh7jLUGqPtwYSgOCWEp1zcnf3
         0U8luNxBrlxsrVoWjkiTF+usIp1371+BLJddwl8+JowDLuPOVPRf2MzSr/E63I2ImF6C
         0Dbe2icx1BjVpNYX1oldLaILr6OnOyDLquDc4=
Received: by 10.103.217.5 with SMTP id u5mr1866635muq.118.1234144864805;
        Sun, 08 Feb 2009 18:01:04 -0800 (PST)
Received: from localhost (host-78-15-9-200.cust-adsl.tiscali.it [78.15.9.200])
        by mx.google.com with ESMTPS id y37sm20208mug.23.2009.02.08.18.01.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 18:01:03 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.173.g5e148
In-Reply-To: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109037>

When invoking gitk, git-gui assumed that the worktree was the dirname of
$_gitdir and that, by consequence, the git dir could be set to the tail of
$_gitdir once we changed to the worktree root directory.

The assumption is no longer true since the previous commit introduced
support for more generic worktree locations, so export a GIT_DIR
environment variable set to the full, normalized path of $_gitdir
instead.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui/git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 94317c7..de3f29c 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1908,7 +1908,7 @@ proc do_gitk {revs} {
 
 		set pwd [pwd]
 		cd $_gitworktree
-		set env(GIT_DIR) [file tail [gitdir]]
+		set env(GIT_DIR) [file normalize [gitdir]]
 
 		eval exec $cmd $revs &
 
-- 
1.6.2.rc0.173.g5e148

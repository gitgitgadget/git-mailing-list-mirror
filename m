From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/3] git-gui: properly check for a bare repo
Date: Mon,  9 Feb 2009 03:00:48 +0100
Message-ID: <1234144850-2903-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 03:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWLTm-0004WI-Qi
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 03:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbZBICBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 21:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbZBICBF
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 21:01:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:32907 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbZBICBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 21:01:01 -0500
Received: by fg-out-1718.google.com with SMTP id 16so963733fgg.17
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 18:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zneHjwayzejeqBVHekzm+BPlesUJBG2URgi5mZslkdc=;
        b=MzFrmUhjfJVB2M7KhqSrT9Oy5DgmPGV6DBJ/77oVAeqL67ZzR4Z7XhVKba5qSZfw27
         wsYOECEqNWw5szquR7mSoUYYoX4Fqu86r6OczXnkpBIgElBS2r3LCE7GOWWl1+Bh+6PU
         rHbKJyd9BVA8gA+7/3gQClJCSACRbZz/Egtuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LtEMIw+3WwPQ6NJa4F+xHOMNCHX4gZ7HU8LDvaB57BpX0ZtP20QdLqvXqdfjhrP/1d
         WHVVzyNJx3gOOt6z/vrt+NKUrucDw1q22QNHwBs8IyGoRUaPKc8oGk6b/p1LrigQkIJk
         QI5E9K16kHvVbQ1y0fk5mqPMlT5V6RxUjWm/Y=
Received: by 10.103.8.17 with SMTP id l17mr1008885mui.125.1234144859694;
        Sun, 08 Feb 2009 18:00:59 -0800 (PST)
Received: from localhost (host-78-15-9-200.cust-adsl.tiscali.it [78.15.9.200])
        by mx.google.com with ESMTPS id w5sm1849986mue.33.2009.02.08.18.00.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 18:00:59 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.173.g5e148
In-Reply-To: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109034>

When bare repository handling is not enabled, check for a bare
repository looking at the core.bare config option rather than refusing
to operate with a git directory ending with .git.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
I know I should have probably used something like
git rev-parse --is-bare-repository instead, but I didn't feel like
adding another git call. Is the config approach robust enough?

 git-gui/git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index e018e07..658a728 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1071,7 +1071,7 @@ if {$_prefix ne {}} {
 	}
 	unset cdup
 } elseif {![is_enabled bare]} {
-	if {[lindex [file split $_gitdir] end] ne {.git}} {
+	if {[is_config_true core.bare]} {
 		catch {wm withdraw .}
 		error_popup [strcat [mc "Cannot use funny .git directory:"] "\n\n$_gitdir"]
 		exit 1
-- 
1.6.2.rc0.173.g5e148

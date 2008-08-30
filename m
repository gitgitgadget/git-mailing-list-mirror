From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 1/8] git-gui: Don't allow staging files with conflicts.
Date: Sun, 31 Aug 2008 00:54:19 +0400
Organization: TEPKOM
Message-ID: <200808310054.19732.angavrilov@gmail.com>
References: <200808310052.21595.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXo4-00089f-9r
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757238AbYH3VOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbYH3VOa
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:30 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:58555 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905AbYH3VO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:26 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883439fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=gWTqf5skDUTOaYkfAuk1Ld5yWEYvi0+ifeYsGAsnc4w=;
        b=qKe820qWVE64og8xTpmERT//MBf1Df7PsyhaiO7VKyL3xAsn82m7ctTbO3URLy1HaU
         s0f9eYdx95yp+f003uY1srWsx8fZG7BReWYjWrd+ob+hZ4gc4HCacawz4ugoShPRppV5
         ozFqyD1i2xfG0AlcY7W6icRFRFWqrUBJE4wf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=R4m+6KVveF9JdgrhgzDeT4EW+qg4OYqD0gPHMZ/uYg+yRF+RjAvwLXNUDJTr5cGXsb
         5GXmHGJb4EwiIt8WXYx8rmxaMgOpxLWxNW8neWz4/YC/QTs0tZCaxs4fZ26fXbSB9+xG
         fzKqjJCRujDlt6hhe5+G3LLPY7YtnhacCleKY=
Received: by 10.181.23.2 with SMTP id a2mr4115758bkj.24.1220130864353;
        Sat, 30 Aug 2008 14:14:24 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.23
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:23 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808310052.21595.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94428>

Prevent staging files with conflict markers by clicking
on the icon in the 'Unstaged Changes' list. Instead, pretend
that the user clicked the name, and show the diff.

Originally it made some sense to allow staging conflicting
files, because git-gui did not provide any tools to resolve
them from within the GUI. But now that I'm adding mergetool
capabilities, it is more likely to cause accidental and
non-undoable errors.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ec08b5a..9df4f8c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1838,6 +1838,14 @@ proc toggle_or_diff {w x y} {
 	$ui_index tag remove in_sel 0.0 end
 	$ui_workdir tag remove in_sel 0.0 end
 
+	# Do not stage files with conflicts
+	if {[info exists file_states($path)]} {
+		set state [lindex $file_states($path) 0]
+		if {[string index $state 0] eq {U}} {
+			set col 1
+		}
+	}
+
 	if {$col == 0 && $y > 1} {
 		set i [expr {$lno-1}]
 		set ll [expr {[llength $file_lists($w)]-1}]
-- 
1.6.0.20.g6148bc

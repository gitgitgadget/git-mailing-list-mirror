From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [GUILT] Use git_editor
Date: Tue, 30 Sep 2008 19:43:50 +0100
Message-ID: <48E27366.3080503@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 20:45:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkkDb-0006g8-Eg
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 20:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbYI3Sn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 14:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbYI3Sn5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 14:43:57 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:4246 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbYI3Sn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 14:43:56 -0400
Received: by ik-out-1112.google.com with SMTP id c30so130906ika.5
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding:sender;
        bh=OpRMe81nJVgkIz8zvF2L6oD3kmq6Pj2mTxuzI1XlHK0=;
        b=f9MS/J8wIlGxG1lua0vH6sj1tGDi+LhrZM0+awEBBaQZNGd8VGmFG/HIYWNE1cgOBK
         nCNM6e5tmvlLqaykM5UskpxiZ+L1aOaHZWcoZRLE4DIbN+h5wbt+jr/AXWapjHYoSQi4
         2PsgmRrB4cFaool7tB5RrcwL79dauQt6+DX7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding:sender;
        b=iOtBYd8JK28z4DPCFljEmaV8v6P3kB/Uxapw0TVE8nsCdVNx0Rh70iJFZOnodLA4Hk
         Q6FLaIzBQQw3mR31wt+3J09jh0j3bg66WKmGAu0fiRE5b+mJURuhTarpy1cv2ItiqZ6l
         3ZrJnHq8PuSAyQybZ/1CsWhsXvr0BIbQAcWx4=
Received: by 10.210.54.19 with SMTP id c19mr6888483eba.106.1222800234478;
        Tue, 30 Sep 2008 11:43:54 -0700 (PDT)
Received: from ?10.222.147.176? ([86.53.68.233])
        by mx.google.com with ESMTPS id 7sm3185500eyb.1.2008.09.30.11.43.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 11:43:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97141>

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

diff --git a/guilt b/guilt
index 1cef7b9..8d023e9 100755
--- a/guilt
+++ b/guilt
@@ -693,10 +693,6 @@ fi
 series="$GUILT_DIR/$branch/series"
 applied="$GUILT_DIR/$branch/status"
 
-# determine an editor to use for anything interactive (fall back to vi)
-editor="vi"
-[ ! -z "$EDITOR" ] && editor="$EDITOR"
-
 # determine a pager to use for anything interactive (fall back to more)
 pager="more"
 [ ! -z "$PAGER" ] && pager="$PAGER"
diff --git a/guilt-header b/guilt-header
index da46c82..66521ac 100755
--- a/guilt-header
+++ b/guilt-header
@@ -46,7 +46,7 @@ if [ -z "$edit" ]; then
 else
 	do_get_full_header "$GUILT_DIR/$branch/$patch" > "$TMP_MSG"
 	do_get_patch "$GUILT_DIR/$branch/$patch" > "$TMP_DIFF"
-	$editor "$TMP_MSG"
+	git_editor "$TMP_MSG"
 	mv "$GUILT_DIR/$branch/$patch" "$GUILT_DIR/$branch/$patch~"
 
 	(
diff --git a/guilt-new b/guilt-new
index 05318a5..7845d00 100755
--- a/guilt-new
+++ b/guilt-new
@@ -77,7 +77,7 @@ mkdir_dir=`dirname "$GUILT_DIR/$branch/$patch"`
 ) >> "$GUILT_DIR/$branch/$patch"
 
 # edit -e ?
-[ "$edit" = "t" ] && $editor "$GUILT_DIR/$branch/$patch"
+[ "$edit" = "t" ] && git_editor "$GUILT_DIR/$branch/$patch"
 
 if [ ! -z "$force" ]; then
 	(
diff --git a/guilt-series b/guilt-series
index 7d8f8e9..4f24ffd 100755
--- a/guilt-series
+++ b/guilt-series
@@ -22,7 +22,7 @@ do
 done
 
 if [ ! -z "$edit" ]; then 
-	$editor "$series"
+	git_editor "$series"
 elif [ ! -z "$gui" ]; then
 	[ -z "`get_top`" ] && die "No patches applied."
 	bottom=`git rev-parse refs/patches/$branch/$(head -1 $applied)`

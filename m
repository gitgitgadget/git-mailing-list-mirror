From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 04/20] rebase: remove unused rebase state 'prev_head'
Date: Thu, 25 Nov 2010 20:57:47 +0100
Message-ID: <1290715083-16919-5-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:59:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLnax-00026e-HA
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab0KZB6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:18 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab0KZB6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:10 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347966vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4vb3XATEjIcpeoVXIMz5J1ZruU/QewbZO5oKp6rVefw=;
        b=Dxq/MZo7Zb+QWK27nNCTSaRl3GSvKc//nxIKNunzXukinswo5Y3D79lXDrti2PJDVJ
         C8qgAqXDbWK9NIHRlk/V6rhRBiRVWq5ncsJJTMZ9NZx/kwAIH9LdkQOkyGbhwp8I4J8f
         DWSwgi1feZ1PoCwwUSiy9Up/6p9pPzB1+6HCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jxRaSkUImKy1+hd2Eju+77xuyl3DgtcRRBVm2EcqZWI37C+KJLhKS+Xg5PPfTqYiRg
         nSqeDj+IIhYJVnN9EkY/CqrS0s4c4JO/0RiSvXxvSrKYb/hCl1VP0aY2jHk3jp3ki6vb
         8GQTrKy1dj4ihUibg3yFQAsxI0eZMed70fH7E=
Received: by 10.220.202.196 with SMTP id ff4mr390100vcb.6.1290736690046;
        Thu, 25 Nov 2010 17:58:10 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:09 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162177>

The rebase state 'prev_head' is not used. Remove it.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b1fadb6..aaee06b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -60,7 +60,6 @@ read_state () {
 	if test -d "$merge_dir"
 	then
 		state_dir="$merge_dir"
-		prev_head=$(cat "$merge_dir"/prev_head) &&
 		onto_name=$(cat "$merge_dir"/onto_name) &&
 		end=$(cat "$merge_dir"/end) &&
 		msgnum=$(cat "$merge_dir"/msgnum)
@@ -74,7 +73,6 @@ read_state () {
 }
 
 continue_merge () {
-	test -n "$prev_head" || die "prev_head must be defined"
 	test -d "$merge_dir" || die "$merge_dir directory does not exist"
 
 	unmerged=$(git ls-files -u)
@@ -108,10 +106,6 @@ continue_merge () {
 	test -z "$GIT_QUIET" &&
 	GIT_PAGER='' git log --format=%s -1 "$cmt"
 
-	prev_head=`git rev-parse HEAD^0`
-	# save the resulting commit so we can read-tree on it later
-	echo "$prev_head" > "$merge_dir/prev_head"
-
 	# onto the next patch:
 	msgnum=$(($msgnum + 1))
 	echo "$msgnum" >"$merge_dir/msgnum"
@@ -566,8 +560,6 @@ fi
 
 mkdir -p "$merge_dir"
 echo "$onto_name" > "$merge_dir/onto_name"
-prev_head=$orig_head
-echo "$prev_head" > "$merge_dir/prev_head"
 echo "$head_name" > "$merge_dir/head-name"
 echo "$onto" > "$merge_dir/onto"
 echo "$orig_head" > "$merge_dir/orig-head"
-- 
1.7.3.2.864.gbbb96

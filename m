From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 30/31] rebase -i: don't read unused variable preserve_merges
Date: Tue, 28 Dec 2010 10:30:47 +0100
Message-ID: <1293528648-21873-31-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYq-0005Wr-9Q
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab0L1PdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:19 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0L1PdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:16 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9391760qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Uqo/gFjG7ZGVQjetO68YQVfNMdY5iVGF5hX/Ct49Ndc=;
        b=l13gswR4YBrAHg/+UGaMQXOovMpedlKQrWUwEF1qKt7Zigz6xD53tX7cfhTLbIn5Uc
         +L7NkBo2nhDeAXvii7T67IrkE8hBRVTsTD5AKIUlecc8iS8PgKN7WlzzDaOgiDNtRy08
         S4mXHL92JPJKUw082z/fD8iYa/GyuqL/op0kA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KsRkvl39HjJL16PEF1nltFvphqUFyekz/WcWjKCc1L7PkbbVHvw59/UeOAqQtktWUc
         20mJqjqAZxNhYm6nZYOUuG+5W16su/9uPdxPakFXums8uU2OtxtG11dmKKvmyZQ8hq22
         63E/PKpcUB9eWJhlO6UQ+9RtEQvyN2N31Fgfk=
Received: by 10.224.11.21 with SMTP id r21mr5226082qar.6.1293550395672;
        Tue, 28 Dec 2010 07:33:15 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:14 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164266>

Since 8e4a91b (rebase -i: remember the settings of -v, -s and -p when
interrupted, 2007-07-08), the variable preserve_merges (then called
PRESERVE_MERGES) was detected from the state saved in
$GIT_DIR/rebase-merge in order to be used when the rebase resumed, but
its value was never actually used. The variable's value was only used
when the rebase was initated.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0763ef5..d20a9b2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -583,7 +583,6 @@ skip_unnecessary_picks () {
 }
 
 get_saved_options () {
-	test -d "$REWRITTEN" && preserve_merges=t
 	test -f "$state_dir"/rebase-root && rebase_root=t
 }
 
@@ -650,8 +649,6 @@ rearrange_squash () {
 
 case "$action" in
 continue)
-	get_saved_options
-
 	# do we have anything to commit?
 	if git diff-index --cached --quiet --ignore-submodules HEAD --
 	then
@@ -682,8 +679,6 @@ first and then run 'git rebase --continue' again."
 	do_rest
 	;;
 skip)
-	get_saved_options
-
 	git rerere clear
 
 	do_rest
-- 
1.7.3.2.864.gbbb96

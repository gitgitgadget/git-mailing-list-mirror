From: Julien Carsique <julien.carsique@gmail.com>
Subject: [PATCH] git-prompt.sh: shorter equal upstream branch name
Date: Tue, 30 Sep 2014 17:36:10 +0200
Message-ID: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Julien Carsique <julien.carsique@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 17:37:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYzUS-0005K3-Rn
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 17:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbaI3PhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 11:37:16 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46114 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaI3PhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 11:37:06 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so4837030wgg.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2014 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eDbzwwsWgCe9c57lvygIBg+rb9Lgk7u7/+SStTGcJlI=;
        b=W6CkdxJzzmuYjYk1rZsmIjAKT0R4M5dYTML6vV/0cDGxeIAjIahJuXvng7leWs2RZD
         4Hc2nDxZsSEZIxRVnKBRI9IfLJRXaam2FHjp5WABYuV8F3qOhYTOK/iHSmnwIH/uo2d0
         OgKUEVDKD9UbBp4ZqkBVEmQqX3/4YT49GI6Z7vv9jLDirXqGjgMWjbZdPIsfmfCV4ORP
         FuLxBjFzLCN04yyiKf7oRFGnmtmbkHymq23E2Ylsb/lciVSszIsXudSUNyNENudQyI2X
         OuUO88sR+AUyRZGvY8QCRfRGXru4rj8SiXLGQTTNNboTJ89O0Il4R3a9+GUd9BUD1CEO
         SPkw==
X-Received: by 10.180.207.104 with SMTP id lv8mr6779638wic.35.1412091425232;
        Tue, 30 Sep 2014 08:37:05 -0700 (PDT)
Received: from nocebo.in.nuxeo.com ([176.57.246.10])
        by mx.google.com with ESMTPSA id g6sm19608007wjf.13.2014.09.30.08.36.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Sep 2014 08:36:58 -0700 (PDT)
X-Google-Original-From: Julien Carsique <jcarsique@nuxeo.com>
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257671>

From: Julien Carsique <julien.carsique@gmail.com>

When using the "name" option of GIT_PS1_SHOWUPSTREAM to show the upstream
abbrev name, if the upstream name is the same as the local name, then some
space could be saved in the prompt. This is especially needed on long branch
names.

Replace the upstream name with the sign '=' if equal to the local one.
Example:    [master * u= origin/=]$
instead of: [master * u= origin/master]$

Signed-off-by: Julien Carsique <julien.carsique@gmail.com>
---
 contrib/completion/git-prompt.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c5473dc..a9aba20 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -209,6 +209,13 @@ __git_ps1_show_upstream ()
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream" 2>/dev/null)
+
+			__head=${b##refs/heads/}
+			if [ "$__head" = "${__git_ps1_upstream_name##*/}" ]; then
+				__git_ps1_upstream_name=${__git_ps1_upstream_name/$__head/=}
+			fi
+			unset __head
+
 			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
 				p="$p \${__git_ps1_upstream_name}"
 			else
-- 
2.1.0

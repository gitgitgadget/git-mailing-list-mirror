From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 1/4] t4150: test applying with a newline in subject
Date: Mon, 15 Jun 2009 19:05:02 -0700
Message-ID: <1245117905-19351-2-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 04:05:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGO3O-0000LG-7W
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 04:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169AbZFPCFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 22:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755866AbZFPCFU
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 22:05:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:45866 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbZFPCFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 22:05:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1651641wfd.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 19:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=CRfMZmYthbwiSFUtN9n/yGet9E4SVMBdIDrc5j4cWFc=;
        b=fv06qCZIIammTGMOs+CBAp9LJfSzjbofl3eYKC/B3r78hQDjpVPDIyfQU1j5EL7yGg
         8FqL/CaDhGfciYj8hfeOXr58/DdNcxaFJMtwThZnI8YKqRB2wDz3Nsut58BK/h2dS94f
         fna1VhVSbfjsJvxVoVS1pmyjjftjFY8IHAwe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y/yCd0qDgYkbDECDqurDPGTPwxwTo28zURNhCzoFSPExqGoPFGZk7LWGHNhm1NYKvY
         Cok3VVFnFWIapoLJ8ahut++73jZvJKY55TnIZ2A0oCH3DmQ0d5ZJZx/D/Wu0zZG+jGTp
         RMnbop5z8K0knmkca9/pnABk7tItAPhWGNsHg=
Received: by 10.142.77.11 with SMTP id z11mr3671198wfa.277.1245117912451;
        Mon, 15 Jun 2009 19:05:12 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id 22sm886482wfd.19.2009.06.15.19.05.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Jun 2009 19:05:11 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 15 Jun 2009 19:05:09 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121649>

Commit 4b7cc26 (git-am: use printf instead of echo on user-supplied
strings, 2007-05-25) fixed a bug where subjects with newlines would
cause git-am to echo multiple lines when it says "Applying: <subject>".

This test ensures that fix stays valid.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 t/t4150-am.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index d6ebbae..51c369a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -305,4 +305,12 @@ test_expect_success 'am into an unborn branch' '
 	test "z$result" = "z$(git rev-parse first^{tree})"
 '
 
+test_expect_success 'am newline in subject' '
+	git checkout first &&
+	test_tick &&
+	sed -e "s/second/second \\\n foo/" patch1 > patchnl &&
+	git am < patchnl > output.out 2>&1 &&
+	grep "^Applying: second \\\n foo$" output.out
+'
+
 test_done
-- 
1.6.3.2.306.g4f4fa

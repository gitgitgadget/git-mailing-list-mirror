From: David Cowden <dcow90@gmail.com>
Subject: [PATCH v2] Clarify pre-push hook documentation
Date: Mon, 24 Mar 2014 16:43:29 -0700
Message-ID: <1395704609-81957-1-git-send-email-dcow90@gmail.com>
References: <1395601267-78377-1-git-send-email-dcow90@gmail.com>
Cc: David Cowden <dcow90@gmail.com>, philipoakley@iee.org,
	sunshine@sunshineco.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 00:44:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSEXQ-00009s-UG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 00:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbaCXXoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 19:44:04 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:39531 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbaCXXoD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 19:44:03 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so6137931pbc.4
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CPRfSQjOKc0Gjf/9oKU34WkaENOFYk8d4inyNSBHgj8=;
        b=Rt/UOfE9koV/bEsV26lXd7SXzvTJegeDgBG17dHI8PyU49qVRMhXAmyfKIm2DMkHAf
         awcl+FPocmo8bsz1mfaQcSiSU6YYPXeeMPT69VCg4jM2ZVLBSJuSdwFafTvCmXD5Pv56
         jlVYt5aRIo7v+nP6s6DNgu2pvsk6tmY5dzlKEvInTC119OCVnc8RMtqtiO0B4XiX3R46
         rmokwqtJzJTvOz9AmznpFX5aFBISS33iLPD7DC/FewCy3GJ1e1wbVvY+lpgMAKyvr63D
         nQWfFZF33MwylNlztXt2TgbtCNvo2CuT53S7EL2QoyWQnkXMNe5sRiJwkiGPyUwSIcYJ
         TBdQ==
X-Received: by 10.66.140.104 with SMTP id rf8mr75188133pab.107.1395704642914;
        Mon, 24 Mar 2014 16:44:02 -0700 (PDT)
Received: from Davids-MacBook-Pro-2.local.com ([69.170.160.74])
        by mx.google.com with ESMTPSA id iv2sm36443585pbc.19.2014.03.24.16.44.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Mar 2014 16:44:02 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395601267-78377-1-git-send-email-dcow90@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244898>

The documentation as-is does not mention that the pre-push hook is
executed even when there is nothing to push.  This can lead a new
reader to believe there will always be lines fed to the script's
standard input and cause minor confusion as to what is happening
when there are no lines provided to the pre-push script.

Signed-off-by: David Cowden <dcow90@gmail.com>
---

Notes:
    c.f. http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script-does-not-receive-input-via-stdin
    
    I'm not sure if I've covered every case here.  If there are more cases to
    consider, please let me know and I can update to include them.

 Documentation/githooks.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..d05b3c5 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -203,6 +203,15 @@ SHA-1>` will be 40 `0`.  If the local commit was specified by something other
 than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
 supplied as it was originally given.
 
+The hook is executed regardless of whether changes will actually be pushed or
+not.  This may happen are when 'git push' is called and:
+
+ - the remote ref is already up to date, or
+ - pushing to the remote ref cannot be handled by a simple fast-forward
+
+In other words, the script is called for every push.  In the event that nothing
+is to be pushed, no data will be provided on the script's standard input.
+
 If this hook exits with a non-zero status, 'git push' will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
-- 
1.9.1

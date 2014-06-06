From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 20/20] CodingGuidelines: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:56:03 -0700
Message-ID: <1402066563-28519-21-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZN-0001vC-9A
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbaFFO43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:29 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39155 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbaFFO41 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:27 -0400
Received: by mail-pd0-f176.google.com with SMTP id p10so2507484pdj.7
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ipud0AoI3gJJo7slWQ3UK03mPzKwcqJf1gaFICS/sOw=;
        b=S+Wn18uwY1IQXsalgRU6ZSItqEmj1/bnnneOkr0K/KXwyU+fWpFlzyOy0U6vipjQd7
         psHRBoLcKb9oE/5Pgfnlq4DnQnaLw5cRbwYenM6uE9M7nvPukqv2XBF6lzI5H43kiw8D
         MfcNOey8GtAFKCUXxMlzBDzx2KrzUb7R6PnhT4NXiR9l6lFm59s0Txx08wfA3UyJ3kA7
         0tktbB7bhjekQDrOsmSqpAS8RulLmKa5OU4Z4tTWFYObWnoLvMSWhVmr59ZNx0UStViH
         wgkdPpGshuFqeH9YZu8TUV35y7KSEpCLpdb3UPJlwDS48YzUK9x0SPO/u3UN3plCB/ja
         GKGw==
X-Received: by 10.68.143.231 with SMTP id sh7mr1929656pbb.7.1402066586687;
        Fri, 06 Jun 2014 07:56:26 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250927>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Documentation/CodingGuidelines |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index f424dbd..2d426bc 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -106,6 +106,18 @@ For shell scripts specifically (not exhaustive):
    interface translatable. See "Marking strings for translation" in
    po/README.
 
+ - We do not write our "test" command with "-a" and "-o" and use "&&"
+   or "||" to concatenate multiple "test" commands instead, because
+   the use of "-a/-o" is often error-prone.  E.g.
+
+     test -n "$x" -a "$a" = "$b"
+
+   is buggy and breaks when $x is "=", but
+
+     test -n "$x" && test "$a" = "$b"
+
+   does not have such a problem.
+
 For C programs:
 
  - We use tabs to indent, and interpret tabs as taking up to
-- 
1.7.10.4

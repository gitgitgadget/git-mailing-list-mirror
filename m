From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 4/4] completion: fix remote.pushdefault
Date: Sun,  5 Jan 2014 15:48:05 +0530
Message-ID: <1388917085-18701-5-git-send-email-artagnon@gmail.com>
References: <1388917085-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 05 11:18:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzkmi-0002oW-Rv
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 11:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbaAEKSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 05:18:14 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:39740 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbaAEKSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 05:18:13 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so17546802pad.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 02:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J1w5W0gaQU8Mcr6DqZ3JNkG6rFzdUJ/WHboSSS/xN3I=;
        b=SipihW7GfFAlxYhht0pVk9i2+HBF2cgP20JcTM5xwixa09O5ahoXdWL8NXpW5MvCf/
         JBOAYzdfkrchtlkC3FAQ2ybWx9fK/q/2zGYwW22Aj3i+Jtl/KYt//KndhDpiMP46vdfT
         kht8/QWLm3K9NFw5Hz/DZ54YMMIHP4lrBi33pzLrIE7H9xYbEjcsqtDWU7BIShpaVINB
         qf6dTP0WtibzP0970Xxv3uoCzhX9Hff+I4WSlpsDKJma+xJOyVf+k1aWctcqJmYcVVdZ
         amOOeoUQFvJYzNt5kKUC8tBxkSKWPk14nO8ZFsf4BTPQtwTuWwR62Nr5yhgLUpMFaQ4q
         8JRg==
X-Received: by 10.68.25.229 with SMTP id f5mr114939782pbg.6.1388917092636;
        Sun, 05 Jan 2014 02:18:12 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id fk4sm25113615pab.23.2014.01.05.02.18.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2014 02:18:12 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388917085-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239963>

When attempting to complete

  $ git config remote.push<TAB>

'pushdefault' doesn't come up. This is because "$cur" is matched with
"remote.*" and a list of remotes are completed. Add 'pushdefault' as a
candidate for completion too, using __gitcomp_nl_append ().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a57bcbe..4fe5ce3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1884,6 +1884,7 @@ _git_config ()
 	remote.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
+		__gitcomp_nl_append "pushdefault" "$pfx" "$cur_"
 		return
 		;;
 	url.*.*)
-- 
1.8.5.2.227.g53f3478

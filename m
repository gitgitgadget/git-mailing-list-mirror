From: Frans Klaver <fransklaver@gmail.com>
Subject: [PATCH 0/2] run-command: Add EACCES diagnostics
Date: Tue,  6 Dec 2011 22:38:21 +0100
Message-ID: <1323207503-26581-1-git-send-email-fransklaver@gmail.com>
References: <op.v5e8mgbc0aolir@keputer>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 22:39:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2j9-0004JE-Mo
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab1LFVi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:38:57 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54231 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab1LFVi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:38:57 -0500
Received: by eeaq14 with SMTP id q14so3376202eea.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 13:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9orZ47YgnyJ6YRboaz1R6trSwjr8A42NVDFbIvIxeX4=;
        b=HMf8Tz7IcAkIV5Y02xFDXwpxP1fRNfjDIPOA8vFyS94ZI60PBFIgvh2wWnY28751eQ
         JtJE2fhMCssDEjdyTk+VskpZop2+2FUC8OoGBSYyAwzFo3YllSuwPnP81DKvbq8qtDGA
         LOHOoe+reudyGfeAwJ1aUBI9B3kxRDJHUbmNk=
Received: by 10.14.14.80 with SMTP id c56mr2866450eec.197.1323207535771;
        Tue, 06 Dec 2011 13:38:55 -0800 (PST)
Received: from localhost.localdomain (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id 65sm51275159eeg.8.2011.12.06.13.38.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 13:38:55 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <op.v5e8mgbc0aolir@keputer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186388>

So here's a couple of patches that introduce some more elaborate investigation
into what went wrong when receiving EACCES. This is probably something that
could be expanded in the future, as running a command doesn't always produce
equally obvious error messages.

"run-command: Add checks after execvp fails with EACCES" provides some basic checks
on the permissions in PATH, and gives just a warning that none of its checks 
indicate a problem, so the user should check at least the interpreter permissions.

"run-command: Add interpreter permissions check" actually adds interpreter checking.

---

 run-command.c          |  172 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0061-run-command.sh |   38 ++++++++++-
 2 files changed, 209 insertions(+), 1 deletions(-)
